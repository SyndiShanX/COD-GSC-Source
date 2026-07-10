require("x64:53e8db3768fb02a")
require("x64:3050b56bc941c17")
require("x64:2f7767db3f402c")
require("x64:b370b3af9224bd0")
Lobby.JSON = {}
Lobby.JSON.BuildMapPackFlagsTable = function(f1_arg0, f1_arg1, f1_arg2)
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0x8F57745D21DF973] > 0 then
		table.insert(f1_arg0, "MP_ORIGINAL_MAPS")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "MP_ORIGINAL_MAPS \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0xD0159800EF882D] > 0 then
		table.insert(f1_arg0, "DLC_1")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_1 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0x29A60980B253C57] > 0 or f1_arg2 then
		table.insert(f1_arg0, "DLC_2")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_2 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0x8261E9804B77826] > 0 then
		table.insert(f1_arg0, "DLC_3")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_3 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0xA487F980F37C788] > 0 or f1_arg2 then
		table.insert(f1_arg0, "DLC_4")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_4 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0x2B943980B3FBB9F] > 0 then
		table.insert(f1_arg0, "DLC_5")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_5 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0xCEE5E97EC437975] > 0 or f1_arg2 then
		table.insert(f1_arg0, "DLC_6")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_6 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0xA298C980F1D2D10] > 0 then
		table.insert(f1_arg0, "DLC_7")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_7 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0x7448D97F2981FCE] > 0 or f1_arg2 then
		table.insert(f1_arg0, "DLC_8")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_8 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0xCAD7197EC0C02C9] > 0 then
		table.insert(f1_arg0, "DLC_9")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_9 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0xEFFA497F6B527C3] > 0 or f1_arg2 then
		table.insert(f1_arg0, "DLC_10")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_10 \n")
	end
	if f1_arg1 & Enum[0xE2A6806BB83D51C][0x7699A97F2B75222] > 0 then
		table.insert(f1_arg0, "DLC_11")
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "DLC_11 \n")
	end
	return f1_arg0
end
Lobby.JSON.GetMappackBitsForName = function(f2_arg0)
	local f2_local0 = 0
	if f2_arg0 == "MP_ORIGINAL_MAPS" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0x8F57745D21DF973]
	elseif f2_arg0 == "DLC_1" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0xD0159800EF882D]
	elseif f2_arg0 == "DLC_2" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0x29A60980B253C57]
	elseif f2_arg0 == "DLC_3" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0x8261E9804B77826]
	elseif f2_arg0 == "DLC_4" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0xA487F980F37C788]
	elseif f2_arg0 == "DLC_5" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0x2B943980B3FBB9F]
	elseif f2_arg0 == "DLC_6" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0xCEE5E97EC437975]
	elseif f2_arg0 == "DLC_7" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0xA298C980F1D2D10]
	elseif f2_arg0 == "DLC_8" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0x7448D97F2981FCE]
	elseif f2_arg0 == "DLC_9" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0xCAD7197EC0C02C9]
	elseif f2_arg0 == "DLC_10" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0xEFFA497F6B527C3]
	elseif f2_arg0 == "DLC_11" then
		f2_local0 = Enum[0xE2A6806BB83D51C][0x7699A97F2B75222]
	end
	return f2_local0
end
Lobby.JSON.ErrorWrite = function(f3_arg0, f3_arg1, f3_arg2)
	Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], f3_arg1 .. ": " .. f3_arg2 .. "\n")
	if f3_arg0 ~= nil then
		f3_arg0:endWrite()
	end
	return nil
end
Lobby.JSON.ErrorParsing = function(f4_arg0, f4_arg1, f4_arg2)
	Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], f4_arg1 .. ": " .. f4_arg2 .. "\n")
	if f4_arg0 ~= nil then
		f4_arg0:endParse()
	end
	return nil
end
Lobby.JSON.CreateFieldAndAddToLocation = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg1:setField(f5_arg2, LuaEnum.JSON_TYPE.JSON_OBJECT)
	if f5_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "failed to set '" .. f5_arg2 .. "' field.\n")
		return nil
	else
		return f5_local0
	end
end
Lobby.JSON.CreateArrayAndAddToLocation = function(f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = f6_arg1:setField(f6_arg2, LuaEnum.JSON_TYPE.JSON_ARRAY)
	if f6_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "failed to set '" .. f6_arg2 .. "' array field.\n")
		return nil
	else
		return f6_local0
	end
