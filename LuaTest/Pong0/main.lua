window_width = 800
window_height = 600
function love.load()
    love.window.setMode(window_width, window_height, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end

function love.draw()
    love.graphics.printf("Hello Pong", 0, window_height / 2 - 6, window_width, 'center')
end

