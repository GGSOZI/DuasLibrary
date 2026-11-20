-- Laser Eyes (client) | emitters rebuilt from Dua's VFX logger, made longer + bigger
-- Equip the "Laser Eyes" tool and hold click/tap (or E): eyes charge, then fire a red laser at your mouse / screen centre.
-- NPCs hit by the laser catch fire, lose health, then die (network-ownership trick, needs sethiddenproperty).

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local cam = workspace.CurrentCamera

local CFG = {
	Key = Enum.KeyCode.E,
	ChargeTime = 1.5,    -- seconds of charge before firing
	MaxFire = 6,         -- seconds you can fire per use
	Range = 600,
	GroundFX = true,     -- debris flies where the laser hits the ground (client-side, only you see it)
	DebrisMax = 70,      -- max debris parts alive at once (lower if it lags)
	PebbleEvery = 0.07,  -- seconds between pebble bursts that follow the beam
	PebbleCount = 3,
	ChunkEvery = 0.45,   -- min seconds between big-chunk bursts (they only fire when the beam hits a new surface)
	Cooldown = 2,        -- seconds before you can fire again after a use
	FireLoopFrom = 0.4,  -- when the fire sound ends, it restarts from this fraction of its length (not from 0)
	AimSmooth = 5,       -- laser follow delay: lower = slower/laggier follow, higher = snappier
	LifeMult = 2.5,      -- particle lifetime multiplier (longer)
	EyeScale = 0.12,     -- emitter size at the eyes (originals are huge, e.g. ChargeFire = 60)
	BeamWidth = 3,
	KillNPCs = true,
	KillRadius = 8,
	KillTime = 2.5,      -- seconds of laser contact before an NPC dies (it burns + loses health meanwhile)
	BurnLinger = 4,      -- fire stays on the NPC this long after you stop hitting it
	SimRadius = 1000,    -- simulation radius while firing, restored afterwards
	ShakeCharge = 0.12,  -- camera shake at the end of the charge
	ShakeFire = 0.45,    -- camera shake while firing
	BeamRadius = 4,      -- NPC hit radius along the whole beam
	BeamStep = 8,        -- studs between beam damage checks
	MaxPower = 2.5,      -- power multiplier after holding the laser for PowerRamp seconds (wider beam, faster burn)
	PowerRamp = 4,
	FovZoom = 10,        -- FOV zoom-in while charging
}

-- Impact-point emitter sizes. Flare (the streak/line one) is kept at its ORIGINAL size (1); the rest are bigger.
local HIT_SCALE = { Aura = 3.5, Heat = 3, Flash = 3, Flash2 = 3, Almost = 3, Flare = 1 }

-- Charge = your first logger paste. Fire = the Superman Laser Eyes asset you linked.
local SOUNDS = { Fire = 18506093197, Hit = nil }
-- Charge sounds are tried in order; the first one that loads is used. 107571923469306 is private for you,
-- so add public ids after it. If none load, the fire sound is played with a rising pitch as the charge-up.
local CHARGE_IDS = { 107571923469306 }

----------------------------------------------------------------------
-- Emitter specs (from your logger scripts)
----------------------------------------------------------------------
local RED = ColorSequence.new(Color3.new(1, 0, 0))
local SOLID = { { 0, 0 }, { 1, 0 } }
local FADE = { { 0, 0 }, { 1, 1 } }
local E = Enum

