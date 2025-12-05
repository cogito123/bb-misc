--- Point a cursor at a captain that shall receive pack and execute
--- any of the below scripts.

-- PACKS
-- ECONOMY
local player = game.player.selected
player.insert{name="stone-furnace", count = 70}
player.insert{name="burner-mining-drill", count = 20}
player.insert{name="coal", count = 300}
player.insert{name="wood", count = 100}

-- AUTOMATION
local player = game.player.selected
player.insert{name="assembling-machine-1", count = 5}
player.insert{name="transport-belt", count = 200}
player.insert{name="inserter", count = 50}
player.insert{name="splitter", count = 1}
player.insert{name="electric-mining-drill", count = 2}
player.insert{name="wood", count = 100}

-- SCIENCE
local player = game.player.selected
player.insert{name="automation-science-pack", count = 70}
player.insert{name="logistic-science-pack", count = 32}
player.insert{name="lab", count = 8}
player.insert{name="wood", count = 100}

-- POWER
local player = game.player.selected
player.insert{name="wood", count = 100}

local e = game.player.surface.create_entity {
  name = "electric-energy-interface",
  position = {
    x=-7,
    y=39 * (player.force.name == "north" and -1 or 1)
  }
}
e.power_production = 333333.33333333
e.electric_buffer_size = 333000
e.minable = false
e.operable = false
e.destructible = false
e.force = "neutral"

-- TF
local player = game.player.selected
player.insert{name="shotgun", count = 3}
player.insert{name="heavy-armor", count = 3}
player.insert{name="grenade", count = 75}
player.insert{name="raw-fish", count = 100}
player.insert{name="shotgun-shell", count = 75}
player.insert{name="wood", count = 100}

-- DEF
local player = game.player.selected
player.insert{name="firearm-magazine", count = 50}
player.insert{name="gun-turret", count = 5}
player.insert{name="flamethrower-turret", count = 10}
player.insert{name="wood", count = 100}
