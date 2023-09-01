PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player {
        type = ENTITY_DEFS['player'].type,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,

        x = VIRTUAL_WIDTH / 2 - ENTITY_DEFS['player'].width / 2,
        y = VIRTUAL_HEIGHT / 2 - ENTITY_DEFS['player'].height / 2,

        width = ENTITY_DEFS['player'].width,
        height = ENTITY_DEFS['player'].height
    }

    self.map = Map(self.player)

    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['fall'] = function() return PlayerFallState(self.player, self.map) end,
        ['walk'] = function() return PlayerWalkState(self.player, self.map) end
    }

    self.player:changeState('fall')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.map:update(dt)
end

function PlayState:render()
    self.map:render()
end