local SPEC = {
	Aura = { tex = "rbxassetid://15269497616", rate = 200, life = { 0.5, 0.75 }, speed = { 0.1, 5 },
		size = { { 0, 0 }, { 0.1035, 0.578 }, { 0.2531, 2.109 }, { 0.48, 2.823 }, { 0.7531, 2.075 }, { 1, 1.001 } },
		color = RED, trans = SOLID, rot = { -360, 360 }, rotspeed = { -400, 400 }, spread = 360, le = 0, locked = true,
		z = 0, orient = E.ParticleOrientation.VelocityPerpendicular, bright = 6,
		fb = { E.ParticleFlipbookLayout.Grid4x4, E.ParticleFlipbookMode.OneShot, { 10, 20 }, true } },
	Almost = { tex = "rbxassetid://90520792878218", rate = 15, life = { 0.2, 0.5 }, speed = { 0.003, 0.003 },
		size = { { 0, 0 }, { 0.1, 0.59 }, { 0.2, 0.91 }, { 0.3, 1.17 }, { 0.5, 1.6 }, { 0.7, 1.92 }, { 0.9, 2.11 }, { 1, 2.15 } },
		color = ColorSequence.new(Color3.new(1, 0.031, 0.031)),
		trans = { { 0, 0 }, { 0.543, 0 }, { 0.712, 0.7 }, { 1, 1 } }, rot = { -360, 360 }, spread = 120, le = 0,
		locked = true, z = -1, orient = E.ParticleOrientation.VelocityParallel, bright = 100,
		fb = { E.ParticleFlipbookLayout.Grid4x4, E.ParticleFlipbookMode.OneShot, { 5.94, 5.94 }, false } },
	ChargeA = { tex = "rbxassetid://18461488917", rate = 40, life = { 0.15, 0.2 }, speed = { 0, 0 },
		size = { { 0, 5 }, { 1, 0 } }, color = RED, trans = { { 0, 1 }, { 1, 0 } }, rot = { -360, 360 }, spread = 0,
		drag = 2, le = 1, li = 0.1, locked = true, orient = E.ParticleOrientation.FacingCamera, bright = 15 },
	ChargeB = { tex = "rbxassetid://18461488917", rate = 40, life = { 0.15, 0.2 }, speed = { 4, 4 },
		size = { { 0, 28 }, { 0.2485, 25.5 }, { 0.5845, 18.3 }, { 1, 0 } }, color = RED,
		trans = { { 0, 1 }, { 1, 0 } }, rot = { -360, 360 }, spread = 1, drag = 2, le = 1, li = 0.1, locked = true,
		orient = E.ParticleOrientation.FacingCamera, bright = 15 },
	ChargeFire = { tex = "rbxassetid://1053548563", rate = 100, life = { 0.16, 0.16 }, speed = { 0.01, 0.01 },
		size = { { 0, 60 }, { 1, 60 } }, color = RED, trans = FADE, rot = { -360, 360 }, spread = 360, le = 1,
		locked = false, orient = E.ParticleOrientation.VelocityPerpendicular, bright = 5,
		squash = { { 0, -3 }, { 1, 0 } } },
	Flare = { tex = "http://www.roblox.com/asset/?id=5192965045", rate = 20, life = { 2, 2 }, speed = { 0, 0 },
		size = { { 0, 2 }, { 1, 2 } },
		color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
		trans = SOLID, le = 1, locked = true, z = 3, orient = E.ParticleOrientation.FacingCamera, bright = 5,
		squash = { { 0, 0 }, { 0.21, -6.89 }, { 0.51, -9.9 }, { 1, -11.56 } } },
	Flash = { tex = "rbxassetid://12993580758", rate = 50, life = { 0.0155, 0.031 }, lm = 8, speed = { 0.002, 0.002 },
		size = { { 0, 0 }, { 0.1, 0.63 }, { 0.2, 1.22 }, { 0.3, 1.77 }, { 0.4, 2.28 }, { 0.5, 2.75 }, { 0.6, 3.15 }, { 0.7, 3.48 }, { 0.8, 3.73 }, { 0.9, 3.88 }, { 1, 3.92 } },
		color = ColorSequence.new(Color3.new(0.9686, 0.0078, 0)),
		trans = { { 0, 0 }, { 0.528, 0 }, { 0.717, 0.894 }, { 1, 1 } }, rot = { -360, 360 }, spread = 360, le = 0.5,
		locked = false, z = 1.5, orient = E.ParticleOrientation.VelocityParallel, bright = 25 },
	Flash2 = { tex = "rbxassetid://13853120945", rate = 15, life = { 0.0358, 0.0358 }, lm = 8, speed = { 0.005, 0.005 },
		size = { { 0, 4.53 }, { 0.2, 4.42 }, { 0.4, 3.82 }, { 0.5, 2.2 }, { 0.6, 0.69 }, { 0.8, 0.1 }, { 1, 0 } },
		color = ColorSequence.new(Color3.new(0.9686, 0.0078, 0)),
		trans = { { 0, 0 }, { 0.528, 0 }, { 0.717, 0.894 }, { 1, 1 } }, rot = { -360, 360 }, spread = 360, le = 0,
		locked = true, z = 1.5, orient = E.ParticleOrientation.FacingCamera, bright = 45 },
	Heat = { tex = "rbxassetid://13026594575", rate = 10, life = { 1, 1 }, speed = { 0.1, 0.1 },
		size = { { 0, 0 }, { 0.1025, 4.32 }, { 0.2325, 9.18 }, { 0.4965, 13.96 }, { 0.7585, 15.97 }, { 1, 16.67 } },
		color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
		trans = FADE, rot = { -360, 360 }, spread = 20, dir = E.NormalId.Top, le = 0, locked = false,
		orient = E.ParticleOrientation.FacingCamera, bright = 20,
		fb = { E.ParticleFlipbookLayout.Grid8x8, E.ParticleFlipbookMode.Loop, { 40, 90 }, false } },
}

