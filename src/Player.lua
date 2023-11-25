Player = Class{__includes = Entity}

function Player:init(def)
    self.canDash = true
    self.isDashing = false
    self.dashDuration = 0.2
    self.dashTimer = 0

    Entity.init(self, def)
end

function Player:update(dt)
    if self.health <= 0 then
        gStateStack:pop()
        gStateStack:push(GameOverState())
    end

    Entity.update(self, dt)
end

function Player:dash()
    if self.canDash then
        self.walkSpeed = self.dashSpeed
        self.isDashing = true
        self.dashTimer = self.dashDuration
    end
end

function Player:controlDashing(dt)
    if self.isDashing then
        self.dashTimer = self.dashTimer - dt

        if self.dashTimer <= 0 then
            self.walkSpeed = ENTITY_DEFS['player'].walkSpeed
            self.isDashing = false
        end
    end
end

function Player:fallDamage()
    if self.dy >= 3333 and self.dy < 6666 then
        self:damage(1)
    elseif self.dy >= 6666 and self.dy < 9999 then
        self:damage(2)
    elseif self.dy >= 9999 then
        self:damage(3)
    end
end

function Player:checkLeftCollisions(dt) 
    -- allow us to walk atop solid objects even if we collide with them
    self.y = self.y - 1
    local collidedObjects = self:checkObjectCollisions()
    self.y = self.y + 1

    -- reset X if new collided object
    if #collidedObjects > 0 then
        self.x = self.x + self.walkSpeed * dt
    end
end

function Player:checkRightCollisions(dt)        
    -- allow us to walk atop solid objects even if we collide with them
    self.y = self.y - 1
    local collidedObjects = self:checkObjectCollisions()
    self.y = self.y + 1

    -- reset X if new collided object
    if #collidedObjects > 0 then
        self.x = self.x - self.walkSpeed * dt
    end
end

function Player:checkObjectCollisions()
    local collidedObjects = {}

    for k, object in pairs(self.map.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            end
        end
    end

    return collidedObjects
end

function Player:render()
    Entity.render(self)
end