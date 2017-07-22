
local cstr = terralib.includec("string.h")

-- Terra Termbox immediate mode widgets module
local widgets = {}

function widgets:init(tb)
  self.tb = tb -- set the tb library instance
end

function widgets:tbutton(x,y,text,clicked,color)
  if clicked == true then
    self.tb.frame(x,y,cstr.strlen(text)+2,3,color,self.tb.DEFAULT)
    self.tb.print(x+1,y+1,text,self.tb.DEFAULT,color)
  else
    self.tb.print(x+1,y+1,text,self.tb.GREEN,self.tb.DEFAULT)
  end
end

function widgets:checkbox(x,y,checked,color)

end

return widgets
