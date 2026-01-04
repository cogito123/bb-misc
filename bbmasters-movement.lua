/sc
--[[
Applies 25% movement speed bonus to captains
Applies 10% movement speed bonus to players picked in initial picking phase
No movement speed bonus to players picked in late picking phase
Changes default pick timer to 15min.

This script must be executed still in the lobby, before initial picking phase.
Script will autodetect who is captain and who are other players based on match time.
--]]
if storage.cptms then
  game.print("Movement speed bonus is active already!")
  return
end

storage.special_games_variables.captain_mode.autoPickIntervalTicks = 54000
storage.cptms = {
    cpt = {},
    players = {},
}

function create_description()
  local chest = game.player.surface.create_entity(
    {
      name = "wooden-chest",
      position = { 0, -20 },
    }
  )
  chest.minable = false
  chest.destructible = false
  chest.operable = false

  local texts = {
    'Captains receive a 25% movement speed bonus',
    'Players joining in the initial picking phase receive a 10% movement speed bonus',
    'Players joining in the late picking phase receive no bonus'
  }

  for i, text in ipairs(texts) do
    local color = i % 2 == 0 and { 255, 255, 0 } or { 255, 200, 0 }
    rendering.draw_text {
      text = text,
      surface = game.player.surface,
      target = { entity = chest, offset = { 0, 1.25 * i } },
      color = color,
      scale = 1.00,
      font = "heading-1",
      alignment = "center",
      scale_with_zoom = true
    }
  end
end

create_description()

local Event = require "utils.event"

local on_player_respawned = [[function (event)
    local function has_value(arr, val)
        for _, v in ipairs(arr) do
            if v == val then
                return true
            end
        end

        return false
    end

    local player = game.get_player(event.player_index)
    if has_value(storage.cptms.cpt, player.name) then
        player.character_running_speed_modifier = 0.25
        return
    end

    if has_value(storage.cptms.players, player.name) then
        player.character_running_speed_modifier = 0.1
    end
end]]

Event.add_removable_function(
    defines.events.on_player_respawned,
    on_player_respawned,
    "cptms_on_player_respawned"
)

local on_player_joined_team = [[function (event)
    local functions = require("maps.biter_battles_v2.functions")
    local ticks = functions.get_ticks_since_game_start()
    if ticks > 0 then
      return
    end

    local pp = storage.cptms.players
    local cpt = storage.cptms.cpt
    local p = game.get_player(event.player_index)
    if #cpt < 2 then
        cpt[#cpt + 1] = p.name
        p.character_running_speed_modifier = 0.25
    else
        pp[#pp + 1] = p.name
        p.character_running_speed_modifier = 0.1
    end
end]]

local Gui = require("maps.biter_battles_v2.gui")
Event.add_removable_function(
  Gui.events.on_player_joined_team,
  on_player_joined_team,
  "cptms_on_player_joined_team"
)

local on_surface_deleted = [[function(event)
    game.print("Movement speed bonus removed")
    storage.cptms = nil
    local Event = require "utils.event"
    local Gui = require("maps.biter_battles_v2.gui")
    Event.remove_removable_function(defines.events.on_player_respawned, "cptms_on_player_respawned")
    Event.remove_removable_function(Gui.events.on_player_joined_team, "cptms_on_player_joined_team")
    Event.remove_removable_function(defines.events.on_surface_deleted, "cptms_on_surface_deleted")
end]]

Event.add_removable_function(defines.events.on_surface_deleted, on_surface_deleted, "cptms_on_surface_deleted")

local p = game.player
game.print("Movement speed bonus enabled by " .. p.name)
