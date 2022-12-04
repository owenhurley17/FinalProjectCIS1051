Class = require 'class'
push = require 'push'
require 'Paddle'
require 'Ball'
require 'addfunctions'

--establishes window height/width
windowWidth = 1280
windowHeight = 720
virtualWidth = 854
virtualHeight = 480
paddleSpeedPlayer2 = 150
paddleSpeedPlayer1 = 250
paddleMultiplier = 0

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
    --establihes initial store and the initial server
    player1score = 0
    player2score = 0
    servingPlayer = math.random(2) == 1 and 1 or 2
    winningPlayer = 0
    winningScore = 5
    establishPaddles()
    --imports sounds
    sounds = {
        ['paddle_hit'] = love.audio.newSource('paddle_hit.wav', 'static'),
        ['point_scored'] = love.audio.newSource('score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('hit.wav', 'static')
    }
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
        elseif gameState == 'play' then
            gameState = 'start'
        end
    elseif key == 'space' and gameState == 'start' then
        gameState = 'play'
        ball:reset()
    elseif key == 'space' and gameState == 'serve' then
        gameState = 'play'
    elseif key == 'space' and gameState == 'victory' then
        gameState = 'start'
    end
end

function love.update(dt)
    if gameState == 'play' then
        --if player 1 or 2scores
        player2scores()
        player1scores()
        --if the ball collides with any of the paddles for player 1 or 2
        collision()
        --[[moves the ball, the update function is different for each paddle as the min/max y boundaries
        are different for each part of the paddle]]
        player1paddle1:update1(dt)
        player1paddle2:update2(dt)
        player1paddle3:update3(dt)
        player1paddle4:update4(dt)
        player2paddle1:update5(dt)
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
    elseif gameState == 'serve' then
        serve()
    elseif gameState == 'victory' then
        victory()
        player1score = 0
        player2score = 0
    end
    --draws the score
    if gameState ~='main_menu' then
        love.graphics.setFont(titelScreenFont)
        love.graphics.print(player1score, virtualWidth / 2 - 100, virtualHeight / 3)
        love.graphics.print(player2score, virtualWidth / 2 + 70, virtualHeight / 3)
    end
    push:apply('end')
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
    player1paddle1:renderPlayer1()
    player1paddle2:renderPlayer1()
    player1paddle3:renderPlayer1()
    player1paddle4:renderPlayer1()
    player2paddle1:renderPlayer2()
    ball:render()
end

function serve()
    player1paddle1:renderPlayer1()
    player1paddle2:renderPlayer1()
    player1paddle3:renderPlayer1()
    player1paddle4:renderPlayer1()
    player2paddle1:renderPlayer2()
    ball:render()
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Space to Play Next Round', 0, 25, virtualWidth, 'center')
end

function establishPaddles()
    --displays paddles, player 1
    paddleHeight = 18
    player1paddle1 = Paddle(5, 20, 7, paddleHeight)
    player1paddle2 = Paddle(5, 35, 7, paddleHeight)
    player1paddle3 = Paddle(5, 50, 7, paddleHeight)
    player1paddle4 = Paddle(5, 65, 7, 15)
    --player 2 paddles
    player2paddle1 = Paddle(virtualWidth - 12, 20, 7, 60)
    --the ball
    ball = Ball(virtualWidth / 2 - 4, virtualHeight / 2 - 4, 8, 8)
    --establishes initial server
    if servingPlayer == 1 then
        ball.dx = 200
    else
        ball.dx = -200
    end
end

function player1Movement()
    if love.keyboard.isDown('w') then
        player1paddle1.dy = -paddleSpeedPlayer1
        player1paddle2.dy = -paddleSpeedPlayer1
        player1paddle3.dy = -paddleSpeedPlayer1
        player1paddle4.dy = -paddleSpeedPlayer1
    elseif love.keyboard.isDown('s') then
        player1paddle1.dy = paddleSpeedPlayer1
        player1paddle2.dy = paddleSpeedPlayer1
        player1paddle3.dy = paddleSpeedPlayer1
        player1paddle4.dy = paddleSpeedPlayer1
    else
        player1paddle1.dy = 0
        player1paddle2.dy = 0
        player1paddle3.dy = 0
        player1paddle4.dy = 0
    end
end

function player2Movement()
    if gameState == 'play' then
        if player2paddle1.y > ball.y then
            player2paddle1.dy = -paddleSpeedPlayer2
        elseif player2paddle1.y < ball.y then
            player2paddle1.dy = paddleSpeedPlayer2
        end
    else
        player2paddle1.dy = 0
    end
end

function ballYDeflection()
    if ball.y <= 0 then
        ball.dy = -ball.dy
        sounds['wall_hit']:play()
        --ball.y = 0
    end
    if ball.y >= virtualHeight - 8 then
        ball.dy = -ball.dy
        sounds['wall_hit']:play()
        --ball.y = virtualHeight - 8
    end
end

function collision()
    --collides with player 1 paddles (with the holes between paddles)
    if ball:collides(player1paddle1) then
        ball.dx = -ball.dx
        sounds['paddle_hit']:play()
    end
    if ball:collides(player1paddle2) then
        ball.dx = -ball.dx
        sounds['paddle_hit']:play()
    end
    if ball:collides(player1paddle3) then
        ball.dx = -ball.dx
        sounds['paddle_hit']:play()
    end
    if ball:collides(player1paddle4) then
        ball.dx = -ball.dx
        sounds['paddle_hit']:play()
    end
    -- if the ball collides with any of the paddle for player 2
    if ball:collides(player2paddle1) then
        ball.dx = -ball.dx
        sounds['paddle_hit']:play()
    end
end

function player2scores()
    if ball.x <= 0 then
        player2score = player2score + 1
        servingPlayer = 1
        paddleMultiplier = paddleMultiplier + 12
        sounds['point_scored']:play()
        ball:reset()
        --establishes a victory condition
        if player2score >= winningScore then
            gameState = 'victory'
            winningPlayer = 2
        else
            gameState = 'serve'
            serve()
            ball.dx = 300 --serves ball towards player 2
        end
    end
end

function player1scores()
    if ball.x >= virtualWidth - 8 then
        player1score = player1score + 1
        servingPlayer = 2
        sounds['point_scored']:play()
        ball:reset()
        --establishes victory condition
        if player1score >= winningScore then
            gameState = 'victory'
            winningPlayer = 1
        else
            gameState = 'serve'
            serve()
            ball.dx = -300 --serves ball towards player 1
        end
    end
end

function victory()
    if winningPlayer == 1 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Player 1 Wins!', 0, 25, virtualWidth, 'center')
        love.graphics.printf('Press Space to Play Again or Escape to Exit', 0, 100, virtualWidth, 'center')
    elseif winningPlayer == 2 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Player 2 Wins!', 0, 25, virtualWidth, 'center')
        love.graphics.printf('Press Space to Play Again or Escape to Exit', 0, 100, virtualWidth, 'center')
    end
    paddleMultiplier = 0
end
