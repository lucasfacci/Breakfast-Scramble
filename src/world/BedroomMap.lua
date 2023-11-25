BedroomMap = Class{}

function BedroomMap:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.groundLevel = MAP_HEIGHT - 30

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT

    self.objects = {}
    self:generateGameObjects()
end

function BedroomMap:generateGameObjects()
    local door = GameObject(GAME_OBJECT_DEFS['door'], VIRTUAL_WIDTH - 260, self.groundLevel - GAME_OBJECT_DEFS['door'].height - 10)

    door.onCollide = function()
        if love.keyboard.wasPressed('e') then
            gStateStack:pop()
            gStateStack:push(PlayKitchenState())
        end
    end

    table.insert(self.objects, door)

    local bed = GameObject(GAME_OBJECT_DEFS['bed'], 350, self.groundLevel - GAME_OBJECT_DEFS['bed'].height)

    bed.onCollide = function()
        if love.keyboard.wasPressed('e') then
            print('bed trigger')
        end
    end

    table.insert(self.objects, bed)
end

function BedroomMap:update(dt)
end

function BedroomMap:render()
    love.graphics.draw(gTextures['bedroom_background'], gFrames['bedroom_background'][1], 0, 0)

    self.objects[1]:render()
end