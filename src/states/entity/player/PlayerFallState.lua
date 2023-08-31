PlayerFallState = Class{__includes = EntityFallState}

function PlayerFallState:enter(params)
end

function PlayerFallState:update(dt)
    EntityFallState.update(self, dt)
end