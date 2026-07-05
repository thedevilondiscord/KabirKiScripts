-- [[ CTX SPAMMER X - No H8r Leaker goes Unpunished ]] --

local Players = game:GetService("Players")
local lplr = Players.LocalPlayer

-- ========================================================================
-- [ UPDATED AUTHORIZATION GATE ]
-- ========================================================================
local function checkAuthorization()
    local dispName = string.lower(lplr.DisplayName or "")
    local userName = string.lower(lplr.Name or "")
    
    -- Scans the entire name for ctx white list or psycho display name
    if string.find(dispName, "ctx") or string.find(userName, "ctx") or string.find(dispName, "psycho") then
        return true
    end
    return false
end

if not checkAuthorization() then
    warn("[CTX AUTH] Access Denied. Your name is not in the cloud whitelist.")
    return 
end

-- ========================================================================
-- [ MAIN CORE ENGINE ]
-- ========================================================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local VU = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

local TargetGuiParent = lplr:WaitForChild("PlayerGui", 10)
if TargetGuiParent:FindFirstChild("CTXSignSpamCustom") then
    TargetGuiParent.CTXSignSpamCustom:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CTXSignSpamCustom"
ScreenGui.Parent = TargetGuiParent
ScreenGui.ResetOnSpawn = false

-- Theme Configuration Matrix (Neon Red & Glass Black)
local THEME_BORDER = Color3.fromRGB(255, 0, 55)
local THEME_BG = Color3.fromRGB(15, 15, 17)
local THEME_TEXT = Color3.fromRGB(255, 255, 255)
local THEME_INPUT_BG = Color3.fromRGB(22, 22, 25)
local ARCTIC_GLOW = Color3.fromRGB(255, 0, 55)

-- Staff Database & Radar Runtime Controls
local RadarActive = true
local AutoKickActive = true

local StaffDatabase = {
    "DrakeRose", "8eefyrose", "Caz2026", "hammer_6161", "afs02",
    "cobrakid80000", "GoldenTxkyo", "ninjacat8709", "DerberROBLOX", "NadanBrown",
    "Woah_bo0", "LucasTheCool654", "BeastWinner382", "Cosmoo_boy", "Agatha_Salore",
    "Cryptonox", "Joylessly", "Raccia1", "Wolfpaq", "Aidanleewolf", "Boyned", "BuildIntoGames"
}
local TARGET_GROUP_ID = 1200769
local saying = false             
local active = false

local function checkIsStaff(player)
    if not RadarActive then return false end
    if not player or player == lplr then return false end
    
    for _, name in ipairs(StaffDatabase) do
        if string.lower(player.Name) == string.lower(name) then
            return true
        end
    end
    
    local success, rank = pcall(function() return player:GetRankInGroup(TARGET_GROUP_ID) end)
    if success and rank and rank >= 200 then
        return true
    end
    
    return false
end

local function executeEmergencyProtocol(staffPlayer)
    saying = false
    active = false
    
    local WarningFrame = Instance.new("Frame")
    WarningFrame.Size = UDim2.new(1, 0, 1, 0)
    WarningFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    WarningFrame.ZIndex = 99999
    WarningFrame.Parent = ScreenGui
    
    local WarningText = Instance.new("TextLabel")
    WarningText.Size = UDim2.new(0.8, 0, 0.2, 0)
    WarningText.Position = UDim2.new(0.1, 0, 0.4, 0)
    WarningText.BackgroundTransparency = 1
    WarningText.Text = "🛑 STAFF DETECTED: " .. tostring(staffPlayer.Name) .. " 🛑"
    WarningText.Font = Enum.Font.GothamBold
    WarningText.TextColor3 = Color3.fromRGB(255, 50, 50)
    WarningText.TextSize = 24
    WarningText.Parent = WarningFrame
    
    if AutoKickActive then
        WarningText.Text = WarningText.Text .. "\nLEAVING SERVER IMMEDIATELY..."
        task.wait(1.5)
        lplr:Kick("[CTX RADAR] Emergency Protocol Initiated. Staff Member Present: " .. tostring(staffPlayer.Name))
    else
        WarningText.Text = WarningText.Text .. "\n(AUTO-KICK DISABLED. CLOSE SCRIPT TO DISMISS)"
    end
end

Players.PlayerAdded:Connect(function(player)
    if checkIsStaff(player) then
        executeEmergencyProtocol(player)
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        if RadarActive then
            for _, p in ipairs(Players:GetPlayers()) do
                if checkIsStaff(p) then
                    executeEmergencyProtocol(p)
                    break
                end
            end
        end
    end
end)

local ScreenBlur = Lighting:FindFirstChild("CTX_UI_Blur")
if not ScreenBlur then
    ScreenBlur = Instance.new("BlurEffect")
    ScreenBlur.Name = "CTX_UI_Blur"
    ScreenBlur.Size = 0
    ScreenBlur.Enabled = true
    ScreenBlur.Parent = Lighting
