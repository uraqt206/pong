push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

state = 'start'
servingPlayer = 1;
PADDLE_SPEED = 100

function love.load() 
  love.graphics.setDefaultFilter('nearest', 'nearest')
  VIRTUE_WIDTH, VIRTUE_HEIGHT = 432, 243
  WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
  push:setupScreen(VIRTUE_WIDTH, VIRTUE_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
  })
  startFont = love.graphics.newFont('font.ttf', 16)
  startFont2 = love.graphics.newFont('font.ttf', 16)
  Player1 = Paddle(0, 0, 10, 30)
  Player2 = Paddle(VIRTUE_WIDTH-10, VIRTUE_HEIGHT-30, 10, 30)
  Ball = Ball(VIRTUE_WIDTH/2-2, VIRTUE_HEIGHT/2-2, 0, 0)
end

function love.keypressed(key) 
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

function drawStartGame()
  love.graphics.setFont(startFont)
  love.graphics.printf('Welcome to the pong!', 0, VIRTUE_HEIGHT/2-6, VIRTUE_WIDTH, 'center')
  love.graphics.setFont(startFont2)
  love.graphics.printf('Press enter to start the game', 0, VIRTUE_HEIGHT/2+15, VIRTUE_WIDTH, 'center')
end

function drawServing()
  Ball:render()
  Player1:render()
  Player2:render()
  love.graphics.printf('Player ' .. servingPlayer .. ' to serve', 0, VIRTUE_HEIGHT/2+10, VIRTUE_WIDTH, 'center')
  love.graphics.printf('Please press enter', 0, VIRTUE_HEIGHT/2+25, VIRTUE_WIDTH, 'center')
end

function drawPlaying() 
  Ball:render()
  Player1:render()
  Player2:render()
end

function love.update(dt) 
  if love.keyboard.isDown('w') then
    Player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
    Player1.dy = PADDLE_SPEED
  else
    Player1.dy = 0
  end
  
  if love.keyboard.isDown('up') then
    Player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('down') then
    Player2.dy = PADDLE_SPEED
  else 
    Player2.dy = 0
  end
  
  if state ~= 'start' then
    Player1:update(dt)
    Player2:update(dt)
  end
end

function love.draw()
  push:apply('start');

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  
  if state == 'start' then
    drawStartGame()
  end
  
  if state == 'serving' then
    drawServing()
  end
  
  if state == 'playing' then
    drawPlaying()
  end
  
  push:apply('end');
end