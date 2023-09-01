PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, map)
    self.entity = player
    self.map = map

    self.entity.offsetX = 0
    self.entity.offsetY = 5
end

function PlayerWalkState:update(dt)
    -- walk diagonally to the top left side
    if (love.keyboard.isDown('left') or love.keyboard.isDown('a')) and (love.keyboard.isDown('up') or love.keyboard.isDown('w')) then
        self.entity.direction = 'left'
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    -- walk diagonally to the bottom left side
    elseif (love.keyboard.isDown('left') or love.keyboard.isDown('a')) and (love.keyboard.isDown('down') or love.keyboard.isDown('s')) then
        self.entity.direction = 'left'
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    -- walk straight to the left side
    elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    -- walk diagonally to the top right side
    elseif (love.keyboard.isDown('right') or love.keyboard.isDown('d')) and (love.keyboard.isDown('up') or love.keyboard.isDown('w')) then
        self.entity.direction = 'right'

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    -- walk diagonally to the bottom right side
    elseif (love.keyboard.isDown('right') or love.keyboard.isDown('d')) and (love.keyboard.isDown('down') or love.keyboard.isDown('s')) then
        self.entity.direction = 'right'

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    -- walk straight to the right side
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.entity.direction = 'right'

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    -- walk straight to the top side
    elseif love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        self.entity.direction = 'up'

        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    -- walk straight to the bottom side
    elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        self.entity.direction = 'down'

        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    -- don't walk, stay idle
    else
        self.entity:changeState('idle')
    end

    EntityWalkState.update(self, dt)

    if self.bumped then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'right' then
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'up' then
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
        else
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
        end
    end
end