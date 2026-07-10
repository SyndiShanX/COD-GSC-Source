require("x64:53e8db3768fb02a")
require("x64:2f7767db3f402c")
Lobby.MapVote = {}
Lobby.MapVote.VoteState = LuaEnum.MAP_VOTE_STATE.HIDDEN
Lobby.MapVote.VoteInfo = nil
Lobby.MapVote.VoteData = nil
Lobby.MapVote.storedNextPrev = false
Lobby.MapVote.GetMapValue = function(f1_arg0, f1_arg1)
	local f1_local0 = LuaUtils.GetMapsTable()
	if not f1_local0[f1_arg0] then
		return nil
	else
		f1_local0 = LuaUtils.GetMapsTable()
		return f1_local0[f1_arg0][f1_arg1]
	end
end
Lobby.MapVote.SetGameModeName = function(f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = f2_arg0:create(f2_arg1)
	f2_local0:set(Engine[@"converttoxhash"](f2_arg2))
end
Lobby.MapVote.TallyVotes = function(f3_arg0)
	local f3_local0 = Enum[@"lobbymapvote"][@"lobby_mapvote_next"]
	local f3_local1 = 0
	local f3_local2 = 0
	local f3_local3 = 0
	local f3_local4 = Engine[@"lobbygetsessionclients"](f3_arg0, Engine[@"lobbygetcontrollinglobbysession"](f3_arg0))
	for f3_local8, f3_local9 in ipairs(f3_local4.sessionClients) do
		if f3_local9.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_next"] then
			f3_local1 = f3_local1 + 1
		end
		if f3_local9.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_previous"] then
			f3_local2 = f3_local2 + 1
		end
		if f3_local9.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_random"] then
			f3_local3 = f3_local3 + 1
		end
	end
	f3_local5 = false
	f3_local6 = f3_local1
	if f3_local6 < f3_local2 then
		f3_local5 = true
		f3_local6 = f3_local2
		f3_local0 = Enum[@"lobbymapvote"][@"lobby_mapvote_previous"]
	end
	if f3_local6 < f3_local3 then
		f3_local5 = false
		f3_local6 = f3_local3
		f3_local0 = Enum[@"lobbymapvote"][@"lobby_mapvote_random"]
	end
	return f3_local0
end
Lobby.MapVote.UpdateMapVoteInfo = function()
	local f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6 = nil
	if Lobby.MapVote.VoteState == LuaEnum.MAP_VOTE_STATE.HIDDEN then
		Lobby.MapVote.storedNextPrev = false
	end
	local f4_local7 = LobbyData.GetCurrentMenuTarget()
	if f4_local7[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_invalid"] then
		return
	end
	local f4_local8 = Enum[@"lobbymodule"][@"lobby_module_host"]
	if not Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"]) then
		f4_local8 = Enum[@"lobbymodule"][@"lobby_module_client"]
	end
	local f4_local9 = Engine[@"lobbygetcontrollinglobbysession"](f4_local8)
	if Lobby.MapVote.VoteState == LuaEnum.MAP_VOTE_STATE.LOCKEDIN then
		local f4_local10 = Engine[@"getlobbysessiongamedata"](Enum[@"lobbymodule"][@"lobby_module_client"], f4_local9)
		local f4_local11 = f4_local10.mapname
		local f4_local12 = f4_local10.gametype
		f4_local0 = f4_local11
		f4_local3 = f4_local12
		f4_local1 = f4_local11
		f4_local4 = f4_local12
		local f4_local13 = Lobby.MapVote.TallyVotes(Enum[@"lobbymodule"][@"lobby_module_client"])
		local f4_local14 = Engine[@"getglobalmodel"]()
		f4_local14.MapVote.lobbyMapVoteType:set(f4_local13)
	else
		local f4_local10 = Engine[@"lobbygetmapvote"](f4_local8, f4_local9)
		if f4_local10 == nil then
			f4_local0 = Engine[@"lobbygetmap"]()
			f4_local3 = Engine[@"lobbygetgametype"]()
		else
			f4_local0 = f4_local10.nextMapName
			f4_local1 = f4_local10.previousMapName
			f4_local3 = f4_local10.nextGametype
			f4_local4 = f4_local10.previousGametype
			previousGametypeType = f4_local4
			if Lobby.MapVote.storedNextPrev == false then
				Lobby.MapVote.storedNextPrev = true
				Engine[@"storeplaylistnextprev"](Enum[@"lobbymodule"][@"lobby_module_host"], f4_local9, f4_local10.playlistNext, f4_local10.playlistPrevious)
			end
		end
	end
	local f4_local10 = Engine[@"getglobalmodel"]()
	local f4_local11 = f4_local10:create("MapVote", true)
	if Engine[@"lobbygetgametype"]() == "doa" then
		f4_local0 = "cp_doa_bo3"
		Engine[@"lobbysetmap"](f4_local9, f4_local0)
	end
	if f4_local0 ~= nil then
		if string.sub(f4_local0, 1, 6) == "cp_sh_" then
			local f4_local12 = Dvar[@"cp_queued_level"]:get()
			if f4_local12 and f4_local12 ~= "" then
				f4_local0 = f4_local12
			end
		end
		if f4_local0 == "" then
			f4_local0 = Engine[@"lobbygetmap"]()
		end
		if f4_local3 == "" or f4_local3 == nil then
			f4_local3 = Engine[@"lobbygetgametype"]()
		end
		local f4_local12 = f4_local11:create("mapVoteMapNext")
		f4_local12:set(Engine[@"converttoxhash"](f4_local0))
		Lobby.MapVote.SetGameModeName(f4_local11, "mapVoteGameModeNext", f4_local3 or "")
	end
	if previousGametypeType then
		local f4_local12 = f4_local11:create("mapVoteMapPreviousGametype")
		f4_local12:set(Engine[@"converttoxhash"](previousGametypeType))
	end
	if f4_local1 ~= nil then
		local f4_local12 = f4_local11:create("mapVoteMapPrevious")
		f4_local12:set(Engine[@"converttoxhash"](f4_local1))
		Lobby.MapVote.SetGameModeName(f4_local11, "mapVoteGameModePrevious", f4_local4 or "")
	end
	return true
end
Lobby.MapVote.OnSessionStart = function(f5_arg0)
	local f5_local0 = f5_arg0.lobbyModule
	local f5_local1 = f5_arg0.lobbyType
	local f5_local2 = f5_arg0.lobbyMode
	if f5_local1 == Enum[@"lobbytype"][@"lobby_type_game"] then
		Lobby.MapVote.Clear()
	end
end
Lobby.MapVote.OnSessionEnd = function(f6_arg0)
	local f6_local0 = f6_arg0.lobbyModule
	local f6_local1 = f6_arg0.lobbyType
	local f6_local2 = f6_arg0.lobbyMode
	if f6_local0 == Enum[@"lobbymodule"][@"lobby_module_host"] and f6_local1 == Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]) then
		Engine[@"setplaylistprevcount"](Enum[@"lobbymodule"][@"lobby_module_host"], f6_local1, 0)
	end
