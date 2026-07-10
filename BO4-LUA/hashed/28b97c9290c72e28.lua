require("x64:53e8db3768fb02a")
Lobby.RecentPlayers = {}
Lobby.RecentPlayers.Options = {
	InGameOnly = true,
	NoFriends = false,
}
Lobby.RecentPlayers.AddRecentPlayer = function(f1_arg0, f1_arg1)
	local f1_local0, f1_local1 = nil
	local f1_local2 = Engine[@"hash_691D6FDBC677ECD8"]()
	f1_arg0.isSorted:set(0)
	for f1_local6, f1_local7 in DDLUtils.ipairs(f1_arg0.playersMet) do
		local f1_local8 = Engine[@"hash_690B6BCE69A8E08B"](f1_local7.xuid:get())
		if f1_local8 == f1_arg1.xuid then
			f1_arg0.playersMet[f1_local6].time:set(Engine[@"hash_691D6FDBC677ECD8"]())
			Engine[@"hash_6B3F256EBFE9A103"](f1_arg1.xuid, f1_arg1.gamertag, string.len(f1_arg1.gamertag))
			return
		elseif f1_local0 == nil then
			if f1_local8 == 0 then
				f1_local0 = f1_local6
				break
			elseif f1_local7.time:get() < f1_local2 then
				f1_local1 = f1_local6
				f1_local2 = f1_local7.time:get()
			end
		end
	end
	if f1_local0 then
		f1_arg0.count:set(f1_arg0.count:get() + 1)
	else
		if f1_local1 == nil then
			return
		end
		f1_local0 = f1_local1
	end
	f1_arg0.playersMet[f1_local0].xuid:set(f1_arg1.xuid)
	f1_arg0.playersMet[f1_local0].time:set(Engine[@"hash_691D6FDBC677ECD8"]())
	Engine[@"hash_6B3F256EBFE9A103"](f1_arg1.xuid, f1_arg1.gamertag, string.len(f1_arg1.gamertag))
end
Lobby.RecentPlayers.ShouldAddPlayer = function(f2_arg0, f2_arg1)
	if f2_arg1.lobbyClientType ~= nil and (f2_arg1.lobbyClientType == Enum[@"lobbyclienttype"][@"lobby_client_type_bot_temp"] or f2_arg1.lobbyClientType == Enum[@"lobbyclienttype"][@"lobby_client_type_bot_permanent"]) then
		return false
	elseif Engine[@"islocalclient"](f2_arg1.xuid) then
		return false
	elseif Lobby.RecentPlayers.Options.NoFriends and Engine[@"isfriendfromxuid"](f2_arg0, f2_arg1.xuid) then
		return false
	else
		return true
	end
end
Lobby.RecentPlayers.AddOneRecentPlayer = function(f3_arg0, f3_arg1, f3_arg2)
	if Lobby.RecentPlayers.ShouldAddPlayer(f3_arg0, f3_arg2) then
		Lobby.RecentPlayers.AddRecentPlayer(f3_arg1, f3_arg2)
	end
end
Lobby.RecentPlayers.AddListOfRecentPlayers = function(f4_arg0, f4_arg1, f4_arg2)
	for f4_local3, f4_local4 in ipairs(f4_arg2) do
		Lobby.RecentPlayers.AddOneRecentPlayer(f4_arg0, f4_arg1, f4_local4)
	end
	Engine[@"storagewrite"](f4_arg0, Enum[@"storagefiletype"][@"hash_22C45CE6FD0D4539"])
end
Lobby.RecentPlayers.AddToAllActiveControllers = function(f5_arg0, f5_arg1)
	if Engine[@"getdvarbool"]("recentPlayerListEnabled") then
		for f5_local0 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
			if Engine[@"iscontrollerbeingused"](f5_local0) then
				local f5_local3 = Engine[@"storagegetbuffer"](f5_local0, Enum[@"storagefiletype"][@"hash_22C45CE6FD0D4539"])
				if f5_local3 then
					f5_arg0(f5_local0, f5_local3, f5_arg1)
				end
			end
		end
	end
