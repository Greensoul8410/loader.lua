-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Config
local SERVICE_IDENTIFIER = "redsoulhub"
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/Greensoul8410/redsoulmain/main/main.lua"
local GET_KEY_URL = "https://api.pandadevelopment.net/getkey?service=redsoulhub"

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RedsoulKeyUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.38, 0.32)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.BackgroundTransparency = 1
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- Fade in animation
TweenService:Create(frame, TweenInfo.new(0.35), {BackgroundTransparency = 0}):Play()

-- Draggable logo to hide/show
local logo = Instance.new("ImageButton")
logo.Size = UDim2.fromScale(0.08, 0.08)
logo.Position = UDim2.fromScale(0.01, 0.01)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://77729081025397" -- replace with your logo asset ID
logo.Parent = frame

local uiVisible = true
logo.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    frame.Visible = uiVisible
end)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.22, 0)
title.BackgroundTransparency = 1
title.Text = "🔐 Redsoul Hub"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 60, 60)
title.Parent = frame

-- Subtitle
local sub = Instance.new("TextLabel")
sub.Position = UDim2.fromScale(0, 0.22)
sub.Size = UDim2.new(1, 0, 0.1, 0)
sub.BackgroundTransparency = 1
sub.Text = "Enter your key to continue"
sub.Font = Enum.Font.Gotham
sub.TextScaled = true
sub.TextColor3 = Color3.fromRGB(180, 180, 180)
sub.Parent = frame

-- Key TextBox
local box = Instance.new("TextBox")
box.PlaceholderText = "Red-XXXXXXXX"
box.Text = ""
box.Size = UDim2.fromScale(0.9, 0.18)
box.Position = UDim2.fromScale(0.05, 0.35)
box.BackgroundColor3 = Color3.fromRGB(28, 0, 0)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Font = Enum.Font.Gotham
box.TextScaled = true
box.ClearTextOnFocus = false
box.Parent = frame
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 14)

-- Status label
local status = Instance.new("TextLabel")
status.Size = UDim2.fromScale(0.9, 0.1)
status.Position = UDim2.fromScale(0.05, 0.55)
status.BackgroundTransparency = 1
status.Text = ""
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Parent = frame

-- Button creator
local function makeBtn(text, pos, color)
    local b = Instance.new("TextButton")
    b.Text = text
    b.Size = UDim2.fromScale(0.42, 0.18)
    b.Position = pos
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)
    b.Parent = frame

    -- Hover effect
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = color:Lerp(Color3.fromRGB(255, 100, 100), 0.3)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    return b
end

-- Buttons
local getKey = makeBtn("🔗 Get Key", UDim2.fromScale(0.05, 0.75), Color3.fromRGB(70, 0, 0))
local checkKey = makeBtn("✅ Verify", UDim2.fromScale(0.53, 0.75), Color3.fromRGB(120, 0, 0))

-- Get Key click
getKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GET_KEY_URL)
    end
    status.Text = "🔗 Key link copied! Go get your key"
    status.TextColor3 = Color3.fromRGB(120, 160, 255)
end)

-- Verify click
checkKey.MouseButton1Click:Connect(function()
    local key = box.Text:gsub("%s", "") -- remove spaces
    if key == "" then
        status.Text = "⚠️ Enter a key first"
        status.TextColor3 = Color3.fromRGB(255, 120, 120)
        return
    end

    status.Text = "⏳ Verifying key..."
    status.TextColor3 = Color3.fromRGB(200, 200, 200)

    local ok, res = pcall(function()
        return game:HttpGet("https://api.pandadevelopment.net/verify?service="..SERVICE_IDENTIFIER.."&key="..key)
    end)

    print("Pelican Response:", res)

    if ok and res == "true" then
        status.Text = "✅ Key verified! Loading..."
        status.TextColor3 = Color3.fromRGB(120, 255, 160)
        task.wait(0.5)
        gui:Destroy()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
    else
        status.Text = "❌ Invalid / expired key"
        status.TextColor3 = Color3.fromRGB(255, 120, 120)
    end
end)
