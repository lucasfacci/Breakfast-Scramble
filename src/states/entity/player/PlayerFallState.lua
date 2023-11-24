PlayerFallState = Class{__includes = EntityFallState}

function PlayerFallState:update(dt)
    if love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('fall-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        self.entity:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('fall-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        self.entity:checkRightCollisions(dt)
    end
    
    self.entity.dy = self.entity.dy + self.map.gravityAmount
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    -- check if we've collided with any collidable game objects
    for k, object in pairs(self.map.objects) do
        if object:collides(self.entity) then
            if object.solid then
                self.entity.dy = 0
                self.entity.y = object.y - self.entity.height

                if love.keyboard.isDown('a') or love.keyboard.isDown('d') then
                    self.entity:changeState('walk')
                else
                    self.entity:changeState('idle')
                end
            end
        end
    end

    -- check if we are at the ground level
    if self.entity.y >= self.map.groundLevel - self.entity.height then
        self.entity.y = self.map.groundLevel - self.entity.height
        self.entity.dy = 0
        if love.keyboard.isDown('a') then
            self.entity.direction = 'left'
            self.entity:changeState('walk')
        elseif love.keyboard.isDown('d') then
            self.entity.direction = 'right'
            self.entity:changeState('walk')
        else
            self.entity:changeState('idle')
        end
    end

    EntityFallState.update(self, dt)
end