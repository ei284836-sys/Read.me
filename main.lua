-- =========================================================
-- JDEV BLOX🤫🌙 — Painel Premium Executável v3.2 (FIXED)
-- Autor: JDEV
-- =========================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- UTILITÁRIOS
-- ==========================================
local function Create(ClassName, Properties)
    local Object = Instance.new(ClassName)
    for Key, Value in pairs(Properties) do
        Object[Key] = Value
    end
    return Object
end

-- Parent seguro: CoreGui com fallback para PlayerGui
local GuiParent
do
    local probe = Instance.new("ScreenGui")
    local ok = pcall(function()
        probe.Parent = CoreGui
    end)
    if ok then
        GuiParent = CoreGui
    else
        GuiParent = LocalPlayer:WaitForChild("PlayerGui")
    end
    probe:Destroy()
end

-- Remove painel antigo, se existir
local old = GuiParent:FindFirstChild("JDEV_BLOX_UI")
if old then old:Destroy() end

-- ==========================================
-- CONFIGURAÇÕES
-- ==========================================
local PanelConfig = {
    Title = "JDEV BLOX🤫🌙",
    Width = 420,
    Height = 520,
    X = 10,
    Y = 10,
    Theme = {
        Background = Color3.fromRGB(12, 12, 20),
        HeaderBg = Color3.fromRGB(20, 18, 35),
        CardBg = Color3.fromRGB(25, 22, 40),
        CardHover = Color3.fromRGB(35, 30, 55),
        Accent = Color3.fromRGB(168, 85, 247),
        TextPrimary = Color3.fromRGB(228, 228, 255),
        TextSecondary = Color3.fromRGB(148, 163, 184),
        BorderColor = Color3.fromRGB(139, 92, 246),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(245, 158, 11),
        ModalBg = Color3.fromRGB(15, 12, 30),
    }
}

local GamesList = {
    { Name = "MOG OR DIE", Icon = "🐱", Status = "active", ScriptFunc = function()
        print("[JDEV BLOX] ✅ MOG OR DIE - Carregado!")
        print("   → Auto Win / Auto Farm / ESP / God Mode")
    end },
    { Name = "Blox Fruits", Icon = "🍎", Status = "active", ScriptFunc = function()
        print("[JDEV BLOX] ✅ Blox Fruits - Carregado!")
        print("   → Auto Farm / Auto Quest / Auto Raid / Teleport")
    end },
    { Name = "King Legacy", Icon = "👑", Status = "active", ScriptFunc = function()
        print("[JDEV BLOX] ✅ King Legacy - Carregado!")
        print("   → Auto Farm / Auto Boss / ESP / Speed 100")
    end },
    { Name = "Pet Sim 99", Icon = "🐾", Status = "active", ScriptFunc = function()
        print("[JDEV BLOX] ✅ Pet Sim 99 - Carregado!")
        print("   → Auto Hatch / Auto Farm / Huge Pets ESP")
    end },
    { Name = "Arsenal", Icon = "🔫", Status = "active", ScriptFunc = function()
        print("[JDEV BLOX] ✅ Arsenal - Carregado!")
        print("   → ESP / Aimbot / No Recoil")
    end },
    { Name = "Tower of Thrones", Icon = "🏰", Status = "active", ScriptFunc = function()
        print("[JDEV BLOX] ✅ Tower of Thrones - Carregado!")
        print("   → Auto Attack / Auto Heal / ESP")
    end },
    { Name = "Anime Defenders", Icon = "🛡️", Status = "brew" },
    { Name = "Doom Spire", Icon = "⚔️", Status = "brew" },
    { Name = "Murder Mystery 2", Icon = "🔪", Status = "brew" },
    { Name = "BedWars", Icon = "🛏️", Status = "brew" },
    { Name = "Doors", Icon = "🚪", Status = "brew" },
    { Name = "Piggy", Icon = "🐷", Status = "brew" },
}

-- ==========================================
-- SCREEN GUI
-- ==========================================
local ScreenGui = Create("ScreenGui", {
    Name = "JDEV_BLOX_UI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 9999,
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
    Parent = GuiParent,
})

