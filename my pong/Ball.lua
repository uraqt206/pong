Ball = Class{}

function Ball:init(_x, _y, _dx, _dy)
  self.x, self.y, self.dx, self.dy = _x, _y, _dx, _dy
end

function Ball:move(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function Ball:changeDy() 
  if self.dy < 0 then
    self.dy = math.random(10, 150) 
  else
    self.dy = -math.random(10, 150)
  end
end

function Ball:render()
  love.graphics.rectangle('fill', self.x, self.y, BALL_SIZE, BALL_SIZE);  
end