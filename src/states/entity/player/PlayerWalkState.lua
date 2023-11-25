PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:enter(params)
    self.entity.width = 157
    self.entity.height = 211
    self.entity.canDash = true
end

function PlayerWalkState:update(dt)
    -- temporarily shift player down a pixel to test for game objects beneath
    self.entity.y = self.entity.y + 1

    local collidedObjects = self.entity:checkObjectCollisions()

    self.entity.y = self.entity.y - 1
    
    if love.keyboard.wasPressed('lshift') then
        if not self.entity.isDashing then
            self.entity:dash(dt)
        end
    end

    self.entity:controlDashing(dt)
    
    if #collidedObjects == 0 and self.entity.y < self.map.groundLevel - self.entity.height then
        self.entity.dy = 0
        self.entity:changeState('fall')
    -- walk straight to the left side
    elseif love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        self.entity:checkLeftCollisions(dt)
    -- walk straight to the right side
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        self.entity:checkRightCollisions(dt)
    -- don't walk, stay idle
    else
        self.entity.direction = 'front'
        self.entity:changeState('idle')
    end

    EntityWalkState.update(self, dt)
end