end
Lobby.JSON.ParseLobbyHostDoc = function(f7_arg0, f7_arg1)
	local f7_local0 = "Lobby.JSON.ParseLobbyHostDoc"
	local f7_local1 = Engine[0xA4245AC303B4CD5]()
	if f7_local1 == nil then
		return Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to create JSON handle.\n")
	elseif f7_local1:beginParse("lobbyHostDoc", f7_arg0 .. " ") == false then
		return Lobby.JSON.ErrorParsing(f7_local1, f7_local0, "failed to parse lobbyHostDoc JSON.\n")
	end
	local f7_local2 = f7_local1:getRoot()
	if f7_local2 == nil then
		return Lobby.JSON.ErrorParsing(f7_local1, f7_local0, "failed to get root of lobbyHostDoc JSON.\n")
	end
	local f7_local3 = f7_local2:getUInt64("update_id")
	if f7_local3 == nil then
		Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'update_id'.\n")
		f7_local3 = 0
	end
	local f7_local4 = f7_local2:getUInt64("game_id")
	if f7_local4 == nil then
		Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'game_id'.\n")
		f7_local4 = 0
	end
	local f7_local5 = f7_local2:getUInt64("update_time")
	if f7_local5 == nil then
		Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'update_time'.\n")
		f7_local5 = 0
	end
	local f7_local6 = f7_local2:getBool("lobby_open_for_pres_join")
	if f7_local6 == nil then
		Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'lobby_open_for_pres_join'. Default to true\n")
		f7_local6 = true
	end
	local f7_local7 = ""
	local f7_local8 = 0
	local f7_local9 = f7_local2:getFieldByKey("listen_server")
	if f7_local9 ~= nil then
		f7_local7 = f7_local9:getString("host_address")
		if f7_local7 == nil then
			Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'listen_server:host_address'.")
		end
		f7_local8 = f7_local9:getUInt64("host_player_id")
		if f7_local8 == nil then
			Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'listen_server:host_player_id'.")
		end
		local f7_local10 = {
			host_player_id = f7_local8,
			host_address = f7_local7,
			hostAddress = Engine[0xDF4C7BBB34DA21C](f7_local7),
		}
		local f7_local11 = {}
		local f7_local12 = f7_local2:getFieldByKey("player_state")
		if f7_local12 == nil then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.ParseLobbyHostDoc: Missing current_player_state\n")
		else
			for f7_local17, f7_local18 in ipairs(f7_local12:getAllKeys()) do
				local f7_local16 = f7_local12:getUInt64(f7_local18)
				if f7_local16 == nil then
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.ParseLobbyHostDoc: current_player_state[" .. f7_local18 .. "] failed to get connection state\n")
					f7_local16 = LuaEnum.LobbyMemberStatus.MEMBER_STATUS_UNACKNOWLEDGED
				end
				f7_local11[f7_local18] = f7_local16
			end
		end
		local f7_local19 = "No Name"
		local f7_local13 = 0
		local f7_local14 = f7_local2:getFieldByKey("attachment")
		if f7_local14 ~= nil and f7_local14:hasData() then
			host_name = f7_local14:getString("host_name")
			if nil == host_name then
				Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'host_name'.")
				f7_local19 = ""
			end
			f7_local13 = f7_local14:getUInt("host_menuID")
			if f7_local13 == nil then
				Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'host_menuID'.\n")
			end
		end
		local f7_local15 = {
			host_menuID = f7_local13,
			host_name = host_name,
		}
		local f7_local17 = f7_local2:getBool("lobby_open")
		if f7_local17 == nil then
			f7_local17 = false
		end
		local f7_local18 = f7_local2:getFieldByKey("team_balance")
		local f7_local16 = false
		if f7_local18 ~= nil then
			f7_local16 = f7_local18:getBool("can_change_teams")
			if f7_local16 == nil then
				Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read bool 'team_balance:can_change_teams'.\n")
			end
		else
			Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read field 'team_balance'.\n")
		end
		local f7_local20 = {
			can_change_teams = f7_local16,
		}
		local f7_local21 = false
		local f7_local22 = false
		local f7_local23 = f7_local2:getFieldByKey("ruleset_payload")
		if f7_local23 ~= nil and f7_local23:hasData() then
			if f7_local23:checkIfFieldHasData("is_merge_src") and f7_local23:getBool("is_merge_src") == nil then
				Lobby.JSON.ErrorParsing(f7_local1, f7_local0, "failed to read 'ruleset_payload:is_merge_src'.\n")
				f7_local21 = false
			end
			if f7_local23:checkIfFieldHasData("is_merge_dst") then
				f7_local22 = f7_local23:getBool("is_merge_dst")
				if f7_local22 == nil then
					Lobby.JSON.ErrorParsing(f7_local1, f7_local0, "failed to read 'ruleset_payload:is_merge_dst'.\n")
					f7_local22 = false
				end
			end
		else
			Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read field 'ruleset_payload'.\n")
		end
		if f7_local2:checkIfFieldHasData("dedicated_server") == true then
			dedicated_server = f7_local2:getFieldByKey("dedicated_server")
			if nil ~= dedicated_server then
				dedicated_server_user_id = dedicated_server:getUInt64("user_id")
				if nil == dedicated_server_user_id then
					Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'dedicated_server:user_id'.")
				end
				dedicated_server_data_center = dedicated_server:getString("data_center")
				if nil == dedicated_server_data_center then
					Lobby.JSON.ErrorParsing(nil, f7_local0, "failed to read 'dedicated_server:data_center'.")
				else
				end
			end
		end
		local f7_local24 = {}
		if nil ~= dedicated_server_user_id and nil ~= dedicated_server_data_center then
			f7_local24 = {
				user_id = dedicated_server_user_id,
				data_center = dedicated_server_data_center,
			}
		end
		f7_local1:endParse()
		f7_local1 = nil
		local f7_local25 = {
			lobbyDoc = f7_arg0,
			update_id = f7_local3,
			update_time = f7_local5,
			game_id = f7_local4,
			listen_server = f7_local10,
			attachment = f7_local15,
			current_player_state = f7_local11,
			lobby_open = f7_local17,
			lobby_open_for_pres_join = f7_local6,
			is_merge_src = f7_local21,
			is_merge_dst = f7_local22,
			team_balance = f7_local20,
			dedicated_server = f7_local24,
		}
		if f7_arg1 == nil then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], f7_local0 .. "\n lobbyHostDoc: " .. f7_arg0 .. "\n lobbyHostXuid: " .. Engine[0x4C599F1694E23EF](f7_local25.listen_server.host_player_id) .. "\n hostAddressBase64Encoded: " .. f7_local25.listen_server.host_address .. ".\n")
		end
		return f7_local25
	end
	return Lobby.JSON.ErrorParsing(f7_local1, f7_local0, "failed to read 'listen_server'.\n")
end
Lobby.JSON.CreateWritableDocFromString = function(f8_arg0)
	local f8_local0 = Engine[0x1FCAFA688299BE3](f8_arg0 .. " ")
	if f8_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.CreateWritableDocFromString: couldn't create json object\n")
		return nil
	else
		local f8_local1 = f8_local0:getRoot()
		if f8_local1 == nil then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.CreateWritableDocFromString: failed to get root of lobbyHostDoc JSON\n")
			f8_local0:endWrite()
			return nil
		else
			return f8_local0, f8_local1
		end
	end
end
Lobby.JSON.CreateConvertJsonToStringAndCloseHandle = function(f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0:getRepresentation()
	if f9_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.MatchmakingAsync.CreateConvertJsonToStringAndClose: failed (getRepresentation) to get JSON.\n")
	else
		f9_arg1.lobbyDoc = f9_local0
	end
	f9_arg0:endWrite()
end
Lobby.JSON.setUpdateID = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	if f10_arg1:setUInt64("update_id", f10_arg3) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.setUpdateID: failed setting the 'update_id' in the lobbyhostdoc.\n")
	end
	f10_arg2.update_id = f10_arg3
	return f10_arg2
end
Lobby.JSON.setUpdateTime = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	if f11_arg1:setUInt64("update_time", f11_arg3) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.setUpdateTime: failed setting the 'update_time' in the lobbyhostdoc.\n")
	end
	f11_arg2.update_time = f11_arg3
	return f11_arg2
end
Lobby.JSON.setCanSplitTeam = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	local f12_local0 = f12_arg1:getFieldByKey("team_balance")
	if f12_local0 ~= nil and f12_local0:setBool("can_change_teams", f12_arg3) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.setCanSplitTeam: failed setting the 'game_is_in_progress' in the lobbyhostdoc.\n")
	end
	f12_arg2.team_balance.can_change_teams = f12_arg3
	f12_arg2.needs_update = true
	return f12_arg2
end
Lobby.JSON.setLobbyOpen = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	if f13_arg1:getFieldByKey("lobby_open") ~= nil and f13_arg1:setBool("lobby_open", f13_arg3) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.setLobbyOpen: failed setting the 'lobby_open' in the lobbyhostdoc.\n")
	end
	f13_arg2.lobby_open = f13_arg3
	f13_arg2.needs_update = true
	Engine[0xCD447775E2BE007](f13_arg3)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.setLobbyOpen: Lobby.MMAsync.AdvertStatus was " .. tostring(Lobby.MMAsync.AdvertStatus) .. " now it's " .. tostring(f13_arg3) .. "\n")
	Lobby.MMAsync.AdvertStatus = f13_arg3
	return f13_arg2
end
Lobby.JSON.setAllowPresenseJoin = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
	if f14_arg1:getFieldByKey("lobby_open_for_pres_join") ~= nil and f14_arg1:setBool("lobby_open_for_pres_join", f14_arg3) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.setLobbyOpen: failed setting the 'lobby_open_for_pres_join' in the lobbyhostdoc.\n")
	end
	f14_arg2.lobby_open_for_pres_join = f14_arg3
	f14_arg2.needs_update = true
	return f14_arg2
end
Lobby.JSON.setGameID = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
	if f15_arg1:setUInt64("game_id", f15_arg3) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.setUpdateID: failed setting the 'game_id' in the lobbyhostdoc.\n")
	end
	f15_arg2.game_id = f15_arg3
	return f15_arg2
end
Lobby.JSON.AddExpectedPlayersToLobbyHostDoc = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4)
	local f16_local0 = f16_arg1:getFieldByKey("player_state")
	if f16_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddExpectedPlayersToLobbyHostDoc: failed to read 'current_player_state' field.\n")
		return nil
	end
	for f16_local4, f16_local5 in ipairs(f16_arg3.expectedPlayers) do
		if f16_arg4[f16_local5.xuidstrnum] == nil then
			if f16_local0:getFieldByKey(f16_local5.xuidstrnum) == nil then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddExpectedPlayersToLobbyHostDoc: Player not found adding \n")
				f16_arg2.needs_update = true
				f16_arg2.current_player_state[f16_local5.xuidstrnum] = LuaEnum.LobbyMemberStatus.MEMBER_STATUS_MAY_CONNECT
				Lobby.MatchmakingAsync.AddReservation(f16_local5.xuidstrnum)
				if f16_local0:setUInt64(f16_local5.xuidstrnum, Engine[0x8506F73B393062F](LuaEnum.LobbyMemberStatus.MEMBER_STATUS_MAY_CONNECT)) == false then
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddExpectedPlayersToLobbyHostDoc: failed to write xuid(" .. f16_local5.xuidstrnum .. ") to 'current_player_state' Expecting player may connect.\n")
				end
			end
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddExpectedPlayersToLobbyHostDoc: Player found \n")
			if f16_arg2.current_player_state[f16_local5.xuidstrnum] == nil or f16_arg2.current_player_state[f16_local5.xuidstrnum] < LuaEnum.LobbyMemberStatus.MEMBER_STATUS_MAY_CONNECT then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddExpectedPlayersToLobbyHostDoc: Player found Updating \n")
				f16_arg2.current_player_state[f16_local5.xuidstrnum] = LuaEnum.LobbyMemberStatus.MEMBER_STATUS_MAY_CONNECT
				f16_arg2.needs_update = true
				if f16_local0:setUInt64(f16_local5.xuidstrnum, Engine[0x8506F73B393062F](LuaEnum.LobbyMemberStatus.MEMBER_STATUS_MAY_CONNECT)) == false then
					Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddExpectedPlayersToLobbyHostDoc: failed to write xuid(" .. f16_local5.xuidstrnum .. ") to 'current_player_state' Expecting player may connect.\n")
				end
				Lobby.MatchmakingAsync.AddReservation(f16_local5.xuidstrnum)
			end
		end
	end
	return f16_arg2