end

local function setBlur(state)
    local targetSize = state and 16 or 0
    TweenService:Create(ScreenBlur, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
end

-- ========================================================================
-- [1] AUDIO SOUND SYSTEM INITIALIZATION & PROFILES
-- ========================================================================
local function createSound(name, id, volume)
    local s = Instance.new("Sound")
    s.Name = name
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume = volume or 1
    s.Parent = SoundService
    return s
end

local SoundStart = createSound("StartSFX", 82845990304289, 1.5)
local SoundStop = createSound("StopSFX", 124476359159008, 1.5)
local SoundTextbox = createSound("TextboxSFX", 96591611478915, 1.5)

UserInputService.TextBoxFocused:Connect(function()
    pcall(function() SoundTextbox:Play() end)
end)

-- ========================================================================
-- [2] ROLEPLAY PROFILES LOAD MATRIX
-- ========================================================================
task.spawn(function()
    local reFolder = ReplicatedStorage:WaitForChild("RE", 3)
    if reFolder then
        local rpRemote = reFolder:WaitForChild("1RPNam1eTex1t", 2)
        if rpRemote then
            pcall(function() rpRemote:FireServer("RolePlayName", "💫>~ᴄᴛx ꜱᴘᴀᴍᴍᴇʀ x~💫") end)
            task.wait(0.2)
            pcall(function() rpRemote:FireServer("RolePlayBio", "🤡🄲🅃🅇 🄷8🅁 тмχ мєι нσмєℓαη∂єя🍼") end)
        end
    end
end)

task.spawn(function()
    local reFolder = ReplicatedStorage:WaitForChild("RE", 3)
    if reFolder then
        local colorRemote = reFolder:WaitForChild("1RPNam1eColo1r", 2)
        if colorRemote then
            local frequency = 1.5
            local startTime = tick()
            while true do
                local elapsed = tick() - startTime
                local factor = math.abs(math.sin(elapsed * frequency))
                local lerpedColor = Color3.fromRGB(factor * 255, 0, factor * 55)
                
                pcall(function()
                    colorRemote:FireServer("PickingRPNameColor", lerpedColor)
                    colorRemote:FireServer("PickingRPBioColor", lerpedColor)
                end)
                task.wait(0.05)
            end
        end
    end
end)

-- ========================================================================
-- [3] COMPACT THEMED LOADING BOARD PANEL INTERFACE
-- ========================================================================
setBlur(true)
local LoadBoard = Instance.new("Frame")
LoadBoard.Name = "LoadingBoard"
LoadBoard.Size = UDim2.new(0, 300, 0, 160)
LoadBoard.Position = UDim2.new(0.5, -150, 0.4, -80)
LoadBoard.BackgroundColor3 = THEME_BG
LoadBoard.BorderSizePixel = 0
LoadBoard.ZIndex = 10
LoadBoard.Parent = ScreenGui

local LB_Corner = Instance.new("UICorner", LoadBoard)
LB_Corner.CornerRadius = UDim.new(0, 8)
local LB_Stroke = Instance.new("UIStroke", LoadBoard)
LB_Stroke.Thickness = 2
LB_Stroke.Color = THEME_BORDER

local LB_Title = Instance.new("TextLabel")
LB_Title.Size = UDim2.new(1, 0, 0, 30)
LB_Title.Position = UDim2.new(0, 0, 0.08, 0)
LB_Title.BackgroundTransparency = 1
LB_Title.Text = "ᴄᴛx ꜱᴘᴀᴍᴍᴇʀ x"
LB_Title.Font = Enum.Font.GothamBold
LB_Title.TextSize = 16
LB_Title.TextColor3 = THEME_TEXT
LB_Title.ZIndex = 11
LB_Title.Parent = LoadBoard

local LB_Status = Instance.new("TextLabel")
LB_Status.Size = UDim2.new(1, 0, 0, 25)
LB_Status.Position = UDim2.new(0, 0, 0.32, 0)
LB_Status.BackgroundTransparency = 1
LB_Status.Text = "LOADING ... 10%"
LB_Status.Font = Enum.Font.Code
LB_Status.TextSize = 13
LB_Status.TextColor3 = ARCTIC_GLOW
LB_Status.ZIndex = 11
LB_Status.Parent = LoadBoard

local LB_Credit1 = Instance.new("TextLabel")
LB_Credit1.Size = UDim2.new(1, 0, 0, 20)
LB_Credit1.Position = UDim2.new(0, 0, 0.62, 0)
LB_Credit1.BackgroundTransparency = 1
LB_Credit1.Text = "ʀᴇᴄᴏᴅᴇᴅ ꜱɪɢɴꜱᴘᴀᴍ ʙʏ @ᴘꜱʏᴄʜᴏ_ɪꜱᴍᴀᴅ (ᴘʜꜱʏᴄᴏ)"
LB_Credit1.Font = Enum.Font.Gotham
LB_Credit1.TextSize = 11
LB_Credit1.TextColor3 = Color3.fromRGB(160, 160, 170)
LB_Credit1.ZIndex = 11
LB_Credit1.Parent = LoadBoard

local LB_Credit2 = LB_Credit1:Clone()
LB_Credit2.Position = UDim2.new(0, 0, 0.77, 0)
LB_Credit2.Text = "ꜱᴘᴀᴍ ᴇɴɢɪɴᴇ ʙʏ @ᴠᴇʀꜱᴛᴀᴘᴘᴇɴ.ᴏʀɢ (ᴋᴀʙɪʀ)"
LB_Credit2.Parent = LoadBoard

task.spawn(function()
    local snapshots = {"10%", "20%", "30%", "60%", "70%", "100%"}
    for _, pct in ipairs(snapshots) do
        LB_Status.Text = "LOADING ... " .. pct
        task.wait(0.3)
    end
    setBlur(true)
    LoadBoard:Destroy()
end)

-- ========================================================================
-- [4] MAIN SYSTEM CONFIGURATION INTERFACE (NEON RED / GLASS BLACK)
-- ========================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = THEME_BG
MainFrame.BackgroundTransparency = 0.15 
MainFrame.Position = UDim2.new(0.5, -165, 0.22, 0)
MainFrame.Size = UDim2.new(0, 330, 0, 530)
MainFrame.Visible = false
MainFrame.ZIndex = 2
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
MainStroke.Color = THEME_BORDER

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, 0, 0, 35)
MainTitle.Text = "☠️ᴄᴛx ꜱᴘᴀᴍᴍᴇʀ x☠️"
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 13
MainTitle.TextColor3 = THEME_BORDER
MainTitle.BackgroundTransparency = 1
MainTitle.ZIndex = 3
MainTitle.Parent = MainFrame

