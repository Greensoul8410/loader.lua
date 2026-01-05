-- 🔑 CONFIG
local SERVICE = "redsoulhub"
local GET_KEY_URL = "https://api.pandadevelopment.net/getkey?service=redsoulhub"
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/Greensoul8410/redsoulmain/main/main.lua"

-- 🔧 Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- 🖼️ UI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "RedsoulKeyUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.35, 0.3)
frame.Position = UDim2.fromScale(0.325, 0.35)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.25,0)
title.Text = "🔥 Redsoul Hub – Key System"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Enter your key here"
box.Size = UDim2.fromScale(0.9, 0.2)
box.Position = UDim2.fromScale(0.05, 0.4)
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextScaled = true
box.BackgroundColor3 = Color3.fromRGB(35,35,35)
box.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", box).CornerRadius = UDim.new(0,12)

local getKey = Instance.new("TextButton", frame)
getKey.Text = "🔗 Get Key"
getKey.Size = UDim2.fromScale(0.42, 0.2)
getKey.Position = UDim2.fromScale(0.05, 0.7)
getKey.BackgroundColor3 = Color3.fromRGB(255,80,80)
getKey.TextScaled = true
getKey.Font = Enum.Font.GothamBold
getKey.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", getKey).CornerRadius = UDim.new(0,12)

local checkKey = Instance.new("TextButton", frame)
checkKey.Text = "✅ Check Key"
checkKey.Size = UDim2.fromScale(0.42, 0.2)
checkKey.Position = UDim2.fromScale(0.53, 0.7)
checkKey.BackgroundColor3 = Color3.fromRGB(80,255,120)
checkKey.TextScaled = true
checkKey.Font = Enum.Font.GothamBold
checkKey.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", checkKey).CornerRadius = UDim.new(0,12)

-- 🔗 Get Key button
getKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GET_KEY_URL)
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Redsoul Hub",
        Text = "Get Key link copied to clipboard!",
        Duration = 5
    })
end)

-- ✅ Check Key button
checkKey.MouseButton1Click:Connect(function()
    local key = box.Text
    if key == "" then return end

    local url = "https://api.pandadevelopment.net/verify?service="..SERVICE.."&key="..key
    local response = game:HttpGet(url)

    if response == "true" then
        gui:Destroy()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Invalid Key",
            Text = "Key is wrong or expired",
            Duration = 5
        })
    end
end)
