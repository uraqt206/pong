push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

state = 'start'
servingPlayer = 1
PADDLE_SPEED = 175
BALL_SPEED = 200
BALL_SIZE = 5

function initFont() 
  startFont = love.graphics.newFont('font.ttf', 16)
  scoreFont = love.graphics.newFont('font.ttf', 48)
  winFont = love.graphics.newFont('font.ttf', 32)
end

function initSound() 
  hitWall = love.audio.newSource('sounds/wall_hit.wav', 'static')
  hitPaddle = love.audio.newSource('sounds/paddle_hit.wav', 'static')
  score = love.audio.newSource('sounds/score.wav', 'static')
end

function love.load() 
  VIRTUE_WIDTH, VIRTUE_HEIGHT = 432, 243
  WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('pong')
  push:setupScreen(VIRTUE_WIDTH, VIRTUE_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true
  })
  math.randomseed(os.time())
  initFont()
  initSound()
  Player1 = Paddle(0, 0, 10, 40)
  Player2 = Paddle(VIRTUE_WIDTH-10, VIRTUE_HEIGHT-30, 10, 40)
  Player1Point = 0
  Player2Point = 0
  Ball = Ball(VIRTUE_WIDTH/2-2, VIRTUE_HEIGHT/2-2, 0, 0)
end

function love.keypressed(key) 
  if key == 'return' then
    if state == 'serving' then
      state = 'playing'
      if servingPlayer == 1 then
        Ball.dx = BALL_SPEED
        Ball.dy = math.random(-150, 150)
      else 
        Ball.dx = -BALL_SPEED
        Ball.dy = math.random(-150, 150)
      end
    end

    if state == 'winning' then
      Player1Point = 0
      Player2Point = 0
      state = 'serving'
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
  love.graphics.printf('Press enter to start the game', 0, VIRTUE_HEIGHT/2+15, VIRTUE_WIDTH, 'center')
end

function Serving()
  love.graphics.setFont(startFont)
  love.graphics.printf('Player ' .. servingPlayer .. ' to serve', 0, VIRTUE_HEIGHT/2+100, VIRTUE_WIDTH, 'center')
  -- love.graphics.printf('Please press enter', 0, VIRTUE_HEIGHT/2+25, VIRTUE_WIDTH, 'center')
end

function Winning() 
  love.graphics.setFont(winFont)
  love.graphics.printf('Player ' .. winPlayer .. ' won!', 0, VIRTUE_HEIGHT/2-100, VIRTUE_WIDTH, 'center')
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
  
  Player1:update(dt)
  Player2:update(dt)
  if state == 'playing' then
    Ball:move(dt)
    
    if Player1:touch(Ball) then
      hitPaddle:play()
      Ball.x = Player1.x + Player1.width + 1
      Ball.dx = -Ball.dx - Ball.dx * dt  
    end

    if Player2:touch(Ball) then
      hitPaddle:play()
      Ball.x = Player2.x - BALL_SIZE - 1
      Ball.dx = -Ball.dx - Ball.dx * dt
    end

    if Ball.x <= 0 then
      score:play()
      Player2Point = Player2Point + 1
      servingPlayer = 1
      Ball:init(VIRTUE_WIDTH/2-2, VIRTUE_HEIGHT/2-2, 0, 0)
      state = 'serving'

      if Player2Point == 5 then
        winPlayer = 2
        servingPlayer = 1
        state = 'winning'
      end
    end

    if Ball.x > VIRTUE_WIDTH then
      score:play()
      Player1Point = Player1Point + 1
      servingPlayer = 2
      Ball:init(VIRTUE_WIDTH/2-2, VIRTUE_HEIGHT/2-2, 0, 0)
      state = 'serving'

      if Player1Point == 5 then
        winPlayer = 1
        servingPlayer = 2
        state = 'winning'
      end
    end

    if Ball.y <= 0 then
      hitWall:play()
      Ball:changeDy()
      Ball.y = 1
    end

    if Ball.y >= VIRTUE_HEIGHT-4 then
      hitWall:play()
      Ball:changeDy()
      Ball.y = VIRTUE_HEIGHT-5
    end
  end
end


function love.draw()
  push:apply('start');

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  
  Player1:render()
  Player2:render()

  if state ~= 'start' then
    love.graphics.setFont(scoreFont)
    love.graphics.printf(tostring(Player1Point), 0, VIRTUE_HEIGHT/2-20, VIRTUE_WIDTH/2 - 20, 'right')
    love.graphics.printf(tostring(Player2Point), VIRTUE_WIDTH/2 + 25, VIRTUE_HEIGHT/2-20, VIRTUE_WIDTH, 'left')
    Ball:render()
  end
  
  if state == 'start' then
    StartGame()
  end
  
  if state == 'serving' then
    Serving()
  end

  if state == 'winning' then
    Winning()
  end
  
  push:apply('end');
end