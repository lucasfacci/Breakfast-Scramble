MenuState = Class{__includes = BaseState}

function MenuState:init()
    option = 1
end

function MenuState:update(dt)
    if love.keyboard.wasPressed('w') or love.keyboard.wasPressed('up') then
        if option == 1 then
            option = 4
        else
            option = option - 1
        end
    elseif love.keyboard.wasPressed('s') or love.keyboard.wasPressed('down') then
        if option == 4 then
            option = 1
        else
            option = option + 1
        end
    end

    if love.keyboard.wasPressed('return') and option == 1 then
        gStateStack:pop()
        gStateStack:push(PlayBedroomState())
    elseif love.keyboard.wasPressed('return') and option == 2 then
        gStateStack:pop()
        gStateStack:push(CreditsState())
    elseif love.keyboard.wasPressed('return') and option == 3 then
        gStateStack:pop()
        gStateStack:push(OptionsState())
    elseif love.keyboard.wasPressed('return') and option == 4 then
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
    if option == 1 then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Play', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    elseif option == 2 then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Credits', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    elseif option == 3 then
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Options', 0, VIRTUAL_HEIGHT / 2 + 100, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Exit', 0, VIRTUAL_HEIGHT / 2 + 200, VIRTUAL_WIDTH, 'center')
    end
end