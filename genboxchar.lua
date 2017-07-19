-- requires Lua 5.3 or higher because of the included utf8 module
local serpent = require 'serpent'

-- unicode box drawing character range pairs
local rp = {
  0x2500,0x250F,
  0x2510,0x251F,
  0x2520,0x252F,
  0x2530,0x253F,
  0x2540,0x254F,
  0x2550,0x255F,
  0x2560,0x256F,
  0x2570,0x257F,
}

local boxchars = {}

for p=1,#rp,2 do
  for i=rp[p],rp[p+1] do
    boxchars[utf8.char(i)] = i -- populate table
  end
end

local file = io.open('boxchars.lua','w') -- serialize data with serpent module
file:write('return ' .. serpent.block(boxchars, {comment=false}))
file:close()
