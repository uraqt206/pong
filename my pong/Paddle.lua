

Paddle = Class {}

VIRTUE_WIDTH, VIRTUE_HEIGHT = 432, 243
WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720

function Paddle:init(_x, _y, _w, _h)
  self.x, self.y, self.width, self.height, self.dy = _x, _y, _w, _h, 0
end

function Paddle:up() 
  self.y = self.y - 1
  if self.y < 0 then
    self.y = 0
  end
end

function Paddle:update(dt) 
  if self.dy < 0 then
    self.y = math.max(0, self.y + self.dy * dt)
  elseif self.dy > 0 then
    self.y = math.min(VIRTUE_HEIGHT - self.height, self.y + self.dy * dt)
  end
end

function Paddle:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end 