end
Lobby.JSON.migrateHostData = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
	local f17_local0 = f17_arg1:getFieldByKey("listen_server")
	if f17_local0 then
		if f17_local0:setUInt64("host_player_id", f17_arg3.hostXuid) == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.migrateHostData: failed to write 'lobby_host'.\n")
		end
		if f17_local0:setString("host_address", f17_arg3.hostAddress) == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.migrateHostData: failed to write 'lobby_host_address'.\n")
		end
	end
	f17_arg2.listen_server.host_player_id = f17_arg3.hostXuid
	f17_arg2.listen_server.host_address = f17_arg3.hostAddress
	f17_arg2.listen_server.hostAddress = Engine[0xDF4C7BBB34DA21C](f17_arg3.hostAddress)
	local f17_local1 = f17_arg1:getFieldByKey("attachment")
	if f17_local1 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.migrateHostData: failed to get 'attachment' field from hostdoc.\n")
	else
		if f17_local1:setString("host_name", f17_arg3.gamertag) == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.migrateHostData: failed to write 'host_name' in the attachment.\n")
		end
		f17_arg2.attachment.host_name = f17_arg3.gamertag
	end
	local f17_local2 = f17_arg1:getFieldByKey("player_state")
	if f17_local2 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.migrateHostData: failed to read 'current_player_state' field.\n")
	end
	for f17_local10, f17_local11 in ipairs(f17_local2:getAllKeys()) do
		local f17_local6 = false
		for f17_local7, f17_local8 in ipairs(f17_arg3.sessionClients) do
			if f17_local11 == f17_local8.xuidstrnum then
				f17_local6 = true
				break
			end
		end
		if f17_local6 == false then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.migrateHostData: Migration Data setting XUID [" .. f17_local11 .. "] to MEMBER_STATUS_WONT_CONNECT\n")
			f17_local2:deleteField(f17_local11)
			f17_arg2.current_player_state[f17_local11] = nil
		end
	end
	f17_arg2.needs_update = true
	return f17_arg2
end
Lobby.JSON.RemoveClientsFromHostData = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	local f18_local0 = f18_arg1:getFieldByKey("player_state")
	if f18_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.RemoveClientsFromHostData: failed to read 'current_player_state' field.\n")
		return nil
	end
	for f18_local4, f18_local5 in ipairs(f18_arg3.removeList) do
		if f18_local0:deleteField(f18_local5.xuidstrnum) then
			f18_arg2.needs_update = true
			f18_arg2.current_player_state[f18_local5.xuidstrnum] = nil
			Lobby.MatchmakingAsync.RemoveReservation(f18_local5.xuidstrnum)
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Removed client xuid:" .. f18_local5.xuidstrnum .. "/" .. tostring(f18_local5.xuid) .. ".\n")
		end
	end
	return f18_arg2
end
Lobby.JSON.AddClientsToHostData = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	local f19_local0 = f19_arg1:getFieldByKey("player_state")
	if f19_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddClientsToHostData: failed to read 'current_player_state' field.\n")
		return nil
	end
	for f19_local4, f19_local5 in ipairs(f19_arg3.sessionClients) do
		local f19_local6 = f19_arg2.current_player_state[f19_local5.xuidstrnum]
		if f19_local0:setUInt64(f19_local5.xuidstrnum, Engine[0x8506F73B393062F](LuaEnum.LobbyMemberStatus.MEMBER_STATUS_CONNECTED)) == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddClientsToHostData: failed to write xuid(" .. f19_local5.xuidstrnum .. ") to 'current_player_state' .\n")
		end
		Lobby.MatchmakingAsync.RemoveReservation(f19_local5.xuidstrnum)
		f19_arg2.current_player_state[f19_local5.xuidstrnum] = LuaEnum.LobbyMemberStatus.MEMBER_STATUS_CONNECTED
		if f19_local6 ~= LuaEnum.LobbyMemberStatus.MEMBER_STATUS_CONNECTED then
			f19_arg2.needs_update = true
		end
	end
	return f19_arg2
end
Lobby.JSON.UpdateMergeRules = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	local f20_local0 = f20_arg1:getFieldByKey("ruleset_payload")
	if f20_local0 then
		if f20_local0:setBool("is_merge_src", f20_arg3.src) == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.UpdateMergeRules: failed to write 'is_merge_src'\n")
		end
		if f20_local0:setBool("is_merge_dst", f20_arg3.dst) == false then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.UpdateMergeRules: failed to write 'is_merge_dst'\n")
		end
	end
	f20_arg2.is_merge_src = f20_arg3.src
	f20_arg2.is_merge_dst = f20_arg3.dst
	f20_arg2.needs_update = true
	return f20_arg2
end
Lobby.JSON.AddHostAttachmentInfo = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
	local f21_local0 = f21_arg1:setField("attachment", LuaEnum.JSON_TYPE.JSON_OBJECT)
	if f21_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddHostData: failed to add 'attachment' Array field to hostdoc.\n")
		return nil
	elseif f21_local0:setString("host_name", f21_arg3.hostName) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddHostData: failed to write 'host_name' in the attachment.\n")
		return nil
	elseif f21_local0:setUInt("host_menuID", f21_arg3.menuID) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.AddHostData: failed to write 'host_menuID' in the attachment.\n")
		return nil
	else
		f21_arg2.attachment = {
			host_name = f21_arg3.hostName,
			host_menuID = f21_arg3.menuID,
		}
		f21_arg2.needs_update = true
		return f21_arg2
	end
