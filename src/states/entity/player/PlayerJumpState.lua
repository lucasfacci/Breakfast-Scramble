PlayerJumpState = Class{__includes = EntityJumpState}

function PlayerJumpState:enter(params)
    self.entity.dy = self.entity.jumpVelocity
    self.entity.canDash = true
end

function PlayerJumpState:update(dt)
    if love.keyboard.wasPressed('lshift') then
        if not self.entity.isDashing then
            self.entity:dash(dt)
            self.entity.canDash = false
        end
    end

    self.entity:controlDashing(dt)

    if love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('jump-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        self.entity:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('jump-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        self.entity:checkRightCollisions(dt)
    end
    
    if self.entity.dy >= 0 then
        self.entity:changeState('fall')
    end
    
    self.entity.dy = self.entity.dy + self.map.gravityAmount
    self.entity.y = self.entity.y + (self.entity.dy * dt)

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

    EntityJumpState.update(self, dt)
end