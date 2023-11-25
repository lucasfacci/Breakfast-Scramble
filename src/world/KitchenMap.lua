KitchenMap = Class{}

function KitchenMap:init()
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

function KitchenMap:generateGameObjects()
    local kitchen_table = GameObject(GAME_OBJECT_DEFS['table'], self.width / 2, self.groundLevel - GAME_OBJECT_DEFS['table'].height)

    kitchen_table.onCollide = function()
        if love.keyboard.wasPressed('e') then
            print('table trigger')
        end
    end

    table.insert(self.objects, kitchen_table)
end

function KitchenMap:update(dt)
end

function KitchenMap:render()
    love.graphics.draw(gTextures['kitchen_background'], gFrames['kitchen_background'][1], 0, 0)
    love.graphics.draw(gTextures['mother'], gFrames['mother'][1], self.width / 3 + 20, self.groundLevel - 475)
end