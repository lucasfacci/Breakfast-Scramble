GameObject = Class{}

function GameObject:init(def, x, y)
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    self.solid = def.solid

    self.opacity = 1

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.dx = 0
    self.dy = 0

    self.onCollide = function() end
end

function GameObject:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
        target.y > self.y + self.height or self.y > target.y + target.height)
end

function GameObject:update(dt)

end

function GameObject:render()
    love.graphics.setColor(1, 1, 1, self.opacity)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x, self.y)
    love.graphics.setColor(1, 1, 1, 1)
end