end
Lobby.JSON.markDedicatedToShutdown = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = f22_arg1:getFieldByKey("dedicated_server")
	if f22_local0 ~= nil and f22_local0:setBool("shutting_down", true) == false then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.markDedicatedToShutdown: failed setting the 'dedicated_server.shutting_down' in the lobbyhostdoc.\n")
	end
	f22_arg2.dedicated_server.shutting_down = true
	f22_arg2.needs_update = true
	return f22_arg2
end
Lobby.JSON.ParseLobbyBackendDoc = function(f23_arg0)
	local f23_local0, f23_local1 = nil
	local f23_local2 = 0
	while f23_local0 == nil and f23_local2 < 3 do
		f23_local0, f23_local1 = Lobby.JSON.ParseLobbyBackendDocInternal(f23_arg0)
		if f23_local0 == nil then
			local f23_local3 = false
			if f23_local1 ~= nil and string.find(f23_arg0, f23_local1) == nil then
				f23_local3 = true
			end
			Engine[0xDE279ECDDDD966](0, "dlog_event_backend_doc_parse_failure", {
				lobby_backend_doc = f23_arg0,
				error_on_reading = f23_local1,
				missing_entry = f23_local3,
			})
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.ParseLobbyBackendDoc: Failed to parse lobbyBackendDoc try# [" .. tostring(f23_local2) .. "] is missing entry " .. tostring(f23_local3) .. "\n")
			if f23_local3 == true then
				f23_local2 = 4
			end
		end
		f23_local2 = f23_local2 + 1
	end
	if f23_local0 == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.ParseLobbyBackendDoc: Failed to parse lobbyBackendDoc 3 times throwing com error \n")
		Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x2FD312C2C06EC11], "Lobby.JSON.ParseLobbyBackendDoc has failed, please email your logs to codcoreonline@treyarch.com")
	end
	return f23_local0
end
Lobby.JSON.ParseLobbyBackendDocInternal = function(f24_arg0)
	local f24_local0 = "Lobby.JSON.ParseLobbyBackendDocInternal"
	local f24_local1 = Engine[0xA4245AC303B4CD5]()
	if f24_local1 == nil then
		return Lobby.JSON.ErrorParsing(nil, f24_local0, "failed to create JSON handle.\n"), nil
	elseif f24_local1:beginParse("lobbyBackendDoc", f24_arg0 .. " ") == false then
		return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to parse lobbyBackendDoc JSON.\n"), "docHandle"
	end
	local f24_local2 = f24_local1:getRoot()
	if f24_local2 == nil then
		return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to get root of lobbyBackendDoc JSON.\n"), "no root"
	end
	local f24_local3 = f24_local2:getUInt64("lobby_id")
	if f24_local3 == nil then
		return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'lobby_id'.\n"), "lobby_id"
	end
	local f24_local4 = f24_local2:getUInt64("create_time")
	if f24_local4 == nil then
		return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'create_time'.\n"), "create_time"
	end
	local f24_local5 = f24_local2:getUInt64("update_time")
	if f24_local5 == nil then
		return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'update_time'.\n"), "update_time"
	end
	local f24_local6 = f24_local2:getUInt64("update_id")
	if f24_local6 == nil then
		return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'update_id'.\n"), "update_id"
	end
	local f24_local7 = ""
	local f24_local8 = ""
	local f24_local9 = f24_local2:getFieldByKey("dtls")
	if f24_local9 then
		f24_local7 = f24_local9:getString("security_id")
		if f24_local7 == nil then
			return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'security_id'.\n"), "security_id"
		end
		f24_local8 = f24_local9:getString("security_key")
		if f24_local8 == nil then
			return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'security_key'.\n"), "security_key"
		end
		local f24_local10 = f24_local2:getFieldByKey("lobby_size")
		local f24_local11 = 0
		local f24_local12 = 0
		if f24_local10 then
			local f24_local13 = f24_local10:getUInt("min")
			if f24_local13 == nil then
				return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'lobby_size:min'.\n"), "lobby_size:min"
			end
			f24_local11 = f24_local13
			local f24_local14 = f24_local10:getUInt("max")
			if f24_local14 == nil then
				return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'lobby_size:max'.\n"), "lobby_size:man"
			end
			f24_local13 = {
				min = f24_local11,
				max = f24_local14,
			}
			f24_local14 = {}
			local f24_local15 = f24_local2:getFieldByKey("team_balance")
			if f24_local15 then
				local f24_local16 = f24_local15:getUInt("num")
				if f24_local16 == nil then
					return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'team_balance:num'.\n"), "team_balance:num"
				end
				local f24_local17 = f24_local15:getFieldByKey("teams")
				if f24_local17 == nil then
					return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'teams'.\n"), "team_balance:teams"
				end
				local f24_local18 = 0
				while f24_local18 < f24_local16 do
					local f24_local19 = f24_local17:getFieldByKey(tostring(f24_local18))
					local f24_local20 = f24_local19:getFieldSize()
					if f24_local20 ~= nil then
						local f24_local21 = #f24_local14
						f24_local14[f24_local21 + 1] = {}
						for f24_local22 = 1, f24_local20, 1 do
							f24_local14[f24_local21 + 1][f24_local22] = f24_local19:getUInt64ByIndex(f24_local22 - 1)
						end
					end
					f24_local18 = f24_local18 + 1
				end
			end
			local f24_local16 = ""
			local f24_local17 = ""
			local f24_local18 = f24_local2:getFieldByKey("dedicated_server")
			if f24_local18 then
				f24_local17 = f24_local18:getString("build_name")
				if f24_local17 == nil then
					return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'build_name'.\n"), "dedicated_server:build_name"
				end
				f24_local16 = f24_local18:getString("need_for_dedicated_server")
				if f24_local16 == nil then
					return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'need_for_dedicated_server'.\n"), "dedicated_server:need_for_dedicated_server"
				end
			end
			local f24_local19 = f24_local2:getFieldByKey("players")
			if f24_local19 == nil then
				return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'expected_players' field.\n"), "players"
			end
			local f24_local20 = {}
			for f24_local25, f24_local26 in ipairs(f24_local19:getAllKeys()) do
				f24_local20[#f24_local20 + 1] = {
					xuid = Engine[0x9073FBE2D48C156](f24_local26),
					xuidstrnum = f24_local26,
				}
			end
			f24_local22 = 0
			f24_local23 = false
			f24_local24 = f24_local2:getFieldByKey("ruleset_payload")
			if f24_local24 then
				f24_local25 = f24_local24:getFieldByKey("filter")
				if f24_local25 then
					f24_local22 = f24_local25:getInt("playlist_id")
					if f24_local22 == nil then
						return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'ruleset_payload.filter.playlist_id'.\n"), "ruleset_payload:playlist_id"
					end
					f24_local23 = f24_local24:getBool("forced_empty")
					f24_local25 = {}
					f24_local26 = 0
					local f24_local27 = ""
					local f24_local28 = f24_local2:getFieldByKey("game_state")
					if f24_local28 then
						local f24_local29 = f24_local28:getFieldByKey("valid_map_packs")
						if f24_local29 then
							local f24_local30 = f24_local29:getFieldSize()
							for f24_local31 = 0, f24_local30 - 1, 1 do
								f24_local27 = f24_local29:getStringByIndex(f24_local31)
								table.insert(f24_local25, f24_local27)
								f24_local26 = f24_local26 | Lobby.JSON.GetMappackBitsForName(f24_local27)
							end
						end
					end
					f24_local1:endParse()
					local f24_local29 = Engine[0xE46D712FE84AF13](f24_local7, f24_local8)
					local f24_local30 = {
						lobbyDoc = f24_arg0,
						lobbyID = f24_local3,
						create_time = f24_local4,
						update_id = f24_local6,
						update_time = f24_local5,
						secIdKey = f24_local29,
						secId = f24_local29.secId,
						secKey = f24_local29.secKey,
						secIdBase64Encoded = f24_local7,
						secKeyBase64Encoded = f24_local8,
						expectedPlayers = f24_local20,
						teams = f24_local14,
						lobby_size = f24_local13,
						num_teams = num_teams,
						build_name = f24_local17,
						need_for_dedicated_server = f24_local16,
						playlist_id = f24_local22,
						forced_empty = f24_local23,
						valid_map_pack_bits = f24_local26,
						valid_map_packs = f24_local25,
					}
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.MatchmakingAsync.ParseLobbyBackendDoc:" .. "\n lobbyBackendDoc: " .. f24_local30.lobbyDoc .. "\n lobbyID: " .. Engine[0x4C599F1694E23EF](f24_local30.lobbyID) .. "\n updateID: " .. Engine[0x4C599F1694E23EF](f24_local30.update_id) .. "\n secIdBase64Encoded: " .. f24_local30.secIdBase64Encoded .. "\n secKeyBase64Encoded: " .. f24_local30.secKeyBase64Encoded .. "\n playlistID: " .. tostring(f24_local30.playlist_id) .. "\n")
					return f24_local30, nil
				end
				return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'ruleset_payload.filter'.\n"), "ruleset_payload:filter"
			end
			return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'ruleset_payload' field.\n"), "ruleset_payload"
		end
		return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'lobby_size'.\n"), "lobby_size"
	end
	return Lobby.JSON.ErrorParsing(f24_local1, f24_local0, "failed to read 'dtls' field.\n"), "dtls"
