RockMap = Class{}

function RockMap:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.topLevel = -15000
    self.groundLevel = MAP_HEIGHT - 30

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT - 30

    self.objects = {}

    self:generatePlatforms()
end

function RockMap:generatePlatforms()
    local lastPlatformPosition = 0

    for y = -10000, self.groundLevel - 100 do
        if y % 400 == 0 then
            
            for i = #self.objects, 1, -1 do
                
                if self.objects[i]['type'] == 'rock_platform' then
                    lastPlatformPosition = i
                    break
                end

                if i == 1 and self.objects[i]['type'] ~= 'rock_platform' then
                    lastPlatformPosition = 0
                end
            end

            if lastPlatformPosition == 0 then
                local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], math.random(self.width - GAME_OBJECT_DEFS['rock_platform'].width), y)
                table.insert(self.objects, platform)
            else
                -- 1 means that the next platform will be in the left side of the last platform
                -- 2 means that the next platform will be in the right side of the last platform
                local platformSide = math.random(1, 2)

                -- it checks if there is space to create a platform in the left or right side of the last platform without going out of the map boundaries
                -- if no it changes to the other side
                if platformSide == 1 then
                    if self.objects[lastPlatformPosition].x - GAME_OBJECT_DEFS['rock_platform'].width - 100 < 0 then
                        platformSide = 2
                    end
                else
                    if self.objects[lastPlatformPosition].x + self.objects[lastPlatformPosition].width + GAME_OBJECT_DEFS['rock_platform'].width + 100 > self.width then
                        platformSide = 1
                    end
                end

                -- this variable represents the longest distance that a platform can be from the last platform, so the player can reach it
                local longestPossibleDistance = 910
                
                -- if the new platform will be in the left side of the last platform
                if platformSide == 1 then
                    if self.objects[lastPlatformPosition].x - longestPossibleDistance < 0 then
                        local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], math.random(0, self.objects[lastPlatformPosition].x - GAME_OBJECT_DEFS['rock_platform'].width), y)
                        table.insert(self.objects, platform)
                    else
                        local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], math.random(self.objects[lastPlatformPosition].x - longestPossibleDistance, self.objects[lastPlatformPosition].x - GAME_OBJECT_DEFS['rock_platform'].width), y)
                        table.insert(self.objects, platform)
                    end
                -- else if the new platform will be in the right side of the last platform
                else
                    if self.objects[lastPlatformPosition].x + self.objects[lastPlatformPosition].width + longestPossibleDistance > self.width - GAME_OBJECT_DEFS['rock_platform'].width then
                        local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], math.random(self.objects[lastPlatformPosition].x + GAME_OBJECT_DEFS['rock_platform'].width, self.width - GAME_OBJECT_DEFS['rock_platform'].width), y)
                        table.insert(self.objects, platform)
                    else
                        local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], math.random(self.objects[lastPlatformPosition].x + GAME_OBJECT_DEFS['rock_platform'].width, self.objects[lastPlatformPosition].x + GAME_OBJECT_DEFS['rock_platform'].width + longestPossibleDistance), y)
                        table.insert(self.objects, platform)
                    end
                end
            end
        end
    end

    local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], self.width - GAME_OBJECT_DEFS['rock_platform'].width, -10400)
            table.insert(self.objects, platform)
end

function RockMap:update(dt)
end

function RockMap:render()
    love.graphics.setColor(180/255, 180/255, 180/255)
    love.graphics.rectangle('fill', 0, self.topLevel, MAP_WIDTH, -self.topLevel + MAP_HEIGHT)
    love.graphics.setColor(255/255, 255/255, 255/255)

    if self.player then
        self.player:render()
    end

    for k, object in pairs(self.objects) do
        object:render()
        -- -- DEBUG
        -- love.graphics.setColor(255, 0, 255, 255)
        -- love.graphics.rectangle('line', object.x, object.y, object.width, object.height)
        -- love.graphics.setColor(255, 255, 255, 255)
    end
end