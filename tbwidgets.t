-- Terra Termbox immediate mode widgets module

local cstr = terralib.includec("string.h")

local widgets = {}

function widgets:init(tb)
  self.tb = tb -- set the tb library instance
  self.lastx = -1
  self.lasty = -1
  self.down = false
end

function _clickcheck(self,e,fun)
  if self.lastx ~= e.x and self.lasty ~= e.y and self.down == true then
    self.lastx = e.x
    self.lasty = e.y
  elseif not self.down then
    fun()
    self.down = true
    self.lastx = e.x
    self.lasty = e.y
  elseif self.lastx == e.x and self.lasty == e.y then
    self.down = false
    self.lastx = -1
    self.lasty = -1
  end
end

function widgets:onclick(e,x,y,fun)
  if e.x == x and e.y == y then
    _clickcheck(self,e,fun)
  end
end

function widgets:onbclick(e,bbx,fun)
  if e.x >= bbx[1] and e.y >= bbx[2] and e.x <= bbx[1] + bbx[3] and e.y <= bbx[2] + bbx[4] then
    _clickcheck(self,e,fun)
  end
end

function widgets:tbutton(x,y,text,toggled,color,color_toggled)
  if toggled == true then
    self.tb.frame(x,y,cstr.strlen(text)+2,3,color_toggled,self.tb.DEFAULT)
    self.tb.print(x+1,y+1,text,self.tb.DEFAULT,color_toggled)
  else
    self.tb.frame(x,y,cstr.strlen(text)+2,3,color,self.tb.DEFAULT)
    self.tb.print(x+1,y+1,text,color,self.tb.DEFAULT)
  end
  return {x,y,cstr.strlen(text)+2,3}
end

function widgets:checkbox(x,y,checked,color,color_checked)
  if checked == true then
    self.tb.frame(x,y,3,2,color_checked,self.tb.DEFAULT)
  else
    self.tb.frame(x,y,3,2,color,self.tb.DEFAULT)
  end
  return {x,y,3,2}
end

return widgets