end
Lobby.JSON.ParseDCQoSInfo = function(f25_arg0)
	local f25_local0 = function(f26_arg0, f26_arg1)
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.ParseDCQoSInfo: " .. f26_arg1)
		if f26_arg0 ~= nil then
			f26_arg0:endParse()
		end
		return nil
	end
	local f25_local1 = Engine[0xA4245AC303B4CD5]()
	if f25_local1 == nil then
		return f25_local0(nil, "failed to create JSON handle.\n")
	elseif f25_local1:beginParse("dcQoSInfo", f25_arg0 .. " ") == false then
		return f25_local0(f25_local1, "failed to parse dcQoSInfo JSON.\n")
	end
	local f25_local2 = f25_local1:getRoot()
	if f25_local2 == nil then
		return f25_local0(f25_local1, "failed to get root of dcQoSInfo JSON.\n")
	end
	local f25_local3 = f25_local2:getUInt("num_probes")
	if f25_local3 == nil then
		return f25_local0(f25_local1, "failed to read 'num_probes'.\n")
	end
	local f25_local4 = f25_local2:getUInt64("transaction_id")
	if f25_local4 == nil then
		return f25_local0(f25_local1, "failed to read 'transaction_id'.\n")
	end
	local f25_local5 = f25_local2:getFieldByKey("hosts")
	if f25_local5 == nil then
		return f25_local0(f25_local1, "failed to read 'hosts' field.\n")
	end
	local f25_local6 = f25_local5:getFieldSize()
	if f25_local6 == nil then
		return f25_local0(f25_local1, "failed to read 'hosts' field size.\n")
	end
	local f25_local7 = {}
	for f25_local8 = 1, f25_local6, 1 do
		local f25_local11 = f25_local5:getFieldByIndex(f25_local8 - 1)
		if f25_local11 == nil then
			return f25_local0(f25_local1, "failed to read host field at index " .. tostring(f25_local8 - 1) .. " from 'hosts'.\n")
		end
		local f25_local12 = f25_local11:getString("security_id")
		if f25_local12 == nil then
			return f25_local0(f25_local1, "failed to read 'security_id'.\n")
		end
		local f25_local13 = f25_local11:getString("security_key")
		if f25_local13 == nil then
			return f25_local0(f25_local1, "failed to read 'security_key'.\n")
		end
		local f25_local14 = f25_local11:getString("address")
		if f25_local14 == nil then
			return f25_local0(f25_local1, "failed to read 'address'.\n")
		end
		local f25_local15 = ""
		if f25_local11:checkIfFieldHasData("datacenter") then
			f25_local15 = f25_local11:getString("datacenter")
			if f25_local15 == nil then
				Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "No datacenter in json, skipping\n")
			end
		end
		local f25_local16 = Engine[0xE46D712FE84AF13](f25_local12, f25_local13)
		local f25_local17 = Engine[0xDF4C7BBB34DA21C](f25_local14)
		f25_local3 = tonumber(Engine[0x4C599F1694E23EF](f25_local3))
		table.insert(f25_local7, {
			secIdKey = f25_local16,
			secId = f25_local16.secId,
			secIdInt64 = f25_local16.secIdInt64,
			secKey = f25_local16.secKey,
			secIdBase64Encoded = f25_local12,
			secKeyBase64Encoded = f25_local13,
			serializedAdr = f25_local17.serializedAdr,
			addressBase64Encoded = f25_local14,
			datacenterBase64Encoded = f25_local15,
			numProbes = f25_local3,
		})
	end
	f25_local1:endParse()
	local f25_local8 = {
		dcQoSInfo = f25_arg0,
		numProbes = f25_local3,
		transactionID = f25_local4,
		qosHosts = f25_local7,
	}
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.ParseDCQoSInfo:" .. "\n dcQoSInfo: " .. f25_local8.dcQoSInfo .. "\n numProbes: " .. tostring(f25_local8.numProbes) .. "\n transactionID: " .. Engine[0x4C599F1694E23EF](f25_local8.transactionID) .. "\n hosts: cannot display info" .. "\n")
	return f25_local8
