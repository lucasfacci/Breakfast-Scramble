Map = Class{}

function Map:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.player = player

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y
end

function Map:update(dt)
    self.player:update(dt)
end

function Map:render()
    if self.player then
        self.player:render()
    end
end