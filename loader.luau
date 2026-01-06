-- ================= CONFIG =================
Config = {
    api = "e272e094-2f1e-45ff-a636-55b95ee83ffa",
    service = "RedsoulHub",
    provider = "Checkpoint1"
}

local function main()
    local success, err = pcall(function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/Greensoul8410/mainone/main/main.lua"
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
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

-- ================= UI CONFIG =================
local KeySystemData = {
    Name = "RedsoulHub",
    DiscordInvite = "https://discord.gg/tafEvVkssv",
    FileName = "redexecutor/key.txt",
    Colors = {
        Background = Color3.fromRGB(30, 30, 35),
        Title = Color3.fromRGB(220, 50, 50),
        InputField = Color3.fromRGB(25, 25, 30),
        Border = Color3.fromRGB(180, 0, 0),
        Button = Color3.fromRGB(25, 25, 30),
        ButtonHover = Color3.fromRGB(35, 35, 40),
        Error = Color3.fromRGB(220, 50, 50),
        Success = Color3.fromRGB(80, 200, 80),
        Discord = Color3.fromRGB(88, 101, 242)
    }
}

-- ================= HELPERS =================
local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then obj[k] = v end
    end
    if props.Parent then obj.Parent = props.Parent end
    return obj
end

local function Tween(obj, t, props)
    TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- ================= BLUR =================
local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting
Tween(Blur, 0.5, {Size = 16})

-- ================= GUI =================
local ScreenGui = Create("ScreenGui", {
    Name = "RedsoulKeySystem",
    Parent = CoreGui,
    ResetOnSpawn = false,
    DisplayOrder = 999
})

local MainFrame = Create("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 350, 0, 250),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = KeySystemData.Colors.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
})
Create("UICorner", {Parent = MainFrame, CornerRadius = UDim.new(0, 10)})

-- ================= TITLE =================
local TitleBar = Create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundTransparency = 1
})

local Title = Create("TextLabel", {
    Parent = TitleBar,
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = KeySystemData.Name .. " Key System",
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextColor3 = KeySystemData.Colors.Title
})

task.spawn(function()
    while Title.Parent do
        Tween(Title, 1.5, {TextTransparency = 0.3})
        task.wait(1.5)
        Tween(Title, 1.5, {TextTransparency = 0})
        task.wait(1.5)
    end
end)

-- ================= INPUT =================
local KeyInput = Create("TextBox", {
    Parent = MainFrame,
    Size = UDim2.new(0, 280, 0, 36),
    Position = UDim2.new(0.5, 0, 0.32, 0),
    AnchorPoint = Vector2.new(0.5, 0),
    PlaceholderText = "Enter your key...",
    Text = "",
    Font = Enum.Font.Gotham,
    TextSize = 14,
    BackgroundColor3 = KeySystemData.Colors.InputField,
    TextColor3 = Color3.fromRGB(220,220,220),
    ClearTextOnFocus = false
})
Create("UICorner", {Parent = KeyInput, CornerRadius = UDim.new(0, 6)})
local Stroke = Create("UIStroke", {Parent = KeyInput, Color = KeySystemData.Colors.Border, Transparency = 0.8})

-- ================= BUTTONS =================
local function MakeButton(text, x)
    local b = Create("TextButton", {
        Parent = MainFrame,
        Size = UDim2.new(0, 110, 0, 32),
        Position = UDim2.new(x, 0, 0.56, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        BackgroundColor3 = KeySystemData.Colors.Button,
        TextColor3 = KeySystemData.Colors.Title,
        AutoButtonColor = false
    })
    Create("UICorner", {Parent = b, CornerRadius = UDim.new(0, 6)})
    return b
end

local SubmitButton = MakeButton("Verify Key", 0.3)
local GetKeyButton = MakeButton("Get Key", 0.7)

local DiscordButton = Create("TextButton", {
    Parent = MainFrame,
    Size = UDim2.new(0, 220, 0, 32),
    Position = UDim2.new(0.5, 0, 0.78, 0),
    AnchorPoint = Vector2.new(0.5, 0),
    Text = "Join Discord for Tutorial",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BackgroundColor3 = KeySystemData.Colors.Discord,
    TextColor3 = Color3.new(1,1,1),
    AutoButtonColor = false
})
Create("UICorner", {Parent = DiscordButton, CornerRadius = UDim.new(0, 6)})

-- ================= STATUS =================
local Status = Create("TextLabel", {
    Parent = MainFrame,
    Size = UDim2.new(1, -40, 0, 20),
    Position = UDim2.new(0.5, 0, 0.9, 0),
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextTransparency = 1
})

local function ShowStatus(txt, col)
    Status.Text = txt
    Status.TextColor3 = col
    Tween(Status, 0.25, {TextTransparency = 0})
    task.delay(3, function()
        Tween(Status, 0.4, {TextTransparency = 1})
    end)
end

-- ================= LOADER =================
local Loader = Create("ImageLabel", {
    Parent = MainFrame,
    Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(0.5, 0, 0.44, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://7733658504",
    ImageTransparency = 1
})

local spinning = false
local function SetLoading(state)
    spinning = state
    Tween(Loader, 0.2, {ImageTransparency = state and 0 or 1})
    task.spawn(function()
        while spinning do
            Loader.Rotation += 6
            task.wait()
        end
    end)
end

-- ================= SAVE / LOAD KEY =================
local function SaveKey(key)
    if writefile then writefile(KeySystemData.FileName, key) end
end

local function LoadKey()
    if readfile and isfile and isfile(KeySystemData.FileName) then
        return readfile(KeySystemData.FileName)
    end
end

local saved = LoadKey()
if saved then KeyInput.Text = saved end

-- ================= EFFECTS =================
local function ButtonAnim(btn)
    local s = btn.Size
    Tween(btn, 0.08, {Size = s - UDim2.fromOffset(4,4)})
    task.wait(0.08)
    Tween(btn, 0.12, {Size = s})
end

local function Shake()
    local pos = MainFrame.Position
    for i = 1,6 do
        MainFrame.Position = pos + UDim2.fromOffset(i%2==0 and -6 or 6, 0)
        task.wait(0.03)
    end
    MainFrame.Position = pos
end

-- ================= JUNKIE =================
local function openGetKey()
    local sdk = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local link = sdk.getLink(Config.api, Config.provider, Config.service)
    if link and setclipboard then
        setclipboard(link)
        ShowStatus("Verification link copied!", KeySystemData.Colors.Success)
    end
end

local function validateKey()
    local key = KeyInput.Text:gsub("%s+","")
    if key == "" then return ShowStatus("Enter a key.", KeySystemData.Colors.Error) end

    SetLoading(true)
    ShowStatus("Validating key...", Color3.fromRGB(255,165,0))

    local sdk = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local valid = sdk.verifyKey(Config.api, key, Config.service)

    SetLoading(false)

    if valid then
        SaveKey(key)
        ShowStatus("Key valid! Loading...", KeySystemData.Colors.Success)
        task.wait(0.6)
        Blur:Destroy()
        ScreenGui:Destroy()
        main()
    else
        Shake()
        ShowStatus("Invalid key.", KeySystemData.Colors.Error)
    end
end

-- ================= EVENTS =================
SubmitButton.MouseButton1Click:Connect(function()
    ButtonAnim(SubmitButton)
    validateKey()
end)

GetKeyButton.MouseButton1Click:Connect(function()
    ButtonAnim(GetKeyButton)
    openGetKey()
end)

DiscordButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/" .. KeySystemData.DiscordInvite)
        ShowStatus("Discord invite copied!", KeySystemData.Colors.Success)
    end
end)