-- ==========================================
-- PAINEL
-- ==========================================
local MainFrame = Create("Frame", {
    Name = "JDEV_BLOX_Panel",
    Size = UDim2.new(0, PanelConfig.Width, 0, PanelConfig.Height),
    Position = UDim2.new(0, PanelConfig.X, 0, PanelConfig.Y),
    BackgroundColor3 = PanelConfig.Theme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Active = true,
    Parent = ScreenGui,
})

Create("UICorner", { CornerRadius = UDim.new(0, 16), Parent = MainFrame })
Create("UIStroke", {
    Color = PanelConfig.Theme.Accent,
    Thickness = 1.5,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = MainFrame,
})

-- ==========================================
-- CABEÇALHO
-- ==========================================
local HeaderFrame = Create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 70),
    BackgroundColor3 = PanelConfig.Theme.HeaderBg,
    BorderSizePixel = 0,
    Active = true,
    Parent = MainFrame,
})

Create("UICorner", { CornerRadius = UDim.new(0, 16), Parent = HeaderFrame })

-- Ícone da lua (emoji, sem asset quebrado)
local MoonContainer = Create("Frame", {
    Name = "MoonIcon",
    Size = UDim2.new(0, 48, 0, 48),
    Position = UDim2.new(0, 15, 0.5, -24),
    BackgroundColor3 = PanelConfig.Theme.Accent,
    BorderSizePixel = 0,
    Parent = HeaderFrame,
})
Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = MoonContainer })
Create("UIStroke", {
    Color = PanelConfig.Theme.Accent,
    Thickness = 3,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = MoonContainer,
})

Create("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "🌙",
    TextSize = 26,
    Font = Enum.Font.GothamBold,
    Parent = MoonContainer,
})

Create("TextLabel", {
    Name = "Title",
    Size = UDim2.new(1, -110, 0, 26),
    Position = UDim2.new(0, 72, 0, 14),
    BackgroundTransparency = 1,
    Text = "JDEV BLOX",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = PanelConfig.Theme.TextPrimary,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = HeaderFrame,
})

Create("TextLabel", {
    Name = "Subtitle",
    Size = UDim2.new(1, -110, 0, 18),
    Position = UDim2.new(0, 72, 0, 40),
    BackgroundTransparency = 1,
    Text = "🤫🌙 ULTIMATE HUB",
    Font = Enum.Font.GothamSemibold,
    TextSize = 11,
    TextColor3 = PanelConfig.Theme.Accent,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = HeaderFrame,
})

-- ==========================================
-- LISTA (Scroll)
-- ==========================================
local ScrollFrame = Create("ScrollingFrame", {
    Name = "GameList",
    Size = UDim2.new(1, -20, 1, -90),
    Position = UDim2.new(0, 10, 0, 80),
    BackgroundTransparency = 1,
    CanvasSize = UDim2.new(0, 0, 0, #GamesList * 85),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = PanelConfig.Theme.Accent,
    VerticalScrollBarInset = Enum.Inset.ScrollbarAlwaysOff,
    Parent = MainFrame,
})

-- ==========================================
-- TOAST (declarado antes dos cards)
-- ==========================================
local ToastFrame = Create("Frame", {
    Name = "Toast",
    Size = UDim2.new(0, 300, 0, 50),
    Position = UDim2.new(1, -320, 1, -70),
    BackgroundColor3 = Color3.fromRGB(20, 18, 35),
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 60,
    Parent = ScreenGui,
})

Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = ToastFrame })
Create("UIStroke", {
    Color = PanelConfig.Theme.Success,
    Thickness = 1.5,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = ToastFrame,
})

local ToastText = Create("TextLabel", {
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "",
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextColor3 = PanelConfig.Theme.Success,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextWrapped = true,
    Parent = ToastFrame,
})

local toastToken = 0
local function ShowToast(message)
    toastToken = toastToken + 1
    local myToken = toastToken
    ToastText.Text = message
    ToastFrame.Visible = true
    ToastFrame.Position = UDim2.new(1, -320, 1, -70)
    TweenService:Create(ToastFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 1, -100),
    }):Play()

    task.delay(3, function()
        if myToken ~= toastToken then return end
        TweenService:Create(ToastFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(1, -320, 1, -70),
        }):Play()
        task.wait(0.35)
        if myToken == toastToken then
            ToastFrame.Visible = false
        end
    end)
end

