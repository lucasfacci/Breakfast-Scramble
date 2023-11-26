EntityWalkShootState = Class{__includes = BaseState}

function EntityWalkShootState:init(entity, map)
    self.entity = entity
    self.map = map
    self.entity:changeAnimation('walk-shoot-' .. self.entity.direction)
end

function EntityWalkShootState:update(dt)
    self.entity.currentAnimation:update(dt)
end

function EntityWalkShootState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    -- DEBUG
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(255, 255, 255, 255)
end