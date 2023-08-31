EntityFallState = Class{__includes = BaseState}

function EntityFallState:init(entity, gravity)
    self.entity = entity
    self.gravity = gravity
end

function EntityFallState:update(dt)
    self.entity.dy = self.entity.dy + self.gravity
    self.entity.y = self.entity.y + (self.entity.dy * dt)
end

function EntityFallState:render()
    love.graphics.rectangle('fill', self.entity.x, self.entity.y, ENTITY_DEFS['player'].width, ENTITY_DEFS['player'].height)
end