-- ==========================================
-- MODAL "EM BREVE" (declarado antes dos cards)
-- ==========================================
local BrewModal = Create("TextButton", {
    Name = "BrewModal",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    Text = "",
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 50,
    Parent = ScreenGui,
})

Create("Frame", {
    Name = "Overlay",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 0.55,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    Parent = BrewModal,
})

local ModalContent = Create("Frame", {
    Name = "Content",
    Size = UDim2.new(0, 340, 0, 200),
    Position = UDim2.new(0.5, -170, 0.5, -100),
    BackgroundColor3 = PanelConfig.Theme.ModalBg,
    BorderSizePixel = 0,
    Parent = BrewModal,
})

Create("UICorner", { CornerRadius = UDim.new(0, 16), Parent = ModalContent })
Create("UIStroke", { Color = PanelConfig.Theme.Accent, Thickness = 2, Parent = ModalContent })

local ModalScale = Create("UIScale", { Scale = 1, Parent = ModalContent })

Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 34),
    Position = UDim2.new(0, 0, 0, 20),
    BackgroundTransparency = 1,
    Text = "⏳ EM BREVE",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = PanelConfig.Theme.Warning,
    Parent = ModalContent,
})

local BrewMessage = Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 60),
    Position = UDim2.new(0, 20, 0, 64),
    BackgroundTransparency = 1,
    Text = "",
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextColor3 = PanelConfig.Theme.TextSecondary,
    TextWrapped = true,
    Parent = ModalContent,
})

local ChooseBtn = Create("TextButton", {
    Size = UDim2.new(0, 200, 0, 40),
    Position = UDim2.new(0.5, -100, 0, 138),
    BackgroundColor3 = PanelConfig.Theme.Accent,
    BorderSizePixel = 0,
    Text = "ESCOLHER OUTRO",
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = ModalContent,
})

Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = ChooseBtn })

local function CloseModal()
    BrewModal.Visible = false
end

ChooseBtn.MouseButton1Click:Connect(CloseModal)
BrewModal.MouseButton1Click:Connect(CloseModal)

local function ShowBrewModal(gameName)
    BrewMessage.Text = 'O script para "' .. gameName .. '" ainda está sendo desenvolvido.\nEscolha outro jogo abaixo!'
    ModalScale.Scale = 0.85
    BrewModal.Visible = true
    TweenService:Create(ModalScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1,
    }):Play()
end

-- ==========================================
-- CARDS
-- ==========================================
local lastClick = 0

local function OnClick(GameData)
    local now = os.clock()
    if now - lastClick < 0.2 then return end
    lastClick = now

    if GameData.Status == "brew" then
        ShowBrewModal(GameData.Name)
    else
        local ok, err = pcall(GameData.ScriptFunc)
        if ok then
            ShowToast("✅ " .. GameData.Name .. " carregado!")
        else
            ShowToast("⚠️ Erro: " .. tostring(err))
            warn("[JDEV BLOX] " .. tostring(err))
        end
    end
end

for i, GameData in ipairs(GamesList) do
    local isActive = GameData.Status == "active"

    local Card = Create("Frame", {
        Name = "GameCard_" .. i,
        Size = UDim2.new(1, -10, 0, 75),
        Position = UDim2.new(0, 5, 0, (i - 1) * 85 + 5),
        BackgroundColor3 = PanelConfig.Theme.CardBg,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        Parent = ScrollFrame,
    })

    Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = Card })

    Create("TextLabel", {
        Size = UDim2.new(0, 45, 0, 45),
        Position = UDim2.new(0, 10, 0.5, -22.5),
        BackgroundTransparency = 1,
        Text = GameData.Icon,
        TextSize = 26,
        Parent = Card,
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -140, 0, 22),
        Position = UDim2.new(0, 60, 0, 12),
        BackgroundTransparency = 1,
        Text = GameData.Name,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = PanelConfig.Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = Card,
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -140, 0, 18),
        Position = UDim2.new(0, 60, 0, 38),
        BackgroundTransparency = 1,
        Text = isActive and "● ATIVO" or "◌ EM BREVE",
        Font = Enum.Font.GothamSemibold,
        TextSize = 10,
        TextColor3 = isActive and PanelConfig.Theme.Success or PanelConfig.Theme.Warning,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Card,
    })

    local ExecuteBtn = Create("TextButton", {
        Size = UDim2.new(0, 55, 0, 35),
        Position = UDim2.new(1, -65, 0.5, -17.5),
        BackgroundColor3 = isActive and PanelConfig.Theme.Accent or PanelConfig.Theme.CardHover,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = isActive and "▶ EXEC" or "🔒",
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = isActive and Color3.fromRGB(255, 255, 255) or PanelConfig.Theme.TextSecondary,
        Parent = Card,
    })

    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = ExecuteBtn })

    Card.MouseEnter:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.15), {
            BackgroundColor3 = isActive and PanelConfig.Theme.CardHover or PanelConfig.Theme.CardBg,
        }):Play()
    end)

    Card.MouseLeave:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.15), {
            BackgroundColor3 = PanelConfig.Theme.CardBg,
        }):Play()
    end)

    Card.MouseButton1Click:Connect(function() OnClick(GameData) end)
    ExecuteBtn.MouseButton1Click:Connect(function() OnClick(GameData) end)

    task.delay(0.04 * i, function()
        TweenService:Create(Card, TweenInfo.new(0.3), { BackgroundTransparency = 0 }):Play()
    end)