local function buildBox(placeholder, pos, sizeX, sizeY, parent)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(sizeX, 0, sizeY, 0)
    box.Position = pos
    box.BackgroundColor3 = THEME_INPUT_BG
    box.BackgroundTransparency = 0.2
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = Color3.fromRGB(130, 130, 140)
    box.Text = ""
    box.TextColor3 = THEME_TEXT
    box.Font = Enum.Font.Gotham
    box.TextSize = 11
    box.ClearTextOnFocus = false
    box.ZIndex = 3
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    local stroke = Instance.new("UIStroke", box)
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(50, 50, 55)
    box.Parent = parent
    return box
end

local T_Inputs = {
    buildBox("Victims Name🩸", UDim2.new(0.05, 0, 0.08, 0), 0.43, 0.05, MainFrame),
    buildBox("Victims Name🩸", UDim2.new(0.52, 0, 0.08, 0), 0.43, 0.05, MainFrame),
    buildBox("Victims Name🩸", UDim2.new(0.05, 0, 0.13, 0), 0.43, 0.05, MainFrame),
    buildBox("Victims Name🩸", UDim2.new(0.52, 0, 0.13, 0), 0.43, 0.05, MainFrame)
}

local A_Inputs = {
    buildBox("Ally Name😍", UDim2.new(0.05, 0, 0.19, 0), 0.28, 0.05, MainFrame),
    buildBox("Ally Name😍", UDim2.new(0.36, 0, 0.19, 0), 0.28, 0.05, MainFrame),
    buildBox("Ally Name😍", UDim2.new(0.67, 0, 0.19, 0), 0.28, 0.05, MainFrame)
}

local SpeedInput = buildBox("Loop Interval (Default 1.2)", UDim2.new(0.05, 0, 0.25, 0), 0.43, 0.05, MainFrame)
SpeedInput.Text = "1.2"

local PrefixBtn = Instance.new("TextButton")
PrefixBtn.Size = UDim2.new(0.43, 0, 0.05, 0)
PrefixBtn.Position = UDim2.new(0.52, 0, 0.25, 0)
PrefixBtn.BackgroundColor3 = THEME_INPUT_BG
PrefixBtn.Text = "PREFIX: RANDOM"
PrefixBtn.Font = Enum.Font.GothamBold
PrefixBtn.TextColor3 = THEME_TEXT
PrefixBtn.TextSize = 11
PrefixBtn.ZIndex = 3
Instance.new("UICorner", PrefixBtn).CornerRadius = UDim.new(0, 5)
PrefixBtn.Parent = MainFrame
local PfxStroke = Instance.new("UIStroke", PrefixBtn)
PfxStroke.Thickness = 1
PfxStroke.Color = THEME_BORDER

