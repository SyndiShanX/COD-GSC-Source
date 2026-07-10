require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingPriority = {}
Lobby.MatchmakingPriority.SETTING = {
	DISABLED = 0,
	SINGLE_PRIORITY_LOW = 1,
	MULTI_PRIORITY_LOW = 2,
	SINGLE_IGNORE = 3,
	MULTI_IGNORE = 4,
}
Lobby.MatchmakingPriority.mpPublicGame = {}
Lobby.MatchmakingPriority.doaPublicGame = {}
Lobby.MatchmakingPriority.OnMatchmakingPriorityQuit = function(f1_arg0)
	local f1_local0 = LobbyData.GetLobbyMenuByID(LobbyData.GetLobbyNav())
	if f1_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) then
		Lobby.MatchmakingPriority.AddHost(f1_arg0.hostSecId, Enum[@"jointype"][@"join_type_playlist"])
	end
end
Lobby.MatchmakingPriority.GetSettings = function()
	local f2_local0 = Lobby.MatchmakingPriority.SETTING.DISABLED
	local f2_local1 = nil
	local f2_local2 = 0
	if Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) and Dvar[@"tu11_matchmakingprioritymp"]:exists() then
		f2_local0 = Dvar[@"tu11_matchmakingprioritymp"]:get()
		f2_local1 = Lobby.MatchmakingPriority.mpPublicGame
		f2_local2 = Dvar[@"tu11_matchmakingprioritympignoretime"]:get()
	end
	return f2_local0, f2_local1, f2_local2
end
Lobby.MatchmakingPriority.AddHost = function(f3_arg0, f3_arg1)
	local f3_local0, f3_local1, f3_local2 = Lobby.MatchmakingPriority.GetSettings()
	if f3_local0 == Lobby.MatchmakingPriority.SETTING.DISABLED then
		return
	elseif f3_arg1 ~= Enum[@"jointype"][@"join_type_playlist"] then
		return
	end
	local f3_local3 = nil
	for f3_local7, f3_local8 in pairs(f3_local1) do
		if f3_local8.secId == f3_arg0 then
			f3_local3 = f3_local8
			break
		end
	end
	if f3_local0 == Lobby.MatchmakingPriority.SETTING.SINGLE_PRIORITY_LOW or f3_local0 == Lobby.MatchmakingPriority.SETTING.SINGLE_IGNORE then
		LuaUtils.TableClear(f3_local1)
		table.insert(f3_local1, {
			secId = f3_arg0,
			joinTime = Engine[@"seconds"](),
			ignoreUntilTime = Engine[@"seconds"]() + f3_local2,
		})
	elseif f3_local0 == Lobby.MatchmakingPriority.SETTING.MULTI_PRIORITY_LOW or f3_local0 == Lobby.MatchmakingPriority.SETTING.MULTI_IGNORE then
		if f3_local3 == nil then
			table.insert(f3_local1, {
				secId = f3_arg0,
				joinTime = Engine[@"seconds"](),
				ignoreUntilTime = Engine[@"seconds"]() + f3_local2,
			})
		else
			f3_local3.joinTime = Engine[@"seconds"]()
			f3_local3.ignoreUntilTime = Engine[@"seconds"]() + f3_local2
		end
	end
end
Lobby.MatchmakingPriority.OnMatchStart = function(f4_arg0)
	local f4_local0, f4_local1, f4_local2 = Lobby.MatchmakingPriority.GetSettings()
	if f4_local0 == Lobby.MatchmakingPriority.SETTING.DISABLED then
		return
	else
		LuaUtils.TableClear(f4_local1)
	end
end
Lobby.MatchmakingPriority.IgnoreSearchResult = function(f5_arg0)
	local f5_local0, f5_local1, f5_local2 = Lobby.MatchmakingPriority.GetSettings()
	if f5_local0 == Lobby.MatchmakingPriority.SETTING.DISABLED then
		return false
	elseif f5_local0 == Lobby.MatchmakingPriority.SETTING.SINGLE_PRIORITY_LOW or f5_local0 == Lobby.MatchmakingPriority.SETTING.MULTI_PRIORITY_LOW then
		return false
	end
	for f5_local6, f5_local7 in pairs(f5_local1) do
		if f5_local7.secId == f5_arg0 then
			if f5_local7.ignoreUntilTime > Engine[@"seconds"]() then
			else
				table.remove(f5_local1, f5_local6)
				break
			end
			return true
		end
	end
	return false
end
Lobby.MatchmakingPriority.IsPriorityLow = function(f6_arg0)
	local f6_local0, f6_local1, f6_local2 = Lobby.MatchmakingPriority.GetSettings()
	if f6_local0 == Lobby.MatchmakingPriority.SETTING.DISABLED then
		return false
	elseif f6_local0 == Lobby.MatchmakingPriority.SETTING.SINGLE_IGNORE or f6_local0 == Lobby.MatchmakingPriority.SETTING.MULTI_IGNORE then
		return false
	end
	for f6_local6, f6_local7 in pairs(f6_local1) do
		if f6_local7.secId == f6_arg0 then
			table.remove(f6_local1, f6_local6)
			return true
		end
	end
	return false
end
