require("x64:53e8db3768fb02a")
require("x64:2f7767db3f402c")
Lobby.Theater = {}
Lobby.Theater.OnSessionStart = function(f1_arg0)
	if f1_arg0.lobbyMode ~= Enum[0x8409AA0F01B5DBC][0x8B3B066EFD7CD01] then
		return
	else
		Lobby.Theater.fileID = Engine[0x2B3D98DC8F66DEE]()
	end
end
Lobby.Theater.OnSessionEnd = function(f2_arg0)
	if f2_arg0.lobbyMode ~= Enum[0x8409AA0F01B5DBC][0x8B3B066EFD7CD01] then
		return
	else
		Lobby.MapVote.Clear()
		local f2_local0 = Engine[0xA5B9C0111291A8B]()
		Engine[0xB81A5136C5503E4](f2_local0, "demo_abortfilesharedownload")
		Engine[0xA47E6B48AB89F8E](f2_local0, "")
		Engine[0x6EF15B09AB807C9]()
		Engine[0xB177D654FFB67BE]("ui_demoname", "")
		Lobby.Theater.fileID = Engine[0x2B3D98DC8F66DEE]()
		Lobby.Theater.downloadPercent = 0
		Engine[0x926702316790C77](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]), f2_local0)
	end
end
Lobby.Theater.Pump = function()
	local f3_local0 = LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
	if not f3_local0 then
		return
	elseif f3_local0[0x8409AA0F01B5DBC] ~= Enum[0x8409AA0F01B5DBC][0x8B3B066EFD7CD01] then
		return
	end
	local f3_local1 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	if Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f3_local1) == false then
		return
	elseif Engine[0xEA2BE00F49480D](f3_local1) == false then
		return
	end
	local f3_local2 = Engine[0x23AF33F30C69410](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f3_local1)
	if f3_local2 then
		local f3_local3 = f3_local2.fileID
		local f3_local4 = f3_local2.readyForPlayback
		local f3_local5 = f3_local2.downloadPercent
		local f3_local6 = false
		local f3_local7 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.theaterDataDownloaded")
		local f3_local8 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.theaterDownloadPercent")
		if Engine[0x614D394F6F9A18D](f3_local7) == nil or Engine[0x614D394F6F9A18D](f3_local8) == nil then
			f3_local6 = true
		end
		if f3_local3 ~= Lobby.Theater.fileID or f3_local4 ~= Lobby.Theater.readyForPlayback or f3_local5 ~= Lobby.Theater.downloadPercent or f3_local6 then
			Lobby.Theater.fileID = f3_local3
			Lobby.Theater.readyForPlayback = f3_local2.readyForPlayback
			Lobby.Theater.downloadPercent = f3_local2.downloadPercent
			Engine[0x83C9B5DE1D9371](f3_local7, Lobby.Theater.readyForPlayback)
			Engine[0x83C9B5DE1D9371](f3_local8, Lobby.Theater.downloadPercent)
		end
	end
end
