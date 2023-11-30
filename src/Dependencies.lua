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
require 'src/Hitbox'
require 'src/Player'
require 'src/Projectile'
require 'src/StateMachine'
require 'src/Util'

require 'src/gui/Panel'
require 'src/gui/Textbox'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/entity/EntityFallShootState'
require 'src/states/entity/EntityFallState'
require 'src/states/entity/EntityIdleShootState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityJumpShootState'
require 'src/states/entity/EntityJumpState'
require 'src/states/entity/EntitySneakState'
require 'src/states/entity/EntityWalkShootState'
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerFallShootState'
require 'src/states/entity/player/PlayerFallState'
require 'src/states/entity/player/PlayerIdleShootState'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerJumpShootState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerSneakState'
require 'src/states/entity/player/PlayerWalkShootState'
require 'src/states/entity/player/PlayerWalkState'

require 'src/states/game/CreditsState'
require 'src/states/game/DialogueState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'
require 'src/states/game/GameOverState'
require 'src/states/game/LevelSelectorState'
require 'src/states/game/MenuState'
require 'src/states/game/OptionsState'
require 'src/states/game/PlayBedroomState'
require 'src/states/game/PlayKitchenState'
require 'src/states/game/PlayRockState'
require 'src/states/game/PlayState'

require 'src/world/BedroomMap'
require 'src/world/KitchenMap'
require 'src/world/Map'
require 'src/world/RockMap'

gTextures = {
    ['character_idle'] = love.graphics.newImage('graphics/character_idle.png'),
    ['character_walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['character_sneak'] = love.graphics.newImage('graphics/character_sneak.png'),
    ['character_shoot'] = love.graphics.newImage('graphics/character_walk_shoot.png'),
    ['character_idle_shoot'] = love.graphics.newImage('graphics/character_idle_shoot.png'),
    ['bedroom_background'] = love.graphics.newImage('graphics/bedroom_background.png'),
    ['kitchen_background'] = love.graphics.newImage('graphics/kitchen_background.png'),
    ['player_dialogue_icon'] = love.graphics.newImage('graphics/player_dialogue_icon.png'),
    ['mother_dialogue_icon'] = love.graphics.newImage('graphics/mother_dialogue_icon.png'),
    ['hearth'] = love.graphics.newImage('graphics/hearth.png'),
    ['mother'] = love.graphics.newImage('graphics/mother.png'),
    ['rock'] = love.graphics.newImage('graphics/rock.png'),
    ['rock_platform'] = love.graphics.newImage('graphics/rock_platform.png'),
    ['door'] = love.graphics.newImage('graphics/door.png'),
    ['bed'] = love.graphics.newImage('graphics/bed.png'),
    ['table'] = love.graphics.newImage('graphics/table.png')
}

gFrames = {
    ['character_idle'] = GenerateQuads(gTextures['character_idle'], ENTITY_DEFS['player'].width, ENTITY_DEFS['player'].height),
    ['character_walk'] = GenerateQuads(gTextures['character_walk'], 157, 211),
    ['character_sneak'] = GenerateQuads(gTextures['character_sneak'], 223, 174),
    ['character_shoot'] = GenerateQuads(gTextures['character_shoot'], 210, 211),
    ['character_idle_shoot'] = GenerateQuads(gTextures['character_idle_shoot'], 255, 211),
    ['bedroom_background'] = GenerateQuads(gTextures['bedroom_background'], 1920, 1080),
    ['kitchen_background'] = GenerateQuads(gTextures['kitchen_background'], 1920, 1080),
    ['player_dialogue_icon'] = GenerateQuads(gTextures['player_dialogue_icon'], 120, 129),
    ['mother_dialogue_icon'] = GenerateQuads(gTextures['mother_dialogue_icon'], 145, 167),
    ['hearth'] = GenerateQuads(gTextures['hearth'], 70, 70),
    ['mother'] = GenerateQuads(gTextures['mother'], 234, 475),
    ['rock'] = GenerateQuads(gTextures['rock'], GAME_OBJECT_DEFS['rock'].width, GAME_OBJECT_DEFS['rock'].height),
    ['rock_platform'] = GenerateQuads(gTextures['rock_platform'], GAME_OBJECT_DEFS['rock_platform'].width, GAME_OBJECT_DEFS['rock_platform'].height),
    ['door'] = GenerateQuads(gTextures['door'], GAME_OBJECT_DEFS['door'].width, GAME_OBJECT_DEFS['door'].height),
    ['bed'] = GenerateQuads(gTextures['bed'], GAME_OBJECT_DEFS['bed'].width, GAME_OBJECT_DEFS['bed'].height),
    ['table'] = GenerateQuads(gTextures['table'], GAME_OBJECT_DEFS['table'].width, GAME_OBJECT_DEFS['table'].height)
}

gFonts = {
    ['yesevaone-small'] = love.graphics.newFont('fonts/Yeseva_One/YesevaOne-Regular.ttf', 32),
    ['yesevaone-medium'] = love.graphics.newFont('fonts/Yeseva_One/YesevaOne-Regular.ttf', 64),
    ['yesevaone-large'] = love.graphics.newFont('fonts/Yeseva_One/YesevaOne-Regular.ttf', 128)
}