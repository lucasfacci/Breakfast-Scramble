EntitySneakState = Class{__includes = BaseState}

function EntitySneakState:init(entity, map)
    self.entity = entity
    self.map = map
    self.entity:changeAnimation('sneak')
end

function EntitySneakState:update(dt)
    self.entity.currentAnimation:update(dt)
end

function EntitySneakState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end