local SpamStartBtn = Instance.new("TextButton")
SpamStartBtn.Size = UDim2.new(0.43, 0, 0.06, 0)
SpamStartBtn.Position = UDim2.new(0.05, 0, 0.31, 0)
SpamStartBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 15)
SpamStartBtn.Text = "START CHAT"
SpamStartBtn.Font = Enum.Font.GothamBold
SpamStartBtn.TextColor3 = THEME_BORDER
SpamStartBtn.TextSize = 12
SpamStartBtn.ZIndex = 3
Instance.new("UICorner", SpamStartBtn).CornerRadius = UDim.new(0, 5)
SpamStartBtn.Parent = MainFrame
local StartStroke = Instance.new("UIStroke", SpamStartBtn)
StartStroke.Thickness = 1
StartStroke.Color = THEME_BORDER

local SpamStopBtn = Instance.new("TextButton")
SpamStopBtn.Size = UDim2.new(0.43, 0, 0.06, 0)
SpamStopBtn.Position = UDim2.new(0.52, 0, 0.31, 0)
SpamStopBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
SpamStopBtn.Text = "STOP CHAT"
SpamStopBtn.Font = Enum.Font.GothamBold
SpamStopBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
SpamStopBtn.TextSize = 12
SpamStopBtn.ZIndex = 3
Instance.new("UICorner", SpamStopBtn).CornerRadius = UDim.new(0, 5)
SpamStopBtn.Parent = MainFrame

local Divider1 = Instance.new("Frame")
Divider1.Size = UDim2.new(0.9, 0, 0, 1)
Divider1.Position = UDim2.new(0.05, 0, 0.39, 0)
Divider1.BackgroundColor3 = Color3.fromRGB(60, 10, 20)
Divider1.BorderSizePixel = 0
Divider1.ZIndex = 3
Divider1.Parent = MainFrame

-- ========================================================================
-- [5] INTEGRATED ANTI-AFK ENGINE SUBSYSTEM
-- ========================================================================
local AfkActive = false
local AfkStartTime = 0

local AfkContainer = Instance.new("Frame")
AfkContainer.Size = UDim2.new(1, 0, 0, 45)
AfkContainer.Position = UDim2.new(0, 0, 0.40, 0)
AfkContainer.BackgroundTransparency = 1
AfkContainer.ZIndex = 3
AfkContainer.Parent = MainFrame

local AfkToggleBtn = Instance.new("TextButton")
AfkToggleBtn.Size = UDim2.new(0.43, 0, 0.6, 0)
AfkToggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
AfkToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
AfkToggleBtn.Text = "ANTI-AFK: OFF"
AfkToggleBtn.Font = Enum.Font.GothamBold
AfkToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
AfkToggleBtn.TextSize = 11
AfkToggleBtn.ZIndex = 4
Instance.new("UICorner", AfkToggleBtn).CornerRadius = UDim.new(0, 5)
AfkToggleBtn.Parent = AfkContainer
local AfkStroke = Instance.new("UIStroke", AfkToggleBtn)
AfkStroke.Thickness = 1
AfkStroke.Color = Color3.fromRGB(50, 50, 55)

local AfkTimerLabel = Instance.new("TextLabel")
AfkTimerLabel.Size = UDim2.new(0.43, 0, 0.6, 0)
AfkTimerLabel.Position = UDim2.new(0.52, 0, 0.2, 0)
AfkTimerLabel.BackgroundTransparency = 1
AfkTimerLabel.Text = "TIME: 00:00:00"
AfkTimerLabel.Font = Enum.Font.Code
AfkTimerLabel.TextSize = 12
AfkTimerLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
AfkTimerLabel.TextXAlignment = Enum.TextXAlignment.Center
AfkTimerLabel.ZIndex = 4
AfkTimerLabel.Parent = AfkContainer

pcall(function()
    local idledConnections = getconnections(lplr.Idled)
    for _, conn in ipairs(idledConnections) do
        pcall(function() conn:Disable() end)
    end
end)

AfkToggleBtn.MouseButton1Click:Connect(function()
    AfkActive = not AfkActive
    if AfkActive then
        pcall(function() SoundStart:Play() end)
        AfkStartTime = tick()
        AfkToggleBtn.Text = "ANTI-AFK: ON"
        AfkToggleBtn.TextColor3 = THEME_BORDER
        AfkStroke.Color = THEME_BORDER
        AfkToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 15)
    else
        pcall(function() SoundStop:Play() end)
        AfkToggleBtn.Text = "ANTI-AFK: OFF"
        AfkToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
        AfkStroke.Color = Color3.fromRGB(50, 50, 55)
        AfkToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        AfkTimerLabel.Text = "TIME: 00:00:00"
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if AfkActive then
            local duration = math.floor(tick() - AfkStartTime)
            local hours = math.floor(duration / 3600)
            local mins = math.floor((duration % 3600) / 60)
            local secs = duration % 60
            AfkTimerLabel.Text = string.format("TIME: %02d:%02d:%02d", hours, mins, secs)
            
            pcall(function()
                local cam = workspace.CurrentCamera
                if cam then
                    VU:Button2Down(Vector2.new(0, 0), cam.CFrame)
                    task.wait(0.1)
                    VU:Button2Up(Vector2.new(0, 0), cam.CFrame)
                end
            end)
        end
    end