end
Lobby.RecentPlayers.OnClientAdded = function(f6_arg0)
	if f6_arg0.lobbyModule == Enum[@"lobbymodule"][@"lobby_module_client"] then
		if Enum[@"emodes"][@"mode_warzone"] == Engine[@"currentsessionmode"]() then
			if f6_arg0.lobbyType == Enum[@"lobbytype"][@"lobby_type_private"] then
				Lobby.RecentPlayers.AddToAllActiveControllers(Lobby.RecentPlayers.AddOneRecentPlayer, {
					xuid = f6_arg0.xuid,
					gamertag = f6_arg0.customData,
				})
			end
		elseif (Engine[@"isingame"]() or not Lobby.RecentPlayers.Options.InGameOnly or f6_arg0.lobbyType == Enum[@"lobbytype"][@"lobby_type_private"]) and not Engine[@"hash_65CB8E6B7FBBFFD5"](f6_arg0.xuid) then
			Lobby.RecentPlayers.AddToAllActiveControllers(Lobby.RecentPlayers.AddOneRecentPlayer, {
				xuid = f6_arg0.xuid,
				gamertag = f6_arg0.customData,
			})
		end
	end
end
Lobby.RecentPlayers.OnMatchStart = function(f7_arg0)
	if Engine[@"currentsessionmode"]() ~= Enum[@"emodes"][@"mode_warzone"] then
		local f7_local0 = Engine[@"lobbygetsessionclients"](f7_arg0.lobbyModule, f7_arg0.lobbyType)
		Lobby.RecentPlayers.AddToAllActiveControllers(Lobby.RecentPlayers.AddListOfRecentPlayers, f7_local0.sessionClients)
	end
end
Lobby.RecentPlayers.OnMatchEnd = function(f8_arg0)
	for f8_local0 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
		if Engine[@"iscontrollerbeingused"](f8_local0) then
			Engine[@"storagewrite"](f8_local0, Enum[@"storagefiletype"][@"hash_22C45CE6FD0D4539"])
		end
	end
end
Lobby.RecentPlayers.OnWarzoneMatchStart = function(f9_arg0)
	local f9_local0 = Enum[@"lobbymodule"][@"lobby_module_client"]
	local f9_local1 = Enum[@"lobbytype"][@"lobby_type_game"]
	local f9_local2 = Engine[@"getprimarycontroller"]()
	local f9_local3 = Engine[@"getteamid"](f9_local2, Engine[@"getclientnum"](f9_local2))
	local f9_local4 = Engine[@"hash_F9C4C8A66F9CB02"](f9_local2)
	local f9_local5 = Engine[@"defaultid64value"]()
	local f9_local6 = {}
	for f9_local11, f9_local12 in pairs(f9_local4) do
		if f9_local3 == f9_local12 then
			local f9_local10 = Engine[@"getlobbyxuidforclientnum"](f9_local0, f9_local1, f9_local11)
			if f9_local10 ~= f9_local5 and not Engine[@"hash_65CB8E6B7FBBFFD5"](f9_local10) then
				table.insert(f9_local6, {
					xuid = f9_local10,
					gamertag = Engine[@"hash_61FB3481C8114A9A"](f9_local10),
				})
			end
		end
	end
	Lobby.RecentPlayers.AddToAllActiveControllers(Lobby.RecentPlayers.AddListOfRecentPlayers, f9_local6)
	for f9_local7 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
		if Engine[@"iscontrollerbeingused"](f9_local7) then
			Engine[@"storagewrite"](f9_local7, Enum[@"storagefiletype"][@"hash_22C45CE6FD0D4539"])
		end
	end
end
Lobby.RecentPlayers.OnLocalClientObituary = function(f10_arg0)
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] and f10_arg0.meansofdeath ~= Enum[@"meansofdeath_t"][@"mod_downed"] then
		assert(f10_arg0.controller ~= nil)
		assert(f10_arg0.xuid ~= nil)
		if f10_arg0.xuid ~= Engine[@"defaultid64value"]() and not Engine[@"hash_65CB8E6B7FBBFFD5"](f10_arg0.xuid) then
			local f10_local0 = Engine[@"storagegetbuffer"](f10_arg0.controller, Enum[@"storagefiletype"][@"hash_22C45CE6FD0D4539"])
			assert(f10_arg0.gamertag ~= nil)
			if Lobby.RecentPlayers.ShouldAddPlayer(f10_arg0.controller, f10_arg0) then
				Lobby.RecentPlayers.AddRecentPlayer(f10_local0, f10_arg0)
				Engine[@"storagewrite"](f10_arg0.controller, Enum[@"storagefiletype"][@"hash_22C45CE6FD0D4539"])
			end
		end
	end
end
