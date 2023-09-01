EntityFallState = Class{__includes = BaseState}

function EntityFallState:init(entity, map)
    self.entity = entity
    self.map = map
end

function EntityFallState:update(dt)
    self.entity.dy = self.entity.dy + self.map.gravityAmount
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    if self.entity.y + self.entity.height >= self.map.height then
        self.entity:changeState('walk')
    end
end

function EntityFallState:render()
    love.graphics.rectangle('fill', self.entity.x, self.entity.y, ENTITY_DEFS['player'].width, ENTITY_DEFS['player'].height)
end