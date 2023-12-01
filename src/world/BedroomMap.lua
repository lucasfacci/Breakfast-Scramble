BedroomMap = Class{}

function BedroomMap:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.groundLevel = MAP_HEIGHT - 30

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT

    self.firstTimeInBedroomScene = maps_control['bedroom'].firstTimeInScene

    self.objects = {}
    self:generateGameObjects()
end

function BedroomMap:generateGameObjects()
    local door = GameObject(GAME_OBJECT_DEFS['door'], VIRTUAL_WIDTH - GAME_OBJECT_DEFS['door'].width - 20, self.groundLevel - GAME_OBJECT_DEFS['door'].height - 10)

    door.onCollide = function()
        -- gStateStack:push(DialogueState(" Press 'E' to go through the door ",
        --     function()
        --         gStateStack:pop()
        --     end)
        -- )
        if love.keyboard.wasPressed('e') then
            gStateStack:pop()
            gStateStack:push(PlayKitchenState())
        end
    end
    
    table.insert(self.objects, door)

    local bed = GameObject(GAME_OBJECT_DEFS['bed'], 350, self.groundLevel - GAME_OBJECT_DEFS['bed'].height)

    bed.onCollide = function()
        -- if love.keyboard.wasPressed('e') then
        --     print('bed trigger')
        -- end
    end

    table.insert(self.objects, bed)

    local mother = GameObject(GAME_OBJECT_DEFS['mother'], self.width - GAME_OBJECT_DEFS['mother'].width - 50, self.groundLevel - 475)

    table.insert(self.objects, mother)
end

function BedroomMap:update(dt)
end

function BedroomMap:render()
    love.graphics.draw(gTextures['bedroom_background'], gFrames['bedroom_background'][1], 0, 0)

    self.objects[1]:render()

    if self.firstTimeInBedroomScene == true then
        if self.objects[3] then
            self.objects[3]:render()
        end
    end
end