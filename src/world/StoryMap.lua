StoryMap = Class{}

function StoryMap:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.player = player

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.gravityOn = true
    self.gravityAmount = GRAVITY_AMOUNT

    self.objects = {}
    self:generateGameObjects()
end

function StoryMap:generateGameObjects()
    local door = GameObject(GAME_OBJECT_DEFS['door'], VIRTUAL_WIDTH - 260, VIRTUAL_HEIGHT - 400)

    door.onCollide = function()
        if love.keyboard.wasPressed('e') then
            gStateStack:pop()
            gStateStack:push(PlayState())
        end
    end

    table.insert(self.objects, door)
end

function StoryMap:update(dt)
    self.player:update(dt)

    for k, object in pairs(self.objects) do
        -- trigger collision callback on object
        if self.player:collides(object) then
            object:onCollide()
        end
    end
end

function StoryMap:render()
    love.graphics.setColor(180/255, 180/255, 180/255)
    love.graphics.rectangle('fill', 0, 0, MAP_WIDTH, MAP_HEIGHT)

    for k, object in pairs(self.objects) do
        object:render()
    end

    love.graphics.setColor(255/255, 255/255, 255/255)
    if self.player then
        self.player:render()
    end
end