--[[
Fly Script v1.0
Copyright (c) 2025 [realjaafan/911isgoo7]. Licensed under MIT.
--]]

-- --- Variables ---
local rs = game:GetService("RunService")

local flying = false

local uis = game:GetService("UserInputService")

local plr = game.Players.LocalPlayer

local chr = plr.Character or plr.CharacterAdded:Wait()

local hrp = chr:WaitForChild("HumanoidRootPart")

local hum = chr:WaitForChild("Humanoid")

local cam = workspace.CurrentCamera

local speed = 100


-- --- MOVEMENT FUNCTIONS ---
local function Flyw()
    hrp.Velocity = cam.CFrame.LookVector * speed
end

local function Flys()
    hrp.Velocity = (cam.CFrame.LookVector * speed) * -1
end

local function Flyd()
    hrp.Velocity = cam.CFrame.RightVector * speed
end

local function Flya()
    hrp.Velocity = (cam.CFrame.RightVector * speed) * -1
end


-- --- The Switch ---
uis.InputBegan:Connect(function(inp, gpe)

    if gpe then return end

    if inp.KeyCode == Enum.KeyCode.F then

        if flying then

            flying = false
            hum.PlatformStand = false
            hrp.CanCollide = true
            hrp.Anchored = false
            hrp.AssemblyLinearVelocity = Vector3.new(0, 20, 0)

        else

            flying = true
            hum.PlatformStand = true
            hrp.CanCollide = false
            hrp.Anchored = true
            
        end
    end
end)


-- --- The Engine ---
rs.Heartbeat:Connect(function(deltaTime)

    if not flying then
        return
    end
    
    local moveVector = Vector3.new(0, 0, 0)
    local pressed = false
    
    if uis:IsKeyDown(Enum.KeyCode.W) then
        moveVector = moveVector + cam.CFrame.LookVector
        pressed = true
    end
    
    if uis:IsKeyDown(Enum.KeyCode.S) then
        moveVector = moveVector - cam.CFrame.LookVector
        pressed = true
    end
    
    if uis:IsKeyDown(Enum.KeyCode.D) then
        moveVector = moveVector + cam.CFrame.RightVector
        pressed = true
    end
    
    if uis:IsKeyDown(Enum.KeyCode.A) then
        moveVector = moveVector - cam.CFrame.RightVector
        pressed = true
    end
    
    if uis:IsKeyDown(Enum.KeyCode.E) then
        moveVector = moveVector + cam.CFrame.UpVector
        pressed = true
    end
    
    if uis:IsKeyDown(Enum.KeyCode.Q) then
        moveVector = moveVector - cam.CFrame.UpVector
        pressed = true
    end
    
    if moveVector.Magnitude > 0 then
        local moveStep = moveVector.Unit * speed * deltaTime
        hrp.CFrame = hrp.CFrame + moveStep
    end
    
    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)
    
    if not pressed then
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
    
end)
