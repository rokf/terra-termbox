
local tb = require 'termbox'
local bit = require("bit")

terra main()
  var running = true
  var initval = tb.init()
  tb.select_input_mode([bit.bor(tb.INPUT_ESC, tb.INPUT_MOUSE)]) -- accept mouse events
  var event = tb.event {} -- make a tb_event instance
  var event_response = -1
  while running do
    event_response = tb.poll_event(&event) -- poll for events
    if event_response == tb.EVENT_RESIZE then -- on resize event
      tb.clear()
    end
    if event_response == tb.EVENT_MOUSE then -- on mouse event
      -- change the clicked cell content to a colored 0
      tb.change_cell(event.x, event.y, ("O")[0], tb.GREEN, tb.DEFAULT)
    end
    if event_response == tb.EVENT_KEY then -- on keypress
      if event.key == tb.KEY_ESC then -- if the key was ESC
        running = false -- stop the loop
      end
    end
    tb.present() -- present buffer
  end
  tb.shutdown() -- stop termbox and return to normal terminal mode
end

main()