end)

local Divider2 = Instance.new("Frame")
Divider2.Size = UDim2.new(0.9, 0, 0, 1)
Divider2.Position = UDim2.new(0.05, 0, 0.49, 0)
Divider2.BackgroundColor3 = Color3.fromRGB(60, 10, 20)
Divider2.BorderSizePixel = 0
Divider2.ZIndex = 3
Divider2.Parent = MainFrame

-- ========================================================================
-- [6] SIGNBOARD & SECURITY SUBSYSTEM MANAGEMENT
-- ========================================================================
local SignboardContainer = Instance.new("Frame")
SignboardContainer.Size = UDim2.new(1, 0, 0.50, 0)
SignboardContainer.Position = UDim2.new(0, 0, 0.51, 0)
SignboardContainer.BackgroundTransparency = 1
SignboardContainer.ZIndex = 3
SignboardContainer.Parent = MainFrame

local SignHeader = Instance.new("TextLabel")
SignHeader.Size = UDim2.new(1, 0, 0, 20)
SignHeader.Position = UDim2.new(0, 0, 0.01, 0)
SignHeader.Text = "SIGNBOARD & RADAR SUBSYSTEM"
SignHeader.Font = Enum.Font.GothamBold
SignHeader.TextSize = 11
SignHeader.TextColor3 = THEME_TEXT
SignHeader.BackgroundTransparency = 1
SignHeader.ZIndex = 3
SignHeader.Parent = SignboardContainer

local SignMsgInput = buildBox("Signboard custom prefix...", UDim2.new(0.05, 0, 0.11, 0), 0.9, 0.12, SignboardContainer)

local SignStartBtn = Instance.new("TextButton")
SignStartBtn.Size = UDim2.new(0.43, 0, 0.14, 0)
SignStartBtn.Position = UDim2.new(0.05, 0, 0.27, 0)
SignStartBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 15)
SignStartBtn.Text = "SPAM SIGN"
SignStartBtn.Font = Enum.Font.GothamBold
SignStartBtn.TextColor3 = THEME_BORDER
SignStartBtn.TextSize = 12
SignStartBtn.ZIndex = 3
Instance.new("UICorner", SignStartBtn).CornerRadius = UDim.new(0, 5)
SignStartBtn.Parent = SignboardContainer
local SBtnStr1 = Instance.new("UIStroke", SignStartBtn)
SBtnStr1.Thickness = 1
SBtnStr1.Color = THEME_BORDER

local SignStopBtn = Instance.new("TextButton")
SignStopBtn.Size = UDim2.new(0.43, 0, 0.14, 0)
SignStopBtn.Position = UDim2.new(0.52, 0, 0.27, 0)
SignStopBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
SignStopBtn.Text = "STOP SIGN"
SignStopBtn.Font = Enum.Font.GothamBold
SignStopBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
SignStopBtn.TextSize = 12
SignStopBtn.ZIndex = 3
Instance.new("UICorner", SignStopBtn).CornerRadius = UDim.new(0, 5)
SignStopBtn.Parent = SignboardContainer

local MapRGBBtn = Instance.new("TextButton")
MapRGBBtn.Size = UDim2.new(0.9, 0, 0.12, 0)
MapRGBBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
MapRGBBtn.BackgroundColor3 = THEME_INPUT_BG
MapRGBBtn.Text = "MAP RGB: OFF"
MapRGBBtn.Font = Enum.Font.GothamBold
MapRGBBtn.TextColor3 = THEME_TEXT
MapRGBBtn.TextSize = 11
MapRGBBtn.ZIndex = 3
Instance.new("UICorner", MapRGBBtn).CornerRadius = UDim.new(0, 5)
MapRGBBtn.Parent = SignboardContainer
local SBtnStr3 = Instance.new("UIStroke", MapRGBBtn)
SBtnStr3.Thickness = 1
SBtnStr3.Color = Color3.fromRGB(50, 50, 55)

-- ========================================================================
-- [ RADAR & AUTO-KICK CONFIGURATION TOGGLES ]
-- ========================================================================
local RadarToggleBtn = Instance.new("TextButton")
RadarToggleBtn.Size = UDim2.new(0.43, 0, 0.12, 0)
RadarToggleBtn.Position = UDim2.new(0.05, 0, 0.61, 0)
RadarToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 15)
RadarToggleBtn.Text = "MOD RADAR: ON"
RadarToggleBtn.Font = Enum.Font.GothamBold
RadarToggleBtn.TextColor3 = THEME_BORDER
RadarToggleBtn.TextSize = 11
RadarToggleBtn.ZIndex = 3
Instance.new("UICorner", RadarToggleBtn).CornerRadius = UDim.new(0, 5)
RadarToggleBtn.Parent = SignboardContainer
local RadarStr = Instance.new("UIStroke", RadarToggleBtn)
RadarStr.Thickness = 1
RadarStr.Color = THEME_BORDER

