include("rtd_config.lua")
include("sv_rtdresults.lua")
RTD = {}

local RTDTimer = RTDC.Time

util.AddNetworkString("RTDChat")
util.AddNetworkString("RTDPrivate")

local meta = FindMetaTable("Player")

function RTDGlobalMessage(ply, msg)
	for k, v in pairs(player.GetAll()) do
		net.Start("RTDChat")
			net.WriteString(msg)
			net.WriteEntity(ply)
		net.Send(v)
	end
end

function meta:RTDPrivateMessage(msg)
	net.Start("RTDPrivate")
		net.WriteString(msg)
	net.Send(self)
end

function meta:StartRTD()
	if self:Alive() then
		if timer.Exists(self:SteamID().."_delay") then
			local timeleft = math.Round(timer.TimeLeft(self:SteamID().."_delay"))
			self:RTDPrivateMessage("You already used RTD command! You have "..timeleft.." seconds left!")
			return
		end

		local result = table.Random(RTD.Results)
		result(self)
		timer.Create(self:SteamID().."_delay", RTDTimer, 1, function() timer.Destroy(self:SteamID().."_delay") end)

	else
		self:RTDPrivateMessage("You need to be alive to use RTD command")
	end
end

function meta:RTDDevCommand()
	if timer.Exists(self:SteamID().."_delay") then
		timer.Destroy(self:SteamID().."_delay")
	end
end

hook.Add("PlayerSay", "RTDChatCommand", function(ply, text, public)
	text = string.lower(text)
	if string.sub(text, 1) == "!rtd" then
		ply:StartRTD()
		return ""
	end
end)

hook.Add("PlayerSay", "RTDDevCommand", function(ply, text, public)
	text = string.lower(text)
	if string.sub(text, 1) == "!rtd reset" then
		if ply:IsSuperAdmin() then
			ply:RTDDevCommand()
			ply:RTDPrivateMessage("RTD been reset")
			return ""
		end
	end
end)

hook.Add("PlayerDisconnected", "RTDDisconnect", function(ply)
	if timer.Exists(ply:SteamID().."_delay") then
		timer.Destroy(ply:SteamID().."_delay")
	end
end)