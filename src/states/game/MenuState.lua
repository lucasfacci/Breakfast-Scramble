MenuState = Class{__includes = BaseState}

function MenuState:init()
    self.option = 1
end

function MenuState:update(dt)
    if self.option ~= 0 then
        if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('up') then
            if self.option == 1 then
                self.option = 4
            else
                self.option = self.option - 1
            end
        elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('down') then
            if self.option == 4 then
                self.option = 1
            else
                self.option = self.option + 1
            end
        end
    end
    
    if love.keyboard.wasPressed('return') and self.option == 1 then
        self.option = 0
        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, {text = 'Wake up honey bun!'}, 1,
        function()
            gStateStack:pop()

            gStateStack:push(PlayBedroomState({firstTimeInScene = true}))
            
            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0
            }, {}, 3,
            function() end))
        end))
    elseif love.keyboard.wasPressed('return') and self.option == 2 then
        gStateStack:pop()
        gStateStack:push(CreditsState())
    elseif love.keyboard.wasPressed('return') and self.option == 3 then
        gStateStack:pop()
        gStateStack:push(OptionsState())
    elseif love.keyboard.wasPressed('return') and self.option == 4 then
        love.event.quit()
    end
end

function MenuState:render()
    -- background
    love.graphics.setFont(gFonts['yesevaone-large'])
    love.graphics.setColor(0/255, 153/255, 204/255)
    love.graphics.rectangle('fill', 0, 0, MAP_WIDTH, MAP_HEIGHT)

    -- title
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Our Game', 0, VIRTUAL_HEIGHT / 4 - 100, VIRTUAL_WIDTH, 'center')
    
    -- menu options
    love.graphics.setFont(gFonts['yesevaone-medium'])
    love.graphics.setColor(192/255, 192/255, 192/255)
    love.graphics.printf('Play', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Credits', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Options', 0, VIRTUAL_HEIGHT / 2 + 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Exit', 0, VIRTUAL_HEIGHT / 2 + 200, VIRTUAL_WIDTH, 'center')
    if self.option == 1 or self.option == 0 then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Play', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    elseif self.option == 2 then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Credits', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    elseif self.option == 3 then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Options', 0, VIRTUAL_HEIGHT / 2 + 100, VIRTUAL_WIDTH, 'center')
    elseif self.option == 4 then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Exit', 0, VIRTUAL_HEIGHT / 2 + 200, VIRTUAL_WIDTH, 'center')
    end
end