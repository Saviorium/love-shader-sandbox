local state = {}

local function loadShader(name)
    local shaderCode = love.filesystem.read("game/shaders/" .. name .. ".glsl")
    return love.graphics.newShader(shaderCode)
end

function state:enter(prev, shader)
    self.shader = loadShader(shader)
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
    if self.shader:hasUniform("mouse_normalized") then
        local x, y = love.mouse.getPosition()
        x = x / love.graphics.getWidth()
        y = y / love.graphics.getHeight()
        self.shader:send("mouse_normalized", {x, y})
    end
    love.graphics.setShader(self.shader)
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setShader()
end

function state:update(dt)
end

return state