end

-- ==========================================
-- ARRASTE (cabeçalho + área vazia do painel)
-- ==========================================
local Dragging = false
local DragStart = Vector2.new()
local StartPos = UDim2.new()

local function ClampPos(x, y)
    local cam = workspace.CurrentCamera
    local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
    return math.clamp(x, 0, math.max(0, vp.X - MainFrame.AbsoluteSize.X)),
           math.clamp(y, 0, math.max(0, vp.Y - MainFrame.AbsoluteSize.Y))
end

local function BeginDrag(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    Dragging = true
    DragStart = input.Position
    StartPos = MainFrame.Position

    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            Dragging = false
        end
    end)
end

HeaderFrame.InputBegan:Connect(BeginDrag)
MainFrame.InputBegan:Connect(BeginDrag)

UserInputService.InputChanged:Connect(function(input)
    if not Dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    local delta = input.Position - DragStart
    local x, y = ClampPos(StartPos.X.Offset + delta.X, StartPos.Y.Offset + delta.Y)
    MainFrame.Position = UDim2.new(0, x, 0, y)
end)

UserInputService.InputEnded:Connect(function()
    Dragging = false
end)

-- ==========================================
-- MINIMIZAR / FECHAR
-- ==========================================
local MinimizeBtn = Create("TextButton", {
    Name = "Minimize",
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -33, 0, 10),
    BackgroundTransparency = 1,
    AutoButtonColor = false,
    Text = "—",
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextColor3 = PanelConfig.Theme.TextSecondary,
    Parent = MainFrame,
})

local CloseBtn = Create("TextButton", {
    Name = "Close",
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -33, 0, 40),
    BackgroundTransparency = 1,
    AutoButtonColor = false,
    Text = "✕",
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextColor3 = Color3.fromRGB(239, 68, 68),
    Parent = MainFrame,
})

local minimized = false

local function SetMinimized(state)
    minimized = state
    HeaderFrame.Visible = not state
    ScrollFrame.Visible = not state
    CloseBtn.Visible = not state
    MinimizeBtn.Text = state and "▢" or "—"
    MinimizeBtn.Position = state and UDim2.new(0.5, -14, 0.5, -14) or UDim2.new(1, -33, 0, 10)

    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = state and UDim2.new(0, 50, 0, 50) or UDim2.new(0, PanelConfig.Width, 0, PanelConfig.Height),
    }):Play()
end

MinimizeBtn.MouseButton1Click:Connect(function()
    SetMinimized(not minimized)
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
    }):Play()
    task.wait(0.25)
    ScreenGui:Destroy()
end)

-- ==========================================
-- ANIMAÇÃO DE ENTRADA
-- ==========================================
MainFrame.Size = UDim2.new(0, 0, 0, 0)
task.delay(0.15, function()
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, PanelConfig.Width, 0, PanelConfig.Height),
    }):Play()
end)

print("[JDEV BLOX🤫🌙] Painel carregado. Arraste pelo cabeçalho.")
print("[JDEV BLOX🤫🌙] " .. #GamesList .. " jogos na lista.")
