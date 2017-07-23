
local tb = require 'termbox'
local tbw = require 'tbwidgets'

tbw:init(tb)

terra make_tb_event()
  return tb.event {}
end

local running = true
local initvar = tb.init()
tb.select_input_mode(bit.bor(tb.INPUT_ESC, tb.INPUT_MOUSE))
local event = make_tb_event()
local event_response = -1

local b_toggled = false
local cb_toggled = false
local mec = 0

while running do
  event_response = tb.poll_event(event)
  tb.clear()
  local btnbbx = tbw:tbutton(1,4,"Button",b_toggled,tb.RED,tb.BLUE)
  local cbbbx = tbw:checkbox(1,8,cb_toggled,tb.RED,tb.BLUE)
  tb.print(2, 1, tostring(mec),tb.WHITE, tb.DEFAULT)
  if event_response == tb.EVENT_MOUSE then
    mec = mec + 1
    tbw:onbclick(event, btnbbx, function ()
      b_toggled = not b_toggled
    end)
    tbw:onbclick(event, cbbbx, function ()
      cb_toggled = not cb_toggled
    end)
  elseif event_response == tb.EVENT_KEY then
    if event.key == tb.KEY_ESC then
      running = false
    end
  end
  tb.present()
end
tb.shutdown()
