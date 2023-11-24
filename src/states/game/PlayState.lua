PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.map = Map()

    self.player = Player {
        type = ENTITY_DEFS['player'].type,
        direction = 'front',
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        jumpVelocity = ENTITY_DEFS['player'].jumpVelocity,
        animations = ENTITY_DEFS['player'].animations,
        health = ENTITY_DEFS['player'].health,

        x = self.map.width / 2 - ENTITY_DEFS['player'].width / 2,
        y = self.map.height - 30 - ENTITY_DEFS['player'].height / 2,

        width = ENTITY_DEFS['player'].width,
        height = ENTITY_DEFS['player'].height,

        map = self.map
    }

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

    love.graphics.setColor(255/255, 255/255, 255/255)
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
    -- enemy's life
    love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 80, 10)
    love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 140, 10)
    love.graphics.draw(gTextures['hearth'], gFrames['hearth'][1], VIRTUAL_WIDTH - 200, 10)
end