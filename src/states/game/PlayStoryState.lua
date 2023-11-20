PlayStoryState = Class{__includes = BaseState}

function PlayStoryState:init()
    self.player = Player {
        type = ENTITY_DEFS['player'].type,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        jumpVelocity = ENTITY_DEFS['player'].jumpVelocity,
        animations = ENTITY_DEFS['player'].animations,
        health = ENTITY_DEFS['player'].health,

        x = VIRTUAL_WIDTH / 2 - ENTITY_DEFS['player'].width / 2,
        y = VIRTUAL_HEIGHT / 2 - ENTITY_DEFS['player'].height / 2,

        width = ENTITY_DEFS['player'].width,
        height = ENTITY_DEFS['player'].height
    }

    self.map = StoryMap(self.player)

    self.camera = Camera(self.player)

    self.player.stateMachine = StateMachine {
        ['fall'] = function() return PlayerFallState(self.player, self.map) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['jump'] = function() return PlayerJumpState(self.player, self.map) end,
        ['walk'] = function() return PlayerWalkState(self.player, self.map) end,
        ['sneak'] = function() return PlayerSneakState(self.player, self.map) end
    }

    self.player:changeState('fall')
end

function PlayStoryState:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.map:update(dt)
    self.camera:update(dt)
end

function PlayStoryState:render()
    love.graphics.translate(-math.floor(self.camera.x), 0)

    love.graphics.push()
    self.map:render()
    love.graphics.pop()
end