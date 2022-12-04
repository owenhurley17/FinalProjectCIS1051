Ball = Class{}

ballyspeed = 200
ballxspeed = 300

function Ball:init(x, y, width, height)
    --establishes ball variables
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    --keeps track of velocity
    self.dx = math.random(2) == 1 and -ballxspeed or ballxspeed
    self.dy = math.random(-ballyspeed, ballyspeed)
end

function Ball:reset()
    --restarts game when ball is placed in center of screen
    self.x = virtualWidth / 2 - 4
    self.y = virtualHeight / 2 - 4
    self.dx = math.random(2) == 1 and -ballxspeed or ballyspeed
    self.dy = math.random(-ballyspeed, ballyspeed)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end


function Ball:collides(box)
    if self.x > box.x + box.width or self.x + self.width < box.x then
        return false
    end
    if self.y > box.y + (box.height + paddleMultiplier) or self.y + self.height < box.y then
        return false
    end
    return true
end

function Ball:render()
    --renders ball
    love.graphics.rectangle('fill', self.x, self.y, 8, 8)
end

