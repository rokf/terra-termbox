-- https://en.wikipedia.org/wiki/Box-drawing_character
-- https://github.com/nsf/termbox/

local _tbox = terralib.includec("termbox.h")
local cstr = terralib.includec("string.h")
terralib.linklibrary("libtermbox.so") -- link shared library

local tb = {}

-- append functions and variables without the tb_ prefix
for k,v in pairs(_tbox) do
  if string.match(k,"tb_") then
    local newkey = string.match(k,"tb_(.*)")
    tb[newkey] = v
  elseif string.match(k,"TB_") then
    local newkey = string.match(k,"TB_(.*)")
    tb[newkey] = v
  end
end

-- print string character by character
tb.print = terra (x: int, y: int, str: rawstring, fg: int, bg: int)
  for i=0, cstr.strlen(str) do
    tb.change_cell(x+i, y, str[i], fg, bg)
  end
end

-- draw a block
tb.block = terra (x: int, y: int, w: int, h: int, fg: int, bg: int)
  for j=0,h do
    for i=0,w do
      tb.change_cell(x+i, y+j, 0x2588, fg, bg)
    end
  end
end

-- draw a frame with big lines
tb.frame = terra (x: int, y: int, w: int, h: int, fg: int, bg: int)
  for j=0,h do
    for i=0,w do
      if i==0 and j == 0 then
        tb.change_cell(x+i, y+j, 0x250F, fg, bg)
      elseif i==w-1 and j == 0 then
        tb.change_cell(x+i, y+j, 0x2513, fg, bg)
      elseif i==0 and j == h-1 then
        tb.change_cell(x+i, y+j, 0x2517, fg, bg)
      elseif i==w-1 and j == h-1 then
        tb.change_cell(x+i, y+j, 0x251B, fg, bg)
      elseif i==0 or i==w-1 then
        tb.change_cell(x+i, y+j, 0x2503, fg, bg)
      elseif j==0 or j==h-1 then
        tb.change_cell(x+i, y+j, 0x2501, fg, bg)
      end
    end
  end
end

-- return module
return tb
