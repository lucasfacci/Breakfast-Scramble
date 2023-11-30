PlayerJumpShootState = Class{__includes = EntityJumpShootState}

function PlayerJumpShootState:enter(params)
    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - 53
    end

    self.entity.width = 210
    self.entity.height = 211

    self.entity.dy = params.dy

    self.waitTimer = params.waitTimer or 0
    self.waitDuration = params.waitDuration or 0.2

    self.canDash = params.canDash or false

    Event.dispatch('player-fire')
end

function PlayerJumpShootState:update(dt)
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
        self.entity.direction = 'left'
        self.entity:changeAnimation('jump-shoot-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        self.entity:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('jump-shoot-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        self.entity:checkRightCollisions(dt)
    end
    
    if self.entity.dy >= 0 then
        if love.keyboard.isDown('x') then
            if self.entity.direction == 'left' then
                self.entity.x = self.entity.x + 53
            end
            self.entity:changeState('fall-shoot', {waitTimer = self.waitTimer, waitDuration = self.waitDuration, canDash = self.entity.canDash})
        else
            self.entity:changeState('fall')
        end
    end
    
    if self.entity.dy then
        self.entity.dy = self.entity.dy + self.map.gravityAmount
        self.entity.y = self.entity.y + (self.entity.dy * dt)
    end

    -- check if we've collided with any collidable game objects
    for k, object in pairs(self.map.objects) do
        if object:collides(self.entity) then
            if object.solid then
                self.entity.y = object.y + object.height
                self.entity.dy = 0
                self.entity:changeState('fall')
            end
        end
    end

    EntityJumpShootState.update(self, dt)
end