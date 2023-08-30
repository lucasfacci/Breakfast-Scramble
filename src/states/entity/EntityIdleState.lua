EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity)
    self.entity = entity
end

function EntityIdleState:render()
    love.graphics.rectangle('fill', self.entity.x, self.entity.y, ENTITY_DEFS['player'].width, ENTITY_DEFS['player'].height)
end