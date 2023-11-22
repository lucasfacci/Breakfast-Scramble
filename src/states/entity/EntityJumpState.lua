EntityJumpState = Class{__includes = BaseState}

function EntityJumpState:init(entity, map)
    self.entity = entity
    self.map = map
    self.entity:changeAnimation('jump-' .. self.entity.direction)
end

function EntityJumpState:update(dt)
    self.entity.currentAnimation:update(dt)
end

function EntityJumpState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    -- DEBUG
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(255, 255, 255, 255)
end