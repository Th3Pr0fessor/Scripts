Fire = Instance.new("RemoteEvent")
Fire.Parent = game.ReplicatedStorage--:WaitForChild("ReplicatedStorage")
Fire.Name = "FireEvent"
Aimer = Instance.new("RemoteEvent")
Aimer.Parent = game.ReplicatedStorage--:WaitForChild("ReplicatedStorage")
Aimer.Name = "Aiming"
Creation = Instance.new("RemoteEvent")
Creation.Parent = game.ReplicatedStorage--:WaitForChild("ReplicatedStorage")
Creation.Name = "Creation"
local RunService = game:GetService("RunService")
local Run = RunService.Heartbeat
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



local RunService = game:GetService("RunService")
local Run = RunService.Heartbeat
Aimer.OnServerEvent:Connect(function(Player, Hit)
	local ready = true
	local radian = math.rad
	local random = math.random
	local Vec3 = Vector3.new
	local Inst = Instance.new
	local cFrame = CFrame.new
	local Euler = CFrame.fromEulerAnglesXYZ
	local cam = game.Workspace.CurrentCamera
	local pt = Player.Character.LowerTorso
	
	pt.Anchored = true
	pt.Parent.Animate.Disabled = true
	Click = true
	spawn(function()
		if Click then
			pt.CFrame = CFrame.new(pt.CFrame.p,Hit) * CFrame.fromOrientation(0,math.rad(90),0)
			wait()	
		end
	end)
end)
Creation.OnServerEvent:Connect(function(Player, Hit)
	Boom = false
	local blast
	local pt = Player.Character.LowerTorso

	if not Player.Character:FindFirstChild(Player.Character.Name.."Blast") and not Boom then
		blast = Instance.new("Part")
		blast.Material = Enum.Material.Neon
		blast.Size = Vector3.new(.1,.1,.1)
		blast.Color = Color3.fromRGB(255, 89, 89)
		blast.CFrame = pt.Parent.RightHand.CFrame
		blast.Shape = Enum.PartType.Ball
		blast.CanCollide = false
		blast.Anchored = true
		blast.Name = Player.Character.Name.."Blast"
		Lens = game.ReplicatedFirst.Blast:Clone()
		Lens.Parent = blast
		wait()
		blast.Parent = pt.Parent
	end
	spawn(function()
		--while Click do
		if Click and blast ~= nil then
			Boom = true
			blast.CFrame = Lerp(blast.CFrame, pt.Parent.RightHand.CFrame * CFrame.new(0,-1,0), 1)
		end
	end)

	Fire.OnServerEvent:Connect(function(plr, Mouse, cam)
		if plr ~= Player or blast == nil then return end
		Boom = true
		function CameraEnshaking(Length,Intensity)
			local radian = math.rad
			local random = math.random
			local Vec3 = Vector3.new
			local Inst = Instance.new
			local cFrame = CFrame.new
			local Euler = CFrame.fromEulerAnglesXYZ
			local hum = plr.Character.Humanoid
			coroutine.resume(coroutine.create(function()
				local intensity = 1*Intensity
				local rotM = 0.01*Intensity
				for i = 0, Length, 0.1 do
					Run:Wait()
					intensity = intensity - 0.05*Intensity/Length
					rotM = rotM - 0.0005*Intensity/Length
					hum.CameraOffset = Vec3(radian(random(-intensity, intensity)), radian(random(-intensity, intensity)), radian(random(-intensity, intensity)))
					cam = cam * cFrame(radian(random(-intensity, intensity)), radian(random(-intensity, intensity)), radian(random(-intensity, intensity))) * Euler(radian(random(-intensity, intensity)) * rotM, radian(random(-intensity, intensity)) * rotM, radian(random(-intensity, intensity)) * rotM)
				end
			hum.CameraOffset = Vec3(0, 0, 0)
			end))
		end
		function Part(N, x, y, z, CF)
			local Ring = game.ReplicatedStorage.FireFolder[N]:Clone()
			Ring.Size = Vector3.new(1,1,1)
			Ring.Anchored = true
			Ring.CanCollide = false
			Ring.CFrame = CF
			Ring.Size = Vector3.new(0,.01,0)
			Ring.Parent = game.Workspace
			wait()
			
			--spawn(function()
			for i = 1, 10 do
				Ring.Size = Ring.Size + Vector3.new(x, y, z)
				Run:Wait()
			end
		--end)
			wait(.5)
			spawn(function()
				for i = 0, 1, .05 do
					Ring.Transparency = i
					wait()
				end
				Ring:Destroy()
			end)		
		end
	
		local function Boom(A, B, C, D, E, F, CF1, CF2)
			CameraEnshaking(7, 5)
			spawn(function()
				for i = 1, A do
					spawn(function()
						Part("NeonRed2", 2, 2, 2, CF1 * CFrame.fromOrientation(math.rad(math.random(-360,360)), math.rad(math.random(-360,360)), math.rad(math.random(-360,360))))--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.fromOrientation(math.rad(math.random(-360,360)), math.rad(math.random(-360,360)), math.rad(math.random(-360,360)))
					end)
				end
			end)
			spawn(function()
				for i = 1, B do
					spawn(function()
						Part("NeonRed", 2, 2, 2, CF2 * CFrame.fromOrientation(math.rad(math.random(-45,45)), math.rad(math.random(-45,45)), math.rad(math.random(-45,45))) * CFrame.new(math.random(-1,1),0,math.random(-1,1)))--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.fromOrientation(math.rad(math.random(-45,45)), math.rad(math.random(-45,45)), math.rad(math.random(-45,45))) * CFrame.new(math.random(-15,15),0,math.random(-15,15))
					end)
				end
			end)	
			spawn(function()
				for i = 1, C do
					spawn(function()
						Part("BlackSmoke", 2, 2, 2, CF2 * CFrame.fromOrientation(math.rad(math.random(-45,45)), math.rad(math.random(-45,45)), math.rad(math.random(-45,45))) * CFrame.new(math.random(-3,3),0,math.random(-3,3)))--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.fromOrientation(math.rad(math.random(-45,45)), math.rad(math.random(-45,45)), math.rad(math.random(-45,45))) * CFrame.new(math.random(-15,15),0,math.random(-15,15))
					end)
				end
			end)
			spawn(function()
				for i = 1, D do
					spawn(function()
						Part("YellowNeon", 2, 2, 2, CF2 * CFrame.fromOrientation(math.rad(math.random(-45,45)), math.rad(math.random(-45,45)), math.rad(math.random(-45,45))) * CFrame.new(math.random(-1,1),0,math.random(-1,1)))--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.fromOrientation(math.rad(math.random(-45,45)), math.rad(math.random(-45,45)), math.rad(math.random(-45,45))) * CFrame.new(math.random(-15,15),0,math.random(-15,15))
					end)
				end
			end)
			spawn(function()
				for i = 1, D do
					spawn(function()
						Part("YellowNeon", 2, 2, 2, CF2 * CFrame.fromOrientation(math.rad(math.random(-45,45)), math.rad(math.random(-45,45)), math.rad(math.random(-45,45))) * CFrame.new(math.random(-1,1),0,math.random(-1,1)))--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.fromOrientation(math.rad(math.random(-45,45)), math.rad(math.random(-45,45)), math.rad(math.random(-45,45))) * CFrame.new(math.random(-15,15),0,math.random(-15,15))
					end)
				end
			end)
		end
		local ready = true
		local Player = plr 
		local char = plr.Character
		local hum = char.Humanoid
		local radian = math.rad
		local random = math.random
		local Vec3 = Vector3.new
		local Inst = Instance.new
		local cFrame = CFrame.new
		local Euler = CFrame.fromEulerAnglesXYZ
		local cam = game.Workspace.CurrentCamera
		Click = false
		if ready then
			local x = Mouse
			Lens:Destroy()
			Click = false
			wait()
			spawn(function()
				for i = 1, 12 do
					blast.CFrame = Lerp(blast.CFrame, x, .2)
					wait()
				end
				wait()
				spawn(function()
					--exlpo(blast, "White", 0, 0, 0)
					Boom(5, 2, 5, 2, 2, 5, blast.CFrame, blast.CFrame)
				end)
			end)
		
		
			spawn(function()
				for i = 0, 5 do
					blast.Size = blast.Size + Vector3.new(1,1,1)
					wait()
				end
				blast:Destroy()
			end)
			wait(1)
			pt.Anchored = false
			pt.Parent.Animate.Disabled = false
			ready = false
		end
	end)
end)
