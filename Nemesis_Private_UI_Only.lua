-- Nemesis Private | UI-only starter
-- Place this LocalScript in StarterPlayerScripts or StarterGui in your own Roblox experience.
-- This is a standalone UI mockup: it does not include exploit APIs or gameplay cheats.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("NemesisPrivate")
if old then old:Destroy() end

local COLORS = {
    background = Color3.fromRGB(17, 19, 25),
    panel = Color3.fromRGB(25, 28, 37),
    panel2 = Color3.fromRGB(32, 36, 47),
    text = Color3.fromRGB(240, 242, 248),
    muted = Color3.fromRGB(145, 152, 169),
    accent = Color3.fromRGB(112, 92, 255),
    stroke = Color3.fromRGB(59, 64, 80),
}
local accent = COLORS.accent
local transparency = 0.08

local gui = Instance.new("ScreenGui")
gui.Name = "NemesisPrivate"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness, trans)
    local s = Instance.new("UIStroke")
    s.Color = color or COLORS.stroke
    s.Thickness = thickness or 1
    s.Transparency = trans or 0
    s.Parent = parent
    return s
end

local function label(parent, text, size, color, font)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = color or COLORS.text
    t.TextSize = size or 14
    t.Font = font or Enum.Font.Gotham
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = parent
    return t
end

local function button(parent, text, size)
    local b = Instance.new("TextButton")
    b.AutoButtonColor = false
    b.Text = text
    b.TextSize = 13
    b.Font = Enum.Font.GothamMedium
    b.TextColor3 = COLORS.text
    b.BackgroundColor3 = COLORS.panel2
    b.Size = size or UDim2.new(1, 0, 0, 36)
    b.Parent = parent
    corner(b, 9)
    return b
end

-- Startup notification
local toast = Instance.new("Frame")
toast.AnchorPoint = Vector2.new(1, 0)
toast.Position = UDim2.new(1, -22, 0, 22)
toast.Size = UDim2.fromOffset(310, 92)
toast.BackgroundColor3 = COLORS.panel
toast.BackgroundTransparency = 0.03
toast.Parent = gui
corner(toast, 12)
stroke(toast, accent, 1.3)

local toastTitle = label(toast, "Nemesis Private", 15, COLORS.text, Enum.Font.GothamBold)
toastTitle.Position = UDim2.fromOffset(14, 10)
toastTitle.Size = UDim2.new(1, -28, 0, 20)
local toastBody = label(toast, "This script is only for premium users.\nCheck your key status in our server.", 11, COLORS.muted)
toastBody.Position = UDim2.fromOffset(14, 35)
toastBody.Size = UDim2.new(1, -28, 0, 32)
toastBody.TextWrapped = true
local toastSign = label(toast, "— Nemesis Hub Bot", 10, accent, Enum.Font.GothamMedium)
toastSign.Position = UDim2.new(0, 14, 1, -19)
toastSign.Size = UDim2.new(1, -28, 0, 14)

task.delay(5, function()
    if toast.Parent then
        TweenService:Create(toast, TweenInfo.new(0.35), {
            Position = UDim2.new(1, 340, 0, 22),
            BackgroundTransparency = 1
        }):Play()
        task.wait(0.4)
        if toast.Parent then toast:Destroy() end
    end
end)

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.53)
main.Size = UDim2.fromOffset(650, 410)
main.BackgroundColor3 = COLORS.background
main.BackgroundTransparency = transparency
main.Parent = gui
corner(main, 15)
stroke(main, COLORS.stroke, 1)

local scale = Instance.new("UIScale")
scale.Scale = 1
scale.Parent = main

-- Responsive sizing for smaller screens
local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    scale.Scale = math.min(1, (viewport.X - 24) / 650, (viewport.Y - 70) / 410)
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

local top = Instance.new("Frame")
top.BackgroundColor3 = COLORS.panel
top.BackgroundTransparency = 0.02
top.Size = UDim2.new(1, 0, 0, 58)
top.Parent = main
corner(top, 15)

local title = label(top, "NEMESIS", 17, COLORS.text, Enum.Font.GothamBlack)
title.Position = UDim2.fromOffset(18, 8)
title.Size = UDim2.fromOffset(150, 23)
local subtitle = label(top, "PRIVATE  /  RIVALS UI", 9, COLORS.muted, Enum.Font.GothamMedium)
subtitle.Position = UDim2.fromOffset(19, 32)
subtitle.Size = UDim2.fromOffset(180, 14)

local status = label(top, "●  UI READY", 10, Color3.fromRGB(115, 220, 160), Enum.Font.GothamMedium)
status.TextXAlignment = Enum.TextXAlignment.Right
status.AnchorPoint = Vector2.new(1, 0)
status.Position = UDim2.new(1, -55, 0, 22)
status.Size = UDim2.fromOffset(110, 16)