end
Lobby.MapVote.Init = function(f7_arg0)
	if f7_arg0.init == false then
		return
	else
		local f7_local0 = Engine[@"getglobalmodel"]()
		f7_local0:create("lobbyRoot.mapVote", true)
		local f7_local1 = f7_local0:create("MapVote", true)
		local f7_local2 = f7_local1:create("mapVoteMapNext", true)
		f7_local2:set(0x0)
		f7_local2 = f7_local1:create("mapVoteMapPrevious", true)
		f7_local2:set(0x0)
		f7_local2 = f7_local1:create("mapVoteGameModeNext", true)
		f7_local2:set(0x0)
		f7_local2 = f7_local1:create("mapVoteGameModePrevious", true)
		f7_local2:set(0x0)
		f7_local2 = f7_local1:create("mapVoteCountNext", true)
		f7_local2:set(0)
		f7_local2 = f7_local1:create("mapVoteCountPrevious", true)
		f7_local2:set(0)
		f7_local2 = f7_local1:create("mapVoteCountRandom", true)
		f7_local2:set(0)
		f7_local2 = f7_local1:create("mapVoteGameModeRandom", true)
		f7_local2:set(@"hash_A51AE597D138D1E")
		f7_local2 = f7_local1:create("mapVoteCountRandom", true)
		f7_local2:set(0)
		f7_local2 = f7_local1:create("mapVoteMapPreviousGametype", true)
		f7_local2:set(0x0)
		f7_local2 = f7_local1:create("mapVoteCustomGameName", true)
		f7_local2:set(0x0)
		f7_local2 = f7_local1:create("isOfficialVariant", true)
		f7_local2:set(true)
		f7_local2 = f7_local1:create("lobbyMapVoteType", true)
		f7_local2:set(Enum[@"lobbymapvote"][@"lobby_mapvote_none"])
		Lobby.MapVote.Clear()
	end
