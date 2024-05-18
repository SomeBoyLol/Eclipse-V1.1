function saveMapImagesPair()
    if #editor.images == 0 then
        return
    end

    local imagesSave = {}
    imagesSave.mapDirectory = map.directory
    for i, image in ipairs(editor.images) do
        local imageSave = {}
        imageSave.name = image.name
        imageSave.path = image.path

        table.insert(imagesSave, imageSave)
    end

    print(table.show(imagesSave, "imagesSave"))

    local found = false
    for i, v in ipairs(mapImages) do
        if v.mapDirectory == imagesSave.mapDirectory then
            mapImages[i] = imagesSave
            found = true
            break
        end
    end

    if not found then
        table.insert(mapImages, imagesSave)
    end

    save()
end

function openMapImagesPair()
    for i, v in ipairs(mapImages) do
        if v.mapDirectory == map.directory then
            editor.images = {}

            for i, image in ipairs(v) do
                editor:newImage({name = image.name, path = image.path})
            end
        end
    end
end