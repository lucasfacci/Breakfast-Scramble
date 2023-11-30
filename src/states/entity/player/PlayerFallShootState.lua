PlayerFallShootState = Class{__includes = EntityFallShootState}

function PlayerFallShootState:enter(params)
    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - 53
    end

    self.entity.width = 210
    self.entity.height = 211

    self.waitTimer = params.waitTimer or 0
    self.waitDuration = params.waitDuration or 0.2

    self.canDash = params.canDash or false

    Event.dispatch('player-fire')
end

function PlayerFallShootState:update(dt)
    -- if press the left shift key, do a dash
    if love.keyboard.wasPressed('lshift') then
        if not self.entity.isDashing then
            self.entity:dash(dt)
            self.entity.canDash = false
        end
    end

    -- control the dash duration and velocity
    self.entity:controlDashing(dt)
    
    -- it controls the time between the shoots
    if self.waitTimer > self.waitDuration then
        self.waitTimer = 0
        self.waitDuration = 0.2
        Event.dispatch('player-fire')
    end
    self.waitTimer = self.waitTimer + dt

    if love.keyboard.isDown('left') then
        self.entity:changeAnimation('jump-shoot-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        self.entity:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.entity:changeAnimation('jump-shoot-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        self.entity:checkRightCollisions(dt)
    end
    
    self.entity.dy = self.entity.dy + self.map.gravityAmount
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    -- check if we've collided with any collidable game objects
    for k, object in pairs(self.map.objects) do
        if object:collides(self.entity) then
            if object.solid then
                
                self.entity:fallDamage()

                self.entity.dy = 0
                self.entity.y = object.y - self.entity.height

                if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
                    self.entity:changeState('walk')
                else
                    self.entity:changeState('idle')
                end
            end
        end
    end

    -- check if we are at the ground level
    if self.entity.y >= self.map.groundLevel - self.entity.height then
        self.entity:fallDamage()

        self.entity.y = self.map.groundLevel - self.entity.height
        self.entity.dy = 0

        if love.keyboard.isDown('left') then
            self.entity.direction = 'left'
            self.entity:changeState('walk')
        elseif love.keyboard.isDown('right') then
            self.entity.direction = 'right'
            self.entity:changeState('walk')
        else
            self.entity:changeState('idle')
        end
    end

    EntityFallShootState.update(self, dt)
end