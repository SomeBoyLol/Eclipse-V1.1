debug = {}
debug.mode = false

local line = 0

local font = love.graphics.newFont(12)

function debug:update(dt)
end

function write(text)
    love.graphics.print(text, 0, 12 * line)

    line = line + 1
end

function debug:draw()
    if not debug.mode then
        return
    end

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 300, love.graphics:getHeight())

    line = 0
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(font)
    write("FPS: "..love.timer:getFPS())
    line = line + 1
    write("Inbound: "..tostring(editor.inbound))
    write("Hover: "..tostring(editor.hover))
    write("Tool: "..editor.tool)
    line = line + 1
    write("Image Select: "..editor.imageSelect)
    write("Image Scale: "..editor.imageScale)
    write("Image Multiple: "..editor.imageMultiple)
    line = line + 1
    write("SelectX: "..editor.selectX.. " SelectY: "..editor.selectY)
    write("targetX: "..editor.targetX.. " targetY: "..editor.targetY)
end