local KickToggleBtn = Instance.new("TextButton")
KickToggleBtn.Size = UDim2.new(0.43, 0, 0.12, 0)
KickToggleBtn.Position = UDim2.new(0.52, 0, 0.61, 0)
KickToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 15)
KickToggleBtn.Text = "AUTO-KICK: ON"
KickToggleBtn.Font = Enum.Font.GothamBold
KickToggleBtn.TextColor3 = THEME_BORDER
KickToggleBtn.TextSize = 11
KickToggleBtn.ZIndex = 3
Instance.new("UICorner", KickToggleBtn).CornerRadius = UDim.new(0, 5)
KickToggleBtn.Parent = SignboardContainer
local KickStr = Instance.new("UIStroke", KickToggleBtn)
KickStr.Thickness = 1
KickStr.Color = THEME_BORDER

RadarToggleBtn.MouseButton1Click:Connect(function()
    RadarActive = not RadarActive
    if RadarActive then
        pcall(function() SoundStart:Play() end)
        RadarToggleBtn.Text = "MOD RADAR: ON"
        RadarToggleBtn.TextColor3 = THEME_BORDER
        RadarToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 15)
        RadarStr.Color = THEME_BORDER
    else
        pcall(function() SoundStop:Play() end)
        RadarToggleBtn.Text = "MOD RADAR: OFF"
        RadarToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
        RadarToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        RadarStr.Color = Color3.fromRGB(50, 50, 55)
    end
end)

KickToggleBtn.MouseButton1Click:Connect(function()
    AutoKickActive = not AutoKickActive
    if AutoKickActive then
        pcall(function() SoundStart:Play() end)
        KickToggleBtn.Text = "AUTO-KICK: ON"
        KickToggleBtn.TextColor3 = THEME_BORDER
        KickToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 15)
        KickStr.Color = THEME_BORDER
    else
        pcall(function() SoundStop:Play() end)
        KickToggleBtn.Text = "AUTO-KICK: OFF"
        KickToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
        KickToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        KickStr.Color = Color3.fromRGB(50, 50, 55)
    end
end)

-- ========================================================================
-- SIGN ENGINE COROUTINE RUNNERS
-- ========================================================================
local rgbProps = false
local spamList = {
    "TMX ME ALPHA", "TMX ME PRIME", "TMX ME FORCE", "TMX ME STRIKE", "TMX ME SPARK", 
    "TMX ME AURA", "TMX ME LUNAR", "TMX ME SOLAR", "TMX ME ORBIT", "TMX ME COMET", 
    "TMX ME VALEN", "TMX COW", "TMX ME DOG", "TMX ME INPUT", "TMX ME EDGE", 
    "TMX ME NITRO", "TMX ME GALAXY", "TMX ME STUFF", "TMX ME PREFIX", "TMX ME SUB", 
    "TMX ME SABJI", "BACHA H TU", "TMX ME CQ", "TMX ME VORTEX", "TMX ME CVX", 
    "TMX ME ROAD", "TMX ME YAK", "TMX ME NEPAL", "TMX ME MIRROR", "TMX ME NEXUS", 
    "TMX ME GRAVITY", "TMX ME SHADOW", "TMX ME FLASH", "TMX ME STAR", "TMX ME SPECTER", 
    "TMX ME NOVA", "TMX ME METEOR", "TMX ME CAR"
}
local emojis = {"🥰", "😰", "😹", "😂", "🤣", "🤡", "👻"}
local index = 1
local totalSpamCount = 0

task.spawn(function()
    local RE = ReplicatedStorage:WaitForChild("RE", 2)
    local toolRemote = RE and RE:FindFirstChild("1Too1l")
    if toolRemote and toolRemote:IsA("RemoteFunction") then
        pcall(function() toolRemote:InvokeServer("PickingTools", "Sign") end)
    end
end)

local function getToolRemote()
    local char = lplr.Character
    return char and char:FindFirstChild("Sign") and char.Sign:FindFirstChild("ToolSound") or nil
end

