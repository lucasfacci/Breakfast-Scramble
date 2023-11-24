EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, map)
    self.entity = entity
    self.map = map
    self.entity:changeAnimation('walk-' .. self.entity.direction)
end

function EntityWalkState:update(dt)
    self.entity.currentAnimation:update(dt)

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('jump')
    end
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    -- DEBUG
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(255, 255, 255, 255)
end