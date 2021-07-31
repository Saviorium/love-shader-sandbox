local state = {}

function state:enter(prev, shader)
    self.shader = shaders[shader]
    print(shader)
end

function state:keypressed(key)
end

function state:draw()
    if self.shader:hasUniform("time") then
        self.shader:send("time", love.timer.getTime())
    end
    if self.shader:hasUniform("mouse_coords") then
        self.shader:send("mouse_coords", {love.mouse.getPosition()})
    end
    love.graphics.setShader(self.shader)
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setShader()
end

function state:update(dt)
end

return state