end
Lobby.JSON.CreatePlayerInfoDoc = function(f27_arg0)
	local f27_local0 = function(f28_arg0, f28_arg1)
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.CreatePlayerInfoDoc: " .. f28_arg1)
		if f28_arg0 ~= nil then
			f28_arg0:endWrite()
		end
		return nil
	end
	local f27_local1 = f27_arg0.encodedAddr
	local f27_local2 = f27_arg0.encodedSecId
	local f27_local3 = f27_arg0.encodeSecKey
	local f27_local4 = ""
	local f27_local5 = ""
	local f27_local6 = Engine[0xD83EDB9C9B5C88E]()
	if Dvar[0x6C1A042EF5D6CEC]:exists() then
		local f27_local7 = tonumber(Dvar[0x6C1A042EF5D6CEC]:get())
		if f27_local7 < 4 then
			f27_local6 = f27_local7
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.CreatePlayerInfoDoc: forcing nat type to " .. f27_local6 .. "\n")
		end
	end
	local f27_local7 = Engine[0xDE8E8B2580DAC97]() == Enum[0xF9B5140618251DD][0xEFC42E21A350493]
	local f27_local8 = ""
	local f27_local9 = ""
	local f27_local10 = {}
	local f27_local11 = "t8echoserver"
	local f27_local12 = "t8echoserver-all-all-all-0"
	local f27_local13 = Lobby.MatchmakingAsync.GetFullBuildName()
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Getting Table of owned mappacks:\n")
	Lobby.JSON.BuildMapPackFlagsTable(f27_local10, Engine[0xFD1E02C14853724](), Engine[0x3C915544ECCD34B](Engine[0xA5B9C0111291A8B]()))
	Engine[0xA8F0FED295F69CD](f27_arg0.secIdKey.secId, f27_arg0.secIdKey.secKey)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Enable QoS listener for client: " .. f27_arg0.gamertag .. ", with Sec Id: " .. tostring(f27_arg0.secIdKey.secIdInt64) .. ".\n")
	Engine[0x95245C472113FE7](true, f27_arg0.secIdKey.secIdInt64)
	local f27_local14 = Engine[0xA4245AC303B4CD5]()
	if f27_local14 == nil then
		return f27_local0(nil, "failed to create JSON handle.\n")
	elseif f27_local14:beginWrite("playerInfoDoc") == false then
		return f27_local0(f27_local14, "failed to create playerInfoDoc JSON.\n")
	end
	local f27_local15 = f27_local14:getRoot()
	if f27_local15 == nil then
		return f27_local0(f27_local14, "failed to get root of playerInfoDoc JSON.\n")
	elseif f27_local15:setString("host_address", f27_local1) == false then
		return f27_local0(f27_local14, "failed to write 'host_address'.\n")
	elseif f27_local15:setString("host_security_id", f27_local2) == false then
		return f27_local0(f27_local14, "failed to write 'host_security_id'.\n")
	elseif f27_local15:setString("host_security_key", f27_local3) == false then
		return f27_local0(f27_local14, "failed to write 'host_security_key'.\n")
	elseif f27_local15:setString("build_name", f27_local13) == false then
		return f27_local0(f27_local14, "failed to write 'build_name'.\n")
	elseif f27_local4 ~= nil and string.len(f27_local4) > 0 and f27_local15:setString("build_name_context", f27_local4) == false then
		return f27_local0(f27_local14, "failed to write 'build_name_context'.\n")
	elseif f27_local12 ~= nil and string.len(f27_local12) > 0 and f27_local15:setString("qos_build_name", f27_local12) == false then
		return f27_local0(f27_local14, "failed to write 'qos_build_name'.\n")
	elseif f27_local11 ~= nil and string.len(f27_local11) > 0 and f27_local15:setString("qos_build_name_context", f27_local11) == false then
		return f27_local0(f27_local14, "failed to write 'build_name_context'.\n")
	elseif f27_local5 ~= nil and string.len(f27_local5) > 0 and f27_local15:setString("partial", f27_local5) == false then
		return f27_local0(f27_local14, "failed to write 'partial'.\n")
	elseif f27_local15:setUInt("nat", f27_local6) == false then
		return f27_local0(f27_local14, "failed to write 'nat'.\n")
	elseif f27_local7 ~= nil and f27_local15:setBool("wifi", f27_local7) == false then
		return f27_local0(f27_local14, "failed to write 'wifi'.\n")
	elseif f27_local8 ~= nil and string.len(f27_local8) > 0 and f27_local15:setString("mb_ram", f27_local8) == false then
		return f27_local0(f27_local14, "failed to write 'mb_ram'.\n")
	elseif f27_local9 ~= nil and string.len(f27_local9) > 0 and f27_local15:setString("cpu_mhz", f27_local9) == false then
		return f27_local0(f27_local14, "failed to write 'cpu_mhz'.\n")
	end
	local f27_local16 = f27_local15:setField("maps", LuaEnum.JSON_TYPE.JSON_ARRAY)
	if f27_local16 == nil then
		return f27_local0(f27_local14, "failed to set 'maps' field.\n")
	end
	for f27_local20, f27_local21 in ipairs(f27_local10) do
		if f27_local16:addString(f27_local21) == false then
			return f27_local0(f27_local14, "failed to add map( " .. f27_local21 .. " ) to 'maps' field.\n")
		end
	end
	f27_local17 = f27_local14:getRepresentation()
	if f27_local17 == nil then
		return f27_local0(f27_local14, "failed (getRepresentation) to get JSON.\n")
	end
	f27_local14:endWrite()
	return f27_local17
