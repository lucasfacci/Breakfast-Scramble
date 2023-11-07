EntityFallState = Class{__includes = BaseState}

function EntityFallState:init(entity, map)
    self.entity = entity
    self.map = map
    self.entity:changeAnimation('fall')
end

function EntityFallState:update(dt)
    self.entity.currentAnimation:update(dt)

    if love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    end
    
    self.entity.dy = self.entity.dy + self.map.gravityAmount
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    if self.entity.y >= self.map.height - self.entity.height then
        self.entity.y = self.map.height - self.entity.height
        self.bumped = true
        self.entity.dy = 0
        self.entity:changeState('idle')
    end
end

function EntityFallState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end