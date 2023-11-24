Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    Entity.update(self, dt)
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