end
Lobby.JSON.CreateStartSearchParamDoc = function(f29_arg0)
	local f29_local0 = "Lobby.JSON.CreateStartSearchParamDoc"
	local f29_local1 = {}
	local f29_local2 = "2.0"
	local f29_local3 = Engine[0x5E804BED092329B]()
	local f29_local4 = Engine[0xB15BEE2BE53060A]()
	local f29_local5 = Engine[0x7B3B2B73B53EB34]()
	local f29_local6 = Dvar[0x1E20802F756EFAF]:exists()
	if f29_local6 then
		f29_local6 = Dvar[0x1E20802F756EFAF]:get()
	end
	local f29_local7 = {}
	local f29_local8, f29_local9 = nil
	if f29_local6 then
		local f29_local10 = Engine[0x8DF2E5447F384B9]()
		f29_local10 = f29_local10.lobbyRoot.searchPlaylistIDs
		if f29_local10 then
			local f29_local11 = f29_local10.count:get()
			for f29_local12 = 1, f29_local11, 1 do
				table.insert(f29_local7, Engine[0x3ACB99DBAD24D55](f29_local10[f29_local12]:get()))
			end
			if #f29_local7 > 0 then
				f29_local5 = f29_local7[1].id
			end
		end
	end
	local f29_local10 = #f29_local7 > 1
	local f29_local11 = Engine[0x3ACB99DBAD24D55](f29_local5)
	local f29_local12 = f29_local11.minPlayersToCreate
	local f29_local13 = f29_local11.maxPlayers
	local f29_local14 = ""
	local f29_local15 = false
	local f29_local16 = 0
	local f29_local17 = Engine[0x3EAC408F958FF05]()
	local f29_local18 = false
	local f29_local19 = Engine[0xF75734A98C53D1B](f29_local5)
	if f29_local19[0x378F6E813F4494A] and not f29_local10 then
		f29_local18 = true
	end
	if Dvar[0xE0FB96935DF872D]:exists() and Dvar[0xE0FB96935DF872D]:get() > 0 then
		f29_local16 = Dvar[0xE0FB96935DF872D]:get()
	end
	if Dvar[0xB0353CA54760727]:exists() and Dvar[0xB0353CA54760727]:get() > 0 and Dvar[0xB0353CA54760727]:get() <= #LuaEnum.NeedForDedicatedServerString then
		f29_local9 = Dvar[0xB0353CA54760727]:get()
	end
	local f29_local20 = LobbyData.GetCurrentMenuTarget()
	local f29_local21 = Engine[0x786FFC9E621CAB7]()
	Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[0x22C2D85063EC515] = f29_local21
	Lobby.MatchmakingAsync.PartyToMatchSummary[0x22C2D85063EC515] = f29_local21
	if f29_arg0 == nil and f29_local11.mainMode ~= f29_local20[0xEB7DDC7F079D51B] then
		Lobby.JSON.ErrorWrite(nil, f29_local0, "Playlist entry mainMode and lobby mainMode Don't match!!")
		return nil
	elseif f29_local20[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x79D01499920B292] or f29_local20[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7B50049993542C0] then
		f29_local8 = 1
	elseif f29_local20[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x78C124999125C42] then
		f29_local8 = 1
		if Dvar[0xA546240BBE08638]:exists() and Dvar[0xA546240BBE08638]:get() then
			f29_local9 = LuaEnum.NeedForDedicatedServer.NOT_NEEDED
		end
		local f29_local22 = Engine[0xE00882E35AF63D2](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
		if f29_local22 ~= nil then
			f29_local15 = f29_local22.fillParty
		end
	end
	if LuaDefine.isPCClient and f29_local20[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7E41449995CD57E] and Dvar[0x3617F20591CC64]:exists() and Dvar[0x3617F20591CC64]:get() then
		f29_local9 = LuaEnum.NeedForDedicatedServer.REQUIRED
	end
	if f29_local20[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xD42D003CEEA3F87] then
		if Dvar[0xAAD4C8A3747B359]:exists() and Dvar[0xAAD4C8A3747B359]:get() then
			f29_local9 = LuaEnum.NeedForDedicatedServer.NOT_NEEDED
		end
		if Dvar[0x781206C11C8B523]:exists() then
			f29_local17 = f29_local17 + Dvar[0x781206C11C8B523]:get()
		end
	end
	local f29_local22 = f29_local8
	if f29_local22 == nil then
		if f29_local13 > 18 then
			local f29_local23 = 1
		end
		f29_local22 = f29_local23 or 2
	end
	if f29_local9 == nil then
		local f29_local24 = f29_local11.searchType
	end
	if Dvar[0xE4D6FF240788F81]:exists() and Dvar[0xE4D6FF240788F81]:get() then
		f29_local14 = LuaDefine.T8_BUILD_NAME
		if LuaDefine.isPS4Client then
			f29_local14 = f29_local14 .. "-ps4"
		elseif LuaDefine.isXboxClient then
			f29_local14 = f29_local14 .. "-xb1"
		elseif LuaDefine.isPCClient then
			f29_local14 = f29_local14 .. "-pc"
		else
			error("Unsupported platform")
		end
		if f29_local20[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x78C124999125C42] then
			f29_local14 = f29_local14 .. "-wz"
			if Dvar[0xAFE8B91B7B953C3]:exists() then
				suffix = "100"
				f29_local14 = f29_local14 .. "-" .. suffix
			end
		elseif f29_local20[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
			f29_local14 = f29_local14 .. "-mp"
		end
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], f29_local0 .. "\n buildNameContext: " .. f29_local14 .. "\n")
	local f29_local25 = ""
	if Dvar[0x5909CF2A6D2C500]:exists() and Dvar[0x5909CF2A6D2C500]:get() then
		f29_local25 = Lobby.MatchmakingAsync.GetFullBuildName() .. " - " .. f29_local14
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "fullBuildNameContext"), f29_local25)
	local f29_local26 = f29_local11.usedDLCMask
	local f29_local27 = false
	local f29_local28 = Engine[0x9882F293C327557]()
	local f29_local29 = Engine[0xA4245AC303B4CD5]()
	if f29_local29 == nil then
		return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to create JSON handle.")
	elseif f29_local29:beginWrite("playerInfoDoc") == false then
		return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to create playerInfoDoc JSON.")
	end
	local f29_local30 = f29_local29:getRoot()
	if f29_local30 == nil then
		return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to get root of playerInfoDoc JSON.")
	end
	local f29_local31 = Lobby.JSON.CreateArrayAndAddToLocation(f29_local29, f29_local30, "members")
	local f29_local32 = Lobby.JSON.CreateArrayAndAddToLocation(f29_local29, f29_local30, "tokens")
	if f29_local31 == nil or f29_local32 == nil then
		return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to create arrays for 'members' or 'tokens' array field.")
	end
	local f29_local33 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	local f29_local34 = {}
	for f29_local38, f29_local39 in ipairs(f29_local33.sessionClients) do
		f29_local31:addUInt64(f29_local39.xuid)
		f29_local32:addUInt64(f29_local39.asyncMatchmakingToken)
		f29_local34[#f29_local34 + 1] = f29_local39.xuid
	end
	if f29_arg0 ~= nil then
		if f29_local30:setUInt64("user_to_join", f29_arg0) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to write 'user_to_join'.\n")
		end
	else
		if f29_local6 then
			f29_local35 = Lobby.JSON.CreateArrayAndAddToLocation(f29_local29, f29_local30, "playlist_config")
			if f29_local35 == nil then
				return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create playlist_config array.")
			end
			for f29_local39, f29_local44 in ipairs(f29_local7) do
				local f29_local41 = f29_local8
				if f29_local41 == nil then
					if f29_local44.maxPlayers > 18 then
						local f29_local40 = 1
					end
					f29_local41 = f29_local40 or 2
				end
				if f29_local9 == nil and (f29_local44.searchType == LuaEnum.NeedForDedicatedServer.REQUIRED or f29_local44.searchType == LuaEnum.NeedForDedicatedServer.BEST_EFFORT and f29_local24 == LuaEnum.NeedForDedicatedServer.NOT_NEEDED) then
					local f29_local24 = f29_local44.searchType
				end
				f29_local26 = f29_local26 | f29_local44.usedDLCMask
				local f29_local42 = f29_local35:addField(LuaEnum.JSON_TYPE.JSON_OBJECT)
				if f29_local42 == nil then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to add field to playlist_config array.")
				end
				local f29_local43 = Lobby.JSON.CreateArrayAndAddToLocation(f29_local29, f29_local42, "playlist_ids")
				if f29_local43 == nil then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create playlist_ids array in playlist_config.")
				elseif f29_local43:addUInt(f29_local44.id) == false then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to add id " .. f29_local44.id .. " to playlist_ids array.")
				elseif f29_local42:setUInt("min_slots", f29_local44.minPlayersToCreate) == false then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set min_slots to " .. f29_local44.minPlayersToCreate .. " in playlist_config.")
				elseif f29_local42:setUInt("max_slots", f29_local44.maxPlayers) == false then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set max_slots to " .. f29_local44.maxPlayers .. " in playlist_config.")
				elseif f29_local42:setUInt("num_teams", f29_local41) == false then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set num_teams to " .. f29_local41 .. " in playlist_config.")
				end
			end
		end
		f29_local35 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local30, "lobby_slots")
		if f29_local35 == nil then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create Lobby_slots")
		elseif f29_local35:setUInt("max", f29_local13) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set lobby_slots.max")
		elseif f29_local35:setUInt("min", f29_local12) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set lobby_slots.max")
		end
		f29_local36 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local30, "dedicated_server")
		if f29_local36 == nil then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create dedicated_server")
		elseif f29_local36:setString("request_level", LuaEnum.NeedForDedicatedServerString[f29_local24]) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set 'request_level'")
		elseif f29_local36:setString("build_name_context", f29_local14) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to write 'build_name_context'.")
		end
		f29_local38 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local30, "team_balance")
		if f29_local38 == nil then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create team_balance")
		elseif f29_local38:setUInt("num_teams", f29_local22) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set 'num_teams'")
		end
		f29_local39 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local30, "ruleset_payload")
		if f29_local39 == nil then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create ruleset_payload")
		end
		local f29_local44 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local39, "filter")
		if f29_local44 == nil then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create 'filter'")
		elseif Dvar[0x4BAF85486280784]:get() == true or Dvar[0x17148A4FB179B6C]:get() == true then
			Dvar[0x4BAF85486280784]:set(false)
			if Dvar[0x17148A4FB179B6C]:get() == false then
				Dvar[0xA546240BBE08638]:set(false)
			end
			if f29_local39:setBool("force_host_of_empty_new_lobby", true) == false then
				return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set 'force_host_of_empty_new_lobby'")
			end
		end
		if f29_local44:setString("matchmaking_version", f29_local2) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to set 'matchmaking_version'")
		elseif f29_local44:setUInt64("netcode_version", f29_local3) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to write 'netcode_version'.")
		elseif f29_local44:setUInt("playlist_version", f29_local4) == false then
			return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to write 'playlist_version'.")
		end
		local f29_local42 = f29_local44
		local f29_local41 = f29_local44.setUInt
		local f29_local43 = "playlist_id"
		local f29_local45
		if f29_local10 then
			f29_local45 = 0
			if not f29_local45 then
			else
				if f29_local41(f29_local42, f29_local43, f29_local45) == false then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to write 'playlist_id'.")
				elseif LuaDefine.isPC and Dvar[0xC8DE5D729904677]:get() and f29_local44:setString("online_matchmaking_restrict", Engine[0x9A70B14679D905C]()) == false then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to write 'bnet_region'.")
				end
				f29_local41 = Lobby.JSON.CreateArrayAndAddToLocation(f29_local29, f29_local39, "playlist_map_packs")
				if f29_local41 == nil then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to write 'playlist_map_packs'.")
				end
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Getting Table of mappacks in the Playlist:\n")
				f29_local42 = {}
				Lobby.JSON.BuildMapPackFlagsTable(f29_local42, f29_local26)
				for f29_local47, f29_local48 in ipairs(f29_local42) do
					if f29_local41:addString(f29_local48) == false then
						return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to add map( " .. f29_local48 .. " ) to 'playlist_map_packs' field.")
					end
				end
				for f29_local47, f29_local48 in ipairs(f29_local11.rules) do
					if f29_local48.name == 0xE535D66F4F89AE5 then
						if #f29_local48.value > 0 then
							local f29_local49 = f29_local48.value
							local f29_local50 = Lobby.JSON.CreateArrayAndAddToLocation(f29_local29, f29_local39, "force_datacenters")
							if f29_local50 == nil then
								return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to write 'force_datacenters'.")
							elseif f29_local50:addString(f29_local49) == false then
							else
								Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "asyncMatchmakingStartDoc: forcing datacenter to  " .. f29_local49 .. "\n")
								break
							end
							return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed to add forcedc( " .. f29_local49 .. " ) to 'force_datacenters' field.")
						end
					end
				end
				if f29_local39:setBool("fill_party", f29_local15) == false then
					Lobby.JSON.ErrorWrite(nil, f29_local0, "Failed to set 'fill_party'")
				end
				if f29_local39:setUInt("affinity_id", f29_local16) == false then
					Lobby.JSON.ErrorWrite(nil, f29_local0, "Failed to set 'affinity_id'")
				end
				if f29_local18 == true and f29_local39:setBool("use_skill", true) == false then
					Lobby.JSON.ErrorWrite(nil, f29_local0, "Failed to set 'use_skill'")
				end
				if f29_local39:setUInt("game_type", f29_local17) == false then
					Lobby.JSON.ErrorWrite(nil, f29_local0, "Failed to set 'game_type'")
				end
				f29_local43 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local30, "player_ruleset_payloads")
				if f29_local43 == nil then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create player_ruleset_payload")
				end
				for f29_local48, f29_local49 in ipairs(f29_local33.sessionClients) do
					local f29_local54 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local43, Engine[0x4C599F1694E23EF](f29_local49.xuid))
					f29_local54:setBool("mic", f29_local49.VOIPStatus == Enum[0x67D1AB56CFA8F00][0xABB324E88F12789])
					f29_local54:setBool("splitscreen", f29_local49.isSplitscreenClient)
					if f29_local48 == 1 then
						local f29_local51 = Engine[0xA5B9C0111291A8B]()
						local f29_local52 = nil
						if f29_local20[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x79D01499920B292] then
							f29_local52 = Engine[0x8BF970606552F4C](f29_local51, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
						elseif f29_local20[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
							f29_local52 = Engine[0x8BF970606552F4C](f29_local51, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
						end
						if f29_local52 then
							local f29_local53 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local54, "match_participation_history")
							if f29_local53 then
								f29_local53:setUInt("host_total_match_count_from_go", f29_local52.match_participation_history.host_total_match_count_from_go:get())
								f29_local53:setUInt("host_disrupted_match_count_from_go", f29_local52.match_participation_history.host_disrupted_match_count_from_go:get())
								f29_local53:setUInt("host_consecutive_success_count_from_go", f29_local52.match_participation_history.host_consecutive_success_count_from_go:get())
								f29_local53:setUInt("host_consecutive_disrupted_count_from_go", f29_local52.match_participation_history.host_consecutive_disrupted_count_from_go:get())
								f29_local53:setUInt("host_migration_attempted_count_from_go", f29_local52.match_participation_history.host_migration_attempted_count_from_go:get())
								f29_local53:setUInt("host_migration_successful_count_from_go", f29_local52.match_participation_history.host_migration_successful_count_from_go:get())
							end
						end
					end
				end
				f29_local45 = Lobby.JSON.CreateFieldAndAddToLocation(f29_local29, f29_local30, "performance")
				if f29_local45 == nil then
					return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "Failed to create performance")
				elseif f29_local45:setUInt("game_type", f29_local17) == false then
					Lobby.JSON.ErrorWrite(nil, f29_local0, "Failed to set 'game_type'")
				end
			end
		end
		f29_local45 = f29_local5
	end
	f29_local35 = f29_local29:getRepresentation()
	if f29_local35 == nil then
		return Lobby.JSON.ErrorWrite(f29_local29, f29_local0, "failed (getRepresentation) to get JSON.\n")
	end
	f29_local29:endWrite()
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], f29_local0 .. "\n asyncMatchmakingStartDoc: " .. f29_local35 .. "\n")
	return f29_local35, f29_local34
