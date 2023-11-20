Camera = Class{}

function Camera:init(player)
    self.x = 0
    self.y = 0

    self.player = player
end

function Camera:update(dt)
    self.x = self.player.x - (VIRTUAL_WIDTH / 2) + (self.player.width / 2)
    self.y = self.player.y - (VIRTUAL_HEIGHT / 2) + (self.player.height / 2)
end