local EYE_CHARGE = { "ChargeA", "ChargeB", "ChargeFire" }
local EYE_FIRE = { "Flash", "Flash2", "Almost" }
local HIT_FIRE = { "Aura", "Heat", "Flare", "Flash", "Flash2", "Almost" }

-- Beams (BeamFixed = core, Beam2 = outer glow)
local BEAMS = {
	{ tex = "rbxassetid://135363279337264", len = 0.25, mode = E.TextureMode.Stretch, w = 1, col = Color3.new(1, 0.12, 0.06), z = 0,
		trans = { { 0, 1 }, { 0.087, 0 }, { 0.372, 0 }, { 0.7166, 0.1875 }, { 1, 1 } } },
	{ tex = "rbxassetid://7071778278", len = 40, mode = E.TextureMode.Static, w = 2, col = Color3.new(1, 0.13, 0.13), z = 2.2,
		trans = { { 0, 1 }, { 0.105, 0.789 }, { 0.334, 0 }, { 0.5, 0 }, { 0.634, 0.161 }, { 0.776, 0.744 }, { 1, 1 } } },
}

----------------------------------------------------------------------
-- Builders
----------------------------------------------------------------------
local function seq(list, m)
	local k = {}
	for i, p in ipairs(list) do k[i] = NumberSequenceKeypoint.new(p[1], p[2] * m) end
	return NumberSequence.new(k)
end

local function mkEmitter(name, parent, scale)
	local s = SPEC[name]
	local e = Instance.new("ParticleEmitter")
	e.Name = name
	e.Texture = s.tex
	e.Rate = s.rate
	local lm = CFG.LifeMult * (s.lm or 1)
	e.Lifetime = NumberRange.new(s.life[1] * lm, s.life[2] * lm)
	e.Speed = NumberRange.new(s.speed[1], s.speed[2])
	e.Size = seq(s.size, scale)
	e.Color = s.color
	e.Transparency = seq(s.trans, 1)
	e.Rotation = NumberRange.new((s.rot or { 0, 0 })[1], (s.rot or { 0, 0 })[2])
	if s.rotspeed then e.RotSpeed = NumberRange.new(s.rotspeed[1], s.rotspeed[2]) end
	e.SpreadAngle = Vector2.new(s.spread or 0, s.spread or 0)
	e.Drag = s.drag or 0
	e.LightEmission = s.le or 0
	e.LightInfluence = s.li or 0
	e.LockedToPart = s.locked
	e.ZOffset = s.z or 0
	e.Orientation = s.orient
	e.Brightness = s.bright or 1
	e.EmissionDirection = s.dir or E.NormalId.Top
	if s.squash then e.Squash = seq(s.squash, scale) end
	if s.fb then
		e.FlipbookLayout = s.fb[1]
		e.FlipbookMode = s.fb[2]
		e.FlipbookFramerate = NumberRange.new(s.fb[3][1], s.fb[3][2])
		e.FlipbookStartRandom = s.fb[4]
	end
	e.Enabled = true
	e.Parent = parent
	return e
end

