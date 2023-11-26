ENTITY_DEFS = {
    ['player'] = {
        type = 'player',
        walkSpeed = 900,
        dashSpeed = 2000,
        jumpVelocity = -1850,
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
                interval = 0.1
            },
            ['walk-right'] = {
                frames = {24, 23, 22, 21, 20, 30, 29, 28, 27, 26, 25, 36, 35, 34, 33, 32, 31},
                texture = 'character_walk',
                interval = 0.1
            },
            ['idle-shoot-left'] = {
                frames = {1},
                texture = 'character_shoot'
            },
            ['idle-shoot-right'] = {
                frames = {24},
                texture = 'character_shoot'
            },
            ['walk-shoot-left'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17},
                texture = 'character_shoot',
                interval = 0.1
            },
            ['walk-shoot-right'] = {
                frames = {24, 23, 22, 21, 20, 19, 30, 29, 28, 27, 26, 25, 36, 35, 34, 33, 32},
                texture = 'character_shoot',
                interval = 0.1
            },
            ['fall-front'] = {
                frames = {1},
                texture = 'character_idle'
            },
            ['fall-left'] = {
                frames = {1},
                texture = 'character_walk'
            },
            ['fall-right'] = {
                frames = {24},
                texture = 'character_walk'
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