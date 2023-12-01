BossIdleState = Class{__includes = EntityIdleState}

function BossIdleState:enter(params)
    self.entity.width = ENTITY_DEFS['boss'].width
    self.entity.height = ENTITY_DEFS['boss'].height
end

function BossIdleState:update(dt)
    EntityIdleState.update(self, dt)
end