local function playSound(id, parent, loop)
	if not id then return end
	local snd = Instance.new("Sound")
	snd.SoundId = "rbxassetid://" .. id
	snd.Volume = 1
	snd.Looped = false
	snd.RollOffMode = Enum.RollOffMode.Linear
	snd.RollOffMinDistance = 10
	snd.RollOffMaxDistance = 300
	snd.Parent = parent
	snd:Play()
	if not loop then
		Debris:AddItem(snd, 6)
	else
		snd.Ended:Connect(function() -- loop only the later part so the intro doesn't restart
			if snd.Parent then
				snd.TimePosition = snd.TimeLength * CFG.FireLoopFrom
				snd:Play()
			end
		end)
	end
	task.spawn(function()
		local t = os.clock()
		while snd.Parent and not snd.IsLoaded and os.clock() - t < 3 do task.wait(0.1) end
		if snd.Parent and not (snd.IsLoaded and snd.TimeLength > 0) then
			warn("[LaserEyes] sound " .. id .. " didn't load (private/removed?)")
		end
	end)
	return snd
end

local function tryLoad(id, parent)
	local snd = Instance.new("Sound")
	snd.SoundId = "rbxassetid://" .. id
	snd.Volume = 1
	snd.RollOffMode = Enum.RollOffMode.Linear
	snd.RollOffMinDistance = 10
	snd.RollOffMaxDistance = 300
	snd.Parent = parent
	local t = os.clock()
	while snd.Parent and not snd.IsLoaded and os.clock() - t < 1.2 do task.wait(0.05) end
	if snd.Parent and snd.IsLoaded and snd.TimeLength > 0 then return snd end
	snd:Destroy()
end

local function startChargeSound(head, dur, ref)
	task.spawn(function()
		local snd
		for _, id in ipairs(CHARGE_IDS) do
			snd = tryLoad(id, head)
			if snd then break end
		end
		if snd then
			snd.PlaybackSpeed = math.clamp(snd.TimeLength / dur, 1, 1.6)
		elseif SOUNDS.Fire then -- fallback: fire sound pitched up = charge-up
			snd = tryLoad(SOUNDS.Fire, head)
			if snd then
				snd.PlaybackSpeed = 0.5
				TweenService:Create(snd, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { PlaybackSpeed = 2 }):Play()
			end
		end
		if not snd then return end
		ref.snd = snd
		if ref.stop then snd:Destroy() return end
		snd:Play()
	end)
end

----------------------------------------------------------------------
-- Simulation radius (boost while firing, then restore)
----------------------------------------------------------------------
local origSim, origMax
local function simBoost()
	if origSim == nil then
		local ok, v = pcall(gethiddenproperty, lp, "SimulationRadius")
		origSim = (ok and tonumber(v)) or 139
		local ok2, m = pcall(function() return lp.MaximumSimulationRadius end)
		origMax = (ok2 and m) or 1000
	end
	pcall(function() sethiddenproperty(lp, "SimulationRadius", CFG.SimRadius) end)
	pcall(function() lp.MaximumSimulationRadius = CFG.SimRadius end)
end
local function simRestore()
	if origSim == nil then return end
	pcall(function() sethiddenproperty(lp, "SimulationRadius", origSim) end)
	pcall(function() lp.MaximumSimulationRadius = origMax end)
	origSim, origMax = nil, nil
end

----------------------------------------------------------------------
-- NPC burn + kill
-- Fire/smoke and the health drain are client-side (only you see them). The final kill is what replicates.
----------------------------------------------------------------------
local burning = {}
local FIRE_PARTS = { "HumanoidRootPart", "Head", "UpperTorso", "Torso", "LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg" }

local function ignite(model)
	local b = burning[model]
	if b then return b end
	b = { exposure = 0, last = os.clock(), fx = {}, killed = false }
	for _, n in ipairs(FIRE_PARTS) do
		local p = model:FindFirstChild(n)
		if p and p:IsA("BasePart") then
			local f = Instance.new("Fire")
			f.Size, f.Heat = 7, 10
			f.Color, f.SecondaryColor = Color3.fromRGB(255, 120, 0), Color3.fromRGB(255, 40, 0)
			f.Parent = p
			local sm = Instance.new("Smoke")
			sm.Size, sm.Opacity, sm.RiseVelocity = 3, 0.3, 6
			sm.Color = Color3.fromRGB(40, 40, 40)
			sm.Parent = p
			table.insert(b.fx, f)
			table.insert(b.fx, sm)
		end
	end
	burning[model] = b
	task.spawn(function()
		while model.Parent and os.clock() - b.last < CFG.BurnLinger do task.wait(0.25) end
		for _, f in ipairs(b.fx) do pcall(function() f:Destroy() end) end
		if burning[model] == b then burning[model] = nil end
	end)
	return b
