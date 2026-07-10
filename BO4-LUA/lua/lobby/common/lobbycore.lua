require("x64:b370b3af9224bd0")
require("x64:127dca51df8f7c7")
require("x64:85d6d26960f9bae")
require("x64:856481cd07ea059")
require("x64:c6e3b538b3d95e3")
Lobby = {
	ProcessTree = nil,
	Navigation = {},
	Core = {},
	HANDLER_TYPE_FWD = 1,
	HANDLER_TYPE_BACK = 2,
}
Lobby.Core.AddHandler = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = LobbyData.GetLobbyMenuByName(f1_arg0)
	local f1_local1 = LobbyData.GetLobbyMenuByName(f1_arg1)
	if not f1_local0 or not f1_local1 then
		return
	elseif Lobby.Navigation[f1_local0[@"name"]] == nil then
		Lobby.Navigation[f1_local0[@"name"]] = {}
	end
	if Lobby.Navigation[f1_local0[@"name"]][f1_arg2] == nil then
		Lobby.Navigation[f1_local0[@"name"]][f1_arg2] = {}
	end
	Lobby.Navigation[f1_local0[@"name"]][f1_arg2][f1_local1[@"name"]] = f1_arg3
end
Lobby.Core.AddProcessForward = function(f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = Lobby.HANDLER_TYPE_FWD
	local f2_local1 = LobbyData.GetLobbyMenuByName(f2_arg0)
	local f2_local2 = LobbyData.GetLobbyMenuByName(f2_arg1)
	if not f2_local1 or not f2_local2 then
		return
	elseif Lobby.Navigation[f2_local1[@"name"]] ~= nil and Lobby.Navigation[f2_local1[@"name"]][f2_local0] ~= nil and Lobby.Navigation[f2_local1[@"name"]][f2_local0][f2_local2[@"name"]] ~= nil then
		error("LobbyVM: A forward handler already exists from '" .. f2_local1[@"name"] .. " to " .. f2_local2[@"name"])
	end
	Lobby.Core.AddHandler(f2_arg0, f2_arg1, f2_local0, f2_arg2)
end
Lobby.Core.AddProcessBack = function(f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = Lobby.HANDLER_TYPE_BACK
	local f3_local1 = LobbyData.GetLobbyMenuByName(f3_arg0)
	if not f3_local1 or not LobbyData.GetLobbyMenuByName(f3_arg1) then
		return
	elseif Lobby.Navigation[f3_local1[@"name"]] ~= nil and Lobby.Navigation[f3_local1[@"name"]] ~= nil and Lobby.Navigation[f3_local1[@"name"]][f3_local0] ~= nil then
		error("LobbyVM: A back handler already exists for '" .. f3_local1[@"name"])
	end
	Lobby.Core.AddHandler(f3_arg0, f3_arg1, f3_local0, f3_arg2)
end
Lobby.Core.GetForwardProcessFunc = function(f4_arg0, f4_arg1)
	if Lobby.Navigation[f4_arg0[@"name"]] ~= nil then
		local f4_local0 = Lobby.Navigation[f4_arg0[@"name"]][Lobby.HANDLER_TYPE_FWD]
		if f4_local0 ~= nil and f4_local0[f4_arg1[@"name"]] ~= nil then
			return f4_local0[f4_arg1[@"name"]]
		end
	end
	return nil
end
Lobby.Core.GetBackProcessFunc = function(f5_arg0)
	if Lobby.Navigation[f5_arg0[@"name"]] ~= nil then
		local f5_local0 = Lobby.Navigation[f5_arg0[@"name"]][Lobby.HANDLER_TYPE_BACK]
		if f5_local0 ~= nil then
			local f5_local1, f5_local2, f5_local3 = pairs(f5_local0)
			local f5_local4, f5_local5 = f5_local1(f5_local2, f5_local3)
			if f5_local4 ~= nil then
				f5_local3 = f5_local4
				return LobbyData.GetLobbyMenuByName(f5_local4), f5_local5
			end
		end
	end
	return nil, nil
end
Lobby.Core.GetMainModeStr = function(f6_arg0)
	return LuaUtils.GetAbbreviationForMainMode(f6_arg0)
end
