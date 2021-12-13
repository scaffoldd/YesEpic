function library:CreateWatermark(name)
    local watermark = { }
    watermark.Visible = true

    local gamename = marketplaceservice:GetProductInfo(game.PlaceId).Name
    watermark.main = Instance.new("ScreenGui", coregui)
    watermark.main.Name = name
    if syn then
        syn.protect_gui(watermark.main)
    end

    if getgenv().watermark then
        getgenv().watermark:Remove()
    end
    getgenv().watermark = watermark.main
    
    watermark.mainbar = Instance.new("Frame", watermark.main)
    watermark.mainbar.Name = "Main"
    watermark.mainbar.BorderColor3 = Color3.fromRGB(80, 80, 80)
    watermark.mainbar.Visible = watermark.Visible
    watermark.mainbar.BorderSizePixel = 0
    watermark.mainbar.ZIndex = 5
    watermark.mainbar.Position = UDim2.new(0.0559123, -89, 0.01, 0)
    watermark.mainbar.Size = UDim2.new(0, 0, 0, 25)

    watermark.Gradient = Instance.new("UIGradient", watermark.mainbar)
    watermark.Gradient.Rotation = 90
    watermark.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 10)) })

    watermark.Outline = Instance.new("Frame", watermark.mainbar)
    watermark.Outline.Name = "outline"
    watermark.Outline.ZIndex = 4
    watermark.Outline.BorderSizePixel = 0
    watermark.Outline.Visible = watermark.Visible
    watermark.Outline.BackgroundColor3 = library.theme.outlinecolor
    watermark.Outline.Position = UDim2.fromOffset(-1, -1)

    watermark.BlackOutline = Instance.new("Frame", watermark.mainbar)
    watermark.BlackOutline.Name = "blackline"
    watermark.BlackOutline.ZIndex = 3
    watermark.BlackOutline.BorderSizePixel = 0
    watermark.BlackOutline.BackgroundColor3 = library.theme.outlinecolor2
    watermark.BlackOutline.Visible = watermark.Visible
    watermark.BlackOutline.Position = UDim2.fromOffset(-2, -2)

    watermark.label = Instance.new("TextLabel", watermark.mainbar)
    watermark.label.Name = "FPSLabel"
    watermark.label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    watermark.label.BackgroundTransparency = 1.000
    watermark.label.Position = UDim2.new(-0.00268030656, 0, 0, 0)
    watermark.label.Size = UDim2.new(0, 238, 0, 25)
    watermark.label.Font = library.theme.font
    watermark.label.ZIndex = 6
    watermark.label.Visible = watermark.Visible
    watermark.label.Text = " ".. name .." | ".. gamename .." | 0 FPS"
    watermark.label.TextColor3 = Color3.fromRGB(255, 255, 255)
    watermark.label.TextSize = 15.000
    watermark.label.TextStrokeTransparency = 0.000
    watermark.label.TextXAlignment = Enum.TextXAlignment.Left
    watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+10, 0, 25)
    
    watermark.topbar = Instance.new("Frame", watermark.mainbar)
    watermark.topbar.Name = "TopBar"
    watermark.topbar.ZIndex = 6
    watermark.topbar.BackgroundColor3 = library.theme.accentcolor
    watermark.topbar.BorderSizePixel = 0
    watermark.topbar.Visible = watermark.Visible
    watermark.topbar.Size = UDim2.new(0, 0, 0, 1)

    watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 25)
    watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)
    watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
    watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)

    watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X+4, 0, 25)    
    watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+4, 0, 25)
    watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)
    watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
    watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)

    local startTime, counter, oldfps = os.clock(), 0, nil
    runservice.Heartbeat:Connect(function()
        watermark.label.Visible = watermark.Visible
        watermark.mainbar.Visible = watermark.Visible
        watermark.topbar.Visible = watermark.Visible
        watermark.Outline.Visible = watermark.Visible
        watermark.BlackOutline.Visible = watermark.Visible

        local currentTime = os.clock()
        counter = counter + 1
        if currentTime - startTime >= 1 then 
            local fps = math.floor(counter / (currentTime - startTime))
            counter = 0
            startTime = currentTime

            if fps ~= oldfps then
                watermark.label.Text = " " .. name .." | ".. gamename .." | " .. fps .." FPS"
    
                watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+10, 0, 25)
                watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 25)
                watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)

                watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
                watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)
            end
            oldfps = fps
        end
    end)

    watermark.mainbar.MouseEnter:Connect(function()
        tweenservice:Create(watermark.mainbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.topbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.label, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.Outline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        tweenservice:Create(watermark.BlackOutline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
    end)
    
    watermark.mainbar.MouseLeave:Connect(function()
        tweenservice:Create(watermark.mainbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.topbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.label, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.Outline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        tweenservice:Create(watermark.BlackOutline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
    end)

    return watermark
end
