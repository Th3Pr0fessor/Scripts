--[[

Client

--]]
local replicatedstorage = game.ReplicatedStorage
local planet = replicatedstorage:FindFirstChild("Planetary")
local player = game.Players.LocalPlayer
local Mouse = player:GetMouse()
game:GetService("UserInputService").InputBegan:Connect(function(inputObject, gameProcessedEvent)
	if inputObject.KeyCode == Enum.KeyCode.Z then
		local pos = Mouse.Hit 
		planet:FireServer(pos)
	end
end)
--[[

Server

--]]
 function Lerp(a, b, t)
    local qa = {
        QuaternionFromCFrame(a)
    }
    local qb = {
        QuaternionFromCFrame(b)
    }
    local ax, ay, az = a.x, a.y, a.z
    local bx, by, bz = b.x, b.y, b.z
    local _t = 1 - t
    return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
local Lerp = CFrame.new().lerp
function QuaternionFromCFrame(cf)
    local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
    local trace = m00 + m11 + m22
    if trace > 0 then
        local s = math.sqrt(1 + trace)
        local recip = 0.5 / s
        return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
    else
        local i = 0
        if m00 < m11 then
            i = 1
        end
        if i == 0 and m00 or m11 < m22 then
            i = 2
        end
        if i == 0 then
            local s = math.sqrt(m00 - m11 - m22 + 1)
            local recip = 0.5 / s
            return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
        elseif i == 1 then
            local s = math.sqrt(m11 - m22 - m00 + 1)
            local recip = 0.5 / s
            return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
        elseif i == 2 then
            local s = math.sqrt(m22 - m00 - m11 + 1)
            local recip = 0.5 / s
            return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
        end
    end
end
function QuaternionToCFrame(px, py, pz, x, y, z, w)
    local xs, ys, zs = x + x, y + y, z + z
    local wx, wy, wz = w * xs, w * ys, w * zs
    local xx = x * xs
    local xy = x * ys
    local xz = x * zs
    local yy = y * ys
    local yz = y * zs
    local zz = z * zs
    return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end
function QuaternionSlerp(a, b, t)
    local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
    local startInterp, finishInterp
    if cosTheta >= 1.0E-4 then
        if 1 - cosTheta > 1.0E-4 then
            local theta = math.acos(cosTheta)
            local invSinTheta = 1 / math.sin(theta)
            startInterp = math.sin((1 - t) * theta) * invSinTheta
            finishInterp = math.sin(t * theta) * invSinTheta
        else
            startInterp = 1 - t
            finishInterp = t
            if 1 + cosTheta > 1.0E-4 then
                local theta = math.acos(-cosTheta)
                local invSinTheta = 1 / math.sin(theta)
                startInterp = math.sin((t - 1) * theta) * invSinTheta
                finishInterp = math.sin(t * theta) * invSinTheta
            else
                startInterp = t - 1
                finishInterp = t
                return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
            end
        end
    end
end

--script.Parent:WaitForChild("LerpModule")



local function Block(part)
				local sizes = {-6,-5,-4,-3,-2,	-1,	0,	1,	2,	4,	5,	6}
				local a = sizes[math.random(7,12)]
				local b = sizes[math.random(7,12)]
				local c = sizes[math.random(7,12)]
				local dir = {-1, 1}
				local Cube = Instance.new("Part")
				Cube.Touched:Connect(function(part)
				--print(part.Parent)
				if part.Parent:FindFirstChildOfClass("Humanoid") then
					local Hum = part.Parent:FindFirstChildOfClass("Humanoid")
					Hum.Health = Hum.Health - 10
				else
					return
				end
			end)
				Cube.Material = Enum.Material.Slate
				--Cube.Anchored = true
				Cube.CanCollide = false
				Cube.Color = Color3.fromRGB(86, 66, 54)
				Cube.Size = Vector3.new(5, 4, 5)
				Cube.Position = part.Position
				--Cube.CFrame = mouse.Hit
				Cube.Parent = part
				spawn(function()
					for i = 0, 1.05, .05 do
						Cube.Transparency = i
						wait()
					end
				end)
				
				for i = 1, 75 do
					Cube.CFrame = Lerp(Cube.CFrame, Cube.CFrame *CFrame.new(a, b, c) * CFrame.fromOrientation(dir[math.random(1,2)] * math.pi/math.random(1,4),	dir[math.random(1,2)] * math.pi/math.random(1,4),	dir[math.random(1,2)] * 	math.pi/math.random(1,4)),.25)
					wait()
				end
				
			end



