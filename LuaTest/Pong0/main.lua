Class = require 'class'
push = require 'push'

window_width = 1280
window_height = 720
virtual_width = 432
virtual_height = 243
paddle_speed = 200

require 'Ball'
require 'Paddle'
--[[
    Initializes the game window
]]
function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    victoryFont = love.graphics.newFont('font.ttf', 24 )
    --player scores and serving number
    player1score = 0
    player2score = 0
    servingPlayer = math.random(2) == 1 and 1 or 2
    winningPlayer = 0
    --establishes initial position of the paddle and ball
    player1 = Paddle(5, 20, 5, 20)
    player2 = Paddle(virtual_width - 10, virtual_height - 30, 5, 20)
    ball = Ball(virtual_width / 2 -2, virtual_height / 2 - 2, 4, 4)
    if servingPlayer == 1 then
        ball.dx = 100
    else
        ball.dx = -100
    end
    --establishing the game state
    gameState = 'start'
    --names the application window
    love.window.setTitle('Pong')
    --establishes sounds
    sounds = {
        ['paddle_hit'] = love.audio.newSource('paddle_hit.wav', 'static'),
        ['point_scored'] = love.audio.newSource('score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('hit.wav', 'static')
    }
    --establishes the window
    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        fullscreen = false,
        vsync = true,
        resizeable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Moving the paddle when a certain key is pressed
]]
function love.update(dt)
    if gameState == 'play' then

        --add score to player 2 if ball goes past player 1 paddle
        --if player 2 scores
        if ball.x <= 0 then
            player2score = player2score + 1
            servingPlayer = 1
            sounds['point_scored']:play()
            ball:reset()
            --establishes a victory condition
            if player2score >= 3 then
                gameState = 'victory'
                winningPlayer = 2
            else
                gameState = 'serve'
                ball.dx = 100 --serves ball towards player 2
            end
        end
        --if player 1 scores
        if ball.x >= virtual_width - 4 then
            player1score = player1score + 1
            servingPlayer = 2
            sounds['point_scored']:play()
            ball:reset()
            --establishes a victory condition
            if player1score >= 3 then
                gameState = 'victory'
                winningPlayer = 1
            else
                gameState = 'serve'
                ball.dx = -100 --serves the ball towards player 1
            end
        end
        --collision detection for the ball, will be deflected if it hits paddle
        if ball:collides(player1) then
            --deflect the ball to the right
            ball.dx = -ball.dx
            sounds['paddle_hit']:play()
        end
        if ball:collides(player2) then
            --deflect the ball to the left
            ball.dx = -ball.dx
            sounds['paddle_hit']:play()
        end
        if ball.y <= 0 then
            --deflects ball down
            ball.dy = -ball.dy
            ball.y = 0
            sounds['wall_hit']:play()
        end
        if ball.y >= virtual_height - 4 then
            --deflects the ball up
            ball.dy = -ball.dy
            ball.y = virtual_height - 4
            sounds['wall_hit']:play()
        end

        player1:update(dt)
        player2:update(dt)
        --changing paddle position
        --player 1
        if love.keyboard.isDown('w') then
            player1.dy = -paddle_speed
        elseif love.keyboard.isDown('s') then
            player1.dy = paddle_speed
        else
            player1.dy = 0
        end
        --player 2
        if love.keyboard.isDown('up') then
            player2.dy = -paddle_speed
        elseif love.keyboard.isDown('down') then
            player2.dy = paddle_speed
        else
            player2.dy = 0
        end

        --changing ball position
        if gameState == 'play' then
            ball:update(dt)
        end
    end
end



--[[
    Allows user to press escape key to exit the application and enter to start
]]
function love.keypressed(key)
    -- if escape is pressed, application closes
    if key == 'escape' then 
        love.event.quit()
    -- pressing enter/return will start the game by changing the gamestate
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'victory' then
            gameState = 'start'
            player1score = 0
            player2score = 0
        end
    end
end
    
--[[
    Draws stuff like text and rectangles
]]
function love.draw()
    push:apply('start')

    --sets backround color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    --establishes the ball
    ball:render()
    --establishes rectnagles
    player1:render()
    player2:render()

    --displays the FPS
    displayFPS()
    --Hello start/play state text
    love.graphics.setFont(smallFont)
    --welcome message
    if gameState == 'start' then
        love.graphics.printf('Welcome to Pong', 0, 20, virtual_width, 'center')
        love.graphics.printf('Press Enter to Play', 0, 32, virtual_width, 'center')
    elseif gameState == 'serve' then
        love.graphics.printf("Player" .. tostring(servingPlayer).."'s turn!", 0, 20, virtual_width, 'center')
        love.graphics.printf('Press Enter to Serve', 0, 32, virtual_width, 'center')
    elseif gameState == 'victory' then
        --draws a victory message
        love.graphics.setFont(victoryFont)
        love.graphics.printf("Player " .. tostring(winningPlayer).." wins!", 0, 20, virtual_width, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to Play Again or Escape to Quit', 0, 50, virtual_width, 'center')
    end
    --sets the font and score for the two players
    love.graphics.setFont(scoreFont)
    love.graphics.print(player1score, virtual_width / 2 - 50, virtual_height / 3 )
    love.graphics.print(player2score, virtual_width / 2 + 30, virtual_height / 3)
    

    push:apply('end')
end

function displayFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(smallFont)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 40, 20)
    love.graphics.setColor(1, 1, 1, 1)
end