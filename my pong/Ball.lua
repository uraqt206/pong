Ball = Class{}

function Ball:init(_x, _y, _dx, _dy)
  self.x, self.y, self.dx, self.dy = _x, _y, _dx, _dy
end

function Ball:render()
  love.graphics.rectangle('fill', self.x, self.y, 4, 4);
end