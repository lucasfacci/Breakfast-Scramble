CreditsState = Class{__includes = BaseState}

function CreditsState:init()
    self.virtualVirtualHeight = VIRTUAL_HEIGHT - gFonts['yesevaone-medium']:getHeight()
end

function CreditsState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(MenuState({}))
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function CreditsState:render()
    love.graphics.setFont(gFonts['yesevaone-medium'])
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Credits to:', 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Facci', 0, self.virtualVirtualHeight / 2 - 200, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('pchila', 0, self.virtualVirtualHeight / 2 - 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('purplily', 0, self.virtualVirtualHeight / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('SirSunstone', 0, self.virtualVirtualHeight / 2  + 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Thank you guys!', 0, self.virtualVirtualHeight - gFonts['yesevaone-medium']:getHeight() - 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Return', 0, VIRTUAL_HEIGHT - gFonts['yesevaone-medium']:getHeight(), VIRTUAL_WIDTH, 'right')
end