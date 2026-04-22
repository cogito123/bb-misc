---Applies 25% movement speed bonus to players in NAMES list.

---This script should be executed still in the lobby, before initial picking phase.
---It can be also executed during the picks or during the game.
---The script must be executed after bbmasters-movement.lua.

---Adjust NAMES before execution.
---Copy from next line until the end of this file.
/sc
local NAMES = {
    'name1',
    'name2',
    'name3',
    'name...',
}

if not storage.cptms then
    game.print('Run movement speed bonus script first!')
    return
end

local function remove_value(arr, val)
    for i, v in ipairs(arr) do
        if v == val then
            table.remove(arr, i)
            return
        end
    end
end

local function has_value(arr, val)
    for _, v in ipairs(arr) do
        if v == val then
            return true
        end
    end

    return false
end

for _, name in ipairs(NAMES) do
    if has_value(storage.cptms.cpt, name) then
        game.print(name .. ' is already in the captain list')
    else
        remove_value(storage.cptms.players, name)
        storage.cptms.cpt[#storage.cptms.cpt + 1] = name
        local player = game.get_player(name)
        if player and player.character then
            player.character_running_speed_modifier = 0.25
        end
        game.print('Applied movement speed bonus to ' .. name)
    end
end

local p = game.player
game.print('Movement speed bonus manually adjusted by ' .. p.name)
