GAME_OBJECT_DEFS = {
    ['mother'] = {
        type = 'mother',
        texture = 'mother',
        frame = 1,
        width = 234,
        height = 475,
        solid = false,
        defaultState = 'stopped',
        states = {
            ['stopped'] = {
                frame = 1
            }
        }
    },
    ['rock'] = {
        type = 'rock',
        texture = 'rock',
        frame = 1,
        width = 200,
        height = 200,
        solid = false,
        defaultState = 'stopped',
        states = {
            ['stopped'] = {
                frame = 1
            }
        }
    },
    ['rock_platform'] = {
        type = 'rock_platform',
        texture = 'rock_platform',
        frame = 1,
        width = 250,
        height = 80,
        solid = true,
        defaultState = 'stopped',
        states = {
            ['stopped'] = {
                frame = 1
            }
        }
    },
    ['door'] = {
        type = 'door',
        texture = 'door',
        frame = 1,
        width = 250,
        height = 400,
        solid = false,
        defaultState = 'closed',
        states = {
            ['closed'] = {
                frame = 1
            }
        }
    },
    ['bed'] = {
        type = 'bed',
        texture = 'bed',
        frame = 1,
        width = 700,
        height = 336,
        solid = false,
        defaultState = 'stopped',
        states = {
            ['stopped'] = {
                frame = 1
            }
        }
    },
    ['table'] = {
        type = 'table',
        texture = 'table',
        frame = 1,
        width = 460,
        height = 345,
        solid = false,
        defaultState = 'stopped',
        states = {
            ['stopped'] = {
                frame = 1
            }
        }
    }
}