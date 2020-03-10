if SERVER then
	include("sv_rtd.lua")
	include("sv_rtdresults.lua")
	AddCSLuaFile("cl_rtd.lua")
	AddCSLuaFile("rtd_config.lua")
else
	include("cl_rtd.lua")
	include("rtd_config.lua")
end