Ball = Class{}

function Ball:init(x, y, width, height)
    --establishes ball variables
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    --keeps track of velocity
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    --when the game starts/restarts the ball is placed in center of screen
    self.x = virtual_width / 2 - 2
    self.y = virtual_height / 2 - 2
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    --allows the ball to move by giving it an x and y direction times dt
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    --renders the ball
    love.graphics.rectangle('fill', self.x, self.y, 4, 4)
end

function Ball:collides(box)
    if self.x > box.x + box.width or self.x + self.width < box.x then
        return false
    end

    if self.y > box.y + box.height or self.y + self.height < box.y then
        return false
    end

    return true
end