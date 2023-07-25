

Paddle = Class {}

function Paddle:init(_x, _y, _w, _h)
  self.x, self.y, self.width, self.height, self.dy = _x, _y, _w, _h, 0
end

function Paddle:render()
  -- love.graphics.printf(tostring(self.w), 0, VIRTUE_HEIGHT, VIRUTE_WIDTH, 'center')
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  -- love.graphics.rectangle('line', 0, 0, 10, 20)
end 