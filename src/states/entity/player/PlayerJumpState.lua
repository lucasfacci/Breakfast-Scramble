PlayerJumpState = Class{__includes = EntityJumpState}

function PlayerJumpState:enter(params)
    self.entity.dy = self.entity.jumpVelocity
end

function PlayerJumpState:update(dt)
    self.entity.dy = self.entity.dy + self.map.gravityAmount
    self.entity.y = self.entity.y + (self.entity.dy * dt)
    
    if self.entity.dy >= 0 then
        self.entity:changeState('fall')
    end

    self.entity.y = self.entity.y + (self.entity.dy * dt)

    EntityJumpState.update(self, dt)
end