local function ShockWave(CF, Part, x ,y ,z, t, name)
	local Shock = game.ReplicatedFirst:FindFirstChild(name):Clone()
	Shock.CFrame = CF * CFrame.fromOrientation(x, y, z)
	Shock.Anchored = true
	Shock.CanCollide = false
	Shock.Size = Vector3.new(1,1,1)
	Shock.Parent = Part
	Shock.Material = Enum.Material.Neon
	Shock.Color = Color3.fromRGB(255,255,255)
	local Smesh = Instance.new("SpecialMesh")
	Smesh.MeshId = "rbxassetid://471124075"
	Smesh.Scale = Vector3.new(0,0,0)
	--Smesh.Parent = Shock
	spawn(function()
		for i = 0, 25 do
			Shock.Size = Shock.Size + Vector3.new(t,0,t) 
			wait()
		end
		
	end)
	spawn(function()
		for i = 0, 1.075 , .075 do
			Shock.Transparency = i
			wait()
		end
		Shock:Destroy()
	end)
end
local function Explosion(r,g,b,CF,t)
	local explo = Instance.new("Part")
	explo.Shape = Enum.PartType.Ball
	explo.Color = Color3.fromRGB(r,g,b)
	explo.CFrame = CF
	explo.Parent = game.Workspace
	explo.CanCollide = false
	explo.Anchored = true
	explo.Material = Enum.Material.Neon
	explo.Name = "Explosion"
	spawn(function()
		for i = 0, 50 do
			explo.Size = explo.Size + Vector3.new(t, t, t)
			wait()
		end
		
	end)
	spawn(function()
		for i = 0, 1.075, .075 do
			explo.Transparency = i
			wait()
		end
		explo:Destroy()
	end)
	ShockWave(explo.CFrame , explo, 0, 0, math.pi/2, 4, "Ring")
	ShockWave(explo.CFrame ,explo, 0, math.pi/2, 0, 4, "Ring")
	ShockWave(explo.CFrame, explo, math.pi/2, 0, 0, 4, "Ring")
	ShockWave(explo.CFrame , explo, 0, 0, math.rad(90), 5, "Shockwave")
end





--LerpMod = require(script.Parent:FindFirstChild("LerpModule"))

local ReplicatedStorage = game:FindFirstChild("ReplicatedStorage")
local ET1 = ReplicatedStorage:FindFirstChild("ET1")

local animations = {2691043874}

ET1.OnServerEvent:Connect(function(plr, mouse)
		local character = plr.Character
		local Pos = mouse
		local Rock = Instance.new("Part")
		local humanoid = character.Humanoid
		local Touched = false
		local numbers = {6}
		local x = numbers[math.random(1,2)]
		Rock.CFrame = character.HumanoidRootPart.CFrame *CFrame.new(0,-6,-8) *CFrame.fromOrientation(0,math.pi,-math.pi/2)
		Rock.Shape = Enum.PartType.Cylinder
		Rock.Anchored = true
		Rock.Parent = game.Workspace
		Rock.Size = Vector3.new(1, 4.2, 4)
		Rock.CanCollide = false
		Rock.Material = Enum.Material.Slate
		Rock.Color = Color3.fromRGB(86, 66, 54)
		Rock.Touched:Connect(function(part)
				--print(part)
				if part.Parent:FindFirstChildOfClass("Humanoid") then
					local Hum = part.Parent:FindFirstChildOfClass("Humanoid")
					if Hum.Parent == plr.Character then return
					else
						Hum.Health = Hum.Health - 10
					end
				else
					return
				end
			end)
		print(x)
		local animation = Instance.new("Animation")
		local picked = math.random(1, #animations)
		animation.AnimationId = "http://roblox.com/asset/?id="..animations[picked]
		local animTrack = humanoid:LoadAnimation(animation)
		animTrack:Play()
		wait(.5)
			for i = 1, 40 do
				Rock.CFrame = Lerp(Rock.CFrame, character.HumanoidRootPart.CFrame *CFrame.new(0, 5,-8) *CFrame.fromOrientation(0,math.pi,-math.pi/2), .25)
				wait()
			end
			wait(.5)
			spawn(function()
				ShockWave(Rock.CFrame, Rock, math.pi/2, 0, 0, 2, "Ring")
			end)
			
			for i = 1, 12 do
				Rock.CFrame = Lerp(Rock.CFrame, Pos *CFrame.fromOrientation(0,math.pi,-math.pi/2), .1)
				wait()
			end
			--spawn(function()
				for i = 1,5 do
					spawn(function()
						Block(Rock)
					end)
				end
			--end
			spawn(function()
				Explosion(90, 76, 66, Rock.CFrame, 4)
			end)
		--end)
		spawn(function()
					for i = 0, 1.05, .05 do
						Rock.Transparency = i
						wait()
					end
					Rock:Destroy()
				end)
end)
