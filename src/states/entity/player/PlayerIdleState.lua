PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    self.entity.width = ENTITY_DEFS['player'].width
    self.entity.height = ENTITY_DEFS['player'].height
    self.entity.canDash = true
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        self.entity:changeState('walk')
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'
        self.entity:changeState('walk')
    end

    if love.keyboard.isDown('s') then
        self.entity.direction = 'front'
        self.entity:changeState('sneak')
    end

    if love.keyboard.wasPressed('space') then
        self.entity.direction = 'front'
        self.entity:changeState('jump')
    end

    EntityIdleState.update(self, dt)
end