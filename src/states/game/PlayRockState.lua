PlayRockState = Class{__includes = BaseState}

function PlayRockState:init()
    self.map = RockMap()

    self.player = Player {
        type = ENTITY_DEFS['player'].type,
        direction = 'front',
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        dashSpeed = ENTITY_DEFS['player'].dashSpeed,
        jumpVelocity = ENTITY_DEFS['player'].jumpVelocity,
        animations = ENTITY_DEFS['player'].animations,
        health = ENTITY_DEFS['player'].health,

        x = self.map.width / 2 - ENTITY_DEFS['player'].width / 2,
        y = self.map.groundLevel - ENTITY_DEFS['player'].height,

        width = ENTITY_DEFS['player'].width,
        height = ENTITY_DEFS['player'].height,

        map = self.map
    }

    self.camera = Camera(self.player)

    self.player.stateMachine = StateMachine {
        ['fall'] = function() return PlayerFallState(self.player, self.map) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['jump'] = function() return PlayerJumpState(self.player, self.map) end,
        ['walk'] = function() return PlayerWalkState(self.player, self.map) end,
        ['sneak'] = function() return PlayerSneakState(self.player, self.map) end,
        ['fall-shoot'] = function() return PlayerFallShootState(self.player, self.map) end,
        ['idle-shoot'] = function() return PlayerIdleShootState(self.player) end,
        ['jump-shoot'] = function() return PlayerJumpShootState(self.player, self.map) end,
        ['walk-shoot'] = function() return PlayerWalkShootState(self.player, self.map) end
    }

    self.player:changeState('fall')

    -- projectiles in the map/state
    self.projectiles = {}

    Event.on('player-fire', function()
        self.player:fire(self.projectiles)
    end)

    self.rockWaitDuration = 0
    self.rockWaitTimer = 0
end

function PlayRockState:generateRock()
    local choice = math.random(2)
    if choice == 1 then
        local rock = GameObject(GAME_OBJECT_DEFS['rock1'], math.random(self.map.width - GAME_OBJECT_DEFS['rock1'].width), self.player.y - MAP_HEIGHT)

        rock.onCollide = function()
            self.player:damage(1)
        end

        table.insert(self.map.objects, rock)
    elseif choice == 2 then
        local rock = GameObject(GAME_OBJECT_DEFS['rock2'], math.random(self.map.width - GAME_OBJECT_DEFS['rock2'].width), self.player.y - MAP_HEIGHT)

        rock.onCollide = function()
            self.player:damage(1)
        end

        table.insert(self.map.objects, rock)
    end
end

function PlayRockState:randomizeRockFallTime(dt)
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

function PlayRockState:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.player:update(dt)
    self.map:update(dt)
    self.camera:update(dt)
    self:randomizeRockFallTime(dt)

    for k, object in pairs(self.map.objects) do
        -- trigger collision callback on object
        if self.player:collides(object) then
            object:onCollide()
        end

        if object.type == 'rock1' or object.type == 'rock2' then
            if object.y < self.map.groundLevel then
                object.y = object.y + 600 * dt
            else
                table.remove(self.map.objects, k)
            end
        end
    end

    for k, projectile in pairs(self.projectiles) do
        projectile:update(dt)

        if projectile.x <= 0 or projectile.x >= self.map.width or projectile.y <= 0 or projectile.y >= self.map.height then
            table.remove(self.projectiles, k)
        end
    end

    if self.player.x <= 0 then
        self.player.x = 0
    end

    if self.player.x >= self.map.width - self.player.width then
        self.player.x = self.map.width - self.player.width
    end
end

function PlayRockState:render()
    if self.player.y + self.player.height / 2 <= self.map.height / 2 then
        love.graphics.translate(0, -math.floor(self.camera.y))
    end

    love.graphics.push()
    self.map:render()
    self.player:render()

    for k, projectile in pairs(self.projectiles) do
        projectile:render()
    end
    love.graphics.pop()

    if self.player.y + self.player.height / 2 <= self.map.height / 2 then
        -- player's life
        if not self.player.dead and self.player.health >= 1 then
            if self.player.health == 3 then
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 10, self.camera.y + 10)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 70, self.camera.y + 10)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 130, self.camera.y + 10)
            elseif self.player.health == 2 then
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 10, self.camera.y + 10)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 70, self.camera.y + 10)
                love.graphics.setColor(255/255, 255/255, 255/255, 0.3)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 130, self.camera.y + 10)
            elseif self.player.health == 1 then
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 10, self.camera.y + 10)
                love.graphics.setColor(255/255, 255/255, 255/255, 0.3)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 70, self.camera.y + 10)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 130, self.camera.y + 10)
            end
        end
    else
        -- player's life
        if not self.player.dead and self.player.health >= 1 then
            if self.player.health == 3 then
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 10, 10)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 70, 10)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 130, 10)
            elseif self.player.health == 2 then
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 10, 10)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 70, 10)
                love.graphics.setColor(255/255, 255/255, 255/255, 0.3)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 130, 10)
            elseif self.player.health == 1 then
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 10, 10)
                love.graphics.setColor(255/255, 255/255, 255/255, 0.3)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 70, 10)
                love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], 130, 10)
            end
        end
    end
end