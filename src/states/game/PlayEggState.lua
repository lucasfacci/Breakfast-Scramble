PlayEggState = Class{__includes = BaseState}

function PlayEggState:init(params)
    self.map = EggMap()

    self.firstTimeInScene = params.firstTimeInScene or false
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

    self:generateGameObjects()
end

function PlayEggState:generateGameObjects()
    local egg = GameObject(GAME_OBJECT_DEFS['egg'], VIRTUAL_WIDTH / 2 - GAME_OBJECT_DEFS['egg'].width / 2, self.map.groundLevel - GAME_OBJECT_DEFS['egg'].height - 10)

    egg.onCollide = function()
        -- gStateStack:push(DialogueState(" Press 'E' get the egg ",
        --     function()
        --         gStateStack:pop()
        --     end)
        -- )
        if love.keyboard.wasPressed('e') then
            self.map.finish = true
            table.remove(self.map.objects, 1)
            self.player:changeState('fall')
        end
    end
    
    table.insert(self.map.objects, egg)

    local nest = GameObject(GAME_OBJECT_DEFS['nest'], VIRTUAL_WIDTH / 2 - GAME_OBJECT_DEFS['nest'].width / 2, self.map.groundLevel - GAME_OBJECT_DEFS['nest'].height + 10)
    
    table.insert(self.map.objects, nest)
end

function PlayEggState:update(dt)
    Timer.update(dt)

    if self.playerBlocked == false then
        self.player:update(dt)
    end
    self.map:update(dt)

    for k, object in pairs(self.map.objects) do
        -- trigger collision callback on object
        if self.player:collides(object) then
            object:onCollide()
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

function PlayEggState:render()
    love.graphics.push()
    self.map:render()
    self.player:render()

    if self.map.finish == true then
        love.graphics.draw(gTextures['egg'], gFrames['egg'][1], self.player.x, self.player.y - 210)
    end

    for k, projectile in pairs(self.projectiles) do
        projectile:render()
    end
    love.graphics.pop()
end