end
Lobby.JSON.ParseAsyncMatchmakingStartDoc = function(f30_arg0)
	local f30_local0 = "Lobby.JSON.ParseAsyncMatchmakingStartDoc"
	local f30_local1 = Engine[0xA4245AC303B4CD5]()
	if f30_local1 == nil then
		return Lobby.JSON.ErrorParsing(nil, f30_local0, "failed to create JSON handle.\n")
	elseif f30_local1:beginParse("asyncMatchmakingStartDoc", f30_arg0 .. " ") == false then
		return Lobby.JSON.ErrorParsing(f30_local1, f30_local0, "failed to parse dcQoSInfo JSON.\n")
	else
		local f30_local2 = f30_local1:getRoot()
		if f30_local2 == nil then
			return Lobby.JSON.ErrorParsing(f30_local1, f30_local0, "failed to get root of dcQoSInfo JSON.\n")
		else
			local f30_local3 = f30_local2:getUInt("estimated_wait_time")
			if f30_local3 == nil then
				return Lobby.JSON.ErrorParsing(f30_local1, f30_local0, "failed to read 'estimated_wait_time'.\n")
			else
				local f30_local4 = f30_local2:getUInt64("mm_id")
				if f30_local4 == nil then
					return Lobby.JSON.ErrorParsing(f30_local1, f30_local0, "failed to read 'mm_id'.\n")
				else
					f30_local1:endParse()
					local f30_local5 = {
						asyncMatchmakingStartDoc = f30_arg0,
						estimatedWaitTime = tonumber(Engine[0x4C599F1694E23EF](f30_local3)),
						mm_id = f30_local4,
					}
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x8E4EED9A90F9B5E], "Lobby.JSON.ParseAsyncMatchmakingStartDoc:" .. "\n asyncMatchmakingStartDoc: " .. f30_local5.asyncMatchmakingStartDoc .. "\n estimatedWaitTime: " .. tostring(f30_local5.estimatedWaitTime) .. "\n MatchmakindID: " .. Engine[0x4C599F1694E23EF](f30_local4) .. "\n")
					return f30_local5
				end
			end
		end
	end
end
