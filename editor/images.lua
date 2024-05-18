editor.images = {}

function editor:newImage(settings)
    local image = {}
    image.name = settings.name or "unnamed image"
    image.path = settings.path

    local file = io.open(image.path, "rb")
    local fileData = file:read("*a")
    file:close()
    fileData = love.filesystem.newFileData(fileData, "image.png")
    local imageData = love.image.newImageData(fileData)

    image.sprite = love.graphics.newImage(imageData)

    table.insert(editor.images, image)
end

function editor:insertImage(settings)
    local image = {}
    image.x = settings.x or 0
    image.y = settings.y or 0
    image.scale = settings.scale or 1
    image.id = settings.id

    table.insert(map.images, image)
end

function editor:updateImages(dt)
end

function editor:drawImages()
    love.graphics.setColor(1, 1, 1)
    for i, image in ipairs(map.images) do
        if editor.images[image.id] == nil then
            return
        end
        love.graphics.draw(editor.images[image.id].sprite, image.x, image.y, nil, image.scale, image.scale)
    end
end