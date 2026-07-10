require("x64:53e8db3768fb02a")
require("x64:3050b56bc941c17")
require("x64:2f7767db3f402c")
require("x64:d0f84a2d7d94ca3")
require("x64:b370b3af9224bd0")
Lobby.Merge = {}
Lobby.Merge.mergeData = nil
Lobby.Merge.Complete = function()
	if Lobby.Merge.mergeData == nil then
		return
	else
		Lobby.Merge.mergeData = nil
	end
end
Lobby.Merge.IsMergingAllowed = function(f2_arg0)
	if Engine[@"isingame"]() then
		return
	elseif Lobby.ProcessQueue.IsQueueEmpty() == false then
		return false
	elseif Engine[@"lobbyjoincount"]() > 0 then
		return false
	elseif Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], f2_arg0, Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]) >= Dvar[@"party_minplayers"]:get() then
		return false
	elseif Engine[@"getsessionstatus"] and Engine[@"getsessionstatus"](f2_arg0) ~= Enum[@"sessionstatus"][@"session_status_idle"] then
		return false
	else
		local f2_local0 = Lobby.Timer.GetTimerStatus()
		if f2_local0 == Lobby.Timer.LOBBY_STATUS.STARTING or f2_local0 == Lobby.Timer.LOBBY_STATUS.IDLE or f2_local0 == Lobby.Timer.LOBBY_STATUS.NOT_RUNNING or f2_local0 == Lobby.Timer.LOBBY_STATUS.POST_GAME or f2_local0 == Lobby.Timer.LOBBY_STATUS.FIND_NEW_LOBBY or f2_local0 == Lobby.Timer.MATCH_START_INVALID then
			return false
		else
			return true
		end
	end
end
Lobby.Merge.Update = function()
	if Lobby.Merge.mergeData == nil then
		return
	elseif Lobby.Merge.mergeData.merging == false then
		if Lobby.Merge.mergeData.timer > Engine[@"milliseconds"]() then
			return
		end
		local f3_local0 = Engine[@"getlobbyhostcontrollerindex"](Enum[@"lobbytype"][@"lobby_type_game"])
		if f3_local0 == -1 then
			f3_local0 = 0
		end
		if Engine[@"isdedicatedserver"]() == true then
			Lobby.ProcessQueue.AddToQueue("Merge", Lobby.Process.MergePublicDedicatedLobby(f3_local0))
		else
			Lobby.ProcessQueue.AddToQueue("Merge", Lobby.Process.MergePublicGameLobby(f3_local0))
		end
		Lobby.Merge.mergeData.merging = true
	end
end
Lobby.Merge.Pump = function()
	if Dvar[@"lobbymergeenabled"]:get() == false or Dvar[@"hash_44BADE8473F0165F"]:get() == true then
		return
	elseif Engine[@"isdedicatedserver"]() and Dvar[@"lobbymergededicatedenabled"]:get() == false then
		return
	elseif false == Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		Lobby.Merge.mergeData = nil
		return
	elseif Lobby.Timer.GetTimerType() ~= LuaEnum.TIMER_TYPE.AUTO_MP then
		Lobby.Merge.mergeData = nil
		return
	elseif Engine[@"getlobbyuiscreen"]() ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) then
		Lobby.Merge.mergeData = nil
		return
	elseif Lobby.Merge.IsMergingAllowed(Enum[@"lobbytype"][@"lobby_type_game"]) then
		if Lobby.Merge.mergeData == nil then
			Lobby.Merge.mergeData = {}
			Lobby.Merge.mergeData.timer = Engine[@"milliseconds"]() + Dvar[@"lobbymergeinterval"]:get()
			Lobby.Merge.mergeData.merging = false
		end
		Lobby.Merge.Update()
	else
		Lobby.Merge.mergeData = nil
	end
end
