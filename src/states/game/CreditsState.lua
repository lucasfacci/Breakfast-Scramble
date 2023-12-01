CreditsState = Class{__includes = BaseState}

function CreditsState:init()
end

function CreditsState:update(dt)
end

function CreditsState:render()
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Still have to implement this :)', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
end