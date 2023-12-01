PlayerIdleShootState = Class{__includes = EntityIdleShootState}

function PlayerIdleShootState:enter(params)
    self.entity.width = 255
    self.entity.height = 211
    self.entity.canDash = false
    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - 55
    end

    self.waitTimer = 0
    self.waitDuration = 0.2
end

function PlayerIdleShootState:update(dt)
    self.entity:changeAnimation('idle-shoot-' .. self.entity.direction)

    if love.keyboard.isDown('x') then
        -- it controls the time between the shoots
        if self.waitTimer == 0 then
            Event.dispatch('player-fire')
            self.waitDuration = 0.2
        elseif self.waitTimer > self.waitDuration then
            self.waitTimer = 0
            self.waitDuration = 0.2
            Event.dispatch('player-fire')
        end
        self.waitTimer = self.waitTimer + dt
    end

    if not love.keyboard.isDown('c') then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x + 55
        end

        if not love.keyboard.wasPressed('left') and not love.keyboard.wasPressed('right') then
            self.entity.direction = 'front'
            self.entity:changeState('idle')
        else
            self.entity:changeState('walk')
        end
    end

    if love.keyboard.wasPressed('left') then
        if self.entity.direction == 'right' then
            self.entity.x = self.entity.x - 55
        end
        self.entity.direction = 'left'
        -- self.entity:changeState('idle-shoot')
    elseif love.keyboard.wasPressed('right') then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x + 55
        end
        self.entity.direction = 'right'
        -- self.entity:changeState('idle-shoot')
    end

    EntityIdleShootState.update(self, dt)
end