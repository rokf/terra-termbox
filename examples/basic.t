local tb = require 'termbox'
local cstr = terralib.includec("string.h")
local cio = terralib.includec("stdio.h")

local bit = require("bit")

terra main()
  var running = true
  var initval = tb.init()
  var event = tb.event {}
  var event_response = -1
  var width : int8[128]
  while running do
    cio.sprintf(width,"width %d",tb.width())
    event_response = tb.poll_event(&event)
    tb.print(5,5,width, tb.RED, tb.DEFAULT)
    tb.print(5,6,"there", tb.BLUE, tb.DEFAULT)
    if event_response == tb.EVENT_KEY then
      if event.ch ~= 0 then
        tb.change_cell(5, 4, event.ch, tb.GREEN, tb.DEFAULT)
      end
      if event.key == tb.KEY_ESC then
        running = false
      end
    end
    tb.present()
  end
  tb.shutdown()
end

-- main()

terra make_tb_event()
  return tb.event {}
end

local running = true
local initval = tb.init()
local event = make_tb_event()
local event_response = -1
local last_event = "nothing"

tb.select_output_mode(tb.OUTPUT_256)
tb.select_input_mode(bit.bor(tb.INPUT_ESC, tb.INPUT_MOUSE))

while running do
  event_response = tb.poll_event(event)
  tb.clear()
  tb.print(5,6,"width is " .. tb.width(), tb.BLUE, tb.DEFAULT)
  tb.print(5,8,last_event, tb.RED, tb.DEFAULT)
  if event_response == tb.EVENT_RESIZE then last_event = "resize" end
  if event_response == tb.EVENT_MOUSE then last_event = "mouse:" .. event.x .. " " .. event.y end
  if event_response == tb.EVENT_KEY then
    last_event = "key"
    if event.ch ~= 0 then
      tb.change_cell(5, 4, event.ch, tb.GREEN, tb.DEFAULT)
    end
    if event.key == tb.KEY_ESC then
      running = false
    end
  end
  tb.present()
end
tb.shutdown()
