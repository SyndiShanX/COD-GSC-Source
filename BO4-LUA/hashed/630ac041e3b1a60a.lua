require("x64:53e8db3768fb02a")
require("x64:2f7767db3f402c")
Lobby.Theater = {}
Lobby.Theater.OnSessionStart = function(f1_arg0)
	if f1_arg0.lobbyMode ~= Enum[@"lobbymode"][@"lobby_mode_theater"] then
		return
	else
		Lobby.Theater.fileID = Engine[@"defaultid64value"]()
	end
end
Lobby.Theater.OnSessionEnd = function(f2_arg0)
	if f2_arg0.lobbyMode ~= Enum[@"lobbymode"][@"lobby_mode_theater"] then
		return
	else
		Lobby.MapVote.Clear()
		local f2_local0 = Engine[@"getprimarycontroller"]()
		Engine[@"execnow"](f2_local0, "demo_abortfilesharedownload")
		Engine[@"switchmode"](f2_local0, "")
		Engine[@"freetheatermemoryifallocated"]()
		Engine[@"setdvar"]("ui_demoname", "")
		Lobby.Theater.fileID = Engine[@"defaultid64value"]()
		Lobby.Theater.downloadPercent = 0
		Engine[@"lobbycleardemoinformation"](Enum[@"lobbymodule"][@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]), f2_local0)
	end
end
Lobby.Theater.Pump = function()
	local f3_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	if not f3_local0 then
		return
	elseif f3_local0[@"lobbymode"] ~= Enum[@"lobbymode"][@"lobby_mode_theater"] then
		return
	end
	local f3_local1 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"])
	if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_host"], f3_local1) == false then
		return
	elseif Engine[@"islobbyhost"](f3_local1) == false then
		return
	end
	local f3_local2 = Engine[@"lobbygetdemoinformation"](Enum[@"lobbymodule"][@"lobby_module_client"], f3_local1)
	if f3_local2 then
		local f3_local3 = f3_local2.fileID
		local f3_local4 = f3_local2.readyForPlayback
		local f3_local5 = f3_local2.downloadPercent
		local f3_local6 = false
		local f3_local7 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.theaterDataDownloaded")
		local f3_local8 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.theaterDownloadPercent")
		if Engine[@"getmodelvalue"](f3_local7) == nil or Engine[@"getmodelvalue"](f3_local8) == nil then
			f3_local6 = true
		end
		if f3_local3 ~= Lobby.Theater.fileID or f3_local4 ~= Lobby.Theater.readyForPlayback or f3_local5 ~= Lobby.Theater.downloadPercent or f3_local6 then
			Lobby.Theater.fileID = f3_local3
			Lobby.Theater.readyForPlayback = f3_local2.readyForPlayback
			Lobby.Theater.downloadPercent = f3_local2.downloadPercent
			Engine[@"setmodelvalue"](f3_local7, Lobby.Theater.readyForPlayback)
			Engine[@"setmodelvalue"](f3_local8, Lobby.Theater.downloadPercent)
		end
	end
end
