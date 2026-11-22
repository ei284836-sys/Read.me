-- =========================================================
-- JDEV BLOX🤫🌙 — MOG OR DIE SCRIPT — Painel v4.0
-- Layout replicado da referência. Tema roxo neon.
-- Executar como LocalScript (executor ou StarterPlayerScripts)
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- =========================================================
-- HELPERS
-- =========================================================
local function Create(ClassName, Props)
    local o = Instance.new(ClassName)
    for k, v in pairs(Props) do o[k] = v end
    return o
end

local function Tween(obj, time, props, style, dir)
    local t = TweenService:Create(obj, TweenInfo.new(
        time or 0.18,
        style or Enum.EasingStyle.Quad,
        dir or Enum.EasingDirection.Out
    ), props)
    t:Play()
    return t
end

local GuiParent
do
    local probe = Instance.new("ScreenGui")
    local ok = pcall(function() probe.Parent = CoreGui end)
    GuiParent = ok and CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    probe:Destroy()
end

for _, old in ipairs(GuiParent:GetChildren()) do
    if old.Name == "JDEV_MOG_UI" then old:Destroy() end
end

-- =========================================================
-- TEMA
-- =========================================================
local T = {
    Bg        = Color3.fromRGB(10, 8, 16),
    Panel     = Color3.fromRGB(14, 11, 22),
    Header    = Color3.fromRGB(17, 13, 27),
    Sidebar   = Color3.fromRGB(12, 9, 19),
    Card      = Color3.fromRGB(20, 16, 30),
    CardLine  = Color3.fromRGB(44, 34, 66),
    Accent    = Color3.fromRGB(168, 85, 247),
    AccentDim = Color3.fromRGB(96, 45, 158),
    Off       = Color3.fromRGB(46, 40, 62),
    Text      = Color3.fromRGB(236, 233, 246),
    TextDim   = Color3.fromRGB(150, 144, 172),
    Success   = Color3.fromRGB(34, 197, 94),
    Danger    = Color3.fromRGB(239, 68, 68),
}

local W, H = 760, 470
local SIDEBAR = 172
local HEADER = 56

-- =========================================================
-- ESTADO
-- =========================================================
local State = {}
local Connections = {}
local Unloaded = false

local function Track(conn) table.insert(Connections, conn) return conn end

local function Notify(msg, color)
    if Unloaded then return end
    local toast = Create("TextLabel", {
        Size = UDim2.new(0, 280, 0, 38),
        Position = UDim2.new(0.5, -140, 1, -56),
        BackgroundColor3 = T.Card,
        Text = msg,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = color or T.Success,
        TextWrapped = true,
        BorderSizePixel = 0,
        ZIndex = 80,
        Parent = ScreenGui,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = toast })
    Create("UIStroke", { Color = color or T.Success, Thickness = 1, Parent = toast })
    Tween(toast, 0.25, { Position = UDim2.new(0.5, -140, 1, -70) })
    task.delay(2.4, function()
        Tween(toast, 0.25, { TextTransparency = 1, BackgroundTransparency = 1 })
        task.delay(0.3, function() toast:Destroy() end)
    end)
end

-- =========================================================
-- ROOT
-- =========================================================
local ScreenGui = Create("ScreenGui", {
    Name = "JDEV_MOG_UI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 9999,
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
    Parent = GuiParent,
})

local Panel = Create("Frame", {
    Name = "Panel",
    Size = UDim2.new(0, W, 0, H),
    Position = UDim2.new(0, 40, 0, 40),
    BackgroundColor3 = T.Panel,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Active = true,
    Parent = ScreenGui,
})

Create("UICorner", { CornerRadius = UDim.new(0, 14), Parent = Panel })
Create("UIStroke", { Color = T.Accent, Thickness = 1.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = Panel })
Create("UIScale", { Scale = 1, Parent = Panel })

-- =========================================================
-- HEADER
-- =========================================================
local Header = Create("Frame", {
    Size = UDim2.new(1, 0, 0, HEADER),
    BackgroundColor3 = T.Header,
    BorderSizePixel = 0,
    Active = true,
    Parent = Panel,
})

