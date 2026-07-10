Lobby.Scheduler = {}
Lobby.Scheduler.LastPumpTime = nil
Lobby.Scheduler.LastActiveEvents = {}
Lobby.Scheduler.CustomRules = {}
Lobby.Scheduler.ExecEvents = function(f1_arg0, f1_arg1) end
Lobby.Scheduler.ExecEvents = function(f2_arg0, f2_arg1)
	for f2_local3, f2_local4 in pairs(f2_arg0) do
		local f2_local5 = f2_local3 .. f2_arg1
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Exec rule: " .. f2_local5 .. "\n")
		Engine[@"execautoeventruleset"](f2_local5)
	end
end
Lobby.Scheduler.GetPlatform = function()
	if Engine[@"hash_25AE97B58D7132F3"]() == "orbis" then
		return "ps4"
	elseif Engine[@"hash_25AE97B58D7132F3"]() == "durango" then
		return "xbox"
	elseif Engine[@"hash_25AE97B58D7132F3"]() == "pc" then
		return "pc"
	else
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Autoevent: Platform not detected.'\n")
		return "unknown"
	end
end
Lobby.Scheduler.IsInCustomRule = function(f4_arg0)
	if f4_arg0 == nil or f4_arg0 == "" then
		return true
	elseif nil == Lobby.Scheduler.CustomRules or Lobby.Scheduler.CustomRules[f4_arg0] == nil then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Autoevent: Invalid custom rule '" .. f4_arg0 .. "'\n")
		return false
	else
		return Lobby.Scheduler.CustomRules[f4_arg0]()
	end
end
Lobby.Scheduler.GetScheduledEvents = function(f5_arg0, f5_arg1)
	local f5_local0 = "events"
	local f5_local1 = "gamedata/events/schedule_" .. Lobby.Scheduler.GetPlatform() .. ".csv"
	local f5_local2 = Engine[@"gettablerowcount"](f5_local1)
	local f5_local3 = false
	for f5_local4 = 0, f5_local2 - 1, 1 do
		local f5_local7 = Engine[@"tablelookupgetcolumnvalueforrow"](f5_local1, f5_local4, 3)
		local f5_local8 = Engine[@"tablelookupgetcolumnvalueforrow"](f5_local1, f5_local4, 4)
		local f5_local9 = Engine[@"tablelookupgetcolumnvalueforrow"](f5_local1, f5_local4, 5)
		local f5_local10 = Engine[@"tablelookupgetcolumnvalueforrow"](f5_local1, f5_local4, 6)
		local f5_local11 = Engine[@"tablelookupgetcolumnvalueforrow"](f5_local1, f5_local4, 0)
		local f5_local12 = Engine[@"tablelookupgetcolumnvalueforrow"](f5_local1, f5_local4, 1)
		local f5_local13 = Engine[@"tablelookupgetcolumnvalueforrow"](f5_local1, f5_local4, 2)
		if Engine[@"isinrange"](tostring(Engine[@"getcurrentutctimestr"]()), f5_local12, f5_local13) and (Engine[@"isdedicatedserver"]() or f5_local8 == nil or f5_local8 == "" or CoDShared.IsInExperiment(f5_local8, f5_local9)) and Lobby.Scheduler.IsInCustomRule(f5_local10) then
			f5_arg0[f5_local11] = true
			if Lobby.Scheduler.LastActiveEvents[f5_local11] == nil then
				Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Autoevent: ACTIVATING event3 '" .. f5_local11 .. "' [" .. Engine[@"getcurrentutctimestr"]() .. "]\n")
				f5_local3 = true
			end
			local f5_local14 = Engine[@"structtablelookupstring"](f5_local0, "name", f5_local11 .. "_ON", "timer_name")
			if f5_local14 ~= nil and f5_local14 ~= "" then
				local f5_local15 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "AutoEvents")
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f5_local15, f5_local14), LuaUtils.SecondsToTimeRemainingString(Engine[@"getsecondsremainingserver"](f5_local13) + 1))
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f5_local15, f5_local14 .. "_raw"), Engine[@"getsecondsremainingserver"](f5_local13) + 1)
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f5_local15, f5_local14 .. "_red"), Engine[@"getsecondsremainingserver"](f5_local13) < 300)
			end
		end
		f5_arg1[f5_local11] = true
	end
	return f5_local3
end
Lobby.Scheduler.GetRotatingEvents = function(f6_arg0, f6_arg1)
	local f6_local0 = ""
	if Engine[@"hash_6E6099BDC574E648"] ~= nil then
		f6_local0 = Engine[@"hash_6E6099BDC574E648"]()
	end
	local f6_local1 = false
	if f6_local0 == nil or f6_local0 == "" then
		return
	elseif f6_local0 ~= "rotation_pause_featured" then
		f6_arg0[f6_local0] = true
	end
	if Lobby.Scheduler.LastActiveEvents[f6_local0] == nil then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Autoevent: ACTIVATING event '" .. f6_local0 .. "' [" .. Engine[@"getcurrentutctimestr"]() .. "]\n")
		f6_local1 = true
	end
	local f6_local2 = "gamedata/events/rotation.csv"
	local f6_local3 = Engine[@"gettablerowcount"](f6_local2)
	for f6_local4 = 0, f6_local3 - 1, 1 do
		f6_arg1[Engine[@"tablelookupgetcolumnvalueforrow"](f6_local2, f6_local4, 0)] = true
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
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Autoevent: DEACTIVATING event '" .. f7_local8 .. "' [" .. Engine[@"getcurrentutctimestr"]() .. "]\n")
			f7_local4 = true
		end
	end
	if f7_arg0 or f7_local2 == true or f7_local3 == true or f7_local4 == true then
		Lobby.Scheduler.ExecEvents(f7_local1, "_OFF")
		Lobby.Scheduler.ExecEvents(f7_local0, "_ON")
		Engine[@"hash_11922CB1488C6C6C"]()
		Engine[@"hash_386B354136A4AF18"]()
		f7_local6 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "AutoEvents"), "cycled")
		if not Engine[@"setmodelvalue"](f7_local6, 1) then
			Engine[@"forcenotifymodelsubscriptions"](f7_local6)
		end
		for f7_local7 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
			if Engine[@"arestatsfetched"](f7_local7) then
				Engine[@"hash_35DE9A824C285D86"](f7_local7)
			end
		end
	end
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "AutoEvents"), "initialized"), true)
	Lobby.Scheduler.LastActiveEvents = f7_local0
end
Lobby.Scheduler.ParseEventsSecure = function()
	if Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Autoevent: ParseEventsSecure not overridden by the ffotd. Autoevents are disabled.'\n")
	end
end
Lobby.Scheduler.Pump = function()
	if Engine[@"getlobbynetworkmode"]() ~= Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] or Engine[@"isingame"]() then
		return
	elseif not Dvar[@"live_autoeventenabled"]:get() then
		return
	else
		Lobby.Scheduler.ParseEventsSecure()
	end
end
