local tb = require 'termbox'
local cstr = terralib.includec("string.h")
local cio = terralib.includec("stdio.h")

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

while running do
  event_response = tb.poll_event(event)
  tb.print(5,6,"width is " .. tb.width() , tb.BLUE, tb.DEFAULT)
  if event_response == tb.EVENT_KEY then
    if event.key == tb.KEY_ESC then
      running = false
    end
  end
  tb.present()
end
tb.shutdown()
