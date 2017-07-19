local _tbox = terralib.includec("termbox.h")
local cstr = terralib.includec("string.h")
terralib.linklibrary("libtermbox.so")

local tb = {}

for k,v in pairs(_tbox) do
  if string.match(k,"tb_") then
    local newkey = string.match(k,"tb_(.*)")
    tb[newkey] = v
  elseif string.match(k,"TB_") then
    local newkey = string.match(k,"TB_(.*)")
    tb[newkey] = v
  end
end

tb.print = terra (x: int, y: int, str: rawstring, fg: int, bg: int)
  for i=0, cstr.strlen(str) do
    tb.change_cell(x+i, y, str[i], fg, bg)
  end
end

return tb