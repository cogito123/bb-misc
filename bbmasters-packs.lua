--- Point a cursor at a captain that shall receive pack and execute
--- any of the below scripts. Each command starts with /sc and ends
--- with "-- END"

-- PACKS
-- ECONOMY
/sc
local player = game.player.selected.player
player.insert{name="stone-furnace", count = 60}
player.insert{name="burner-mining-drill", count = 15}
player.insert{name="coal", count = 275}
player.insert{name="wood", count = 100}
game.print("[font=infinite]Captain " .. player.name .. " has chosen economy pack![/font]")
-- END

-- AUTOMATION
/sc
local player = game.player.selected.player
player.insert{name="assembling-machine-1", count = 5}
player.insert{name="transport-belt", count = 200}
player.insert{name="inserter", count = 50}
player.insert{name="splitter", count = 1}
player.insert{name="electric-mining-drill", count = 10}
player.insert{name="wood", count = 100}
game.print("[font=infinite]Captain " .. player.name .. " has chosen automation pack![/font]")
-- END

-- SCIENCE
/sc
local player = game.player.selected.player
player.insert{name="automation-science-pack", count = 70}
player.insert{name="logistic-science-pack", count = 35}
player.insert{name="lab", count = 8}
player.insert{name="wood", count = 100}

local f = player.force
f.technologies["electronics"].researched = true
f.technologies["automation-science-pack"].researched = true
f.technologies["automation"].researched = true
game.print("[font=infinite]Captain " .. player.name .. " has chosen science pack![/font]")
-- END

-- THREAT FARMING
/sc
local player = game.player.selected.player
player.insert{name="shotgun", count = 2}
player.insert{name="heavy-armor", count = 2}
player.insert{name="grenade", count = 100}
player.insert{name="raw-fish", count = 100}
player.insert{name="shotgun-shell", count = 70}
player.insert{name="wood", count = 100}
game.print("[font=infinite]Captain " .. player.name .. " has chosen threat farming pack![/font]")
-- END

-- DEFENSE
/sc
local player = game.player.selected.player
player.insert{name="firearm-magazine", count = 50}
player.insert{name="gun-turret", count = 5}
player.insert{name="flamethrower-turret", count = 12}
player.insert{name="wood", count = 100}
game.print("[font=infinite]Captain " .. player.name .. " has chosen defense pack![/font]")
-- END

-- 20MW POWER
/sc
local function build_solar(s, p, times)
    local e = nil
    for _ = 1, times do
        e = s.create_entity {
            name = 'solar-panel',
            position = {
                x = p.x,
                y = p.y,
            },
        }
        e.force = 'neutral'
        e.minable_flag = false
        e.destructible = false
        e.operable = false
        e.rotatable = false
    end

    local tiles = {}
    local sbox = e.selection_box
    for x = sbox.left_top.x, sbox.right_bottom.x - 1 do
        for y = sbox.left_top.y, sbox.right_bottom.y - 1 do
            tiles[#tiles + 1] = {
                name = 'dirt-7',
                position = {
                    x = x,
                    y = y
                }
            }
        end
    end

    s.set_tiles(tiles)
end

local player = game.player.selected.player
player.insert{name="wood", count = 100}
player.surface.always_day = true

local flip = (player.force.name == "north" and 1 or -1)
local off = (player.force.name == "north" and 0 or 1)
local position = {
    x = -0,
    y = (-38 + off) * flip,
}
local s = player.surface
build_solar(s, position, 417)
game.print("[font=infinite]Captain " .. player.name .. " has chosen power pack![/font]")
-- END
