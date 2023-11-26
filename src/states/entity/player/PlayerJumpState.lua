PlayerJumpState = Class{__includes = EntityJumpState}

function PlayerJumpState:enter(params)
    self.entity.width = ENTITY_DEFS['player'].width
    self.entity.height = ENTITY_DEFS['player'].height
    self.entity.dy = self.entity.jumpVelocity
    self.entity.canDash = true
end

function PlayerJumpState:update(dt)
    -- if press the left shift key, do a dash
    if love.keyboard.wasPressed('lshift') then
        if not self.entity.isDashing then
            self.entity:dash(dt)
            self.entity.canDash = false
        end
    end

    -- control the dash duration and velocity
    self.entity:controlDashing(dt)

    if love.keyboard.isDown('x') then
        if self.entity.direction ~= 'front' then
            self.entity:changeState('jump-shoot', {dy = self.entity.dy, canDash = self.entity.canDash})
        end
    end

    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('jump-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        self.entity:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
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