-- requires Lua 5.3 or higher because of the included utf8 module
local serpent = require 'serpent'

-- BOX

local boxchars = {}
for i=0x2500,0x257F do
  boxchars[utf8.char(i)] = i
end

local file1 = io.open('boxchars.lua','w')
file1:write('return ' .. serpent.block(boxchars, {comment=false}))
file1:close()

-- BLOCK

local blockchars = {}
for i=0x2580,0x259F do
  blockchars[utf8.char(i)] = i
end

local file2 = io.open('blockchars.lua','w')
file2:write('return ' .. serpent.block(blockchars, {comment=false}))
file2:close()

-- BRAILLE

local braillechars = {}
for i=0x2800,0x28FF do
  braillechars[utf8.char(i)] = i
end

local file3 = io.open('braillechars.lua','w')
file3:write('return ' .. serpent.block(braillechars, {comment=false}))
file3:close()
