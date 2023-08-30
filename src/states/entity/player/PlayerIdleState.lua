PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
        love.keyboard.isDown('up') or love.keyboard.isDown('down') or
        love.keyboard.isDown('a') or love.keyboard.isDown('d') or
        love.keyboard.isDown('w') or love.keyboard.isDown('s') then
        self.entity:changeState('walk')
    end
end