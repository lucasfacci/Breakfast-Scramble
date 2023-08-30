EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity
end

function EntityWalkState:update(dt)
    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    elseif self.entity.direction == 'up' then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    elseif self.entity.direction == 'down' then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    end
end

function EntityWalkState:render()
    love.graphics.rectangle('fill', self.entity.x, self.entity.y, ENTITY_DEFS['player'].width, ENTITY_DEFS['player'].height)
end