end

local function hitNPC(model, power)
	power = power or 1
	local hum = model:FindFirstChildOfClass("Humanoid")
	if not hum or Players:GetPlayerFromCharacter(model) then return end -- NPCs only
	local b = ignite(model)
	b.last = os.clock()
	if b.killed then return end
	b.exposure += 0.1 * power
	pcall(function() hum.Health = math.max(1, hum.Health - hum.MaxHealth * 0.1 * power / CFG.KillTime) end)
	if b.exposure >= CFG.KillTime then
		b.killed = true
		task.delay(1.5, function() b.killed = false end) -- retry if the kill didn't stick
		pcall(function() hum:ChangeState(E.HumanoidStateType.Dead) end)
		pcall(function() hum.Health = 0 end)
	end
end

local function scanAt(pos, radius, op, seen, power)
	for _, part in ipairs(workspace:GetPartBoundsInRadius(pos, radius, op)) do
		local m = part.Parent
		while m and m ~= workspace do
			if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") then
				if not seen[m] then
					seen[m] = true
					hitNPC(m, power)
				end
				break
			end
			m = m.Parent
		end
	end
end

-- damages every NPC along the whole beam (eye -> impact), bigger radius at the impact point
local function scanBeam(from, to, char, folder, power)
	local op = OverlapParams.new()
	op.FilterType = E.RaycastFilterType.Exclude
	op.FilterDescendantsInstances = { char, folder }
	local seen = {}
	local n = math.clamp(math.floor((to - from).Magnitude / CFG.BeamStep), 1, 30)
	for i = 0, n do
		local r = (i == n) and CFG.KillRadius or CFG.BeamRadius
		scanAt(from:Lerp(to, i / n), r * power, op, seen, power)
	end
end

----------------------------------------------------------------------
-- Camera shake
----------------------------------------------------------------------
local shake = 0
RunService:BindToRenderStep("LaserEyesShake", Enum.RenderPriority.Camera.Value + 1, function()
	if shake <= 0 then return end
	local c = workspace.CurrentCamera
	local r = function() return math.random() - 0.5 end
	c.CFrame = c.CFrame * CFrame.new(r() * shake, r() * shake, 0) * CFrame.Angles(0, 0, math.rad(r() * shake * 2))
end)

----------------------------------------------------------------------
-- Ground/wall effect: big chunks burst on impact, pebbles follow the beam (unanchored, local parts)
----------------------------------------------------------------------
local debrisFolder
local debrisList = {}

local function mkDebris(hit, size, vel, life)
	if not debrisFolder or not debrisFolder.Parent then
		debrisFolder = Instance.new("Folder")
		debrisFolder.Name = "LaserDebris"
		debrisFolder.Parent = workspace
	end
	local src = hit.Instance
	local p = Instance.new("Part")
	p.Size = size
	p.Color = src:IsA("Terrain") and workspace.Terrain:GetMaterialColor(hit.Material) or src.Color
	p.Material = hit.Material
	p.Anchored = false
	p.CanQuery, p.CanTouch = false, false
	p.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.5, 0.3)
	p.CFrame = CFrame.new(hit.Position + hit.Normal * (size.Y / 2 + 0.3))
		* CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)
	p.Parent = debrisFolder
	p.AssemblyLinearVelocity = vel
	p.AssemblyAngularVelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
	Debris:AddItem(p, life)
	table.insert(debrisList, p)
	if #debrisList > CFG.DebrisMax then
		local old = table.remove(debrisList, 1)
		if old then old:Destroy() end
	end
end

local function isSolid(hit) -- ground and walls (anything except NPC/player bodies)
	local m = hit.Instance:FindFirstAncestorOfClass("Model")
	return not (m and m:FindFirstChildOfClass("Humanoid"))
end

