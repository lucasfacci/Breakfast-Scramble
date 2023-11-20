GAME_OBJECT_DEFS = {
    ['rock'] = {
        type = 'rock',
        texture = 'rock',
        frame = 1,
        width = 200,
        height = 200,
        solid = true,
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
    ['box'] = {
        type = 'box',
        texture = 'box',
        frame = 1,
        width = 250,
        height = 180,
        solid = false,
        defaultState = 'stopped',
        states = {
            ['stopped'] = {
                frame = 1
            }
        }
    }
}