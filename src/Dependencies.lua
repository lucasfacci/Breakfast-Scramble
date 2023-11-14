Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/Camera'
require 'src/constants'
require 'src/entity_defs'
require 'src/Entity'
require 'src/game_objects'
require 'src/GameObject'
require 'src/Player'
require 'src/StateMachine'
require 'src/Util'

require 'src/world/Map'
require 'src/world/StoryMap'

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

require 'src/states/game/CreditsState'
require 'src/states/game/LevelSelectorState'
require 'src/states/game/MenuState'
require 'src/states/game/OptionsState'
require 'src/states/game/PlayState'
require 'src/states/game/PlayStoryState'

gTextures = {
    ['character_walk'] = love.graphics.newImage('graphics/c_stand(a_little_small).png'),
    ['character_sneak'] = love.graphics.newImage('graphics/c_sneaking(a_little_small).png'),
    ['door'] = love.graphics.newImage('graphics/door.png')
}

gFrames = {
    ['character_walk'] = GenerateQuads(gTextures['character_walk'], ENTITY_DEFS['player'].width, ENTITY_DEFS['player'].height),
    ['character_sneak'] = GenerateQuads(gTextures['character_sneak'], 223, 174),
    ['door'] = GenerateQuads(gTextures['door'], 250, 400)
}

gFonts = {
    ['yesevaone-small'] = love.graphics.newFont('fonts/Yeseva_One/YesevaOne-Regular.ttf', 32),
    ['yesevaone-medium'] = love.graphics.newFont('fonts/Yeseva_One/YesevaOne-Regular.ttf', 64),
    ['yesevaone-large'] = love.graphics.newFont('fonts/Yeseva_One/YesevaOne-Regular.ttf', 128),
}