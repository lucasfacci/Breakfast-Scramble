PlayerSneakState = Class{__includes = EntitySneakState}

function PlayerSneakState:enter(params)
    self.entity.width = 223
    self.entity.height = 174
    self.entity.y = self.entity.y + 38
    self.entity.x = self.entity.x - 14
end

function PlayerSneakState:update(dt)
    if not love.keyboard.isDown('s') then
        self.entity.width = ENTITY_DEFS['player'].width
        self.entity.height = ENTITY_DEFS['player'].height
        self.entity.y = self.entity.y - 38
        self.entity.x = self.entity.x + 14
        self.entity:changeState('walk')
    end

    EntitySneakState.update(self, dt)
end