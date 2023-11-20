FadeInState = Class{__includes = BaseState}

function FadeInState:init(color, params, time, onFadeComplete)
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.opacity = 0
    self.time = time
    self.x = params.x or 0
    self.y = params.y or 0
    self.width = params.width or VIRTUAL_WIDTH
    self.height = params.height or VIRTUAL_HEIGHT

    Timer.tween(self.time, {
        [self] = {opacity = 1}
    })
    :finish(function()
        gStateStack:pop()
        onFadeComplete()
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)
end