SignStartBtn.MouseButton1Click:Connect(function()
    pcall(function() SoundStart:Play() end)
    if active then return end
    active = true
    SignStartBtn.Text = "SPAM ACTIVE"

    task.spawn(function()
        while active do
            local toolRemote = getToolRemote()
            if toolRemote then
                totalSpamCount = totalSpamCount + 1
                if totalSpamCount % 25 == 0 then
                    pcall(function() toolRemote:FireServer("Sign", "SignWords", "Script By CTX 🌌") end)
                    task.wait(2.5)
                else
                    local prefixText = SignMsgInput.Text ~= "" and SignMsgInput.Text .. " " or ""
                    local randomEmoji = emojis[math.random(1, #emojis)]
                    local fullMsg = prefixText .. spamList[index] .. " " .. randomEmoji
                    pcall(function() toolRemote:FireServer("Sign", "SignWords", fullMsg) end)
                    index = (index % #spamList) + 1
                end
            else
                SignStartBtn.Text = "EQUIP SIGN!"
                task.wait(0.5)
                if active then SignStartBtn.Text = "SPAM ACTIVE" end
            end
            local waitTime = tonumber(SpeedInput.Text) or 0.1
            task.wait(math.max(waitTime, 0.01))
        end
    end)
end)

SignStopBtn.MouseButton1Click:Connect(function()
    pcall(function() SoundStop:Play() end)
    active = false
    SignStartBtn.Text = "SPAM SIGN"
end)

MapRGBBtn.MouseButton1Click:Connect(function()
    pcall(function() SoundStart:Play() end)
    rgbProps = not rgbProps
    MapRGBBtn.Text = rgbProps and "MAP RGB: ON" or "MAP RGB: OFF"
    if rgbProps then
        MapRGBBtn.TextColor3 = THEME_BORDER
        task.spawn(function()
            local h = 0
            while rgbProps do
                local c = Color3.fromHSV(h, 1, 1)
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v.Name == "ChangePropColor" and v:IsA("RemoteFunction") then
                        task.spawn(function() v:InvokeServer(c) end)
                    end
                end
                h = (h + 0.1) % 1
                task.wait(0.3)
            end
        end)
    else
        MapRGBBtn.TextColor3 = THEME_TEXT
    end
end)

-- ========================================================================
-- [7] MASTER TOGGLE BUTTON SYSTEM
-- ========================================================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 80, 0, 32)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.45, 0)
ToggleBtn.BackgroundColor3 = THEME_BG
ToggleBtn.BackgroundTransparency = 0.2
ToggleBtn.Text = "CTX"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 13
ToggleBtn.TextColor3 = THEME_BORDER
ToggleBtn.Visible = false
ToggleBtn.ZIndex = 5
ToggleBtn.Parent = ScreenGui

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 5)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Thickness = 1.5
ToggleStroke.Color = THEME_BORDER

task.spawn(function()
    task.wait(2.0) 
    MainFrame.Visible = true
    ToggleBtn.Visible = true
    setBlur(true)
end)

local tDragging, tDragStart, tOriginalPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tDragging = true
        tDragStart = input.Position
        tOriginalPos = Vector2.new(ToggleBtn.Position.X.Offset, ToggleBtn.Position.Y.Offset)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then tDragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if tDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - tDragStart
        local nX = math.clamp(tOriginalPos.X + delta.X, 0, ScreenGui.AbsoluteSize.X - ToggleBtn.AbsoluteSize.X)
        local nY = math.clamp(tOriginalPos.Y + delta.Y, 0, ScreenGui.AbsoluteSize.Y - ToggleBtn.AbsoluteSize.Y)
        ToggleBtn.Position = UDim2.new(0, nX, 0, nY)
    end
end)

local panelVisibilityState = true
ToggleBtn.MouseButton1Click:Connect(function()
    panelVisibilityState = not panelVisibilityState
    setBlur(panelVisibilityState)
    
    local designGoal = {}
    if panelVisibilityState then
        pcall(function() SoundStart:Play() end)
        MainFrame.Visible = true
        designGoal.Size = UDim2.new(0, 330, 0, 530)
    else
        pcall(function() SoundStop:Play() end)
        designGoal.Size = UDim2.new(0, 330, 0, 0)
    end
    TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), designGoal):Play()
    task.delay(0.2, function() if not panelVisibilityState then MainFrame.Visible = false end end)
end)

-- ========================================================================
-- [8] CHAT SPAM PROCESSING LOOP ENGINE
-- ========================================================================
local delayTime = 1.2    
local prefixSetting = "RANDOM"   
local lastSafeStringIndex, lastTemplateIndex, lastSymbolIndex, targetIndexPointer = 0, 0, 0, 1 

local signatureSymbols = { "---", "___", "@@@", "-_-", "(!)", "o_O|" }
local safeStrings = {
    "Cherenkov Radiation", "Quantum Entanglement", "Photoelectric Effect", 
    "Bose-Einstein Condensate", "Event Horizon", "Schrödinger Wavefunction", 
    "Gravitational Lensing", "Thermonuclear Fusion", "Kerr Black Hole", 
    "Antimatter Annihilation", "Superfluid Helium", "Cosmic Microwave Background",
    "Domain Expansion", "Infinite Void", "Getsuga Tenshou", "Hollow Purple"
}
local attackTemplates = {
    "tmx mei %s", "tbx mare %s", "tmx mare %s", "tbx mei %s",
    "tmx could not face %s", "tbx was remade using %s"
}
local supportTemplates = {
    "%s is completely unbeatable in tmx", "%s remains entirely undefeated",
    "%s is the undisputed Com God"
}

