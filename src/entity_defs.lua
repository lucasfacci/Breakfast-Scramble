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
            ['walk-left'] = {
                frames = {1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
                texture = 'character_walk',
                interval = 1
            },
            ['walk-right'] = {
                frames = {24, 23, 22, 21, 20, 30, 29, 28, 27, 26, 25, 36, 35, 34, 33, 32, 31},
                texture = 'character_walk',
                interval = 1
            },
            ['fall-front'] = {
                frames = {1},
                texture = 'character_idle',
                interval = 1
            },
            ['fall-left'] = {
                frames = {1},
                texture = 'character_walk',
                interval = 1
            },
            ['fall-right'] = {
                frames = {24},
                texture = 'character_walk',
                interval = 1
            },
            ['jump-front'] = {
                frames = {1},
                texture = 'character_idle',
            },
            ['jump-left'] = {
                frames = {1},
                texture = 'character_walk',
            },
            ['jump-right'] = {
                frames = {24},
                texture = 'character_walk',
            },
            ['sneak'] = {
                frames = {1},
                texture = 'character_sneak'
            }
        }
    }
}