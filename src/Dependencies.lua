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
require 'src/maps_control'
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

require 'src/states/entity/boss/BossIdleState'

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
require 'src/states/game/PlayBedroomState'
require 'src/states/game/PlayBossState'
require 'src/states/game/PlayEggState'
require 'src/states/game/PlayKitchenState'
require 'src/states/game/PlayRockState'

require 'src/world/BedroomMap'
require 'src/world/BossMap'
require 'src/world/EggMap'
require 'src/world/KitchenMap'
require 'src/world/RockMap'

gTextures = {
    ['character_idle'] = love.graphics.newImage('graphics/character_idle.png'),
    ['character_walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['character_sneak'] = love.graphics.newImage('graphics/character_sneak.png'),
    ['character_carry'] = love.graphics.newImage('graphics/character_carry.png'),
    ['character_shoot'] = love.graphics.newImage('graphics/character_walk_shoot.png'),
    ['character_idle_shoot'] = love.graphics.newImage('graphics/character_idle_shoot.png'),
    ['boss_idle'] = love.graphics.newImage('graphics/boss_anim.png'),
    ['little_character'] = love.graphics.newImage('graphics/little_character.png'),
    ['little_boss'] = love.graphics.newImage('graphics/little_boss.png'),
    ['bedroom_background'] = love.graphics.newImage('graphics/bedroom_background.png'),
    ['kitchen_background'] = love.graphics.newImage('graphics/kitchen_background.png'),
    ['overworld_background'] = love.graphics.newImage('graphics/overworld_background1.png'),
    ['hearth'] = love.graphics.newImage('graphics/hearth.png'),
    ['mother'] = love.graphics.newImage('graphics/mother.png'),
    ['rock1'] = love.graphics.newImage('graphics/rock1.png'),
    ['rock2'] = love.graphics.newImage('graphics/rock2.png'),
    ['egg'] = love.graphics.newImage('graphics/egg.png'),
    ['nest'] = love.graphics.newImage('graphics/nest.png'),
    ['rock_platform'] = love.graphics.newImage('graphics/rock_platform.png'),
    ['door'] = love.graphics.newImage('graphics/Door1.png'),
    ['bed'] = love.graphics.newImage('graphics/bed.png'),
    ['table'] = love.graphics.newImage('graphics/table.png')
}

gFrames = {
    ['character_idle'] = GenerateQuads(gTextures['character_idle'], ENTITY_DEFS['player'].width, ENTITY_DEFS['player'].height),
    ['character_walk'] = GenerateQuads(gTextures['character_walk'], 157, 211),
    ['character_sneak'] = GenerateQuads(gTextures['character_sneak'], 223, 174),
    ['character_carry'] = GenerateQuads(gTextures['character_carry'], 220, 256),
    ['character_shoot'] = GenerateQuads(gTextures['character_shoot'], 210, 211),
    ['character_idle_shoot'] = GenerateQuads(gTextures['character_idle_shoot'], 255, 211),
    ['boss_idle'] = GenerateQuads(gTextures['boss_idle'], 464, 529),
    ['little_character'] = GenerateQuads(gTextures['little_character'], 50, 50),
    ['little_boss'] = GenerateQuads(gTextures['little_boss'], 50, 50),
    ['bedroom_background'] = GenerateQuads(gTextures['bedroom_background'], 1920, 1080),
    ['kitchen_background'] = GenerateQuads(gTextures['kitchen_background'], 1920, 1080),
    ['overworld_background'] = GenerateQuads(gTextures['overworld_background'], 978, 1080),
    ['hearth'] = GenerateQuads(gTextures['hearth'], 70, 70),
    ['mother'] = GenerateQuads(gTextures['mother'], 234, 475),
    ['rock1'] = GenerateQuads(gTextures['rock1'], GAME_OBJECT_DEFS['rock1'].width, GAME_OBJECT_DEFS['rock1'].height),
    ['rock2'] = GenerateQuads(gTextures['rock2'], GAME_OBJECT_DEFS['rock2'].width, GAME_OBJECT_DEFS['rock2'].height),
    ['egg'] = GenerateQuads(gTextures['egg'], GAME_OBJECT_DEFS['egg'].width, GAME_OBJECT_DEFS['egg'].height),
    ['nest'] = GenerateQuads(gTextures['nest'], GAME_OBJECT_DEFS['nest'].width, GAME_OBJECT_DEFS['nest'].height),
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