end
Lobby.MapVote.GetMapVoteStatus = function()
	return Lobby.MapVote.VoteState and Lobby.MapVote.VoteState or LuaEnum.MAP_VOTE_STATE.HIDDEN
end
Lobby.MapVote.SetMapVoteStatus = function(f9_arg0)
	if Lobby.MapVote.VoteState ~= f9_arg0 then
		Lobby.MapVote.VoteState = f9_arg0
		Lobby.MapVote.UpdateMapVoteInfo()
	end
	local f9_local0 = Engine[@"getglobalmodel"]()
	f9_local0 = f9_local0["lobbyRoot.mapVote"]
	if f9_local0:get() == f9_arg0 then
		return false
	end
	f9_local0:set(f9_arg0)
	if f9_arg0 == LuaEnum.MAP_VOTE_STATE.LOCKEDIN then
		Engine[@"hash_55D36C2606141818"](true)
	else
		Engine[@"hash_55D36C2606141818"](false)
	end
	return true
end
Lobby.MapVote.GameLobbyClientDataUpdate = function(f10_arg0)
	if Engine[@"isingame"]() == true then
		return
	end
	local f10_local0 = 0
	local f10_local1 = 0
	local f10_local2 = 0
	local f10_local3 = f10_arg0
	if f10_arg0.clients ~= nil then
		f10_local3 = f10_arg0.clients
	end
	Lobby.MapVote.VoteData = f10_local3
	for f10_local7, f10_local8 in pairs(f10_local3) do
		if f10_local8.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_next"] then
			f10_local0 = f10_local0 + 1
		end
		if f10_local8.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_previous"] then
			f10_local1 = f10_local1 + 1
		end
		if f10_local8.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_random"] then
			f10_local2 = f10_local2 + 1
		end
	end
	f10_local4 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "MapVote", true)
	f10_local4.mapVoteCountNext:set(f10_local0)
	f10_local4.mapVoteCountPrevious:set(f10_local1)
	f10_local4.mapVoteCountRandom:set(f10_local2)
end
Lobby.MapVote.Hide = function()
	Lobby.MapVote.Clear()
end
Lobby.MapVote.ShowVote = function()
	if Lobby.MapVote.UpdateMapVoteInfo() == false then
		return
	else
		Lobby.MapVote.SetMapVoteStatus(LuaEnum.MAP_VOTE_STATE.VOTING)
	end
end
Lobby.MapVote.UpdateMapInfo = function()
	if Lobby.MapVote.UpdateMapVoteInfo() == false then
		return
	end
	local f13_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])
	if Engine[@"getlobbymode"](f13_local0) == Enum[@"lobbymode"][@"lobby_mode_custom"] then
		local f13_local1 = Engine[@"getlobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"], f13_local0)
		if f13_local1 and f13_local1.lobbyData and f13_local1.lobbyData.lobbyCustomData and f13_local1.lobbyData.lobbyCustomData.customGameDetails then
			local f13_local2 = f13_local1.lobbyData.lobbyCustomData.customGameDetails
			local f13_local3 = Engine[@"getglobalmodel"]()
			f13_local3 = f13_local3.MapVote
			local f13_local4 = f13_local3:create("mapVoteCustomGameName")
			f13_local4:set(Engine[@"converttoxhash"](f13_local2.name))
			f13_local4 = f13_local3:create("isOfficialVariant")
			f13_local4:set(f13_local2.isOfficial)
			f13_local4 = f13_local3:create("mapVoteGameModeNext")
			f13_local4:forceNotifySubscriptions()
		end
	end
end
Lobby.MapVote.ShowLockedIn = function()
	local f14_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	if f14_local0[@"lobbymodule"] == Enum[@"lobbymodule"][@"lobby_module_client"] then
		if Lobby.Timer.GetTimerType() == LuaEnum.TIMER_TYPE.THEATER then
		elseif Lobby.MapVote.VoteData == nil then
			return
		end
	end
	Lobby.MapVote.SetMapVoteStatus(LuaEnum.MAP_VOTE_STATE.LOCKEDIN)
	Lobby.MapVote.UpdateMapVoteInfo()
