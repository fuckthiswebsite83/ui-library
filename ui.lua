local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local UILibrary = {}

function UILibrary:Create()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MyUILibrary"
    ScreenGui.Parent = CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Parent = ScreenGui
    
    -- Create tabs container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 0, 30)
    TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabContainer.Parent = MainFrame
    
    -- Create Main tab
    local MainTab = Instance.new("TextButton")
    MainTab.Name = "MainTab"
    MainTab.Size = UDim2.new(0, 100, 1, 0)
    MainTab.Position = UDim2.new(0, 0, 0, 0)
    MainTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MainTab.Text = "Main"
    MainTab.Parent = TabContainer
    
    -- Create Settings tab
    local SettingsTab = Instance.new("TextButton")
    SettingsTab.Name = "SettingsTab"
    SettingsTab.Size = UDim2.new(0, 100, 1, 0)
    SettingsTab.Position = UDim2.new(0, 100, 0, 0)
    SettingsTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SettingsTab.Text = "UI Settings"
    SettingsTab.Parent = TabContainer
    
    -- Create content frames
    local MainContent = Instance.new("Frame")
    MainContent.Name = "MainContent"
    MainContent.Size = UDim2.new(1, 0, 1, -30)
    MainContent.Position = UDim2.new(0, 0, 0, 30)
    MainContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    MainContent.Visible = true
    MainContent.Parent = MainFrame
    
    local SettingsContent = Instance.new("Frame")
    SettingsContent.Name = "SettingsContent"
    SettingsContent.Size = UDim2.new(1, 0, 1, -30)
    SettingsContent.Position = UDim2.new(0, 0, 0, 30)
    SettingsContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SettingsContent.Visible = false
    SettingsContent.Parent = MainFrame
    
    -- Create Unload button in Settings
    local UnloadButton = Instance.new("TextButton")
    UnloadButton.Name = "UnloadButton"
    UnloadButton.Size = UDim2.new(0, 100, 0, 30)
    UnloadButton.Position = UDim2.new(0.5, -50, 0, 20)
    UnloadButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    UnloadButton.Text = "Unload UI"
    UnloadButton.Parent = SettingsContent
    
    -- Tab switching logic
    MainTab.MouseButton1Click:Connect(function()
        MainContent.Visible = true
        SettingsContent.Visible = false
    end)
    
    SettingsTab.MouseButton1Click:Connect(function()
        MainContent.Visible = false
        SettingsContent.Visible = true
    end)
    
    -- Unload functionality
    UnloadButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Make UI draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    return UILibrary
end

return UILibrary
