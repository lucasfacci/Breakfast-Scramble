StoryMap = Class{}

function StoryMap:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.groundLevel = MAP_HEIGHT - 30

    self.player = player

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT

    self.objects = {}
    self:generateGameObjects()
end

function StoryMap:generateGameObjects()
    local door = GameObject(GAME_OBJECT_DEFS['door'], VIRTUAL_WIDTH - 260, self.groundLevel - GAME_OBJECT_DEFS['door'].height - 10)

    door.onCollide = function()
        if love.keyboard.wasPressed('e') then
            gStateStack:pop()
            gStateStack:push(PlayRockState())
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

function StoryMap:update(dt)
    self.player:update(dt)

    for k, object in pairs(self.objects) do
        -- trigger collision callback on object
        if self.player:collides(object) then
            object:onCollide()
        end
    end
    
    if self.player.x <= 0 then
        self.player.x = 0
    end

    if self.player.x >= self.width - self.player.width then
        self.player.x = self.width - self.player.width
    end
end

function StoryMap:render()
    love.graphics.draw(gTextures['story_background'], gFrames['story_background'][1], 0, 0)

    -- for k, object in pairs(self.objects) do
    --     object:render()
    -- end

    self.objects[1]:render()

    if self.player then
        self.player:render()
    end

    self.objects[2]:render()
end