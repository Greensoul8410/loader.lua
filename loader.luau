-- services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- config
local SERVICE_IDENTIFIER = "redsoulhub" -- use identifier, not display name
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/Greensoul8410/redsoulmain/main/main.lua"
local GET_KEY_URL = "https://api.pandadevelopment.net/getkey?service=redsoulhub"

-- gui
local gui = Instance.new("ScreenGui")
gui.Name = "RedsoulKeyUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.38, 0.32)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.BackgroundTransparency = 1
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,20)

-- fade in
TweenService:Create(frame, TweenInfo.new(0.35), {BackgroundTransparency = 0}):Play()

-- title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.22, 0)
title.BackgroundTransparency = 1
title.Text = "🔐 Redsoul Hub"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,90,90)
title.Parent = frame

-- subtitle
local sub = Instance.new("TextLabel")
sub.Position = UDim2.fromScale(0,0.2)
sub.Size = UDim2.new(1,0,0.12,0)
sub.BackgroundTransparency = 1
sub.Text = "Enter your key to continue"
sub.Font = Enum.Font.Gotham
sub.TextScaled = true
sub.TextColor3 = Color3.fromRGB(180,180,180)
sub.Parent = frame

-- key textbox
local box = Instance.new("TextBox")
box.PlaceholderText = "Red-XXXXXXXX"
box.Text = ""
box.Size = UDim2.fromScale(0.9,0.18)
box.Position = UDim2.fromScale(0.05,0.38)
box.BackgroundColor3 = Color3.fromRGB(35,35,45)
box.TextColor3 = Color3.fromRGB(255,255,255)
box.Font = Enum.Font.Gotham
box.TextScaled = true
box.ClearTextOnFocus = false
box.Parent = frame
Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)

-- status label
local status = Instance.new("TextLabel")
status.Size = UDim2.fromScale(0.9,0.1)
status.Position = UDim2.fromScale(0.05,0.58)
status.BackgroundTransparency = 1
status.Text = ""
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.TextColor3 = Color3.fromRGB(200,200,200)
status.Parent = frame

-- button creator
local function makeBtn(text, pos, color)
    local b = Instance.new("TextButton")
    b.Text = text
    b.Size = UDim2.fromScale(0.42,0.18)
    b.Position = pos
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,14)
    b.Parent = frame
    -- hover glow effect
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = color:Lerp(Color3.fromRGB(0,255,255),0.3)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    return b
end

-- buttons
local getKey = makeBtn("🔗 Get Key", UDim2.fromScale(0.05,0.72), Color3.fromRGB(70,70,255))
local checkKey = makeBtn("✅ Verify", UDim2.fromScale(0.53,0.72), Color3.fromRGB(70,200,120))

-- get key click
getKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GET_KEY_URL)
        status.Text = "🔗 Key link copied to clipboard!"
        status.TextColor3 = Color3.fromRGB(120,160,255)
    end
end)

-- verify key click
-- list of keys you want to allow locally
local validKeys = {
    "RED123",
    "TESTKEY",
    "MYSECRET"
}

checkKey.MouseButton1Click:Connect(function()
    local key = box.Text:gsub("%s",""):upper() -- remove spaces & make uppercase
    if key == "" then
        status.Text = "⚠️ Enter a key first"
        status.TextColor3 = Color3.fromRGB(255,120,120)
        return
    end

    status.Text = "⏳ Verifying key..."
    status.TextColor3 = Color3.fromRGB(200,200,200)

    local success = false
    for _, k in pairs(validKeys) do
        if key == k then
            success = true
            break
        end
    end

    if success then
        status.Text = "✅ Key verified! Loading..."
        status.TextColor3 = Color3.fromRGB(120,255,160)
        wait(0.5)
        gui:Destroy()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
    else
        status.Text = "❌ Invalid or expired key"
        status.TextColor3 = Color3.fromRGB(255,120,120)
    end
end)