Create("UICorner", { CornerRadius = UDim.new(0, 14), Parent = Header })
Create("Frame", {
    Size = UDim2.new(1, 0, 0, 20),
    Position = UDim2.new(0, 0, 1, -20),
    BackgroundColor3 = T.Header,
    BorderSizePixel = 0,
    Parent = Header,
})

local IconBox = Create("Frame", {
    Size = UDim2.new(0, 34, 0, 34),
    Position = UDim2.new(0, 16, 0.5, -17),
    BackgroundColor3 = Color3.fromRGB(30, 18, 46),
    BorderSizePixel = 0,
    Parent = Header,
})
Create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = IconBox })
Create("UIStroke", { Color = T.Accent, Thickness = 1.5, Parent = IconBox })
Create("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "🐱",
    TextSize = 19,
    Parent = IconBox,
})

Create("TextLabel", {
    Size = UDim2.new(1, -220, 0, 22),
    Position = UDim2.new(0, 62, 0, 17),
    BackgroundTransparency = 1,
    Text = "MOG OR DIE SCRIPT",
    Font = Enum.Font.GothamBlack,
    TextSize = 17,
    TextColor3 = T.Accent,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header,
})

local CloseBtn = Create("TextButton", {
    Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(1, -38, 0.5, -13),
    BackgroundTransparency = 1,
    AutoButtonColor = false,
    Text = "✕",
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextColor3 = T.TextDim,
    Parent = Header,
})

local MinBtn = Create("TextButton", {
    Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(1, -68, 0.5, -13),
    BackgroundTransparency = 1,
    AutoButtonColor = false,
    Text = "—",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = T.TextDim,
    Parent = Header,
})

-- =========================================================
-- SIDEBAR
-- =========================================================
local Sidebar = Create("Frame", {
    Size = UDim2.new(0, SIDEBAR, 1, -HEADER - 26),
    Position = UDim2.new(0, 0, 0, HEADER),
    BackgroundColor3 = T.Sidebar,
    BorderSizePixel = 0,
    Parent = Panel,
})

Create("Frame", {
    Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(1, -1, 0, 0),
    BackgroundColor3 = T.CardLine,
    BorderSizePixel = 0,
    Parent = Sidebar,
})

local NavList = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Parent = Sidebar,
})
Create("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = NavList })
Create("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = NavList })

-- =========================================================
-- CONTEÚDO
-- =========================================================
local Content = Create("Frame", {
    Size = UDim2.new(1, -SIDEBAR, 1, -HEADER - 26),
    Position = UDim2.new(0, SIDEBAR, 0, HEADER),
    BackgroundColor3 = T.Bg,
    BorderSizePixel = 0,
    Parent = Panel,
})

Create("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 6), PaddingBottom = UDim.new(0, 10), Parent = Content })

-- =========================================================
-- FOOTER
-- =========================================================
Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 26),
    Position = UDim2.new(0, 0, 1, -26),
    BackgroundColor3 = T.Header,
    BorderSizePixel = 0,
    Text = "  JDEV BLOX v4.0  •  MOG OR DIE  •  ULTIMATE HUB",
    Font = Enum.Font.GothamSemibold,
    TextSize = 10,
    TextColor3 = T.TextDim,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Panel,
})

