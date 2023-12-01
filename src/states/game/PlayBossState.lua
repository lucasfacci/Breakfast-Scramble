PlayBossState = Class{__includes = BaseState}

function PlayBossState:init(params)
    self.map = BossMap()

    self.firstTimeInScene = maps_control['boss'].firstTimeInScene
    self.playerBlocked = false

    self.player = Player {
        type = ENTITY_DEFS['player'].type,
        direction = 'front',
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        dashSpeed = ENTITY_DEFS['player'].dashSpeed,
        jumpVelocity = ENTITY_DEFS['player'].jumpVelocity,
        animations = ENTITY_DEFS['player'].animations,
        health = ENTITY_DEFS['player'].health,

        x = 0,
        y = self.map.groundLevel - ENTITY_DEFS['player'].height,

        width = ENTITY_DEFS['player'].width,
        height = ENTITY_DEFS['player'].height,

        map = self.map
    }
    
    self.boss = Entity {
        type = ENTITY_DEFS['boss'].type,
        direction = 'left',
        walkSpeed = ENTITY_DEFS['boss'].walkSpeed,
        jumpVelocity = ENTITY_DEFS['boss'].jumpVelocity,
        animations = ENTITY_DEFS['boss'].animations,
        health = ENTITY_DEFS['boss'].health,

        x = self.map.width - ENTITY_DEFS['boss'].width,
        y = self.map.groundLevel - ENTITY_DEFS['boss'].height,

        width = ENTITY_DEFS['boss'].width,
        height = ENTITY_DEFS['boss'].height,

        map = self.map
    }

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

    self.boss.stateMachine = StateMachine {
        ['idle'] = function() return BossIdleState(self.boss) end
    }

    self.player:changeState('fall')
    self.boss:changeState('idle')

    -- projectiles in the map/state
    self.projectiles = {}

    Event.on('player-fire', function()
        self.player:fire(self.projectiles, self.boss)
    end)


    self.waitBossShootTimer = 0
    self.waitBossShootDuration = 3

    self.rockWaitDuration = 0
    self.rockWaitTimer = 0

    -- if self.firstTimeInScene then
    --     self.playerBlocked = true
    --     Timer.after(3,
    --         function()
    --             self.playerBlocked = false
    --             gStateStack:push(DialogueState(' Boss: \n\n\n' ..
    --                 ' I will protect the egg! \n',
    --                 function()
    --                     self.playerBlocked = false
    --                     maps_control['boss'].firstTimeInScene = false
    --                 end)
    --             )
    --         end
    --     )
    -- end
end

function PlayBossState:generateRock()
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

function PlayBossState:randomizeRockFallTime(dt)
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

function PlayBossState:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if self.playerBlocked == false then
        self.player:update(dt)
    end
    self.boss:update(dt)
    self.map:update(dt)
    self:randomizeRockFallTime(dt)

    for k, object in pairs(self.map.objects) do
        -- trigger collision callback on object
        if self.player:collides(object) then
            object:onCollide()
        end
    end

    for k, projectile in pairs(self.projectiles) do
        projectile:update(dt)

        if projectile.x <= 0 or projectile.x >= self.map.width or projectile.y <= 0 or projectile.y >= self.map.height or projectile.hit == true then
            table.remove(self.projectiles, k)
        end
    end
    
    if self.player.x <= 0 then
        self.player.x = 0
    end

    if self.player.x >= self.map.width - self.player.width then
        self.player.x = self.map.width - self.player.width
        if love.keyboard.wasPressed('e') then
            gStateStack:pop()
            gStateStack:push(PlayRockState())
        end
    end

    if self.waitBossShootTimer > self.waitBossShootDuration then
        self.boss:fire(self.projectiles, self.player)
        self.waitBossShootTimer = 0
    end

    self.waitBossShootTimer = self.waitBossShootTimer + dt
end

function PlayBossState:render()
    love.graphics.push()
    self.map:render()
    self.player:render()
    self.boss:render()

    for k, projectile in pairs(self.projectiles) do
        projectile:render()
    end
    love.graphics.pop()

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

    love.graphics.setColor(255/255, 255/255, 255/255)
    -- boss's life
    if not self.boss.dead and self.boss.health >= 1 then
        if self.boss.health >= 20 then
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 80, 10)
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 140, 10)
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 200, 10)
        elseif self.boss.health >= 10 and self.boss.health < 20  then
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 80, 10)
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 140, 10)
            love.graphics.setColor(255/255, 255/255, 255/255, 0.3)
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 200, 10)
        elseif self.boss.health < 10 then
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 80, 10)
            love.graphics.setColor(255/255, 255/255, 255/255, 0.3)
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 140, 10)
            love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 200, 10)
        end
    end
end