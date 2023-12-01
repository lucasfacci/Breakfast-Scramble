Projectile = Class{}

function Projectile:init(shooter, target)
    self.entity = shooter
    self.target = target

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

    if self.entity.type == 'player' then
        self.r = 53
        self.g = 156
        self.b = 204
    elseif self.entity.type == 'boss' then
        self.r = 53
        self.g = 204
        self.b = 156
        self.y = self.entity.y + self.entity.height / 2 + 50
    end

    self.hitbox = Hitbox(self.x, self.y, self.width, self.height)

    self.hit = false
end

function Projectile:update(dt)
    if self.up == true then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
    else
        self.x = self.x + self.dx * dt
    end

    self.hitbox.x = self.x
    self.hitbox.y = self.y

    if self.target then
        if self.target:collides(self.hitbox) and not self.target.dead and self.target.immunityDuration == 0 then
            self.target:damage(1)
            self.hit = true
        end
    end
end

function Projectile:render()
    love.graphics.setColor(self.r/255, self.g/255, self.b/255, 255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 255)

    if self.entity.type == 'boss' then
        print('')
    end
end