-- =========================================================
-- COMPONENTES
-- =========================================================
local function CreateToggle(card, item, order)
    local row = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        LayoutOrder = order,
        Parent = card,
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 20, 0, 32),
        BackgroundTransparency = 1,
        Text = item.Icon or "•",
        TextSize = 13,
        TextColor3 = T.Accent,
        Parent = row,
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -70, 0, 32),
        Position = UDim2.new(0, 24, 0, 0),
        BackgroundTransparency = 1,
        Text = item.Label,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = T.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = row,
    })

    local sw = Create("TextButton", {
        Size = UDim2.new(0, 42, 0, 22),
        Position = UDim2.new(1, -42, 0.5, -11),
        BackgroundColor3 = T.Off,
        Text = "",
        AutoButtonColor = false,
        Parent = row,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = sw })

    local knob = Create("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 3, 0.5, -8),
        BackgroundColor3 = T.Text,
        BorderSizePixel = 0,
        Parent = sw,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })

    local function Apply(on, animate)
        State[item.Key] = on
        if animate then
            Tween(knob, 0.16, { Position = on and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8) })
            Tween(sw, 0.16, { BackgroundColor3 = on and T.Accent or T.Off })
        else
            knob.Position = on and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
            sw.BackgroundColor3 = on and T.Accent or T.Off
        end
        if item.OnChange then
            local ok, err = pcall(item.OnChange, on)
            if not ok then warn("[JDEV] " .. tostring(err)) end
        end
    end

    Apply(item.Default == true, false)

    Track(sw.MouseButton1Click:Connect(function()
        Apply(not State[item.Key], true)
    end))

    return row
end

local function CreateSlider(card, item, order)
    local row = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundTransparency = 1,
        LayoutOrder = order,
        Parent = card,
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -50, 0, 20),
        BackgroundTransparency = 1,
        Text = item.Label,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = T.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = row,
    })

    local valueLabel = Create("TextLabel", {
        Size = UDim2.new(0, 44, 0, 20),
        Position = UDim2.new(1, -44, 0, 0),
        BackgroundTransparency = 1,
        Text = tostring(item.Default),
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = T.Accent,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = row,
    })

    local track = Create("Frame", {
        Size = UDim2.new(1, -6, 0, 4),
        Position = UDim2.new(0, 3, 0, 28),
        BackgroundColor3 = T.Off,
        BorderSizePixel = 0,
        Parent = row,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })

    local fill = Create("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = T.Accent,
        BorderSizePixel = 0,
        Parent = track,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fill })

    local knob = Create("Frame", {
        Size = UDim2.new(0, 12, 0, 12),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = track,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })

    local dragging = false

    local function SetValue(v, fire)
        v = math.clamp(math.floor(v + 0.5), item.Min, item.Max)
        local alpha = (v - item.Min) / (item.Max - item.Min)
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, 0.5, 0)
        valueLabel.Text = tostring(v)
        State[item.Key] = v
        if fire and item.OnChange then
            local ok, err = pcall(item.OnChange, v)
            if not ok then warn("[JDEV] " .. tostring(err)) end
        end
    end

    local function FromInput(input)
        local rel = (input.Position.X - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1)
        SetValue(item.Min + rel * (item.Max - item.Min), true)
    end

    Track(track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            FromInput(input)
        end
    end))

    Track(UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            FromInput(input)
        end
    end))

    Track(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end))

    SetValue(item.Default, false)
    return row
end

local function CreateActionButton(card, item, order)
    local btn = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = T.AccentDim,
        BorderSizePixel = 0,
        Text = item.Label,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = T.Text,
        AutoButtonColor = false,
        LayoutOrder = order,
        Parent = card,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = btn })

    Track(btn.MouseEnter:Connect(function()
        Tween(btn, 0.15, { BackgroundColor3 = T.Accent })
    end))
    Track(btn.MouseLeave:Connect(function()
        Tween(btn, 0.15, { BackgroundColor3 = T.AccentDim })
    end))

    Track(btn.MouseButton1Click:Connect(function()
        if item.OnClick then
            local ok, err = pcall(item.OnClick)
            if not ok then warn("[JDEV] " .. tostring(err)) end
        end
    end))

    return btn
end

local function CreateCard(parent, section)
    local card = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = T.Card,
        BorderSizePixel = 0,
        Parent = parent,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = card })
    Create("UIStroke", { Color = T.CardLine, Thickness = 1, Parent = card })
    Create("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        Parent = card,
    })
    Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = card })

    Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22),
        BackgroundTransparency = 1,
        Text = section.Title,
        Font = Enum.Font.GothamBlack,
        TextSize = 12,
        TextColor3 = T.Accent,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 0,
        Parent = card,
    })

    for i, item in ipairs(section.Items) do
        if item.Type == "toggle" then
            CreateToggle(card, item, i)
        elseif item.Type == "slider" then
            CreateSlider(card, item, i)
        else
            CreateActionButton(card, item, i)
        end
    end

    return card
