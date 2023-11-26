PlayerWalkShootState = Class{__includes = EntityWalkShootState}

function PlayerWalkShootState:enter(params)
    self.entity.width = 210
    self.entity.height = 211
    self.entity.canDash = true
    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - 53
    end
    self.waitTimer = 0
    self.waitDuration = 0.2

    Event.dispatch('player-fire')
end

function PlayerWalkShootState:update(dt)
    -- temporarily shift player down a pixel to test for game objects beneath
    self.entity.y = self.entity.y + 1

    local collidedObjects = self.entity:checkObjectCollisions()

    self.entity.y = self.entity.y - 1
    
    -- it controls the time between the shoots
    if self.waitTimer > self.waitDuration then
        self.waitTimer = 0
        self.waitDuration = 0.2
        Event.dispatch('player-fire')
    end
    self.waitTimer = self.waitTimer + dt

    -- if release the x key, return to the walk state
    if not love.keyboard.isDown('x') then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x + 53
        end
        self.entity:changeState('walk')
    end
    
    -- if press the left shift key, do a dash
    if love.keyboard.wasPressed('lshift') then
        if not self.entity.isDashing then
            self.entity:dash(dt)
        end
    end

    -- control the dash duration and velocity
    self.entity:controlDashing(dt)

    if love.keyboard.isDown('c') then
        self.entity:changeState('idle-shoot')
    end
    
    if #collidedObjects == 0 and self.entity.y < self.map.groundLevel - self.entity.height then
        self.entity.dy = 0
        self.entity:changeState('fall')
    -- walk straight to the left side
    elseif love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-shoot-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        self.entity:checkLeftCollisions(dt)
    -- walk straight to the right side
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-shoot-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        self.entity:checkRightCollisions(dt)
    -- don't walk, stay idle
    else
        self.entity.direction = 'front'
        self.entity:changeState('idle')
    end

    if love.keyboard.wasPressed('z') then
        if love.keyboard.isDown('x') then
            if self.entity.direction == 'left' then
                self.entity.x = self.entity.x + 53
            end
            self.entity:changeState('jump-shoot', {waitTimer = self.waitTimer, waitDuration = self.waitDuration, dy = self.entity.jumpVelocity, canDash = self.entity.canDash})
        else
            self.entity:changeState('jump')
        end
    end

    EntityWalkShootState.update(self, dt)
end