PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('a') or love.keyboard.isDown('d') then
        self.entity:changeState('walk')
    end

    if love.keyboard.isDown('s') then
        self.entity:changeState('sneak')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('jump')
    end

    EntityIdleState.update(self, dt)
end