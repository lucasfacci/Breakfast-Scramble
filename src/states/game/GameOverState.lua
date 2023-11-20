GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:clear()
        gStateStack:push(MenuState())
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['yesevaone-large'])
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['yesevaone-medium'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH, 'center')
end