end
Lobby.MapVote.LockedInVote = function()
	if Lobby.MapVote.VoteState == LuaEnum.MAP_VOTE_STATE.LOCKEDIN then
		return
	end
	local f15_local0 = Enum[@"lobbymapvote"][@"lobby_mapvote_next"]
	local f15_local1 = nil
	local f15_local2 = 0
	local f15_local3 = 0
	local f15_local4 = 0
	local f15_local5 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"])
	local f15_local6 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_host"], f15_local5)
	for f15_local10, f15_local11 in ipairs(f15_local6.sessionClients) do
		if f15_local11.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_next"] then
			f15_local2 = f15_local2 + 1
		end
		if f15_local11.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_previous"] then
			f15_local3 = f15_local3 + 1
		end
		if f15_local11.mapVote == Enum[@"lobbymapvote"][@"lobby_mapvote_random"] then
			f15_local4 = f15_local4 + 1
		end
	end
	f15_local7 = false
	f15_local8 = f15_local2
	if f15_local8 < f15_local3 then
		f15_local7 = true
		f15_local8 = f15_local3
		f15_local0 = Enum[@"lobbymapvote"][@"lobby_mapvote_previous"]
		Engine[@"lobbychoosepreviousplaylist"](Enum[@"lobbymodule"][@"lobby_module_host"], f15_local5)
	end
	if f15_local8 < f15_local4 then
		f15_local7 = false
		f15_local8 = f15_local4
		f15_local0 = Enum[@"lobbymapvote"][@"lobby_mapvote_random"]
		Engine[@"lobbychooserandomplaylist"](Enum[@"lobbymodule"][@"lobby_module_host"], f15_local5)
		f15_local9 = Engine[@"getlobbysessiongamedata"](Enum[@"lobbymodule"][@"lobby_module_host"], f15_local5)
		f15_local10 = f15_local9.mapname
		f15_local1 = f15_local9.gametype
	end
	if f15_local7 then
		Engine[@"setplaylistprevcount"](Enum[@"lobbymodule"][@"lobby_module_host"], f15_local5, Engine[@"getplaylistprevcount"](Enum[@"lobbymodule"][@"lobby_module_host"], f15_local5) + 1)
	else
		Engine[@"setplaylistprevcount"](Enum[@"lobbymodule"][@"lobby_module_host"], f15_local5, 0)
	end
	f15_local9 = Engine[@"getglobalmodel"]()
	f15_local9 = f15_local9.MapVote
	f15_local9.mapVoteCountNext:set(f15_local2)
	f15_local9.mapVoteCountPrevious:set(f15_local3)
	f15_local9.mapVoteCountRandom:set(f15_local4)
	f15_local10 = f15_local2
	f15_local11 = Enum[@"lobbymapvote"][@"lobby_mapvote_next"]
	if f15_local10 < f15_local3 then
		f15_local10 = f15_local3
		f15_local11 = Enum[@"lobbymapvote"][@"lobby_mapvote_previous"]
	end
	if f15_local10 < f15_local4 then
		f15_local11 = Enum[@"lobbymapvote"][@"lobby_mapvote_random"]
	end
	f15_local9.lobbyMapVoteType:set(f15_local11)
end
Lobby.MapVote.ShowEndResult = function()
	if Lobby.MapVote.VoteState == LuaEnum.MAP_VOTE_STATE.RESULT then
		return
	else
		Lobby.MapVote.SetMapVoteStatus(LuaEnum.MAP_VOTE_STATE.RESULT)
	end
end
Lobby.MapVote.GameLobbyGameServerDataUpdate = function(f17_arg0)
	if Engine[@"isingame"]() == true then
		return
	else
		Lobby.MapVote.UpdateMapInfo()
	end
end
Lobby.MapVote.Clear = function()
	Lobby.MapVote.VoteData = nil
	Lobby.MapVote.storedNextPrev = false
	Lobby.MapVote.SetMapVoteStatus(LuaEnum.MAP_VOTE_STATE.HIDDEN)
	Engine[@"clearmapvotedata"](Enum[@"lobbymodule"][@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]))
	local f18_local0 = Engine[@"getglobalmodel"]()
	f18_local0 = f18_local0.MapVote
	f18_local0.mapVoteMapNext:set(0x0)
	f18_local0.mapVoteMapPrevious:set(0x0)
	f18_local0.mapVoteGameModeNext:set(0x0)
	f18_local0.mapVoteGameModePrevious:set(0x0)
	f18_local0.mapVoteGameModeRandom:set(@"hash_A51AE597D138D1E")
	f18_local0.mapVoteCountNext:set(0)
	f18_local0.mapVoteCountPrevious:set(0)
	f18_local0.mapVoteCountRandom:set(0)
	f18_local0.mapVoteMapPreviousGametype:set(0x0)
	f18_local0.mapVoteCustomGameName:set(0x0)
	f18_local0.isOfficialVariant:set(true)
	f18_local0.lobbyMapVoteType:set(Enum[@"lobbymapvote"][@"lobby_mapvote_none"])
end
Lobby.MapVote.Pump = function() end