end

-- =========================================================
-- HANDLERS DE FEATURE
-- =========================================================
local function GetHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function ApplySpeed(v)
    local hum = GetHumanoid()
    if hum then hum.WalkSpeed = v end
end

local function ApplyJump(v)
    local hum = GetHumanoid()
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = v
    end
end

local function TeleportTo(name)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        Notify("⚠️ Personagem não carregado", T.Danger)
        return
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find(name:lower(), 1, true) then
            hrp.CFrame = obj.CFrame + Vector3.new(0, 4, 0)
            Notify("✅ Teleportado: " .. name)
            return
        end
    end
    Notify("⚠️ Não achei: " .. name, T.Danger)
end

-- =========================================================
-- SEÇÕES
-- =========================================================
local Sections = {
    Farm = {
        Title = "AUTO FARM",
        Items = {
            { Type = "toggle", Label = "Auto Win", Icon = "◎", Default = true, Key = "AutoWin",
              OnChange = function(on) print("[JDEV] Auto Win:", on) end },
            { Type = "toggle", Label = "Auto Coin Farm", Icon = "◎", Default = true, Key = "AutoCoin",
              OnChange = function(on) print("[JDEV] Auto Coin Farm:", on) end },
            { Type = "toggle", Label = "Auto Spin", Icon = "◎", Default = false, Key = "AutoSpin",
              OnChange = function(on) print("[JDEV] Auto Spin:", on) end },
            { Type = "toggle", Label = "Auto Claim Rewards", Icon = "🎁", Default = true, Key = "AutoClaim",
              OnChange = function(on) print("[JDEV] Auto Claim:", on) end },
        },
    },
    Player = {
        Title = "PLAYER",
        Items = {
            { Type = "toggle", Label = "God Mode", Icon = "🛡", Default = true, Key = "GodMode",
              OnChange = function(on)
                  local hum = GetHumanoid()
                  if hum then hum.MaxHealth = on and math.huge or 100 end
              end },
            { Type = "toggle", Label = "Infinite Jump", Icon = "🦘", Default = true, Key = "InfJump",
              OnChange = function(on) print("[JDEV] Infinite Jump:", on) end },
            { Type = "toggle", Label = "No Clip", Icon = "👤", Default = false, Key = "NoClip",
              OnChange = function(on) print("[JDEV] No Clip:", on) end },
            { Type = "slider", Label = "WalkSpeed", Key = "WalkSpeed", Min = 16, Max = 250, Default = 100, OnChange = ApplySpeed },
            { Type = "slider", Label = "JumpPower", Key = "JumpPower", Min = 50, Max = 300, Default = 100, OnChange = ApplyJump },
        },
    },
    Visuals = {
        Title = "VISUALS",
        Items = {
            { Type = "toggle", Label = "ESP Players", Icon = "▣", Default = true, Key = "ESPPlayers",
              OnChange = function(on) print("[JDEV] ESP Players:", on) end },
            { Type = "toggle", Label = "ESP Items", Icon = "◈", Default = true, Key = "ESPItems",
              OnChange = function(on) print("[JDEV] ESP Items:", on) end },
            { Type = "toggle", Label = "ESP Traps", Icon = "◉", Default = true, Key = "ESPTraps",
              OnChange = function(on) print("[JDEV] ESP Traps:", on) end },
            { Type = "toggle", Label = "Show Names", Icon = "◉", Default = true, Key = "ShowNames",
              OnChange = function(on) print("[JDEV] Show Names:", on) end },
            { Type = "toggle", Label = "Show Distance", Icon = "↕", Default = false, Key = "ShowDist",
              OnChange = function(on) print("[JDEV] Show Distance:", on) end },
        },
    },
    Teleports = {
        Title = "TELEPORTS",
        Items = {
            { Type = "button", Label = "Teleport to Lobby", OnClick = function() TeleportTo("lobby") end },
            { Type = "button", Label = "Teleport to Arena", OnClick = function() TeleportTo("arena") end },
            { Type = "button", Label = "Teleport to Shop", OnClick = function() TeleportTo("shop") end },
            { Type = "button", Label = "Teleport to Safezone", OnClick = function() TeleportTo("safezone") end },
        },
    },
    Misc = {
        Title = "MISC",
        Items = {
            { Type = "toggle", Label = "Anti AFK", Icon = "⏱", Default = true, Key = "AntiAFK",
              OnChange = function(on) print("[JDEV] Anti AFK:", on) end },
            { Type = "toggle", Label = "Fullbright", Icon = "☀", Default = false, Key = "Fullbright",
              OnChange = function(on)
                  Lighting.Brightness = on and 3 or 2
                  Lighting.ClockTime = on and 14 or 14
                  Lighting.FogEnd = on and 100000 or 1000
              end },
            { Type = "toggle", Label = "FPS Boost", Icon = "⚡", Default = false, Key = "FPSBoost",
              OnChange = function(on)
                  Lighting.GlobalShadows = not on
                  Lighting.ShadowSoftness = on and 0 or 0.2
              end },
        },
    },
    Settings = {
        Title = "SETTINGS",
        Items = {
            { Type = "button", Label = "Resetar Configurações", OnClick = function()
                ApplySpeed(16); ApplyJump(50)
                Notify("🔄 Configurações resetadas")
            end },
            { Type = "button", Label = "Unload Script", OnClick = function()
                Unloaded = true
                for _, c in ipairs(Connections) do pcall(function() c:Disconnect() end) end
                ScreenGui:Destroy()
            end },
        },
    },
}

