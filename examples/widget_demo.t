
local tb = require 'termbox'
local tbw = require 'tbwidgets'

tbw:init(tb)

-- terra main()
--   var running = true
--   var initval = tb.init()
--   tb.select_input_mode([bit.bor(tb.INPUT_ESC, tb.INPUT_MOUSE)])
--   var event = tb.event {} -- make a tb_event instance
--   var event_response = -1
--   while running do
--     event_response = tb.poll_event(&event) -- poll for events
--     tb.clear()
--     tbw:button(5,5,"Button",true,tb.RED)
--     if event_response == tb.EVENT_MOUSE then -- on mouse event
--       tbw:button(5,5,"Button",false,tb.RED)
--     elseif event_response == tb.EVENT_KEY then -- on keypress
--       if event.key == tb.KEY_ESC then -- if the key was ESC
--         running = false -- stop the loop
--       end
--     end
--     tb.present() -- present buffer
--   end
--   tb.shutdown() -- stop termbox and return to normal terminal mode
-- end

-- main()

terra make_tb_event()
  return tb.event {}
end

function onclick(e,x,y,fun)
  if e.x == x and e.y == y then
    fun()
  end
end

function onbclick(e,x,y,w,h,fun)
  if e.x >= x and e.y >= y and e.x <= x+w and e.y <= y+h then
    fun()
  end
end

local running = true
local initvar = tb.init()
tb.select_input_mode(bit.bor(tb.INPUT_ESC, tb.INPUT_MOUSE))
local event = make_tb_event()
local event_response = -1

local b_toggled = false
local mec = 0

while running do
  event_response = tb.poll_event(event)
  tb.clear()
  tbw:tbutton(5,5,"Button",b_toggled,tb.RED)
  tb.print(1, 1, tostring(mec), b_toggled, tb.RED)
  if event_response == tb.EVENT_MOUSE then
    mec = mec + 1
    onbclick(event, 5, 5, 7, 2, function ()
      b_toggled = not b_toggled
      -- tbw:tbutton(5,5,"Button",true,tb.RED)
    end)
  elseif event_response == tb.EVENT_KEY then
    if event.key == tb.KEY_ESC then
      running = false
    end
  end
  tb.present()
end
tb.shutdown()
