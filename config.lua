Config = {}

Config.Debug = false

-- settings
Config.TraderCycle = 1 -- mins until the cycle runs
Config.ChangeAmount = 0.01 -- amount to increase / decrease per cycle
Config.PromptKey = 'J' -- key used for prompt
Config.ServerNotification = false

Config.Traders = {
    -- stdenis
    {
        prompt     = "stdenis-trader",  -- must be unique
        header     = "StDenis Trader", -- menu header
        coords     = vector3(2693.2382, -1494.436, 45.968975), -- location of the trader
        blipSprite = `blip_shop_market_stall`,
		blipScale  = 0.2,
		blipName   = "StDenis Trader",
        showblip = true,
    },
}
