--- Prints out to log file a content of the registered hook in running BB instance.
/sc
local handlers = {
   function_handlers = true,
   function_nth_tick_handlers = true,
}
local needle = 'name_of_a_function'
for _, cell in ipairs(storage.tokens) do
   for name, inner in pairs(cell) do
      if handlers[name] then
         for name, content in pairs(inner) do
            if name == needle then
               log(serpent.block(content))
            end
         end
      end
   end
end
