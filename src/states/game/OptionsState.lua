OptionsState = Class{__includes = BaseState}

function OptionsState:init()
end

function OptionsState:update(dt)
end

function OptionsState:render()
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Still have to implement this :)', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
end