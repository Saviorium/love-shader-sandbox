require "settings"

Utils = require "engine.utils.utils"
Vector = require "lib.hump.vector"
Class = require "lib.hump.class"

require "engine.utils.debug"
serpent = require "lib.serpent.serpent"

StateManager = require "lib.hump.gamestate"

AssetManager = require "engine.utils.asset_manager"

states = {
    menu = require "game.states.menu",
    fullscreenShader = require "game.states.fullscreen_shader",
}

local RingStruct = require "game.ring_struct"

local shaderStates = RingStruct()
shaderStates:push({type = "fullscreenShader", args = "coord"})
shaderStates:push({type = "fullscreenShader", args = "time"})
shaderStates:push({type = "fullscreenShader", args = "mouse"})
shaderStates:push({type = "fullscreenShader", args = "matrix_pattern"})

function love.load()
    AssetManager:load("data")
    StateManager.switch(states.menu)
end

local debugPixelTimer = 0
local debugPixel = ""

function love.draw()
    StateManager.draw()
    if Debug and Debug.showFps == 1 then
        love.graphics.print(""..tostring(love.timer.getFPS( )), 2, 2)
    end
    if Debug and Debug.mousePixelInfo == 1 then
        local x, y = love.mouse.getPosition()
        local screenX, screenY = love.graphics.getDimensions()

        if debugPixelTimer > 0.5 then
            love.graphics.captureScreenshot( function(image)
                local debugPixelColor = { image:getPixel(x, y) }
                debugPixel = string.format("%.2f %.2f %.2f", debugPixelColor[1], debugPixelColor[2], debugPixelColor[3])
            end )
            debugPixelTimer = 0
        end

        love.graphics.rectangle("fill", x-1, y-1, 1, 1)
        love.graphics.print(string.format("%.2f %.2f\n%s", x/screenX, y/screenY, debugPixel), x+10, y)
    end
end

function love.update(dt)
    debugPixelTimer = debugPixelTimer + dt
end

function love.mousepressed(x, y)
    if StateManager.current().mousepressed then
        StateManager.current():mousepressed(x, y)
    end
end

function love.mousereleased(x, y)
    if StateManager.current().mousereleased then
        StateManager.current():mousereleased(x, y)
    end
end

function love.keypressed(key)
    if StateManager.current().keypressed then
        StateManager.current():keypressed(key)
    end
    if key == "escape" then
        StateManager.switch(states.menu)
    end
    if key == "right" then
        local nextShader = shaderStates:next()
        StateManager.switch(states[nextShader.type], nextShader.args)
    end
    if key == "left" then
        local nextShader = shaderStates:prev()
        StateManager.switch(states[nextShader.type], nextShader.args)
    end
end
