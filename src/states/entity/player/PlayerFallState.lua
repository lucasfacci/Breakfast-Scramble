PlayerFallState = Class{__includes = EntityFallState}

function PlayerFallState:update(dt)
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
            self.entity:changeState('fall-shoot', {})
        end
    end

    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('fall-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        self.entity:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('fall-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        self.entity:checkRightCollisions(dt)
    end
    
    if self.map.finish == true then
        self.entity:changeAnimation('carry')
        Timer.after(5, function()
            self.entity.dy = self.entity.dy + self.map.gravityAmount
            self.entity.y = self.entity.y + (self.entity.dy * dt)
            Timer.after(3, function()
                gStateStack:pop()
                gStateStack:push(CreditsState())
            end)
        end)
    else
        self.entity.dy = self.entity.dy + self.map.gravityAmount
        self.entity.y = self.entity.y + (self.entity.dy * dt)
    end

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
    if self.map.finish == false then
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
    elseif self.map.finish == true then

    end

    EntityFallState.update(self, dt)
end