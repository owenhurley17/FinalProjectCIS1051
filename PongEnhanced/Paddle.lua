Paddle = Class{}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height 
    self.dy = 0
end

function Paddle:update1(dt)
    if self.dy < 0 then 
        self.y = math.max(0, self.y + self.dy * dt)
    elseif self.dy > 0 then
        self.y = math.min(virtualHeight - 60, self.y + self.dy * dt)
    end
end

function Paddle:update2(dt)
    if self.dy < 0 then 
        self.y = math.max(15, self.y + self.dy * dt)
    elseif self.dy > 0 then 
        self.y = math.min(virtualHeight - 45, self.y + self.dy * dt)
    end
end

function Paddle:update3(dt)
    if self.dy < 0 then 
        self.y = math.max(30, self.y + self.dy * dt)
    elseif self.dy > 0 then 
        self.y = math.min(virtualHeight - 30, self.y + self.dy * dt)
    end
end

function Paddle:update4(dt)
    if self.dy < 0 then 
        self.y = math.max(45, self.y + self.dy * dt)
    elseif self.dy > 0 then 
        self.y = math.min(virtualHeight - 15, self.y + self.dy * dt)
    end
end    

function Paddle:update5(dt)
    if self.dy < 0 then 
        self.y = math.max(0, self.y + self.dy * dt)
    elseif self.dy > 0 then
        self.y = math.min(virtualHeight - 60 - paddleMultiplier, self.y + self.dy * dt)
    end
end


function Paddle:renderPlayer1()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:renderPlayer2()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height + paddleMultiplier)
end


