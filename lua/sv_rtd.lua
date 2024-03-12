include("rtd_config.lua")
include("sv_rtdresults.lua")

local RTDTimer = RTDC.Time

util.AddNetworkString("RTDChat")
util.AddNetworkString("RTDPrivate")

local meta = FindMetaTable("Player")

function RTDGlobalMessage(ply, msg)
	net.Start("RTDChat")
		net.WriteString(msg)
		net.WriteEntity(ply)
	net.Broadcast()
end

function meta:RTDPrivateMessage(msg)
	net.Start("RTDPrivate")
		net.WriteString(msg)
	net.Send(self)
end

function meta:StartRTD()
	if not self:Alive() then
		self:RTDPrivateMessage("You need to be alive to use RTD command")
		return 
	end

	local delay = RTDTimer 
    local currentTime = CurTime()

	if not self.lastRTD then self.lastRTD = currentTime - delay end

    if currentTime < self.lastRTD + delay then
        local timeLeft = math.ceil((self.lastRTD + delay) - currentTime)
        self:RTDPrivateMessage("You already used RTD command! You have " .. timeLeft .. " seconds left!")
        return
    end

	-- Remove this if you want it to work with any other gamemode or change TEAM_RUNNER to a team you only want to use the command
	if not self:Team() == TEAM_RUNNER then
		self:RTDPrivateMessage("You can't use this command while on the death team!")
		return
	end

	local result = table.Random(RTD.Results)
	result(self)
	self.lastRTD = currentTime
end

function meta:RTDDevCommand()
	if self.lastRTD then
		self.lastRTD = nil
	end
end

local chatCommands = {}

chatCommands["!rtd"] = function(ply, arg)

	ply:StartRTD()

end

chatCommands["!rtd reset"] = function(ply, arg)
	if ply:IsSuperAdmin() then
		ply:RTDDevCommand()
		ply:RTDPrivateMessage("RTD been reset")
	end
end

hook.Add("PlayerSay", "RTDChatCommands", function(ply, text, public)
	text = string.lower(text)
	if chatCommands[text] then
		chatCommands[text](ply, text)
		return ""
	end
end)

concommand.Add("storm_rtd", function(ply)
	ply:StartRTD()
end)