local state = {}

function state:enter(prev, shader)
    self.shader = shaders[shader]
    vardump(shader)
end

function state:keypressed(key)
end

function state:draw()
    love.graphics.setShader(self.shader)
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setShader()
end

function state:update(dt)
end

return state
