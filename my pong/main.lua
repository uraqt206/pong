push = require 'push'
class = require 'class'
Paddle = require 'Paddle'


function love.load() 
  VIRTUE_WIDTH, VIRTUE_HEIGHT = 432, 243
  WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  push:setupScreen(VIRTUE_WIDTH, VIRTUE_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true
  })

  gameFont = love.graphics.newFont('font.ttf', 20)
end

function love.draw()
  push:apply('start');
  
  push:apply('end');
end