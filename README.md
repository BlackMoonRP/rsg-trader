# RexshackGaming
- discord : https://discord.gg/eW3ADkf4Af
- youtube : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA
- github : https://github.com/Rexshack-RedM

# Dependancies
- rsg-core
- rsg-menu
- rsg-input
- rsg-npc

# Installation
- ensure that the dependancies are added and started
- ensure that you have the trade items in rsg-core -> shared -> items.lua
- add rsg-trader.sql your database
- add rsg-trader to your resources folder
- adjust the config.lua as required

# Add NPC
- add the following to rsg-npc -> config.lua
```lua
    {    -- stdenis trader 
        model = `A_M_M_BLWObeseMen_01`,
        coords = vector4(2693.2382, -1494.436, 45.968975, 135.639),
    },
```

# Starting the resource
- add the following to your server.cfg file : ensure rsg-trader
