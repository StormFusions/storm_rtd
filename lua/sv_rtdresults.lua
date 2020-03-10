-----------------------------------Good Results-----------------------------------

local function IncreaseHealth(ply)
	local i = math.random(2, 50)
	local h = ply:Health()

	ply:SetHealth(h+i)

	RTDGlobalMessage(ply, " health been increased by "..i.."!")
end

local function IncreaseSpeed(ply)
	local s = ply:GetWalkSpeed()
	local i = math.random(100, 300)
	local t = math.random(5, 50)

	local speed = s+i
	ply:SetWalkSpeed(speed)

	timer.Simple(t, function()
		ply:SetWalkSpeed(s)
	end)

	RTDGlobalMessage(ply, " speed been increased by "..i.." for "..t.." seconds!")
end

local function SmallScalePlayer(ply)
	local s = ply:GetModelScale()
	local t = math.random(5, 50)

	ply:SetModelScale(0.2, 0)

	timer.Simple(t, function()
		ply:SetModelScale(s, 0)
	end)

	RTDGlobalMessage(ply, " is now really small for "..t.." seconds!")
end

local function GivePoints(ply)
	local i = math.random(1, 300)
	ply:PS2_AddStandardPoints(i, "Roll the dice")

	RTDGlobalMessage(ply, " has been given "..i.." points!")
end

local function GodMode(ply)
	local t = math.random(0,15)

	if t > 0 then
		ply:GodEnable()
		timer.Simple(t, function() ply:GodDisable() end)

		RTDGlobalMessage(ply, " has been given God mode for "..t.." seconds!")
	else
		RTDGlobalMessage(ply, " has been given God mode but it was just a prank bro!")
	end
end

local function LowGravity(ply)
	local t = math.random(5, 15)
	local g = ply:GetGravity()
	
	ply:SetGravity(0.25)

	timer.Simple(t, function() ply:SetGravity(g) end)

	RTDGlobalMessage(ply, " gravity has been lowered for "..t.." seconds!")
end

local function LargePlayerScale(ply)
	local s = ply:GetModelScale()
	local t = math.random(5, 50)

	ply:SetModelScale(2, 0)

	timer.Simple(t, function()
		ply:SetModelScale(s, 0)
	end)

	RTDGlobalMessage(ply, " is now really big for "..t.." seconds!")
end

-----------------------------------Bad Results-----------------------------------

local function BurnThePlayer(ply)
	local i = math.random(5, 20)
	ply:Ignite(i)

	RTDGlobalMessage(ply, " has been set on fire for "..i.." seconds!")
end

local function LaunchPlayer(ply)
	ply:EmitSound("physics/body/body_medium_impact_hard1.wav")
	ply:SetLocalVelocity(Vector(math.random(0, 2500), math.random(0, 2500), 2500))

	RTDGlobalMessage(ply, " has been slapped into the sky!")
end

local function WhipPlayer(ply)
	local h = math.random(2,15)
	local c = 0

	timer.Create("playerwhip"..ply:SteamID(), 0.5, 0, function()
		if c == h or not ply:Alive() then
			c = nil
			timer.Destroy("playerwhip"..ply:SteamID())
		else
			ply:EmitSound("physics/body/body_medium_impact_hard1.wav")
			ply:SetLocalVelocity(Vector(math.random(0, 500), math.random(0, 500), math.random(0, 500)))
			c = c + 1
		end
	end)

	RTDGlobalMessage(ply, " has been whipped "..h.." times!")
end

local function MegaExplode(ply)
	local h = 10
	local c = 0

	timer.Create("MegaExplode"..ply:SteamID(), 0.1, 0, function()
		if c == h or not ply:Alive() then
			c = nil
			local effect = EffectData()
			effect:SetStart(ply:GetPos())
			effect:SetOrigin(ply:GetPos())
			effect:SetScale(3)
			util.Effect("HelicopterMegaBomb", effect)
			
			ply:EmitSound("ambient/explosions/explode_1.wav")
			ply:Kill()
			timer.Destroy("MegaExplode"..ply:SteamID())
			RTDGlobalMessage(ply, " MEGA exploded!")
		else
			local effect = EffectData()
			effect:SetStart(ply:GetPos())
			effect:SetOrigin(ply:GetPos())
			effect:SetScale(3)
			util.Effect("HelicopterMegaBomb", effect)
			
			ply:EmitSound("ambient/explosions/explode_1.wav")
			c = c + 1
		end
	end)

	
end


local function ExplodePlayer(ply)
	local h = 2
	local c = 0

	timer.Create("ExplodePlayer"..ply:SteamID(), 1, 0, function()
		if c == h or not ply:Alive() then
			c = nil
			local effect = EffectData()
			effect:SetStart(ply:GetPos())
			effect:SetOrigin(ply:GetPos())
			effect:SetScale(3)
			util.Effect("HelicopterMegaBomb", effect)
			ply:EmitSound("ambient/explosions/explode_1.wav")
			ply:Kill()

			timer.Destroy("ExplodePlayer"..ply:SteamID())
			RTDGlobalMessage(ply, " exploded!")
		else
			local effect = EffectData()
			effect:SetStart(ply:GetPos())
			effect:SetOrigin(ply:GetPos())
			effect:SetScale(3)
			util.Effect("HelicopterMegaBomb", effect)
			
			ply:EmitSound("ambient/explosions/explode_1.wav")
			c = c + 1
		end
	end)
end

local function Rocket(ply)
	ply:SetGroundEntity(NULL)
	ply:SetVelocity(Vector(0, 0, 1000))
	ply:EmitSound(Sound("weapons/rpg/rocketfire1.wav"))
	
	timer.Simple(1, function()
		if not ply:Alive() then return end
	
		local effectdata = EffectData()
		effectdata:SetStart(ply:GetPos())
		effectdata:SetOrigin(ply:GetPos())
		effectdata:SetScale(3)
		util.Effect("HelicopterMegaBomb", effectdata)

		ply:EmitSound("ambient/explosions/explode_1.wav", 100, 100)
		ply:Kill()

		RTDGlobalMessage(ply, " has been rocketed into the air!")
	end)
end

RTD.Results = {
	BurnThePlayer,
	LaunchPlayer,
	IncreaseHealth,
	IncreaseSpeed,
	ExplodePlayer,
	GivePoints,
	MegaExplode,
	SmallScalePlayer,
	WhipPlayer,
	GodMode,
	LowGravity,
	LargePlayerScale,
	Rocket,
}
