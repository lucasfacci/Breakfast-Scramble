Projectile = Class{}

function Projectile:init(shooter, r, g, b)
    self.entity = shooter

    self.width = 30
    self.height = 30

    self.velocity = 1100

    self.up = self.entity.up

    if self.entity.direction == 'left' then
        self.x = self.entity.x - self.width
        self.y = self.entity.y + self.entity.height / 2 - self.height / 2
        self.dx = -self.velocity
    elseif self.entity.direction == 'right' then
        self.x = self.entity.x + self.entity.width
        self.y = self.entity.y + self.entity.height / 2 - self.height / 2
        self.dx = self.velocity
    end
    self.dy = -self.velocity

    self.r = 53
    self.g = 156
    self.b = 204

    self.hitbox = Hitbox(self.x, self.y, self.width, self.height)
end

function Projectile:update(dt)
    if self.up == true then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
    else
        self.x = self.x + self.dx * dt
    end
    -- self.y = self.y + self.dy * dt
end

function Projectile:render()
    love.graphics.setColor(self.r/255, self.g/255, self.b/255, 255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 255)
end