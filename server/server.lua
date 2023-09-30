local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Rexshack-RedM/rsg-trader/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

        --versionCheckPrint('success', ('Current Version: %s'):format(currentVersion))
        --versionCheckPrint('success', ('Latest Version: %s'):format(text))
        
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

-----------------------------------------------------------------------

-- get market data
RSGCore.Functions.CreateCallback('rsg-trader:server:getmarketdata', function(source, cb)
    local marketdata = MySQL.query.await('SELECT * FROM market_data', {})

    if marketdata[1] == nil then 
        return 
    end

    cb(marketdata)
end)

RegisterServerEvent('rsg-trader:server:sellitem')
AddEventHandler('rsg-trader:server:sellitem', function(amount, item, name, price)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    local checkitem = Player.Functions.GetItemByName(item)
    if amount >= 0 then
        if checkitem ~= nil then
            local amountitem = Player.Functions.GetItemByName(item).amount
            if amountitem >= amount then
                totalcash = (amount * price) 
                Player.Functions.RemoveItem(item, amount)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "remove")
                Player.Functions.AddMoney('cash', totalcash)
                TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.yousold', { value1 = amount, value2 = name, value3 = totalcash }), 'success')
            else
                TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.notenough', { value1 = name }), 'error')
            end
        else
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.donthaveany', { value1 = item }), 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.negativevalue'), 'error')
    end
end)

-- trading loop system
TradingInterval = function()
    local result = MySQL.query.await('SELECT * FROM market_data', {})

    for i = 1, #result do
        local row = result[i]

        if Config.Debug then
            print(row.id, row.item, row.name, row.itemimage, row.price, row.price_min, row.price_max)
        end
        
        local rand = math.random(1,2)
        local id = row.id
        local item = row.item
        local price = tonumber(row.price)
        local pricemin = tonumber(row.price_min)
        local pricemax = tonumber(row.price_max)
        
        if rand == 1 then -- price increase
            if price < pricemax then
                local pricechange = (price + Config.ChangeAmount)
                MySQL.update('UPDATE market_data SET price = ? WHERE id = ?', { pricechange, id })
            end
        end
        
        if rand == 2 then -- price decrease
            if price > pricemin then
                local pricechange = (price - Config.ChangeAmount)
                MySQL.update('UPDATE market_data SET price = ? WHERE id = ?', { pricechange, id })
            end
        end

    end

    if Config.ServerNotification == true then
        print(Lang:t('print.cyclecomplete'))
    end

    SetTimeout(Config.TraderCycle * (60 * 1000), TradingInterval) -- mins
end

SetTimeout(Config.TraderCycle * (60 * 1000), TradingInterval) -- mins

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()
