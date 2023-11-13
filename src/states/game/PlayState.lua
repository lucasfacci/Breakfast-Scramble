PlayState = Class{__includes = BaseState}

function PlayState:init()
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

    self.map = Map(self.player)

    self.player.stateMachine = StateMachine {
        ['fall'] = function() return PlayerFallState(self.player, self.map) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['jump'] = function() return PlayerJumpState(self.player, self.map) end,
        ['walk'] = function() return PlayerWalkState(self.player, self.map) end,
        ['sneak'] = function() return PlayerSneakState(self.player, self.map) end
    }

    self.player:changeState('fall')
end

function PlayState:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.map:update(dt)
end

function PlayState:render()
    love.graphics.push()
    self.map:render()
    love.graphics.pop()

    love.graphics.setColor(255/255, 0/255, 0/255)
    -- player's life
    love.graphics.rectangle('fill', 10, 10, 50, 50)
    love.graphics.rectangle('fill', 70, 10, 50, 50)
    love.graphics.rectangle('fill', 130, 10, 50, 50)

    -- enemy's life
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 60, 10, 50, 50)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 120, 10, 50, 50)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 180, 10, 50, 50)
end