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
	if Engine[0x7B48C1ABFF0F764]() then
		return
	elseif Lobby.ProcessQueue.IsQueueEmpty() == false then
		return false
	elseif Engine[0xC9190AFD905AC12]() > 0 then
		return false
	elseif Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f2_arg0, Enum[0x575E471C039DBD6][0x92BC25E18D296F]) >= Dvar[0x500E4DB2F10F5EE]:get() then
		return false
	elseif Engine[0x68A5A7A41567A63] and Engine[0x68A5A7A41567A63](f2_arg0) ~= Enum[0x5A046D0646801][0x4787E42BE26EFCD] then
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
		if Lobby.Merge.mergeData.timer > Engine[0x9D33D652B9B0F3B]() then
			return
		end
		local f3_local0 = Engine[0x3797858022DCB59](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		if f3_local0 == -1 then
			f3_local0 = 0
		end
		if Engine[0xE39F1F30B306065]() == true then
			Lobby.ProcessQueue.AddToQueue("Merge", Lobby.Process.MergePublicDedicatedLobby(f3_local0))
		else
			Lobby.ProcessQueue.AddToQueue("Merge", Lobby.Process.MergePublicGameLobby(f3_local0))
		end
		Lobby.Merge.mergeData.merging = true
	end
end
Lobby.Merge.Pump = function()
	if Dvar[0x6AB21D919144AA]:get() == false or Dvar[0x4BADE8473F0165F]:get() == true then
		return
	elseif Engine[0xE39F1F30B306065]() and Dvar[0x6D033E0551BFF83]:get() == false then
		return
	elseif false == Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		Lobby.Merge.mergeData = nil
		return
	elseif Lobby.Timer.GetTimerType() ~= LuaEnum.TIMER_TYPE.AUTO_MP then
		Lobby.Merge.mergeData = nil
		return
	elseif Engine[0x9882F293C327557]() ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) then
		Lobby.Merge.mergeData = nil
		return
	elseif Lobby.Merge.IsMergingAllowed(Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		if Lobby.Merge.mergeData == nil then
			Lobby.Merge.mergeData = {}
			Lobby.Merge.mergeData.timer = Engine[0x9D33D652B9B0F3B]() + Dvar[0x47EDB66E0FE444C]:get()
			Lobby.Merge.mergeData.merging = false
		end
		Lobby.Merge.Update()
	else
		Lobby.Merge.mergeData = nil
	end
end
