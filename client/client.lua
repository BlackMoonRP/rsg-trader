local RSGCore = exports['rsg-core']:GetCoreObject()

-- prompts and blips
Citizen.CreateThread(function()
    for mtrade, v in pairs(Config.Traders) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds[Config.PromptKey], v.header, {
            type = 'client',
            event = 'rsg-trader:client:openmenu',
            args = { v.header },
        })
        if v.showblip == true then
            local TraderBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(TraderBlip, v.blipSprite, true)
            SetBlipScale(TraderBlip, v.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, TraderBlip, v.blipName)
        end
    end
end)

RegisterNetEvent('rsg-trader:client:openmenu', function(header)
    local GetMarketData =
    {
        {
            header = "| "..header.." |",
            isMenuHeader = true,
        }
    }

    RSGCore.Functions.TriggerCallback('rsg-trader:server:getmarketdata', function(cb)
        for i = 1, #cb do
            local data = cb[i]
            local item = data.item
            local name = data.name
            local itemimage = data.itemimage
            local price = data.price
            if Config.Debug == true then
                print('item '..item)
                print('name '..name)
                print('itemimage '..itemimage)
                print('price '..price)
            end
            GetMarketData[#GetMarketData + 1] =
            {
                header = "<img src=nui://rsg-inventory/html/images/"..itemimage.." width=20px>"..name..' ( $'..price..')',
                params =
                {
                    event = 'rsg-trader:client:sellcount',
                    isServer = false,
                    args =
                    {
                        sellitem = item,
                        sellname = name,
                        sellprice = price
                    },
                }
            }
        end

        exports['rsg-menu']:openMenu(GetMarketData)
    end)
end)

RegisterNetEvent('rsg-trader:client:sellcount') 
AddEventHandler('rsg-trader:client:sellcount', function(selldata)
    if Config.Debug == true then
        print(selldata.sellitem)
        print(selldata.sellname)
        print(selldata.sellprice)
    end
    local inputdata = exports['rsg-input']:ShowInput({
        header = 'Enter the number of '..selldata.sellname..' 1pc / '..selldata.sellprice..' $',
        header = Lang:t('inputmenu.header', { value1 = selldata.sellname, value2 = selldata.sellprice }),
        submitText = Lang:t('inputmenu.submittext'),
        inputs = {
            {
                text = Lang:t('inputmenu.imputstext', { value1 = selldata.sellname }),
                input = "amount",
                type = "number",
                isRequired = true
            },
        }
    })
    if inputdata ~= nil then
        for k,v in pairs(inputdata) do
            TriggerServerEvent('rsg-trader:server:sellitem', v, selldata.sellitem, selldata.sellname, selldata.sellprice)
        end
    end
end)
