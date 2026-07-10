Lobby.Scheduler = {}
Lobby.Scheduler.LastPumpTime = nil
Lobby.Scheduler.LastActiveEvents = {}
Lobby.Scheduler.CustomRules = {}
Lobby.Scheduler.ExecEvents = function(f1_arg0, f1_arg1) end
Lobby.Scheduler.ExecEvents = function(f2_arg0, f2_arg1)
	for f2_local3, f2_local4 in pairs(f2_arg0) do
		local f2_local5 = f2_local3 .. f2_arg1
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Exec rule: " .. f2_local5 .. "\n")
		Engine[0xC7A92D4B51E7C65](f2_local5)
	end
end
Lobby.Scheduler.GetPlatform = function()
	if Engine[0x5AE97B58D7132F3]() == "orbis" then
		return "ps4"
	elseif Engine[0x5AE97B58D7132F3]() == "durango" then
		return "xbox"
	elseif Engine[0x5AE97B58D7132F3]() == "pc" then
		return "pc"
	else
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Autoevent: Platform not detected.'\n")
		return "unknown"
	end
end
Lobby.Scheduler.IsInCustomRule = function(f4_arg0)
	if f4_arg0 == nil or f4_arg0 == "" then
		return true
	elseif nil == Lobby.Scheduler.CustomRules or Lobby.Scheduler.CustomRules[f4_arg0] == nil then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Autoevent: Invalid custom rule '" .. f4_arg0 .. "'\n")
		return false
	else
		return Lobby.Scheduler.CustomRules[f4_arg0]()
	end
end
Lobby.Scheduler.GetScheduledEvents = function(f5_arg0, f5_arg1)
	local f5_local0 = "events"
	local f5_local1 = "gamedata/events/schedule_" .. Lobby.Scheduler.GetPlatform() .. ".csv"
	local f5_local2 = Engine[0x63FBABD1982143E](f5_local1)
	local f5_local3 = false
	for f5_local4 = 0, f5_local2 - 1, 1 do
		local f5_local7 = Engine[0x5A4D00DABC5F44B](f5_local1, f5_local4, 3)
		local f5_local8 = Engine[0x5A4D00DABC5F44B](f5_local1, f5_local4, 4)
		local f5_local9 = Engine[0x5A4D00DABC5F44B](f5_local1, f5_local4, 5)
		local f5_local10 = Engine[0x5A4D00DABC5F44B](f5_local1, f5_local4, 6)
		local f5_local11 = Engine[0x5A4D00DABC5F44B](f5_local1, f5_local4, 0)
		local f5_local12 = Engine[0x5A4D00DABC5F44B](f5_local1, f5_local4, 1)
		local f5_local13 = Engine[0x5A4D00DABC5F44B](f5_local1, f5_local4, 2)
		if Engine[0x331C580F6E1415B](tostring(Engine[0x8FD43DB47D439AE]()), f5_local12, f5_local13) and (Engine[0xE39F1F30B306065]() or f5_local8 == nil or f5_local8 == "" or CoDShared.IsInExperiment(f5_local8, f5_local9)) and Lobby.Scheduler.IsInCustomRule(f5_local10) then
			f5_arg0[f5_local11] = true
			if Lobby.Scheduler.LastActiveEvents[f5_local11] == nil then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Autoevent: ACTIVATING event3 '" .. f5_local11 .. "' [" .. Engine[0x8FD43DB47D439AE]() .. "]\n")
				f5_local3 = true
			end
			local f5_local14 = Engine[0x1C6D5C5915588E3](f5_local0, "name", f5_local11 .. "_ON", "timer_name")
			if f5_local14 ~= nil and f5_local14 ~= "" then
				local f5_local15 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "AutoEvents")
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f5_local15, f5_local14), LuaUtils.SecondsToTimeRemainingString(Engine[0x8377C456E1E2B0B](f5_local13) + 1))
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f5_local15, f5_local14 .. "_raw"), Engine[0x8377C456E1E2B0B](f5_local13) + 1)
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f5_local15, f5_local14 .. "_red"), Engine[0x8377C456E1E2B0B](f5_local13) < 300)
			end
		end
		f5_arg1[f5_local11] = true
	end
	return f5_local3
end
Lobby.Scheduler.GetRotatingEvents = function(f6_arg0, f6_arg1)
	local f6_local0 = ""
	if Engine[0xE6099BDC574E648] ~= nil then
		f6_local0 = Engine[0xE6099BDC574E648]()
	end
	local f6_local1 = false
	if f6_local0 == nil or f6_local0 == "" then
		return
	elseif f6_local0 ~= "rotation_pause_featured" then
		f6_arg0[f6_local0] = true
	end
	if Lobby.Scheduler.LastActiveEvents[f6_local0] == nil then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Autoevent: ACTIVATING event '" .. f6_local0 .. "' [" .. Engine[0x8FD43DB47D439AE]() .. "]\n")
		f6_local1 = true
	end
	local f6_local2 = "gamedata/events/rotation.csv"
	local f6_local3 = Engine[0x63FBABD1982143E](f6_local2)
	for f6_local4 = 0, f6_local3 - 1, 1 do
		f6_arg1[Engine[0x5A4D00DABC5F44B](f6_local2, f6_local4, 0)] = true
	end
	return f6_local1
end
Lobby.Scheduler.ParseEvents = function(f7_arg0)
	local f7_local0 = {}
	local f7_local1 = {}
	local f7_local2 = Lobby.Scheduler.GetScheduledEvents(f7_local0, f7_local1)
	local f7_local3 = Lobby.Scheduler.GetRotatingEvents(f7_local0, f7_local1)
	local f7_local4 = false
	for f7_local8, f7_local9 in pairs(Lobby.Scheduler.LastActiveEvents) do
		if f7_local0[f7_local8] == nil then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Autoevent: DEACTIVATING event '" .. f7_local8 .. "' [" .. Engine[0x8FD43DB47D439AE]() .. "]\n")
			f7_local4 = true
		end
	end
	if f7_arg0 or f7_local2 == true or f7_local3 == true or f7_local4 == true then
		Lobby.Scheduler.ExecEvents(f7_local1, "_OFF")
		Lobby.Scheduler.ExecEvents(f7_local0, "_ON")
		Engine[0x1922CB1488C6C6C]()
		Engine[0x86B354136A4AF18]()
		f7_local6 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "AutoEvents"), "cycled")
		if not Engine[0x83C9B5DE1D9371](f7_local6, 1) then
			Engine[0x6A489878620F3BC](f7_local6)
		end
		for f7_local7 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
			if Engine[0xC7D35487C7E276D](f7_local7) then
				Engine[0x5DE9A824C285D86](f7_local7)
			end
		end
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "AutoEvents"), "initialized"), true)
	Lobby.Scheduler.LastActiveEvents = f7_local0
end
Lobby.Scheduler.ParseEventsSecure = function()
	if Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Autoevent: ParseEventsSecure not overridden by the ffotd. Autoevents are disabled.'\n")
	end
end
Lobby.Scheduler.Pump = function()
	if Engine[0xA63E42B2FB6EC02]() ~= Enum[0xC84D3E505F1444][0xE99F41098B71960] or Engine[0x7B48C1ABFF0F764]() then
		return
	elseif not Dvar[0x7112C4349F6F3CE]:get() then
		return
	else
		Lobby.Scheduler.ParseEventsSecure()
	end
end
