local Player = game.Players.LocalPlayer
Character = game.Players.LocalPlayer.Character
Character.Humanoid:GetChildren()
local Mouse = Player:GetMouse()


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
golem = false
game:GetService("UserInputService").InputBegan:Connect(function(inputObject, gameProcessedEvent)
	if inputObject.KeyCode == Enum.KeyCode.E and golem == false then
		for i, v in pairs(Character.Humanoid:GetChildren()) do
			if v.Name ~= "BodyTypeScale" and v.Name ~= "BodyProportionScale" and v.Name ~= "Status" and v.Name ~= "Animator" then
				spawn(function()
					for i = 1, 2.025 , .025 do
						v.Value = i
						wait()
					end
				end)
			end 
		end
		local function Cube(part, x)
			local Block = Instance.new("Part")
			Block.Size = Vector3.new(math.random(4,6), math.random(4,6), math.random(4,6))
			Block.CanCollide = false
			Block.Transparency = 0
			Block.Anchored = true
			Block.Parent = Character
			Block.Size = Vector3.new(x,x,x)
			Block.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-8,8), -8, math.random(-8,8))
			Block.Color = Color3.fromRGB(86, 66, 54)
			Block.Material = Enum.Material.Slate
			for i = 1, 12 do
				Block.CFrame = Lerp(Block.CFrame, Character[part].CFrame * CFrame.fromOrientation(math.pi/math.random(2,4), math.pi/math.random(2,4), math.pi/math.random(2,4)),.25)
				wait()
			end
			local weld = Instance.new("Weld")
			weld.Part0 = Character[part]
			weld.Part1 = Block
			weld.Parent = Block
			weld.C1 = CFrame.fromOrientation(math.pi/math.random(2,6), math.pi/math.random(2,6), math.pi/math.random(2,6))
			Block.Anchored = false
		end
		spawn(function()
			for i, v in pairs(Character:GetChildren()) do
				spawn(function()
					if v:IsA"MeshPart" or v.Name == "Head" then
						spawn(function()
							for i = 0, 1, .1 do
								v.Transparency = i
								wait()
							end
						end)
					end
				end)
				
				spawn(function()
					if v:IsA"Accessory" then
						spawn(function()
							for i = 0, 1, .1 do
								v.Handle.Transparency = i
								wait()
							end
						end)
					end
				end)
			end
		end)
		spawn(function()
			spawn(function()
				--for i = 0,1 do
					Cube("RightHand", 1)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("LeftHand", 1)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("UpperTorso", 1.5)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("Head", 1.5)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("LowerTorso", 1)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("RightUpperArm", 1.5)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("LeftUpperArm", 1.5)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("LeftLowerLeg", 1)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("RightLowerLeg", 1)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("RightFoot", 1)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("LeftFoot", 1)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("LeftUpperLeg", 1.5)
				--end
			end)
			spawn(function()
				--for i = 0,1 do
					Cube("RightUpperLeg", 1.5)
				--end
			end)
		end)
		
		golem = true
	end
end)

game:GetService("UserInputService").InputBegan:Connect(function(inputObject, gameProcessedEvent)
	if inputObject.KeyCode == Enum.KeyCode.E and golem == true then
		spawn(function()
		for i, v in pairs(Character.Humanoid:GetChildren()) do
			if v.Name ~= "BodyTypeScale" and v.Name ~= "BodyProportionScale" and v.Name ~= "Status" and v.Name ~= "Animator" then
				spawn(function()
					for i = 2.025,  1, -.025 do
						v.Value = i
						wait()
					end
				end)
			end 
		end
		end)
		
		spawn(function()
			for i, v in pairs(Character:GetChildren()) do
				spawn(function()
					if v:IsA"MeshPart" or v.Name == "Head" then
						spawn(function()
							for i = 1, 0, -.1 do
								print(i)
								v.Transparency = i
								wait()
								
							end
							--v.Transparency = 1
						end)
					end
				end)
				spawn(function()
					if v:IsA"Accessory" then
						spawn(function()
							for i = 1, 0, -.1 do
								v.Handle.Transparency = i
								wait()
							end
						end)
					end
				end)
			end
		end)
		wait()
		spawn(function()
			for i, v in pairs(Character:GetChildren()) do
				spawn(function()
					if v.Name == "Part" then
						spawn(function()
							for i = 0, 1, .1 do
								v.Transparency = i
								wait(.2)
								
							end
							--v.Transparency = 1
						end)
					end
				end)
			end
		end)
		
		wait(1.5)
		for i, v in pairs(Character:GetChildren()) do
			if v.Name == "Part" then
				spawn(function()
					v.Weld:Destroy()
				end)
			end
		end
		golem = false
	end
end)
