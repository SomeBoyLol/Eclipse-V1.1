gui:style({})

newImage = gui:create("window", {color = {36/255, 36/255, 36/255}})
newImage.title = gui:create("frame", {text = "New Image", width = 450, height = 100, x = 50, y = 50, font = 45, textAlignmentX = "left", textAlignmentY = "top", color = {1, 0, 0, 0}})

local subtitle = {
    x = 50;
    y = 170;
    width = 500;
    height = 50;
    color = {1, 0, 0, 0};
    textAlignmentX = "left";
    font = 30;
}

local input = {
    x = 50;
    y = 230;
    width = 610;
    height = 40;
    textAlignmentX = "left";
    font = 16;
    textMargin = 10;
    color = {56/255, 56/255, 56/255};
    editColor = {64/255, 64/255, 64/255};
    hoverColor = {64/255, 64/255, 64/255};
}

local smallbutton = {
    color = {64/255, 53/255, 130/255};
    hoverColor = {81/255, 67/255, 163/255};
    alignmentX = "left";
    alignmentY = "bottom";
    x = 50;
    y = -50;
    width = 130;
    height = 50;
    font = 20;
}

--NAME--
gui:style({subtitle})
newImage.name = gui:create("frame", {text = "Name"})
gui:style({input})
newImage.nameInput = gui:create("input", {text = "ambatukam"})

--SOURCE-- IM MORBING RAHHH
gui:style({subtitle})
newImage.source = gui:create("frame", {text = "Path", y = 300})
gui:style({input})
newImage.sourceInput = gui:create("input", {text = "C:/Users/inesh/OneDrive/Documents", y = 360})
newImage.pasteClipboard = gui:create("button", {text = "Paste from Clipboard", y = 410, width = 200, height = 40, textAlignmentX = "center", textAlignmentY = "center", func = function()
    newImage.sourceInput.text = love.system:getClipboardText()
end})
newImage.clear = gui:create("button", {text = "Clear", x = 260, y = 410, width = 100, height = 40, textAlignmentX = "center", textAlignmentY = "center", func = function()
    newImage.sourceInput.text = ""
end})

--BOTTOM BUTTONS--
gui:style({smallbutton})
newImage.back = gui:create("button", {text = "Back", func = function() menu = editorGUI end})

newImage.create = gui:create("button", {text = "Create", x = 190, func = function()
    local success, error = pcall(function() editor:newImage({name = newImage.nameInput.text, path = newImage.sourceInput.text}) end)
    print(error)
    if success then
        menu = editorGUI
        print("successfully opened image")
        updateImageList(editor.images)
    else
        print("failed to open image")
    end
end})