Entity = Class{}

function Entity:init(def)
    self.type = def.type
    self.direction = def.direction

    self.animations = self:createAnimations(def.animations)

    self.x = def.x
    self.y = def.y

    self.dx = 0
    self.dy = 0

    self.width = def.width
    self.height = def.height

    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0
    
    self.walkSpeed = def.walkSpeed

    self.dashSpeed = def.dashSpeed

    self.jumpVelocity = def.jumpVelocity
    
    self.waitTimer = 0
    self.immunityDuration = 0

    self.health = def.health
    
    self.dead = false

    self.opacity = 1

    self.map = def.map
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture,
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end

    if self.waitTimer > self.immunityDuration then
        self.opacity = 1
        self.immunityDuration = 0
    end

    self.waitTimer = self.waitTimer + dt
end

function Entity:heal(healing)
    if self.health < 10 then
        self.health = self.health + healing
    end
end

function Entity:damage(dmg)
    if self.immunityDuration == 0 then
        self.health = self.health - dmg
        self.immunityDuration = 2
        self.waitTimer = 0
        self.opacity = 0.5
    end
end

function Entity:collides(entity)
    return not (self.x > entity.x + entity.width or entity.x > self.x + self.width or
        self.y > entity.y + entity.height or entity.y > self.y + self.height)
end

function Entity:render(adjacentOffsetX, adjacentOffsetY)
    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    love.graphics.setColor(1, 1, 1, self.opacity)
    self.stateMachine:render()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)
end