local close = button(top, "×", UDim2.fromOffset(30, 30))
close.Position = UDim2.new(1, -42, 0, 14)
close.TextSize = 20
close.BackgroundColor3 = COLORS.panel2

local sidebar = Instance.new("Frame")
sidebar.BackgroundColor3 = COLORS.panel
sidebar.BackgroundTransparency = 0.02
sidebar.Position = UDim2.fromOffset(12, 70)
sidebar.Size = UDim2.new(0, 150, 1, -82)
sidebar.Parent = main
corner(sidebar, 12)

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 7)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 12)
sidePad.PaddingLeft = UDim.new(0, 9)
sidePad.PaddingRight = UDim.new(0, 9)
sidePad.Parent = sidebar

local content = Instance.new("Frame")
content.BackgroundColor3 = COLORS.panel
content.BackgroundTransparency = 0.02
content.Position = UDim2.fromOffset(174, 70)
content.Size = UDim2.new(1, -186, 1, -82)
content.Parent = main
corner(content, 12)

local pageTitle = label(content, "Home", 19, COLORS.text, Enum.Font.GothamBold)
pageTitle.Position = UDim2.fromOffset(18, 15)
pageTitle.Size = UDim2.new(1, -36, 0, 26)
local pageDesc = label(content, "Welcome to Nemesis Private.", 11, COLORS.muted)
pageDesc.Position = UDim2.fromOffset(19, 42)
pageDesc.Size = UDim2.new(1, -38, 0, 18)

local pageBody = Instance.new("ScrollingFrame")
pageBody.BackgroundTransparency = 1
pageBody.BorderSizePixel = 0
pageBody.Position = UDim2.fromOffset(18, 72)
pageBody.Size = UDim2.new(1, -36, 1, -88)
pageBody.CanvasSize = UDim2.new()
pageBody.AutomaticCanvasSize = Enum.AutomaticSize.Y
pageBody.ScrollBarThickness = 3
pageBody.ScrollBarImageColor3 = accent
pageBody.Parent = content

local bodyLayout = Instance.new("UIListLayout")
bodyLayout.Padding = UDim.new(0, 9)
bodyLayout.SortOrder = Enum.SortOrder.LayoutOrder
bodyLayout.Parent = pageBody

local bodyPad = Instance.new("UIPadding")
bodyPad.PaddingBottom = UDim.new(0, 8)
bodyPad.Parent = pageBody

local function clearBody()
    for _, child in ipairs(pageBody:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function section(text)
    local row = Instance.new("Frame")
    row.BackgroundColor3 = COLORS.panel2
    row.Size = UDim2.new(1, 0, 0, 38)
    row.Parent = pageBody
    corner(row, 8)
    local t = label(row, text, 12, accent, Enum.Font.GothamBold)
    t.Position = UDim2.fromOffset(12, 0)
    t.Size = UDim2.new(1, -24, 1, 0)
end

local function infoCard(head, body)
    local card = Instance.new("Frame")
    card.BackgroundColor3 = COLORS.panel2
    card.Size = UDim2.new(1, 0, 0, 66)
    card.Parent = pageBody
    corner(card, 9)
    local h = label(card, head, 12, COLORS.text, Enum.Font.GothamBold)
    h.Position = UDim2.fromOffset(12, 9)
    h.Size = UDim2.new(1, -24, 0, 18)
    local d = label(card, body, 10, COLORS.muted)
    d.Position = UDim2.fromOffset(12, 31)
    d.Size = UDim2.new(1, -24, 0, 25)
    d.TextWrapped = true
end

local function toggleRow(text, defaultValue, callback)
    local row = Instance.new("Frame")
    row.BackgroundColor3 = COLORS.panel2
    row.Size = UDim2.new(1, 0, 0, 44)
    row.Parent = pageBody
    corner(row, 9)
    local t = label(row, text, 12, COLORS.text, Enum.Font.GothamMedium)
    t.Position = UDim2.fromOffset(12, 0)
    t.Size = UDim2.new(1, -76, 1, 0)

    local toggle = button(row, "", UDim2.fromOffset(42, 23))
    toggle.AnchorPoint = Vector2.new(1, 0.5)
    toggle.Position = UDim2.new(1, -10, 0.5, 0)
    toggle.BackgroundColor3 = defaultValue and accent or COLORS.stroke
    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(17, 17)
    knob.Position = defaultValue and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Parent = toggle
    corner(knob, 9)
    local state = defaultValue
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and accent or COLORS.stroke
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = state and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        }):Play()
        if callback then callback(state) end
    end)
end

local pages = {}
local currentPage = "Home"

