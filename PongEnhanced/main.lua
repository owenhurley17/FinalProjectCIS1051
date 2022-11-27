Class = require 'class'
push = require 'push'
require 'Paddle'
require 'Ball'

--establishes window height/width
windowWidth = 1280
windowHeight = 720
virtualWidth = 854
virtualHeight = 480
paddleSpeed = 250

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --screen title
    love.window.setTitle('PongEnhanced')
    --initial gamestate
    gameState = 'main_menu'
    --establishes fonts
    titelScreenFont = love.graphics.newFont('font.ttf', 50)
    mediumFont = love.graphics.newFont('font.ttf', 24)
    smallFont = love.graphics.newFont('font.ttf', 18)
    math.randomseed(os.time())
    --establihes initial store
    player1score = 0
    player2score = 0
    establishPaddles()
    --displays FPS
    displayFPS()
    --establishes the window
    push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })
end

function love.keypressed(key)
    --if escape is pressed application closes
    if key == 'escape' then
        love.event.quit()
    --enter pressed game goes to start stae
    elseif key == 'enter' or key == 'return' then
        if gameState == 'main_menu' then
            gameState = 'start'
        end
    elseif key == 'space' then
        gameState = 'play'
    end
end

function love.update(dt)
    if gameState == 'play' then
        --if the ball collides with any of the paddles for player 1
        if ball:collides(player1paddle1) then
            ball.dx = -ball.dx
        end
        if ball:collides(player1paddle2) then
            ball.dx = -ball.dx
        end
        if ball:collides(player1paddle3) then
            ball.dx = -ball.dx
        end
        if ball:collides(player1paddle4) then
            ball.dx = -ball.dx
        end
        -- if the ball collides with any of the paddles for player 2
        if ball:collides(player2paddle1) then
            ball.dx = -ball.dx
        end
        if ball:collides(player2paddle2) then
            ball.dx = -ball.dx
        end
        if ball:collides(player2paddle3) then
            ball.dx = -ball.dx
        end
        if ball:collides(player2paddle4) then
            ball.dx = -ball.dx
        end
        --[[moves the ball, the update function is different for each paddle as the min/max y boundaries
        are different for each part of the paddle]]
        player1paddle1:update1(dt)
        player1paddle2:update2(dt)
        player1paddle3:update3(dt)
        player1paddle4:update4(dt)
        player2paddle1:update1(dt)
        player2paddle2:update2(dt)
        player2paddle3:update3(dt)
        player2paddle4:update4(dt)
        player1Movement(dt)
        player2Movement(dt)
        --deflects ball if it hits upper/lower border
        ballYDeflection()
        if gameState == 'play' then
            ball:update(dt)
        end
    end
end

function love.draw()
    push:apply('start')
    --makes the backround color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)
    --main menu establishment
    if gameState == 'main_menu' then
        mainMenu()
    elseif gameState == 'start' then
        start()
    elseif gameState == 'play' then
        play()
    end
    --draws the score
    if gameState ~='main_menu' then
        love.graphics.setFont(titelScreenFont)
        love.graphics.print(player1score, virtualWidth / 2 - 100, virtualHeight / 3)
        love.graphics.print(player2score, virtualWidth / 2 + 70, virtualHeight / 3)
    end
    push:apply('end')
end

function displayFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(smallFont)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 40, 20)
    love.graphics.setColor(1, 1, 1, 1)
end

function mainMenu()
    love.graphics.setFont(titelScreenFont)
    love.graphics.printf('Welcome to Pong Enhanced', 0, 20, virtualWidth, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Start or Escape to Exit', 0, 100, virtualWidth, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf('Created by Owen Hurley, based on CS50 2020 code', 0, virtualHeight - 25,
     virtualWidth, 'center')
    --the two rectangles
    love.graphics.rectangle('fill', virtualWidth / 3.5 ,virtualHeight / 2 + 20, 10, 40)
    love.graphics.rectangle('fill', virtualWidth - virtualWidth / 3.5, virtualHeight / 2 + 20, 10, 40)
    -- the ball & trace rectangle
    love.graphics.rectangle('fill', virtualWidth / 2 - 2, virtualHeight / 2 + 33, 10, 10)
    love.graphics.rectangle('line', virtualWidth / 3.5 - 5, virtualHeight / 3, 
    virtualWidth -468, 240)
end

function start()
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Space to Begin', 0, 25, virtualWidth, 'center')
end

function play()
    player1paddle1:render()
    player1paddle2:render()
    player1paddle3:render()
    player1paddle4:render()
    player2paddle1:render()
    player2paddle2:render()
    player2paddle3:render()
    player2paddle4:render()
    ball:render()
end

function establishPaddles()
    --displays paddles, player 1
    player1paddle1 = Paddle(5, 20, 7, 15)
    player1paddle2 = Paddle(5, 35, 7, 15)
    player1paddle3 = Paddle(5, 50, 7, 15)
    player1paddle4 = Paddle(5, 65, 7, 15)
    --player 2 paddles
    player2paddle1 = Paddle(virtualWidth - 12, 20, 7, 15)
    player2paddle2 = Paddle(virtualWidth - 12, 35, 7, 15)
    player2paddle3 = Paddle(virtualWidth - 12, 50, 7, 15)
    player2paddle4 = Paddle(virtualWidth - 12, 65, 7, 15)
    --the ball
    ball = Ball(virtualWidth / 2 - 4, virtualHeight / 2 - 4, 8, 8)
end

function player1Movement()
    if love.keyboard.isDown('w') then
        player1paddle1.dy = -paddleSpeed
        player1paddle2.dy = -paddleSpeed
        player1paddle3.dy = -paddleSpeed
        player1paddle4.dy = -paddleSpeed
    elseif love.keyboard.isDown('s') then
        player1paddle1.dy = paddleSpeed
        player1paddle2.dy = paddleSpeed
        player1paddle3.dy = paddleSpeed
        player1paddle4.dy = paddleSpeed
    else
        player1paddle1.dy = 0
        player1paddle2.dy = 0
        player1paddle3.dy = 0
        player1paddle4.dy = 0
    end
end

function player2Movement()
    if love.keyboard.isDown('up') then
        player2paddle1.dy = -paddleSpeed
        player2paddle2.dy = -paddleSpeed
        player2paddle3.dy = -paddleSpeed
        player2paddle4.dy = -paddleSpeed
    elseif love.keyboard.isDown('down') then
        player2paddle1.dy = paddleSpeed
        player2paddle2.dy = paddleSpeed
        player2paddle3.dy = paddleSpeed
        player2paddle4.dy = paddleSpeed
    else
        player2paddle1.dy = 0
        player2paddle2.dy = 0
        player2paddle3.dy = 0
        player2paddle4.dy = 0
    end
end

function ballYDeflection()
    if ball.y <= 0 then
        ball.dy = -ball.dy
        ball.y = 0
    end
    if ball.y >= virtualHeight - 8 then
        ball.dy = -ball.dy
        ball.y = virtualHeight - 8
    end
end

