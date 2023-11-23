RockMap = Class{}

function RockMap:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.topLevel = -10000
    self.groundLevel = MAP_HEIGHT - 30

    self.player = player

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT

    self.platforms = {}
    self.rocks = {}

    self:generatePlatforms()

    self.rockWaitDuration = 0
    self.rockWaitTimer = 0
end

function RockMap:generatePlatforms()
    for y = -10000, self.groundLevel - 100 do
        if y % 200 == 0 then
            local platform = GameObject(GAME_OBJECT_DEFS['rock_platform'], math.random(self.width - GAME_OBJECT_DEFS['rock_platform'].width), y)
        
            platform.onCollide = function()
                if platform.solid == true then
                    if self.player.dy > 0 and self.player.y + self.player.height >= platform.y then
                        self.player.y = platform.y - self.player.height
                        self.player.dy = 0
                        self.player:changeState('idle')
                    end
                end
            end

            table.insert(self.platforms, platform)
        end
    end
end

function RockMap:generateRock()
    local rock = GameObject(GAME_OBJECT_DEFS['rock'], math.random(self.width - GAME_OBJECT_DEFS['rock'].width), self.player.y - MAP_HEIGHT)

    rock.onCollide = function()
        self.player:damage(1)

        if self.player.health <= 0 then
            gStateStack:pop()
            gStateStack:push(GameOverState())
        end
    end

    table.insert(self.rocks, rock)
end

function RockMap:processAI(params, dt)
    if self.rockWaitDuration == 0 then
        
        -- set an initial move duration and direction
        self.rockWaitDuration = 1
    elseif self.rockWaitTimer > self.rockWaitDuration then
        self.rockWaitTimer = 0

        self:generateRock()
        self.rockWaitDuration = math.random(5)
    end

    self.rockWaitTimer = self.rockWaitTimer + dt
end

function RockMap:update(dt)
    self.player:update(dt)
    self:processAI({map = self}, dt)

    for k, platform in pairs(self.platforms) do
        -- trigger collision callback on platform
        if self.player:collides(platform) then
            platform:onCollide()
        end
    end

    for k, rock in pairs(self.rocks) do
        -- trigger collision callback on rock
        if self.player:collides(rock) then
            rock:onCollide()
        end

        if rock.y < self.groundLevel then
            rock.y = rock.y + 800 * dt
        else
            table.remove(self.rocks, k)
        end
    end
end

function RockMap:render()
    love.graphics.setColor(180/255, 180/255, 180/255)
    love.graphics.rectangle('fill', 0, 0, MAP_WIDTH, MAP_HEIGHT)
    love.graphics.setColor(255/255, 255/255, 255/255)

    if self.player then
        self.player:render()
    end

    for k, platform in pairs(self.platforms) do
        platform:render()
    end

    for k, rock in pairs(self.rocks) do
        rock:render()
    end
end