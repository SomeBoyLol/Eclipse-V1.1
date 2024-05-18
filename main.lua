function love.load()
    require("source/startup")
    startup()

    read()
    updateRecentsList()
    resetTileset()

    menu = editorGUI

    editor:openMap("C:/Users/inesh/OneDrive/Documents/Maps/collidertest.lua")
    editor.tool = "insert image"
    --editor:newImage({name = "edp", path = "C:/Users/inesh/OneDrive/Pictures/Saved Pictures/edp445.jpg"})
    updateImageList(editor.images)
end

function love.update(dt)
    menu:update(dt)
    editor:update(dt)

    debug:update(dt)
end

function love.draw()
    editor:draw()
    love.graphics.push()
    scale = math.min(love.graphics:getWidth()/coreWidth, love.graphics:getHeight()/coreHeight)
    love.graphics.scale(scale, scale)

    love.graphics.rectangle("line", 0, 0, coreWidth, coreHeight)

    menu:draw()
    love.graphics.pop()

    debug:draw()
end

function love.keypressed(key)
    menu:keypressed(key)

    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        print(inspect(editor.images[editor.imageSelect]))
        print("editor.imageSelect = "..editor.imageSelect)
        print(table.show(editor.images, "editor.images"))
    elseif key == "f11" then
        fullscreen = not fullscreen
        love.window.setFullscreen(fullscreen, "desktop")
    elseif key == "tab" then
        debug.mode = not(debug.mode)
    end
end

function love.mousepressed(x, y, button)
    menu:mousepressed(x, y, button)

    if button ~= 1 then
        return
    end

    if editor.hover and editor.tool == "collider" and editor.inbound then
        if editor.selectColliderClass == nil then
            return
        end

        editor.drawingCollider = true
        editor.startColliderX = editor.selectX
        editor.startColliderY = editor.selectY
    end

    if editor.hover and editor.tool == "delete" then
        if editor.selectColliderClass == nil then
            return
        end

        mx, my = cam:getCamPosition(love.mouse:getPosition())

        for i, collider in pairs(map.colliders[editor.selectColliderClass]) do
            if mx > collider.x and mx < collider.x + collider.width and my > collider.y and my < collider.y + collider.height then
                table.remove(map.colliders[editor.selectColliderClass], i)
            end
        end
    end

    if editor.hover and editor.inbound and editor.tool == "insert image" and editor.imageSelect ~= 0 then
        editor:insertImage({x = editor.selectX, y = editor.selectY, scale = editor.imageScale, id = editor.imageSelect})
    end

    if editor.hover and editor.tool == "delete image" then
        local mx, my = cam:getCamPosition(love.mouse:getPosition())

        for i, image in ipairs(map.images) do
            if editor.images[image.id] == nil then
                return
            end

            local sprite = editor.images[image.id].sprite

            if mx > image.x and mx < image.x + sprite:getWidth() * image.scale and my > image.y and my < image.y + sprite:getHeight() * image.scale then
                table.remove(map.images, i)
            end
        end
    end
end

function love.mousereleased(x, y, button)
    if editor.tool == "collider" and editor.drawingCollider then
        editor.drawingCollider = false

        if editor.hover then
            editor:newCollider({x = editor.selectX, y = editor.selectY, width = editor.selectWidth, height = editor.selectHeight, class = editor.selectColliderClass})
            --print(table.show({x = startX, y = startY, width = width, height = height, class = editor.selectColliderClass}))
        end
    end
end

function love.textinput(t)
    menu:textinput(t)
end

function love.directorydropped(path)
    print(path)
end