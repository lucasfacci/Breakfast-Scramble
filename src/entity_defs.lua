ENTITY_DEFS = {
    ['player'] = {
        type = 'player',
        walkSpeed = PLAYER_WALK_SPEED,
        jumpVelocity = PLAYER_JUMP_VELOCITY,
        health = 10,
        width = 200,
        height = 211,
        animations = {
            ['idle'] = {
                frames = {1},
                texture = 'character_walk'
            },
            ['walk'] = {
                frames = {1},
                texture = 'character_walk'
            },
            ['fall'] = {
                frames = {1},
                texture = 'character_walk',
                interval = 1
            },
            ['jump'] = {
                frames = {1},
                texture = 'character_walk',
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