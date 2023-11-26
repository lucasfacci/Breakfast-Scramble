PlayKitchenState = Class{__includes = BaseState}

function PlayKitchenState:init()
    self.map = KitchenMap()

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
end

function PlayKitchenState:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.player:update(dt)
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

        if love.keyboard.wasPressed('e') then
            gStateStack:pop()
            gStateStack:push(PlayBedroomState({x = MAP_WIDTH - self.player.width}))
        end
    end

    if self.player.x >= self.map.width - self.player.width then
        self.player.x = self.map.width - self.player.width

        if love.keyboard.wasPressed('e') then
            gStateStack:pop()
            gStateStack:push(PlayRockState())
        end
    end
end

function PlayKitchenState:render()
    love.graphics.push()
    self.map:render()
    self.player:render()

    for k, projectile in pairs(self.projectiles) do
        projectile:render()
    end

    for k, object in pairs(self.map.objects) do
        object:render()
    end
    love.graphics.pop()
end