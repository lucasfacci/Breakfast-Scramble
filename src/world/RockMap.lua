RockMap = Class{}

function RockMap:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.topLevel = -10000
    self.groundLevel = MAP_HEIGHT - 30

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT

    self.objects = {}

    self:generatePlatforms()
end

function RockMap:generatePlatforms()
    local aux = 1
    for y = -10000, self.groundLevel - 100 do
        if y % 260 == 0 then
            if aux % 2 == 0 then
                local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], math.random(1, self.width / 2 - GAME_OBJECT_DEFS['rock_platform'].width), y)
                table.insert(self.objects, platform)
            else
                local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], math.random(self.width / 2, self.width - GAME_OBJECT_DEFS['rock_platform'].width), y)
                table.insert(self.objects, platform)
            end
            aux = aux + 1
        end
    end
end

function RockMap:update(dt)
end

function RockMap:render()
    love.graphics.setColor(180/255, 180/255, 180/255)
    love.graphics.rectangle('fill', 0, -10000, MAP_WIDTH, 10000 + MAP_HEIGHT)
    love.graphics.setColor(255/255, 255/255, 255/255)

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