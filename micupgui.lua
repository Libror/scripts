local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
local humanoid = game.Players.LocalPlayer.Character.Humanoid
local userInputService = game:GetService("UserInputService")

local specificSpeed

local speed = 100
local c
local h
local bv
local bav
local cam
local flying
local flyActive = false
local p = game.Players.LocalPlayer
local buttons = {W = false, S = false, A = false, D = false, Moving = false}


local vipTP = CFrame.new(2888.17627, 861.684998, -697.091309, -0.999878109, -1.58851901e-08, -0.0156148029, -1.53734643e-08, 1, -3.28918723e-08, 0.0156148029, -3.26478116e-08, -0.999878109)
local buildingTopTP = CFrame.new(3058.26465, 873.509033, -859.647705, 0.000408259017, 6.17173299e-08, -0.99999994, 9.06058695e-09, 1, 6.17210318e-08, 0.99999994, -9.08578457e-09, 0.000408259017)
local spawnTP = CFrame.new(2888.46606, 840.174866, -720.33728, 0.999905288, -4.03720826e-08, -0.0137612913, 4.12697432e-08, 1, 6.49467964e-08, 0.0137612913, -6.55085728e-08, 0.999905288)
local valkTP = CFrame.new(2960.62646, 1674.97192, -723.46991, 0.155404598, -9.08132947e-08, -0.987850904, -4.32003375e-08, 1, -9.87262609e-08, 0.987850904, 5.80180064e-08, 0.155404598)
local voidCrownTP = CFrame.new(2496.66138, 839.720154, -894.216919, 0.955821216, 3.93281532e-08, 0.293948591, -3.11058521e-08, 1, -3.26469305e-08, -0.293948591, 2.20611085e-08, 0.955821216)
local blackHornsTP = CFrame.new(1246.63647, 841.983032, -953.3927, -0.0346181951, -7.10001729e-08, 0.999400616, 2.06778594e-09, 1, 7.11143784e-08, -0.999400616, 4.5283981e-09, -0.0346181951)
local moonCrownTP = CFrame.new(3429.53833, 877.11499, -791.205383, -0.000257236301, 6.01850942e-08, -0.99999994, 5.28681454e-08, 1, 6.01715016e-08, 0.99999994, -5.28526662e-08, -0.000257236301)
local emporerCrownTP = CFrame.new(2615.81909, 940.692444, -653.314453, 0.0555151962, 2.47452947e-09, 0.998457849, 2.01401313e-08, 1, -3.59816177e-09, -0.998457849, 2.03088248e-08, 0.0555151962)


--Willy V3 GUI by Aika--

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua')))()

local w = library:CreateWindow("Mic UP GUI") -- Creates the window

local b = w:CreateFolder("Controls") -- Creates the folder(U will put here your buttons,etc)
local t = w:CreateFolder("TPs")

--General Menu--

b:Button("Toggle Fly",function()
    flytogl()
end)

b:Bind("Fly Bind",Enum.KeyCode.Y,function() --Default bind
	flytogl()
end)

b:Button("Destroy AFK Script",function()
    toggleAFK()
end)

b:Box("Specific Speed", "number",function(value) --Default bind
	specificSpeed = value
end)

b:Button("Use specific speed",function() --Default bind
	humanoid.WalkSpeed = specificSpeed
end)

b:Button("Default speed",function() --Default bind
	humanoid.WalkSpeed = 16
end)

b:Button("Faster",function() --Default bind
	humanoid.WalkSpeed = humanoid.WalkSpeed + 16
end)

b:Button("Slower",function() --Default bind
	humanoid.WalkSpeed = humanoid.WalkSpeed - 16
end)

b:Button("Restart Game",function() --Default bind
	p = game:GetService("Players").LocalPlayer
	game:GetService("TeleportService"):Teleport(game.PlaceId, p)
end)


--Teleports--

t:Button("Spawn", function()
	pl.CFrame = spawnTP
end)

t:Button("VIP", function()
	pl.CFrame = vipTP
end)

t:Button("Top of Building", function()
	pl.CFrame = buildingTopTP
end)

t:Button("Valkyrie", function()
	pl.CFrame = valkTP
end)

t:Button("Void Crown", function()
	pl.CFrame = voidCrownTP
end)

t:Button("Moon Crown", function()
	pl.CFrame = moonCrownTP
end)

t:Button("Emporer Crown", function()
	pl.CFrame = emporerCrownTP
end)

t:Button("Black Horns", function()
	pl.CFrame = blackHornsTP
end)

--FLY SCRIPT BY RGEENEUS--
--https://pastebin.com/WtpHYdUt--

local startFly = function ()
	if not p.Character or not p.Character.Head or flying then return end
	c = p.Character
	h = c.Humanoid
	h.PlatformStand = true
	cam = workspace:WaitForChild('Camera')
	bv = Instance.new("BodyVelocity")
	bav = Instance.new("BodyAngularVelocity")
	bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
	bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
	bv.Parent = c.Head
	bav.Parent = c.Head
	flying = true
	h.Died:connect(function() flying = false end)
end

local endFly = function ()
	if not p.Character or not flying then return end
	h.PlatformStand = false
	bv:Destroy()
	bav:Destroy()
	flying = false
end

userInputService.InputBegan:Connect(function(input, GPE)
    if GPE then return end
	for i, e in pairs(buttons) do
		if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
			buttons[i] = true
			buttons.Moving = true
		end
	end
end)

game:GetService("UserInputService").InputEnded:connect(function (input, GPE) 
	if GPE then return end
	local a = false
	for i, e in pairs(buttons) do
		if i ~= "Moving" then
			if input.KeyCode == Enum.KeyCode[i] then
				buttons[i] = false
			end
			if buttons[i] then a = true end
		end
	end
	buttons.Moving = a
end)


local setVec = function (vec)
	return vec * (speed / vec.Magnitude)
end

function flytogl()
	if flytoggle == true then
		flytoggle = false
	else
		flytoggle = true
		startFly()
		repeat
			wait(0.001)
		until flytoggle == false
		endFly()
	end
end

game:GetService("RunService").Heartbeat:connect(function (step) -- The actual fly function, called every frame


	if flying and c and c.PrimaryPart then
		local p = c.PrimaryPart.Position
		local cf = cam.CFrame
		local ax, ay, az = cf:toEulerAnglesXYZ()
		c:SetPrimaryPartCFrame(CFrame.new(p.x, p.y, p.z) * CFrame.Angles(ax, ay, az))
		if buttons.Moving then
			local t = Vector3.new()
			if buttons.W then t = t + (setVec(cf.lookVector)) end
			if buttons.S then t = t - (setVec(cf.lookVector)) end
			if buttons.A then t = t - (setVec(cf.rightVector)) end
			if buttons.D then t = t + (setVec(cf.rightVector)) end
			c:TranslateBy(t * step)
		end
	end
end)

--Destroys the AFK script that makes you transparent--

function toggleAFK()
	local afkScript = game.Players.LocalPlayer.PlayerScripts.AFKLocalScript
	afkScript:Destroy()
end
