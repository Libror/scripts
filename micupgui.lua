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


local vipTP = CFrame.new(2888.17627, 861.684998, -697.091309)
local buildingTopTP = CFrame.new(3058.26465, 873.509033, -859.647705)
local spawnTP = CFrame.new(2888.46606, 840.174866, -720.33728)
local valkTP = CFrame.new(2960.62646, 1674.97192, -723.46991)
local voidCrownTP = CFrame.new(2496.66138, 839.720154, -894.216919)
local blackHornsTP = CFrame.new(1246.63647, 841.983032, -953.3927)
local moonCrownTP = CFrame.new(3429.53833, 877.11499, -791.205383)
local emporerCrownTP = CFrame.new(2615.81909, 940.692444, -653.314453)


--TwinkLib by twink marie--

local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

local MainUI = UILibrary.Load("Mic Up GUI")
local FirstPage = MainUI.AddPage("General", false)
local SecondPage = MainUI.AddPage("TPs", false)

FirstPage.AddButton("Toggle Fly", function()
    flytogl()
end)

FirstPage.AddLabel("Press Y to fly")

FirstPage.AddButton("Destroy AFK script", function()
    toggleAFK()
end)

FirstPage.AddSlider("Specific speed", {Min = 0, Max = 250, Def = 100}, function(value)
    specificSpeed = value
end)

FirstPage.AddLabel("Change the slider value once so it updates")

FirstPage.AddButton("Use specific speed", function()
    humanoid.WalkSpeed = specificSpeed
end)

FirstPage.AddButton("Default speed", function()
    humanoid.WalkSpeed = 16
end)

FirstPage.AddButton("Faster", function()
    humanoid.WalkSpeed = humanoid.WalkSpeed + 16
end)

FirstPage.AddButton("Slower", function()
    humanoid.WalkSpeed = humanoid.WalkSpeed - 16
end)

FirstPage.AddButton("Restart game", function()
    p = game:GetService("Players").LocalPlayer
	game:GetService("TeleportService"):Teleport(game.PlaceId, p)
end)

SecondPage.AddButton("Spawn", function()
    pl.CFrame = spawnTP
end)

SecondPage.AddButton("VIP", function()
    pl.CFrame = vipTP
end)

SecondPage.AddButton("Top of building", function()
    pl.CFrame = buildingTopTP
end)

SecondPage.AddButton("Valkyrie", function()
    pl.CFrame = valkTP
end)

SecondPage.AddButton("Void Crown", function()
    pl.CFrame = voidCrownTP
end)

SecondPage.AddButton("Moon Crown", function()
    pl.CFrame = moonCrownTP
end)

SecondPage.AddButton("Emporer Crown", function()
    pl.CFrame = emporerCrownTP
end)

SecondPage.AddButton("Black Horns", function()
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

	if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Y then
            flytogl()
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
