Boss = Class{__includes = Entity}

function Boss:init(def)
    Entity.init(self, def)
end

function Boss:update(dt)
    if self.health <= 0 then
        self.dead = true
    end

    Entity.update(self, dt)
end

function Boss:fire(projectiles, width, height, velocity, r, g, b)
    table.insert(projectiles, Projectile(self, width, height, velocity, r, g, b))
end

function Boss:checkLeftCollisions(dt) 
    -- allow us to walk atop solid objects even if we collide with them
    self.y = self.y - 1
    local collidedObjects = self:checkObjectCollisions()
    self.y = self.y + 1

    -- reset X if new collided object
    if #collidedObjects > 0 then
        self.x = self.x + self.walkSpeed * dt
    end
end

function Boss:checkRightCollisions(dt)        
    -- allow us to walk atop solid objects even if we collide with them
    self.y = self.y - 1
    local collidedObjects = self:checkObjectCollisions()
    self.y = self.y + 1

    -- reset X if new collided object
    if #collidedObjects > 0 then
        self.x = self.x - self.walkSpeed * dt
    end
end

function Boss:checkObjectCollisions()
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

function Boss:render()
    Entity.render(self)
end