local function groundFX(hit, moveVel, big)
	local n = hit.Normal
	local function dir(spread)
		return (n + Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * spread).Unit
	end
	if big then
		for _ = 1, 2 do
			local s = 1.5 + math.random() * 1.5
			mkDebris(hit, Vector3.new(s, s * (0.6 + math.random() * 0.5), s), dir(1.2) * (35 + math.random() * 35) + moveVel * 0.3, 4)
		end
	else
		for _ = 1, CFG.PebbleCount do
			local s = 0.2 + math.random() * 0.35
			mkDebris(hit, Vector3.new(s, s, s), dir(1.6) * (15 + math.random() * 30) + moveVel, 2.5)
		end
	end
end

----------------------------------------------------------------------
-- Laser
----------------------------------------------------------------------
local holding, busy = false, false
local cdUntil = 0
local CAS = game:GetService("ContextActionService")
local ACTION = "LaserEyesAction"

local function rayParams(char, folder)
	local rp = RaycastParams.new()
	rp.FilterType = E.RaycastFilterType.Exclude
	rp.FilterDescendantsInstances = { char, folder }
	return rp
end

local function aimPoint(char, folder)
	local p = UIS.TouchEnabled and cam.ViewportSize / 2 or UIS:GetMouseLocation()
	cam = workspace.CurrentCamera
	local r = cam:ViewportPointToRay(p.X, p.Y)
	local res = workspace:Raycast(r.Origin, r.Direction * CFG.Range, rayParams(char, folder))
	return res and res.Position or (r.Origin + r.Direction * CFG.Range)
end

-- real surface hit from the eyes toward the (delayed) aim point
local function surfaceAt(origin, p, char, folder)
	local d = p - origin
	if d.Magnitude < 0.5 then return nil end
	return workspace:Raycast(origin, d.Unit * (d.Magnitude + 4), rayParams(char, folder))
end

local firing = false

----------------------------------------------------------------------
-- Sparks
----------------------------------------------------------------------
local function mkSparks(parent)
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Rate = 80
	e.Lifetime = NumberRange.new(0.3, 0.8)
	e.Speed = NumberRange.new(20, 45)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Acceleration = Vector3.new(0, -70, 0)
	e.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) })
	e.Color = ColorSequence.new(Color3.fromRGB(255, 170, 40), Color3.fromRGB(255, 60, 0))
	e.LightEmission = 1
	e.Brightness = 3
	e.Parent = parent
	return e
end

----------------------------------------------------------------------
-- Laser
----------------------------------------------------------------------