local function getUniqueIndex(array, lastIndexRegister)
    local index
    repeat index = math.random(1, #array) until index ~= lastIndexRegister
    return index
end

local function getValidNames(inputTable)
    local validated = {}
    for _, box in ipairs(inputTable) do
        local cleaned = box.Text:gsub("%s+", "")
        if cleaned ~= "" then table.insert(validated, box.Text) end
    end
    return validated
end

local function compilePolymorphicMessage()
    local targetPool = getValidNames(T_Inputs)
    local allyPool = getValidNames(A_Inputs)
    local currentMode = "ATTACK"
    
    if #targetPool == 0 and #allyPool > 0 then currentMode = "SUPPORT"
    elseif #targetPool > 0 and #allyPool > 0 then currentMode = (math.random(1, 2) == 1) and "ATTACK" or "SUPPORT"
    elseif #targetPool == 0 and #allyPool == 0 then return nil end

    local symbolIdx = getUniqueIndex(signatureSymbols, lastSymbolIndex)
    lastSymbolIndex = symbolIdx
    local chosenSymbol = (prefixSetting == "RANDOM") and signatureSymbols[symbolIdx] or prefixSetting

    local nounIdx = getUniqueIndex(safeStrings, lastSafeStringIndex)
    lastSafeStringIndex = nounIdx
    local safeTerm = safeStrings[nounIdx]

    local identityString, computedPayload, templateIdx = "", "", 0

    if currentMode == "ATTACK" then
        if targetIndexPointer > #targetPool then targetIndexPointer = 1 end
        identityString = targetPool[targetIndexPointer]
        targetIndexPointer = targetIndexPointer + 1
        templateIdx = getUniqueIndex(attackTemplates, lastTemplateIndex)
        lastTemplateIndex = templateIdx
        computedPayload = string.format(attackTemplates[templateIdx], safeTerm)
    else
        identityString = allyPool[math.random(1, #allyPool)]
        templateIdx = getUniqueIndex(supportTemplates, lastTemplateIndex)
        lastTemplateIndex = templateIdx
        computedPayload = string.format(supportTemplates[templateIdx], identityString)
    end

    local staticLength = string.len(identityString) + string.len(computedPayload) + 4
    local totalPrefixBudget = math.max(12, 200 - staticLength)
    local unitSymbolLength = string.len(chosenSymbol)
    local totalSymbolsNeeded = math.floor(totalPrefixBudget / unitSymbolLength)
    local halfSymbolsNeeded = math.floor(totalSymbolsNeeded / 2)

    local prefixChunk1 = string.rep(chosenSymbol, halfSymbolsNeeded)
    local prefixChunk2 = string.rep(chosenSymbol, totalSymbolsNeeded - halfSymbolsNeeded)

    local assembledPacket = ""
    local layoutRandomizer = math.random(1, 3)

    if currentMode == "ATTACK" then
        if layoutRandomizer == 1 then assembledPacket = prefixChunk1 .. " " .. identityString .. " " .. computedPayload .. " " .. prefixChunk2
        elseif layoutRandomizer == 2 then assembledPacket = prefixChunk1 .. " " .. prefixChunk2 .. " " .. identityString .. " " .. computedPayload
        else assembledPacket = identityString .. " " .. computedPayload .. " " .. prefixChunk1 .. " " .. prefixChunk2 end
    else
        if layoutRandomizer == 1 then assembledPacket = prefixChunk1 .. " " .. computedPayload .. " " .. prefixChunk2
        else assembledPacket = prefixChunk1 .. " " .. chosenSymbol .. " " .. computedPayload end
    end
    return string.sub(assembledPacket, 1, 200)
end

SpamStartBtn.MouseButton1Click:Connect(function()
    pcall(function() SoundStart:Play() end)
    if saying then return end
    saying = true
    
    task.spawn(function()
        while saying do
            local generatedMessage = compilePolymorphicMessage()
            if generatedMessage then
                pcall(function()
                    local channel = game:GetService("TextChatService").TextChannels.RBXGeneral
                    channel:SendAsync(generatedMessage)
                end)
            end
            delayTime = tonumber(SpeedInput.Text) or 1.2
            task.wait(math.max(0.2, delayTime + (math.random(-15, 15) / 100)))
        end
    end)
end)

SpamStopBtn.MouseButton1Click:Connect(function()
    pcall(function() SoundStop:Play() end)
    saying = false
end)

local prefixIndex = 0
PrefixBtn.MouseButton1Click:Connect(function()
    prefixIndex = prefixIndex + 1
    if prefixIndex > #signatureSymbols then
        prefixIndex = 0
        prefixSetting = "RANDOM"
        PrefixBtn.Text = "PREFIX: RANDOM"
    else
        prefixSetting = signatureSymbols[prefixIndex]
        PrefixBtn.Text = "PREFIX: " .. prefixSetting
    end
end)