local function showPage(name)
    currentPage = name
    clearBody()
    pageTitle.Text = name
    pageDesc.Text = ({
        Home = "Welcome to Nemesis Private.",
        Customizer = "Adjust the appearance of the interface.",
        Visuals = "Cosmetic interface preferences only.",
        Settings = "General interface settings.",
        About = "Project information."
    })[name] or ""
    for pageName, nav in pairs(pages) do
        nav.BackgroundColor3 = pageName == name and accent or COLORS.panel2
    end

    if name == "Home" then
        section("OVERVIEW")
        infoCard("Nemesis Private", "A clean, customizable interface with a lightweight glass-inspired look.")
        infoCard("Key status", "N/A  •  Premium verification is not connected in this UI demo.")
        infoCard("Build", "UI-only starter  •  No gameplay automation included.")
    elseif name == "Customizer" then
        section("ACCENT COLOR")
        local colors = {
            {"Violet", Color3.fromRGB(112, 92, 255)},
            {"Blue", Color3.fromRGB(65, 145, 255)},
            {"Mint", Color3.fromRGB(65, 205, 160)},
            {"Rose", Color3.fromRGB(235, 95, 145)},
        }
        for _, item in ipairs(colors) do
            local b = button(pageBody, item[1], UDim2.new(1, 0, 0, 36))
            b.MouseButton1Click:Connect(function()
                accent = item[2]
                for _, nav in pairs(pages) do
                    if nav.BackgroundColor3 == COLORS.accent or nav.BackgroundColor3 == accent then
                        nav.BackgroundColor3 = accent
                    end
                end
                pageBody.ScrollBarImageColor3 = accent
                stroke(main, accent, 1)
                status.TextColor3 = accent
                showPage("Customizer")
            end)
        end
        section("WINDOW")
        local less = button(pageBody, "More transparent", UDim2.new(1, 0, 0, 36))
        less.MouseButton1Click:Connect(function()
            transparency = math.min(0.35, transparency + 0.05)
            main.BackgroundTransparency = transparency
        end)
        local more = button(pageBody, "Less transparent", UDim2.new(1, 0, 0, 36))
        more.MouseButton1Click:Connect(function()
            transparency = math.max(0, transparency - 0.05)
            main.BackgroundTransparency = transparency
        end)
    elseif name == "Visuals" then
        section("INTERFACE")
        toggleRow("Show status indicator", true, function(v)
            status.Visible = v
        end)
        toggleRow("Show startup notification", true, function(v)
            if v then
                local note = Instance.new("TextLabel")
                note.BackgroundTransparency = 1
                note.Text = "Startup notification is enabled for the next launch."
                note.TextColor3 = COLORS.muted
                note.TextSize = 10
                note.Font = Enum.Font.Gotham
                note.Size = UDim2.new(1, 0, 0, 28)
                note.Parent = pageBody
            end
        end)
    elseif name == "Settings" then
        section("GENERAL")
        toggleRow("Remember window visibility", true)
        toggleRow("Compact layout", false, function(v)
            main.Size = v and UDim2.fromOffset(590, 370) or UDim2.fromOffset(650, 410)
            updateScale()
        end)
        local reset = button(pageBody, "Reset interface appearance", UDim2.new(1, 0, 0, 36))
        reset.MouseButton1Click:Connect(function()
            accent = COLORS.accent
            transparency = 0.08
            main.BackgroundTransparency = transparency
            stroke(main, COLORS.stroke, 1)
            showPage("Settings")
        end)
    elseif name == "About" then
        section("ABOUT NEMESIS")
        infoCard("Nemesis Private", "Interface concept by Nemesis Hub.")
        infoCard("Notice", "This starter contains UI and cosmetic controls only. It does not connect to Rivals gameplay systems.")
    end
end

for i, name in ipairs({"Home", "Customizer", "Visuals", "Settings", "About"}) do
    local nav = button(sidebar, name, UDim2.new(1, 0, 0, 36))
    nav.LayoutOrder = i
    nav.TextXAlignment = Enum.TextXAlignment.Left
    nav.Text = "   " .. name
    pages[name] = nav
    nav.MouseButton1Click:Connect(function()
        showPage(name)
    end)
end

-- Drag window using the title bar
local dragging = false
local dragStart, startPos
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local visible = true
local function setVisible(value)
    visible = value
    main.Visible = value
end
close.MouseButton1Click:Connect(function()
    setVisible(false)
end)

-- Small floating logo button reopens the window.
local reopen = button(gui, "N", UDim2.fromOffset(44, 44))
reopen.AnchorPoint = Vector2.new(0, 0.5)
reopen.Position = UDim2.new(0, 14, 0.5, 0)
reopen.BackgroundColor3 = accent
reopen.TextSize = 17
reopen.Font = Enum.Font.GothamBlack
reopen.MouseButton1Click:Connect(function()
    setVisible(not visible)
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        setVisible(not visible)
    end
end)

showPage("Home")
