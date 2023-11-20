ENTITY_DEFS = {
    ['player'] = {
        type = 'player',
        walkSpeed = PLAYER_WALK_SPEED,
        jumpVelocity = PLAYER_JUMP_VELOCITY,
        health = 3,
        width = 200,
        height = 211,
        animations = {
            ['idle'] = {
                frames = {1},
                texture = 'character_idle'
            },
            ['walk'] = {
                frames = {1},
                texture = 'character_idle'
            },
            ['fall'] = {
                frames = {1},
                texture = 'character_idle',
                interval = 1
            },
            ['jump'] = {
                frames = {1},
                texture = 'character_idle',
                interval = 1
            },
            ['sneak'] = {
                frames = {1},
                texture = 'character_sneak',
                interval = 1
            }
        }
    }
}