-- =========================================================
-- ABAS
-- =========================================================
local Tabs = {
    { Name = "Main",     Icon = "🏠", Columns = { { "Farm", "Visuals" }, { "Player", "Teleports" } } },
    { Name = "Farm",     Icon = "⚙",  Columns = { { "Farm" } } },
    { Name = "Player",   Icon = "👤", Columns = { { "Player" } } },
    { Name = "Visuals",  Icon = "👁", Columns = { { "Visuals" } } },
    { Name = "Teleports",Icon = "📍", Columns = { { "Teleports" } } },
    { Name = "Misc",     Icon = "🎛", Columns = { { "Misc" } } },
    { Name = "Settings", Icon = "⚙",  Columns = { { "Settings" } } },
}

local Pages = {}
local NavButtons = {}
local ActiveTab

local function BuildPage(tab)
    if Pages[tab.Name] then return Pages[tab.Name] end

    local page = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = T.Accent,
        VerticalScrollBarInset = Enum.Inset.ScrollbarAlwaysOff,
        Visible = false,
        Parent = Content,
    })

    local holder = Create("Frame", {
        Size = UDim2.new(1, -6, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = page,
    })
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = holder,
    })

    local cols = #tab.Columns
    for ci, colSections in ipairs(tab.Columns) do
        local col = Create("Frame", {
            Size = cols > 1 and UDim2.new(0.5, -6, 0, 0) or UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = ci,
            Parent = holder,
        })
        Create("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, Parent = col })

        for si, sectionKey in ipairs(colSections) do
            local section = Sections[sectionKey]
            if section then
                local card = CreateCard(col, section)
                card.LayoutOrder = si
            end
        end
    end

    Pages[tab.Name] = page
    return page
end

local function SelectTab(name)
    if ActiveTab == name then return end
    ActiveTab = name

    for tabName, page in pairs(Pages) do
        page.Visible = (tabName == name)
    end

    for tabName, btn in pairs(NavButtons) do
        local active = tabName == name
        btn.TextColor3 = active and T.Text or T.TextDim
        btn.BackgroundColor3 = active and Color3.fromRGB(30, 20, 44) or T.Sidebar
        btn.indicator.BackgroundColor3 = active and T.Accent or T.Sidebar
    end
end

for i, tab in ipairs(Tabs) do
    local btn = Create("TextButton", {
        Name = "Nav_" .. tab.Name,
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = T.Sidebar,
        BorderSizePixel = 0,
        Text = "  " .. tab.Icon .. "   " .. tab.Name,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = T.TextDim,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false,
        LayoutOrder = i,
        Parent = NavList,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = btn })

    local indicator = Create("Frame", {
        Size = UDim2.new(0, 3, 0, 18),
        Position = UDim2.new(0, 0, 0.5, -9),
        BackgroundColor3 = T.Sidebar,
        BorderSizePixel = 0,
        Parent = btn,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = indicator })
    btn.indicator = indicator

    NavButtons[tab.Name] = btn

    Track(btn.MouseButton1Click:Connect(function()
        BuildPage(tab)
        SelectTab(tab.Name)
    end))
end

-- =========================================================
-- LOOPS DE FEATURE
-- =========================================================
Track(RunService.Heartbeat:Connect(function()
    if Unloaded then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    if State.GodMode then
        hum.MaxHealth = math.huge
        if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
    end

    if State.NoClip then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
        end
    end
end))

Track(UserInputService.JumpRequest:Connect(function()
    if State.InfJump then
        local hum = GetHumanoid()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

Track(LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    ApplySpeed(State.WalkSpeed or 100)
    ApplyJump(State.JumpPower or 100)
end))

-- =========================================================
-- ARRASTE
-- =========================================================
local dragging, dragStart, startPos = false, Vector2.new(), UDim2.new()

local function BeginDrag(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
        and input.UserInputType ~= Enum.UserInputType.Touch then return end
    dragging = true
    dragStart = input.Position
    startPos = Panel.Position
end

Track(Header.InputBegan:Connect(BeginDrag))
Track(Panel.InputBegan:Connect(BeginDrag))

Track(UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then return end
    local d = input.Position - dragStart
    local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
    Panel.Position = UDim2.new(
        0, math.clamp(startPos.X.Offset + d.X, 0, math.max(0, vp.X - Panel.AbsoluteSize.X)),
        0, math.clamp(startPos.Y.Offset + d.Y, 0, math.max(0, vp.Y - Panel.AbsoluteSize.Y))
    )
end))

Track(UserInputService.InputEnded:Connect(function()
    dragging = false
end))

-- =========================================================
-- MINIMIZAR / FECHAR / REABRIR
-- =========================================================
local minimized = false

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    MinBtn.Text = minimized and "▢" or "—"
    Sidebar.Visible = not minimized
    Content.Visible = not minimized
    Tween(Panel, 0.22, {
        Size = minimized and UDim2.new(0, W, 0, HEADER) or UDim2.new(0, W, 0, H)
    })
end)

local reopen

local function ClosePanel()
    Tween(Panel, 0.22, { Size = UDim2.new(0, W, 0, 0), BackgroundTransparency = 1 })
    task.wait(0.22)
    Panel.Visible = false

    if reopen then reopen:Destroy() end
    reopen = Create("TextButton", {
        Size = UDim2.new(0, 46, 0, 46),
        Position = UDim2.new(0, 40, 0, 40),
        BackgroundColor3 = Color3.fromRGB(30, 18, 46),
        Text = "🌙",
        TextSize = 22,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = reopen })
    Create("UIStroke", { Color = T.Accent, Thickness = 1.5, Parent = reopen })

    reopen.MouseButton1Click:Connect(function()
        reopen.Visible = false
        Panel.Visible = true
        Panel.BackgroundTransparency = 0
        Tween(Panel, 0.25, { Size = UDim2.new(0, W, 0, H) })
    end)
end

CloseBtn.MouseButton1Click:Connect(ClosePanel)

-- =========================================================
-- INIT
-- =========================================================
BuildPage(Tabs[1])
SelectTab("Main")

Panel.Size = UDim2.new(0, 0, 0, 0)
task.delay(0.1, function()
    Tween(Panel, 0.35, { Size = UDim2.new(0, W, 0, H) })
end)

task.wait(0.6)
ApplySpeed(State.WalkSpeed or 100)
ApplyJump(State.JumpPower or 100)

print("[JDEV BLOX🤫🌙] MOG OR DIE SCRIPT v4.0 carregado.")
print("[JDEV BLOX] Arraste pelo cabeçalho. Abas na lateral.")
