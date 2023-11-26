PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    self.entity.width = ENTITY_DEFS['player'].width
    self.entity.height = ENTITY_DEFS['player'].height
    self.entity.canDash = true
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeState('walk')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeState('walk')
    end

    if love.keyboard.isDown('c') then
        if love.keyboard.isDown('left') then
            self.entity.direction = 'left'
            self.entity:changeState('idle-shoot')
        elseif love.keyboard.isDown('right') then
            self.entity.direction = 'right'
            self.entity:changeState('idle-shoot')
        end
    end

    if love.keyboard.isDown('down') then
        self.entity.direction = 'front'
        self.entity:changeState('sneak')
    end

    if love.keyboard.wasPressed('z') then
        self.entity.direction = 'front'
        self.entity:changeState('jump')
    end

    EntityIdleState.update(self, dt)
end