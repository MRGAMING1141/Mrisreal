-- IND HUB | Rayfield Edition
-- Converted from the original UI to Rayfield.

repeat
    task.wait()
until game.Players.LocalPlayer

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "IND HUB",
    LoadingTitle = "IND HUB",
    LoadingSubtitle = "Blox Fruits",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "IND_HUB",
        FileName = "IND_HUB_Config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local function WrapTab(tab)
    local wrapper = {}
    function wrapper:Button(name, callback)
        return tab:CreateButton({Name=tostring(name), Callback=callback or function() end})
    end
    function wrapper:Toggle(name, default, callback)
        return tab:CreateToggle({Name=tostring(name), CurrentValue=default==true, Callback=callback or function() end})
    end
    function wrapper:Dropdown(name, options, callback)
        options=options or {}; local current={}
        for i,v in ipairs(options) do current[i]=tostring(v) end
        local control=tab:CreateDropdown({Name=tostring(name),Options=current,CurrentOption=current[1] and {current[1]} or {},MultipleOptions=false,Callback=function(value)
            if type(value)=="table" then value=value[1] end
            if callback then callback(value) end
        end})
        local api={}
        function api:Clear() current={}; pcall(function() control:Refresh({}) end) end
        function api:Add(value) table.insert(current,tostring(value)); pcall(function() control:Refresh(current) end) end
        return setmetatable(api,{__index=control})
    end
    function wrapper:Slider(name,min,max,default,callback)
        min=tonumber(min) or 0; max=tonumber(max) or 100; default=tonumber(default) or min
        if default<min then default=min end; if default>max then default=max end
        return tab:CreateSlider({Name=tostring(name),Range={min,max},Increment=1,Suffix="",CurrentValue=default,Callback=callback or function() end})
    end
    function wrapper:Textbox(name,_,callback)
        return tab:CreateInput({Name=tostring(name),CurrentValue="",PlaceholderText=tostring(name),RemoveTextAfterFocusLost=false,Callback=callback or function() end})
    end
    function wrapper:Label(text)
        local paragraph=tab:CreateParagraph({Title="",Content=tostring(text or "")}); local api={}
        function api:Set(value) pcall(function() paragraph:Set({Title="",Content=tostring(value or "")}) end) end
        return api
    end
    function wrapper:Seperator(text) return tab:CreateSection(tostring(text or "")) end
    function wrapper:Separator(text) return self:Seperator(text) end
    function wrapper:Line() return tab:CreateSection("────────────────") end
    return wrapper
end

-- The remainder of the original Blox Fruits callbacks is preserved below.
