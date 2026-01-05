-- services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- gui
local gui = Instance.new("ScreenGui")
gui.Name = "RedsoulKeyUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- main frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.38, 0.32)
frame.Position = UDim2.fromScale(0.31, 0.34)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.BackgroundTransparency = 1

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- fade in
TweenService:Create(frame, TweenInfo.new(0.35), {
    BackgroundTransparency = 0
}):Play()

-- title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.22, 0)
title.BackgroundTransparency = 1
title.Text = "🔐 Redsoul Hub"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 90, 90)

-- subtitle
local sub = Instance.new("TextLabel", frame)
sub.Position = UDim2.fromScale(0, 0.2)
sub.Size = UDim2.new(1, 0, 0.12, 0)
sub.BackgroundTransparency = 1
sub.Text = "Enter your key to continue"
sub.Font = Enum.Font.Gotham
sub.TextScaled = true
sub.TextColor3 = Color3.fromRGB(180,180,180)

-- textbox
local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Red-xxxxxxxxxxxxxxxx"
box.Text = ""
box.Size = UDim2.fromScale(0.9, 0.18)
box.Position = UDim2.fromScale(0.05, 0.38)
box.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
box.TextColor3 = Color3.new(1,1,1)
box.Font = Enum.Font.Gotham
box.TextScaled = true
box.ClearTextOnFocus = false
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 14)

-- status
local status = Instance.new("TextLabel", frame)
status.Size = UDim2.fromScale(0.9, 0.1)
status.Position = UDim2.fromScale(0.05, 0.58)
status.BackgroundTransparency = 1
status.Text = ""
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.TextColor3 = Color3.fromRGB(200,200,200)

-- buttons
local function makeBtn(text, pos, color)
    local b = Instance.new("TextButton", frame)
    b.Text = text
    b.Size = UDim2.fromScale(0.42, 0.18)
    b.Position = pos
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)
    return b
end

local getKey = makeBtn("🔗 Get Key", UDim2.fromScale(0.05, 0.72), Color3.fromRGB(70,70,255))
local checkKey = makeBtn("✅ Verify", UDim2.fromScale(0.53, 0.72), Color3.fromRGB(70,200,120))

-- get key
getKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://api.pandadevelopment.net/getkey?service=redsoulhub")
    end
    status.Text = "🔗 Get key link copied to clipboard"
    status.TextColor3 = Color3.fromRGB(120,160,255)
end)

-- verify
checkKey.MouseButton1Click:Connect(function()
    local key = box.Text
    if key == "" then
        status.Text = "⚠️ Enter a key first"
        status.TextColor3 = Color3.fromRGB(255,120,120)
        return
    end

    status.Text = "⏳ Verifying key..."
    status.TextColor3 = Color3.fromRGB(200,200,200)

    local ok, res = pcall(function()
        return game:HttpGet(
            "https://api.pandadevelopment.net/verify?service="
            .. SERVICE .. "&key=" .. key
        )
    end)

    if ok and res == "true" then
        status.Text = "✅ Key verified! Loading..."
        status.TextColor3 = Color3.fromRGB(120,255,160)
        wait(0.5)
        gui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Greensoul8410/redsoulmain/main/main.lua"))()
    else
        status.Text = "❌ Invalid or expired key"
        status.TextColor3 = Color3.fromRGB(255,120,120)
    end
end)
