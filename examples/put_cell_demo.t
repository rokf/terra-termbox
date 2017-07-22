local tb = require 'termbox'

terra main()
  var running = true
  var initval = tb.init()
  tb.select_input_mode([bit.bor(tb.INPUT_ESC, tb.INPUT_MOUSE)]) -- accept mouse events
  var event = tb.event {} -- make a tb_event instance
  var event_response = -1
  var cell = tb.cell { -- cell used for drawing
    ch = 65, -- start with an A
    fg = tb.GREEN, -- green foreground
    bg = tb.DEFAULT -- default background
  }
  while running do
    event_response = tb.poll_event(&event) -- poll for events
    if event_response == tb.EVENT_RESIZE then -- on resize event
      tb.clear()
    end
    if event_response == tb.EVENT_MOUSE then -- on mouse event
      tb.put_cell(event.x, event.y, &cell)
    end
    if event_response == tb.EVENT_KEY then -- on keypress
      if event.ch ~= 0 then
        -- change character used for drawing
        cell.ch = event.ch
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
