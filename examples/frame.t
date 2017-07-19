
local tb = require 'termbox'

terra main()
  var running = true
  var initval = tb.init()
  var event = tb.event {} -- make a tb_event instance
  var event_response = -1
  while running do
    event_response = tb.poll_event(&event) -- poll for events
    tb.clear()
    tb.frame(0,0,tb.width(),tb.height(),tb.BLUE,tb.BLACK) -- draw frame
    tb.print(1,1,"frame example",tb.BLUE,tb.DEFAULT) -- print message
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
