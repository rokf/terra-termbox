
local tb = require 'termbox'

terra main()
  var running = true
  var initval = tb.init()
  tb.select_input_mode([bit.bor(tb.INPUT_ESC, tb.INPUT_MOUSE)]) -- accept mouse events
  var event = tb.event {} -- make a tb_event instance
  var event_response = -1
  while running do
    event_response = tb.poll_event(&event) -- poll for events
    tb.clear()
    if event_response == tb.EVENT_MOUSE then -- on mouse event
      tb.set_cursor(event.x, event.y) -- display cursor on click position
    end
    if event_response == tb.EVENT_KEY then -- on keypress
      if event.ch == ("h")[0] then -- hide cursor after h is pressed
        tb.set_cursor(tb.HIDE_CURSOR, tb.HIDE_CURSOR)
      end
      if event.key == tb.KEY_ESC then -- if the key was ESC
        running = false -- stop the loop
      end
    end
    tb.present() -- present buffer
  end
  tb.shutdown() -- stop termbox and return to normal terminal mode
end

main()
