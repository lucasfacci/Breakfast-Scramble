Entity = Class{}

function Entity:init(def)
    self.type = def.type
    self.direction = def.direction

    self.x = def.x
    self.y = def.y

    self.dx = 0
    self.dy = 0

    self.width = def.width
    self.height = def.height

    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0
    
    self.walkSpeed = def.walkSpeed

    self.health = def.health
    
    self.dead = false
end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:update(dt)
    self.stateMachine:update(dt)
end

function Entity:render(adjacentOffsetX, adjacentOffsetY)
    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    self.stateMachine:render()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)
end