LevelSelectorState = Class{__includes = BaseState}

function LevelSelectorState:init()
    self.firstTimeInScene = maps_control['level_selector'].firstTimeInScene or false

    self.x = VIRTUAL_WIDTH / 2 - 375
    self.y = VIRTUAL_HEIGHT - 250
end

function LevelSelectorState:update(dt)
    if self.firstTimeInScene == true then
        Timer.after(2, function() 
            Timer.tween(1, {
                [self] = {x = VIRTUAL_WIDTH / 2 + 50, y = self.y + 70}
            }):finish(function()
                Timer.tween(1, {
                    [self] = {y = VIRTUAL_HEIGHT / 2 + 100}
                }):finish(function()
                    maps_control['level_selector'].firstTimeInScene = false
                    gStateStack:pop()
                    gStateStack:push(PlayBossState())
                end)
            end)
        end)
    end
end

function LevelSelectorState:render()
    love.graphics.setColor(0/255, 153/255, 204/255)
    love.graphics.rectangle('fill', 0, 0, MAP_WIDTH, MAP_HEIGHT)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(gTextures['overworld_background'], gFrames['overworld_background'][1], VIRTUAL_WIDTH / 2 - 978 / 2, 0)
    love.graphics.draw(gTextures['little_character'], gFrames['little_character'][1], self.x, self.y)
    love.graphics.draw(gTextures['little_boss'], gFrames['little_boss'][1], VIRTUAL_WIDTH / 2 + 150, VIRTUAL_HEIGHT / 2 + 50)
end