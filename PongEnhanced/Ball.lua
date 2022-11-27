Ball = Class{}

function Ball:init(x, y, width, height)
    --establishes ball variables
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    --keeps track of velocity
    self.dx = math.random(2) == 1 and -200 or 200
    self.dy = math.random(-100, 100)
end

function Ball:reset()
    --restarts game when ball is placed in center of screen
    self.x = virtualWidth / 2 - 4
    self.y = virtualHeight / 2 - 4
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
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

function Ball:render()
    --renders ball
    love.graphics.rectangle('fill', self.x, self.y, 8, 8)
end

