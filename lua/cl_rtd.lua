
include("rtd_config.lua")
--testing
net.Receive("RTDChat", function()
	local Text = {}
	local msg = net.ReadString()
	local ply = net.ReadEntity()

	table.insert(Text, Color(50, 50, 50, 255))
	table.insert(Text, "[")
	table.insert(Text, RTDC.NameColour)
	table.insert(Text, RTDC.Name)
	table.insert(Text, Color(50, 50, 50, 255))
	table.insert(Text, "] ")
	table.insert(Text, RTDC.PlayerColour)
	table.insert(Text, ply:Name())
	table.insert(Text, Color(255, 255, 255, 255))
	table.insert(Text, msg)

	chat.AddText(unpack(Text))
end)

net.Receive("RTDPrivate", function()
	local Text = {}
	local msg = net.ReadString()

	table.insert(Text, Color(50, 50, 50, 255))
	table.insert(Text, "[")
	table.insert(Text, RTDC.NameColour)
	table.insert(Text, RTDC.Name)
	table.insert(Text, Color(50, 50, 50, 255))
	table.insert(Text, "] ")
	table.insert(Text, Color(255, 255, 255, 255))
	table.insert(Text, msg)

	chat.AddText(unpack(Text))
end)