print("🔥 Key system script started")

-- ================= CONFIG =================
local Config = {
    api = "e272e094-2f1e-45ff-a636-55b95ee83ffa",
    service = "RedsoulHub",
    provider = "Checkpoint1"
}

-- ================= MAIN SCRIPT =================
local function main()
    local success, err = pcall(function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/gamer8410/choco/main/whattt"
        ))()
    end)

    if not success then
        warn("Failed to load main script:", err)
    end
end

if getgenv().RedExecutorKeySys then return end
getgenv().RedExecutorKeySys = true

-- ================= SERVICES =================
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

-- ================= BLUR =================
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0
TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 18}):Play()

-- ================= GUI =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RedsoulKeySystem"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

-- ================= MAIN FRAME =================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.fromOffset(0,0)
MainFrame.Position = UDim2.fromScale(0.5,0.5)
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(22,22,26)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,14)

-- OPEN ANIMATION
TweenService:Create(
    MainFrame,
    TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.fromOffset(380,270)}
):Play()

-- ================= ACRYLIC NOISE =================
local Noise = Instance.new("ImageLabel", MainFrame)
Noise.Size = UDim2.fromScale(1,1)
Noise.BackgroundTransparency = 1
Noise.Image = "rbxassetid://9968344105"
Noise.ImageTransparency = 0.85
Noise.ZIndex = 2

-- ================= BORDER =================
local Border = Instance.new("UIStroke", MainFrame)
Border.Thickness = 2
Border.Transparency = 0.2

local BorderGrad = Instance.new("UIGradient", Border)
BorderGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,80,80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120,0,255))
}

task.spawn(function()
    while MainFrame.Parent do
        BorderGrad.Rotation += 0.4
        task.wait(0.03)
    end
end)

-- ================= TITLE =================
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "RedsoulHub Key System"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255,90,90)

-- ================= INPUT =================
local KeyInput = Instance.new("TextBox", MainFrame)
KeyInput.Size = UDim2.fromOffset(300,38)
KeyInput.Position = UDim2.fromScale(0.5,0.32)
KeyInput.AnchorPoint = Vector2.new(0.5,0)
KeyInput.PlaceholderText = "Enter your key..."
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 14
KeyInput.TextColor3 = Color3.new(1,1,1)
KeyInput.BackgroundColor3 = Color3.fromRGB(30,30,35)
KeyInput.ClearTextOnFocus = false
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0,8)

local InputStroke = Instance.new("UIStroke", KeyInput)
InputStroke.Color = Color3.fromRGB(255,80,80)
InputStroke.Transparency = 0.7

-- ================= BUTTONS =================
local function MakeButton(text, x)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.fromOffset(130,36)
    b.Position = UDim2.fromScale(x,0.56)
    b.AnchorPoint = Vector2.new(0.5,0)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BackgroundColor3 = Color3.fromRGB(35,35,40)
    b.TextColor3 = Color3.fromRGB(255,90,90)
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    return b
end

local SubmitButton = MakeButton("VERIFY", 0.3)
local GetKeyButton = MakeButton("GET KEY", 0.7)

-- ================= LOADER =================
local Loader = Instance.new("ImageLabel", MainFrame)
Loader.Size = UDim2.fromOffset(26,26)
Loader.Position = UDim2.fromScale(0.5,0.45)
Loader.AnchorPoint = Vector2.new(0.5,0.5)
Loader.Image = "rbxassetid://7733658504"
Loader.BackgroundTransparency = 1
Loader.Visible = false

RunService.RenderStepped:Connect(function(dt)
    if Loader.Visible then
        Loader.Rotation += 360 * dt
    end
end)

-- ================= SUCCESS =================
local Check = Instance.new("TextLabel", MainFrame)
Check.Size = UDim2.fromOffset(80,80)
Check.Position = UDim2.fromScale(0.5,0.45)
Check.AnchorPoint = Vector2.new(0.5,0.5)
Check.BackgroundTransparency = 1
Check.Text = "✓"
Check.Font = Enum.Font.GothamBlack
Check.TextSize = 72
Check.TextColor3 = Color3.fromRGB(80,255,120)
Check.TextTransparency = 1

local function SuccessAnim()
    TweenService:Create(Check, TweenInfo.new(0.25), {
        TextTransparency = 0,
        Rotation = 360
    }):Play()
end

local function Shake()
    local p = MainFrame.Position
    for i = 1,6 do
        MainFrame.Position = p + UDim2.fromOffset(i%2==0 and -6 or 6,0)
        task.wait(0.03)
    end
    MainFrame.Position = p
end

-- ================= KEY SAVE =================
local FileName = "redexecutor/key.txt"
local function SaveKey(k)
    if writefile then writefile(FileName, k) end
end

local function LoadKey()
    if readfile and isfile and isfile(FileName) then
        return readfile(FileName)
    end
end

local saved = LoadKey()
if saved then KeyInput.Text = saved end

-- ================= JUNKIE =================
local function openGetKey()
    print("🟡 Get Key clicked")

    local success, sdk = pcall(function()
        return loadstring(game:HttpGet(
            "https://junkie-development.de/sdk/JunkieKeySystem.lua"
        ))()
    end)

    if not success or not sdk then
        warn("❌ Failed to load Junkie SDK")
        return
    end

    local link
    local ok, err = pcall(function()
        link = sdk.getLink(Config.api, Config.provider, Config.service)
    end)

    if not ok or not link then
        warn("❌ Junkie did not return a link")
        return
    end

    print("✅ Junkie link:", link)

    if setclipboard then
        setclipboard(link)
        print("📋 Link copied to clipboard")
    else
        warn("⚠️ setclipboard not supported, printing link instead")
        print(link)
    end
end


local function validateKey()
    local key = KeyInput.Text:gsub("%s+","")
    if key == "" then return end

    Loader.Visible = true

    local sdk = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local valid = sdk.verifyKey(Config.api, key, Config.service)

    Loader.Visible = false

    if valid then
        SaveKey(key)
        SuccessAnim()
        task.wait(0.4)
        Blur:Destroy()
        ScreenGui:Destroy()
        main()
    else
        Shake()
    end
end

-- ================= EVENTS =================
SubmitButton.MouseButton1Click:Connect(validateKey)
GetKeyButton.MouseButton1Click:Connect(openGetKey)
