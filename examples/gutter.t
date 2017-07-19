local tb = require 'termbox'
local cio = terralib.includec("stdio.h") -- for sprintf
local cstr = terralib.includec("string.h") -- for strlen

-- turn number into string
terra make_line_number(num: int) : {rawstring}
  var str : int8[20] -- slightly oversized buffer
  cio.sprintf(str,"%d",num) -- use sprintf from stdio.h for conversion
  return str
end

terra main()
  var running = true
  var initval = tb.init()
  var event = tb.event {} -- make a tb_event instance
  var event_response = -1
  while running do
    event_response = tb.poll_event(&event) -- poll for events
    tb.clear()
    -- how many characters will the longest number have?
    var longest_length = cstr.strlen(make_line_number(tb.height()))
    -- draw gutter background block according to longest_length
    tb.block(0,0,longest_length,tb.height(),tb.BLUE,tb.BLACK)
    for y=1,tb.height()+1 do -- print a number for every line
      tb.print(0,y-1,make_line_number(y),tb.BLACK,tb.BLUE)
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
