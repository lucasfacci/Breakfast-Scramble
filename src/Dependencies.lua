Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Entity'
require 'src/entity_defs'
require 'src/Player'
require 'src/StateMachine'
require 'src/Util'

require 'src/world/Map'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/entity/EntityFallState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityJumpState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntitySneakState'

require 'src/states/entity/player/PlayerFallState'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerSneakState'

require 'src/states/game/StartState'
require 'src/states/game/PlayState'

gTextures = {
    ['character_walk'] = love.graphics.newImage('graphics/c_stand(maybe_small).png'),
    ['character_sneak'] = love.graphics.newImage('graphics/c_sneaking(maybe_small).png')
}

gFrames = {
    ['character_walk'] = GenerateQuads(gTextures['character_walk'], ENTITY_DEFS['player'].width, ENTITY_DEFS['player'].height),
    ['character_sneak'] = GenerateQuads(gTextures['character_sneak'], 201, 157)
}