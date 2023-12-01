BossMap = Class{}

function BossMap:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.groundLevel = MAP_HEIGHT - 30

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT

    self.objects = {}
    self:generateGameObjects()
end

function BossMap:generateGameObjects()
end

function BossMap:update(dt)
end

function BossMap:render()
    love.graphics.setColor(180/255, 180/255, 180/255)
    love.graphics.rectangle('fill', 0, 0, MAP_WIDTH, MAP_HEIGHT)
    love.graphics.setColor(255/255, 255/255, 255/255)

    -- generate the ground
    local x = 0
    while x < self.width do
        love.graphics.draw(gTextures['rock_platform'], gFrames['rock_platform'][1], x, self.groundLevel)
        x = x + GAME_OBJECT_DEFS['rock_platform'].width
    end

    if self.player then
        self.player:render()
    end
    
    for k, object in pairs(self.objects) do
        object:render()
        -- DEBUG
        love.graphics.setColor(255, 0, 255, 255)
        love.graphics.rectangle('line', object.x, object.y, object.width, object.height)
        love.graphics.setColor(255, 255, 255, 255)
    end
end