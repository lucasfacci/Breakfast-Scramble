PlayerFallState = Class{__includes = EntityFallState}

function PlayerFallState:update(dt)
    EntityFallState.update(self, dt)
end