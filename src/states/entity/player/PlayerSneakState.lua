PlayerSneakState = Class{__includes = EntitySneakState}

function PlayerSneakState:enter(params)
    self.entity.y = self.entity.y + 33
    self.entity.x = self.entity.x - 12
end

function PlayerSneakState:update(dt)
    if not love.keyboard.isDown('s') then
        self.entity.y = self.entity.y - 33
        self.entity.x = self.entity.x + 12
        self.entity:changeState('walk')
    end

    EntitySneakState.update(self, dt)
end