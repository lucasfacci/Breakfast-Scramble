PlayerIdleShootState = Class{__includes = EntityIdleShootState}

function PlayerIdleShootState:enter(params)
    self.entity.width = 200
    self.entity.height = 211
    self.entity.canDash = false

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
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('left') then
        self.entity.direction = 'left'
    elseif love.keyboard.wasPressed('right') then
        self.entity.direction = 'right'
    end

    -- if love.keyboard.isDown('left') then
    --     self.entity.direction = 'left'
    --     self.entity:changeState('walk')
    -- elseif love.keyboard.isDown('right') then
    --     self.entity.direction = 'right'
    --     self.entity:changeState('walk')
    -- end

    -- if love.keyboard.isDown('down') then
    --     self.entity.direction = 'front'
    --     self.entity:changeState('sneak')
    -- end

    -- if love.keyboard.wasPressed('z') then
    --     self.entity.direction = 'front'
    --     self.entity:changeState('jump')
    -- end

    EntityIdleShootState.update(self, dt)
end