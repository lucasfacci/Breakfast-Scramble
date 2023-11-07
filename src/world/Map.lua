Map = Class{}

function Map:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.player = player

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT
end

function Map:update(dt)
    self.player:update(dt)
end

function Map:render()
    love.graphics.setColor(love.math.colorFromBytes(180, 180, 180))
    love.graphics.rectangle('fill', 0, 0, MAP_WIDTH, MAP_HEIGHT)
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))

    if self.player then
        self.player:render()
    end
end