local function fire()
	if busy or os.clock() < cdUntil then return end
	local char = lp.Character
	local head = char and char:FindFirstChild("Head")
	if not head then return end
	busy = true

	local folder = Instance.new("Folder")
	folder.Name = "LaserEyes"
	folder.Parent = workspace

	local tgt = Instance.new("Part")
	tgt.Anchored, tgt.CanCollide, tgt.CanQuery, tgt.CanTouch = true, false, false, false
	tgt.Transparency = 1
	tgt.Size = Vector3.new(0.5, 0.5, 0.5)
	tgt.Parent = folder
	local endAtt = Instance.new("Attachment", tgt)

	local eyes, charge, live, guides, lights, fireBeams = {}, {}, {}, {}, {}, {}
	for i, x in ipairs({ -0.3, 0.3 }) do
		local a = Instance.new("Attachment")
		a.Name = "LaserEye" .. i
		a.Position = Vector3.new(x, 0.15, -0.55)
		a.Parent = head
		eyes[i] = a
		-- eye glow
		local l = Instance.new("PointLight")
		l.Color = Color3.new(1, 0.1, 0.05)
		l.Range = 14
		l.Brightness = 0
		l.Parent = a
		table.insert(lights, l)
	end

	-- charge: eye emitters + guide line (animated, pulsing) + reticle at the aim point
	for _, a in ipairs(eyes) do
		for _, n in ipairs(EYE_CHARGE) do table.insert(charge, mkEmitter(n, a, CFG.EyeScale)) end
		for k = 1, 2 do -- 1 = wide glow, 2 = bright core
			local g = Instance.new("Beam")
			g.Texture = "rbxassetid://135363279337264"
			g.TextureMode = E.TextureMode.Stretch
			g.Color = ColorSequence.new(k == 1 and Color3.new(1, 0.1, 0.05) or Color3.new(1, 0.85, 0.8))
			g.LightEmission = 1
			g.LightInfluence = 0
			g.FaceCamera = true
			g.Segments = 10
			g.ZOffset = k
			g.Width0, g.Width1 = 0.3, 0.3
			g.Attachment0, g.Attachment1 = a, endAtt
			g.Parent = folder
			table.insert(guides, g)
		end
	end
	local reticle = { mkEmitter("ChargeA", endAtt, 0.5), mkEmitter("Almost", endAtt, 0.6) }
	local chargeRef = {}
	startChargeSound(head, CFG.ChargeTime, chargeRef)

	local dt = 1 / 60
	local fired = false
	local sm
	local function smooth(target)
		if not sm then sm = target else sm = sm:Lerp(target, 1 - math.exp(-CFG.AimSmooth * dt)) end
		return sm
	end

	local baseFov = cam.FieldOfView
	local t0 = os.clock()
	while holding and os.clock() - t0 < CFG.ChargeTime do
		local pr = (os.clock() - t0) / CFG.ChargeTime
		shake = CFG.ShakeCharge * pr
		tgt.CFrame = CFrame.new(smooth(aimPoint(char, folder)))
		cam.FieldOfView = baseFov - CFG.FovZoom * pr
		for _, l in ipairs(lights) do l.Brightness = 1 + 4 * pr end
		local pulse = 0.5 + 0.5 * math.sin((os.clock() - t0) * (10 + 14 * pr))
		for i, g in ipairs(guides) do
			local glow = (i % 2 == 1)
			local w = glow and (0.7 + 0.9 * pr) or (0.18 + 0.25 * pr)
			g.Width0, g.Width1 = w, w
			g.Transparency = NumberSequence.new(glow and (0.35 + 0.25 * pulse) or 0)
		end
		dt = RunService.Heartbeat:Wait()
	end

	for _, g in ipairs(guides) do g:Destroy() end
	for _, e in ipairs(reticle) do e.Enabled = false end
	for _, e in ipairs(charge) do e.Enabled = false end
	chargeRef.stop = true
	if chargeRef.snd then chargeRef.snd:Destroy() end

	-- fire
	if holding then
		fired = true
		shake = CFG.ShakeFire
		TweenService:Create(cam, TweenInfo.new(0.15), { FieldOfView = baseFov + 6 }):Play() -- punch
		for _, a in ipairs(eyes) do
			for _, n in ipairs(EYE_FIRE) do table.insert(live, mkEmitter(n, a, CFG.EyeScale * 2)) end
			for _, b in ipairs(BEAMS) do
				local beam = Instance.new("Beam")
				beam.Texture = b.tex
				beam.TextureLength = b.len
				beam.TextureMode = b.mode
				beam.TextureSpeed = 1
				beam.Color = ColorSequence.new(b.col)
				beam.Transparency = seq(b.trans, 1)
				beam.LightEmission = 1
				beam.LightInfluence = 0
				beam.Width0 = b.w * CFG.BeamWidth * 0.5
				beam.Width1 = b.w * CFG.BeamWidth
				beam.Segments = 10
				beam.FaceCamera = true
				beam.ZOffset = b.z
				beam.Attachment0, beam.Attachment1 = a, endAtt
				beam.Parent = folder
				table.insert(fireBeams, { beam = beam, w0 = beam.Width0, w1 = beam.Width1 })
			end
		end
		for _, n in ipairs(HIT_FIRE) do table.insert(live, mkEmitter(n, endAtt, HIT_SCALE[n] or 1)) end
		table.insert(live, mkSparks(endAtt))
		local fireSnd = playSound(SOUNDS.Fire, head, true)
		playSound(SOUNDS.Hit, tgt)
		if CFG.KillNPCs then simBoost() end

		firing = true
		local t1, lastScan, lastPebble, lastChunk, lastP, lastInst = os.clock(), 0, 0, 0, nil, nil
		while holding and char.Parent and os.clock() - t1 < CFG.MaxFire do
			-- power builds up the longer you hold
			local power = 1 + (CFG.MaxPower - 1) * math.clamp((os.clock() - t1) / CFG.PowerRamp, 0, 1)
			local p = smooth(aimPoint(char, folder))
			local hit = surfaceAt(head.Position, p, char, folder)
			if hit then p = hit.Position end
			tgt.CFrame = CFrame.new(p)
			shake = CFG.ShakeFire * math.sqrt(power)
			for _, fb in ipairs(fireBeams) do
				fb.beam.Width0, fb.beam.Width1 = fb.w0 * power, fb.w1 * power
			end
			for _, l in ipairs(lights) do l.Brightness = 5 * power end
			local now = os.clock()
			if CFG.KillNPCs and now - lastScan >= 0.1 then
				lastScan = now
				scanBeam(head.Position, p, char, folder, power)
			end
			-- ground effect
			local moveVel = Vector3.zero
			if lastP then
				local v = (p - lastP) / math.max(dt, 1 / 120)
				v = Vector3.new(v.X, 0, v.Z)
				moveVel = v.Magnitude > 80 and v.Unit * 80 or v
			end
			lastP = p
			local solid = CFG.GroundFX and hit and isSolid(hit)
			if solid then
				-- small pebbles all the time while you drag / hold on a surface
				if now - lastPebble >= CFG.PebbleEvery then
					lastPebble = now
					groundFX(hit, moveVel, false)
				end
				-- big chunks only at the moment the beam hits a (new) surface
				if hit.Instance ~= lastInst and now - lastChunk >= CFG.ChunkEvery then
					lastChunk = now
					groundFX(hit, moveVel, true)
				end
			end
			lastInst = solid and hit.Instance or nil
			dt = RunService.Heartbeat:Wait()
		end
		firing = false
		if fireSnd then fireSnd:Destroy() end
	end

	-- cleanup (let particles fade out)
	shake = 0
	simRestore()
	TweenService:Create(cam, TweenInfo.new(0.4), { FieldOfView = baseFov }):Play()
	for _, l in ipairs(lights) do l:Destroy() end
	for _, e in ipairs(live) do e.Enabled = false end
	for _, c in ipairs(folder:GetChildren()) do
		if c:IsA("Beam") then c:Destroy() end
	end
	for _, a in ipairs(eyes) do Debris:AddItem(a, 4) end
	Debris:AddItem(folder, 4)
	if fired then
		cdUntil = os.clock() + CFG.Cooldown
		pcall(function() CAS:SetTitle(ACTION, "WAIT") end)
		task.delay(CFG.Cooldown, function() pcall(function() CAS:SetTitle(ACTION, "LASER") end) end)
	end
	busy = false
