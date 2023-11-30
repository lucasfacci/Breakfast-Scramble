FadeInState = Class{__includes = BaseState}

function FadeInState:init(color, params, time, onFadeComplete)
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.opacity = 0
    self.text = params.text or nil
    self.x = params.x or 0
    self.y = params.y or 0
    self.width = params.width or VIRTUAL_WIDTH
    self.height = params.height or VIRTUAL_HEIGHT
    self.time = time

    Timer.tween(self.time, {
        [self] = {opacity = 1}
    })
    :finish(function()
        Timer.after(3, function ()
            gStateStack:pop()
            onFadeComplete()
        end)
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)

    if self.text and self.opacity == 1 then
        love.graphics.setFont(gFonts['yesevaone-medium'])
        love.graphics.printf(self.text, 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')
    end
end