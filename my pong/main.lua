push = require 'push'
Class = require 'class'
require 'Paddle'

state = 'start'
servingPlayer = 1;
PADDLE_SPEED = 100

function love.load() 
  VIRTUE_WIDTH, VIRTUE_HEIGHT = 432, 243
  WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
  love.graphics.setDefaultFilter('nearest', 'nearest')
  push:setupScreen(VIRTUE_WIDTH, VIRTUE_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true
  })
  startFont = love.graphics.newFont('font.ttf', 20)
  startFont2 = love.graphics.newFont('font.ttf', 10)
  Paddle1 = Paddle(0, 0, 10, 30)
  Paddle2 = Paddle(VIRTUE_WIDTH-10, VIRTUE_HEIGHT-30, 10, 30)
end

function love.keypressed(key) 
  love.graphics.printf(tostring(key), 0, 0, VIRTUE_WIDTH, 'center')
  if key == 'return' then
    if (state == 'serving') then
      state = 'playing'
    end

    if state == 'start' then
      state = 'serving'
    end

  end

  if key == 'escape' then
    love.event.quit()
  end
end

function StartGame()
  love.graphics.setFont(startFont)
  love.graphics.printf('Welcome to the pong!', 0, VIRTUE_HEIGHT/2-6, VIRTUE_WIDTH, 'center')
  love.graphics.setFont(startFont2)
  love.graphics.printf('Press enter to start the game', 0, VIRTUE_HEIGHT/2+15, VIRTUE_WIDTH, 'center')
end

function Serving()
  love.graphics.printf('Player ' .. servingPlayer .. ' to serve', 0, VIRTUE_HEIGHT/2-6, VIRTUE_WIDTH, 'center')
  love.graphics.printf('Please press enter', 0, VIRTUE_HEIGHT/2+10, VIRTUE_WIDTH, 'center')
end

function love.draw()
  push:apply('start');
  
  if state ~= 'start' then
    Paddle1:render()
    Paddle2:render()
  end

  if state == 'start' then
    StartGame()
  end
  
  if state == 'serving' then
    Serving()
  end

  push:apply('end');
end