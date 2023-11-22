PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:update(dt)
    -- walk straight to the left side
    if love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    -- walk straight to the right side
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    -- don't walk, stay idle
    else
        self.entity.direction = 'front'
        self.entity:changeState('idle')
    end

    EntityWalkState.update(self, dt)
end