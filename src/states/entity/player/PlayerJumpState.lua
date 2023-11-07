PlayerJumpState = Class{__includes = EntityJumpState}

function PlayerJumpState:enter(params)
    self.entity.dy = self.entity.jumpVelocity
end

function PlayerJumpState:update(dt)
    
    if love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    end
    
    if self.entity.dy >= 0 then
        self.entity:changeState('fall')
    end
    
    self.entity.dy = self.entity.dy + self.map.gravityAmount
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    EntityJumpState.update(self, dt)
end