end

----------------------------------------------------------------------
-- Tool: equip "Laser Eyes" from your hotbar, then hold click / the on-screen LASER button (or E)
----------------------------------------------------------------------

local function startHold()
	holding = true
	task.spawn(fire)
end

local function onAction(_, state)
	if state == Enum.UserInputState.Begin then
		startHold()
	elseif state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then
		holding = false -- ignore Change events so holding the button keeps firing
	end
	return Enum.ContextActionResult.Sink
end

local function bindButton()
	CAS:UnbindAction(ACTION)
	CAS:BindAction(ACTION, onAction, true, CFG.Key) -- true = on-screen touch button (key still works on PC)
	CAS:SetTitle(ACTION, "LASER")
	CAS:SetPosition(ACTION, UDim2.new(1, -120, 1, -220))
	local b = CAS:GetButton(ACTION)
	if b then b.Size = UDim2.fromOffset(90, 90) end
end

local function unbindButton()
	holding = false
	CAS:UnbindAction(ACTION)
end

local function makeTool()
	local t = Instance.new("Tool")
	t.Name = "Laser Eyes"
	t.ToolTip = "Hold to charge and fire"
	t.RequiresHandle = false
	t.CanBeDropped = false
	t.Activated:Connect(startHold)
	t.Deactivated:Connect(function() holding = false end)
	t.Equipped:Connect(bindButton)
	t.Unequipped:Connect(unbindButton)
	t.Destroying:Connect(unbindButton)
	return t
end

local function give()
	local bp = lp:WaitForChild("Backpack")
	if bp:FindFirstChild("Laser Eyes") or (lp.Character and lp.Character:FindFirstChild("Laser Eyes")) then return end
	makeTool().Parent = bp
end
give()
lp.CharacterAdded:Connect(function()
	unbindButton()
	task.wait(1)
	give()
end)
