GAME_OBJECT_DEFS = {
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