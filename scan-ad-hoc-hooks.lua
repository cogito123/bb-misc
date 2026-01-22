--- Scans currently running BB instance for any extra event handlers
--- inserted through /sc and prints them to in-game console.
/sc
local function save_keys(tbl, name, buf)
   for k, _ in pairs(tbl) do
      buf[#buf+1] = name .. ": " .. k
   end
end

local handlers = {
   function_handlers = true,
   function_nth_tick_handlers = true,
}
local hooks = {}
for _, cell in ipairs(storage.tokens) do
   for name, inner in pairs(cell) do
      if handlers[name] then
         save_keys(inner, name, hooks)
      end
   end
end

if #hooks == 0 then
   game.print("scan-ad-hoc-hooks: no hooks found")
end

for _, hook in ipairs(hooks) do
   game.print("scan-ad-hoc-hooks: " .. hook)
end
