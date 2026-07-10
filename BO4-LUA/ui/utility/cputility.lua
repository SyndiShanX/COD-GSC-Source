CoD.CPUtility = {}
require("x64:f3c5259f470592d")
CoD.CPUtility.DIFFICULTY = {}
CoD.CPUtility.DIFFICULTY[0] = @"menu/recruit"
CoD.CPUtility.DIFFICULTY[1] = @"menu/regular"
CoD.CPUtility.DIFFICULTY[2] = @"hash_5EB0FE85B0C234B0"
CoD.CPUtility.DIFFICULTY[3] = @"menu/veteran"
CoD.CPUtility.DIFFICULTY[4] = @"menu/heroic"
CoD.CPUtility.DIFFICULTY_DESC = {}
CoD.CPUtility.DIFFICULTY_DESC[0] = @"hash_6E6EE823F2A199D7"
CoD.CPUtility.DIFFICULTY_DESC[1] = @"hash_1DD1C9C6348D427D"
CoD.CPUtility.DIFFICULTY_DESC[2] = @"hash_4AE85AB083535732"
CoD.CPUtility.DIFFICULTY_DESC[3] = @"hash_15D910F0B084B1E8"
CoD.CPUtility.DIFFICULTY_DESC[4] = @"hash_C562663F9E9D20F"
CoD.CPUtility.DIFFICULTY_ICON = {}
CoD.CPUtility.DIFFICULTY_ICON[0] = "playlist_sp_recr"
CoD.CPUtility.DIFFICULTY_ICON[1] = "playlist_sp_reg"
CoD.CPUtility.DIFFICULTY_ICON[2] = "playlist_sp_hard"
CoD.CPUtility.DIFFICULTY_ICON[3] = "playlist_sp_vet"
CoD.CPUtility.DIFFICULTY_ICON[4] = "playlist_sp_real"
CoD.CPUtility.FrontendPlayerCharacterUpdate = "updateCpCharacter"
CoD.CPUtility.ObjectiveNotificationUpdateEvent = "objective_notification_update"
CoD.CPUtility.ObjectiveNotificationTransitionEvent = "objective_notification_transition"
CoD.CPUtility.ObjectiveNotificationSlideToTopEvent = "objective_notification_slide_to_top"
CoD.CPUtility.ObjectiveCompleteStateName = "ObjectiveComplete"
CoD.CPUtility.NOTIFICATION_BUFFER_ANIM_TIME_MS = 6
CoD.CPUtility.NOTIFICATION_SHRINK_ANIM_TIME_MS = 300
CoD.CPUtility.NOTIFICATION_SLIDE_ANIM_TIME_MS = 300
CoD.CPUtility.ClearAllTransitionLives = 3
CoD.CPUtility.INVALID_WAYPOINT_OBJ_ID = 0
CoD.CPUtility.CP_OBJ_WIDGET_NONE = 0
CoD.CPUtility.CP_OBJ_WIDGET_WAYPOINTS = 1
CoD.CPUtility.CP_OBJ_WIDGET_CLEAR_ALL = 2
CoD.CPUtility.CP_OBJ_WIDGET_GO_TO = 3
CoD.CPUtility.CP_OBJ_WIDGET_HARDPOINT = 4
CoD.CPUtility.CP_OBJ_WIDGET_PERCENT = 5
CoD.CPUtility.CP_OBJ_PROGRESS_TYPE_NONE = 0
CoD.CPUtility.CP_OBJ_PROGRESS_TYPE_FRACTION = 1
CoD.CPUtility.CP_OBJ_PROGRESS_TYPE_PERCENT = 2
CoD.CPUtility.CP_OBJ_PROGRESS_TYPE_TIME = 3
CoD.CPUtility.CP_OBJ_INFO_STATE_INCOMPLETE = 0
CoD.CPUtility.CP_OBJ_INFO_STATE_SUCCESS = 1
CoD.CPUtility.CP_OBJ_INFO_STATE_FAILURE = 2
CoD.CPUtility.CP_OBJ_INFO_TYPE_DEFAULT = 0
CoD.CPUtility.CP_OBJ_INFO_TYPE_SPECIALIST = 1
CoD.CPUtility.CP_OBJ_INFO_TYPE_OPTIONAL = 2
CoD.CPUtility.NewsRoomChannels = LuaEnum.createEnum("UNS", "NOBLE", "TORCH")
CoD.CPUtility.GetFactionFromStats = function(f1_arg0)
	if f1_arg0 then
		local f1_local0 = f1_arg0.faction
		local f1_local1 = f1_arg0.faction:get()
	end
	return f1_local0 and f1_local1 or Enum[@"team_t"][@"team_allies"]
end
CoD.CPUtility.GetFactionFromStatsByController = function(f2_arg0)
	return CoD.CPUtility.GetFactionFromStats(Engine[@"getplayerstats"](f2_arg0))
end
CoD.CPUtility.CreateCPFactionList = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = {}
	local f3_local1 = function(f4_arg0)
		return {
			models = {
				name = CoD.TeamUtility.GetDefaultTeamName(f4_arg0),
				image = CoD.TeamUtility.GetDefaultTeamFactionIcon(f4_arg0),
				detailedDescription = Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamFactionDescription(f4_arg0)),
				team = f4_arg0,
			},
			properties = {
				faction = f4_arg0,
				action = f3_arg2,
				itemGainFocusAction = f3_arg3,
			},
		}
	end
	table.insert(f3_local0, f3_local1(Enum[@"team_t"][@"team_allies"]))
	table.insert(f3_local0, f3_local1(Enum[@"team_t"][@"team_axis"]))
	return f3_local0
end
DataSources.CPFactions = DataSourceHelpers.ListSetup("CPFactions", function(f5_arg0, f5_arg1)
	return CoD.CPUtility.CreateCPFactionList(f5_arg0, f5_arg1)
end, true)
DataSources.CPFactions_Lobby = DataSourceHelpers.ListSetup(
	"CPFactions_Lobby",
	function(f6_arg0, f6_arg1)
		return CoD.CPUtility.CreateCPFactionList(f6_arg0, f6_arg1, function(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
			CoD.CPUtility.SelectFaction_Internal(f7_arg2, f7_arg1.faction)
		end, function(f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
			CoD.CPUtility.FactionHighlighted(f8_arg2, f8_arg4, f8_arg1)
		end)
	end,
	true,
	nil,
	function(f9_arg0, f9_arg1, f9_arg2)
		f9_arg1.loseFocusAction = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4)
			CoD.CPUtility.FactionHighlighted(f10_arg2, f10_arg4, {
				faction = CoD.CPUtility.GetFactionFromStatsByController(f10_arg2),
			})
		end
	end
)
CoD.OverlayUtility.AddSystemOverlay("CompleteCPFirstTimeFlow", {
	menuName = "SystemOverlay_FreeCursor",
	title = @"hash_353A77C82A092440",
	description = @"hash_57FBC646A5BC61C8",
	categoryType = CoD.OverlayUtility.OverlayTypes.Notice,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f11_arg0)
		return function(f12_arg0, f12_arg1)
			GoBack(f12_arg0, f12_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = @"menu/ok",
	[CoD.OverlayUtility.bCirclePromptFn] = function(f13_arg0)
		return function(f14_arg0, f14_arg1)
			GoBack(f14_arg0, f14_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = @"menu/back",
})
CoD.OverlayUtility.AddSystemOverlay("ConfirmCompanionChange", {
	menuName = "SystemOverlay_FreeCursor",
	title = @"hash_2D53A1670E00816",
	description = function(f15_arg0, f15_arg1)
		local f15_local0 = Engine[@"getplayerstats"](f15_arg0)
		local f15_local1 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Enum[@"emodes"][@"mode_campaign"], f15_local0.companion:get())
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_F68F0D6082EA8E6", f15_local1.displayName)
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.Notice,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f16_arg0, f16_arg1)
		return function(f17_arg0, f17_arg1)
			CoD.CPUtility.SelectCompanion_Internal(f17_arg1, f16_arg1)
			local f17_local0 = GoBack(f17_arg0, f17_arg1)
			SendClientScriptMenuChangeNotify(f17_arg1, f17_local0, false)
			GoBack(f17_local0, f17_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = @"menu/confirm",
	[CoD.OverlayUtility.bCirclePromptFn] = function(f18_arg0, f18_arg1)
		return function(f19_arg0, f19_arg1)
			GoBack(f19_arg0, f19_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = @"menu/cancel",
})
CoD.OverlayUtility.AddSystemOverlay("ConfirmFactionChange", {
	menuName = "SystemOverlay_FreeCursor",
	title = @"hash_A080AB301CEFC5C",
	description = function(f20_arg0, f20_arg1)
		return Engine[@"hash_4F9F1239CFD921FE"](0x1A66A45FDE33A4, CoD.TeamUtility.GetDefaultTeamName(CoD.CPUtility.GetFactionFromStatsByController(f20_arg0)))
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.Notice,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f21_arg0, f21_arg1)
		return function(f22_arg0, f22_arg1)
			CoD.CPUtility.SelectFaction_Internal(f22_arg1, f21_arg1)
			local f22_local0 = GoBack(f22_arg0, f22_arg1)
			SendClientScriptMenuChangeNotify(f22_arg1, f22_local0, false)
			GoBack(f22_local0, f22_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = @"menu/confirm",
	[CoD.OverlayUtility.bCirclePromptFn] = function(f23_arg0, f23_arg1)
		return function(f24_arg0, f24_arg1)
			GoBack(f24_arg0, f24_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = @"menu/cancel",
})
CoD.CPUtility.SelectCompanion_Internal = function(f25_arg0, f25_arg1)
	local f25_local0 = Engine[@"getplayerstats"](f25_arg0)
	f25_local0.companion:set(f25_arg1)
	UploadStats(f25_arg0)
end
CoD.CPUtility.GetTeamTokenXModel = function(f26_arg0)
	if f26_arg0 == Enum[@"team_t"][@"team_allies"] or f26_arg0 == Enum[@"team_t"][@"team_axis"] then
		return "p8_frontend_cp_faction_" .. Engine[@"getfactionforteam"](f26_arg0) .. "_base"
	else
		return "tag_origin"
	end
end
CoD.CPUtility.GetFactionBodyIndexForPlayer = function(f27_arg0)
	local f27_local0
	if f27_arg0 == Enum[@"team_t"][@"team_allies"] then
		f27_local0 = 0
		if not f27_local0 then
		else
			return f27_local0
		end
	end
	f27_local0 = 1
end
CoD.CPUtility.GetFactionBodyIndexForCompanion = function(f28_arg0, f28_arg1)
	local f28_local0
	if f28_arg0 == Enum[@"team_t"][@"team_allies"] then
		f28_local0 = 1
		if not f28_local0 then
		else
			if f28_arg1 and #f28_arg1.bodies <= f28_local0 then
				f28_local0 = 0
			end
			return f28_local0
		end
	end
	f28_local0 = 2
end
CoD.CPUtility.GetFactionHelmetIndexForCompanion = function(f29_arg0, f29_arg1)
	local f29_local0
	if f29_arg0 == Enum[@"team_t"][@"team_allies"] then
		f29_local0 = 1
		if not f29_local0 then
		else
			if f29_arg1 and #f29_arg1.helmets <= f29_local0 then
				f29_local0 = 0
			end
			return f29_local0
		end
	end
	f29_local0 = 2
end
CoD.CPUtility.SelectFaction_Internal = function(f30_arg0, f30_arg1)
	local f30_local0 = Engine[@"getplayerstats"](f30_arg0)
	f30_local0.faction:set(f30_arg1)
	CoD.LobbyUtility.LobbySetTeam(f30_arg0, f30_arg1)
	UploadStats(f30_arg0)
end
CoD.CPUtility.SetupFrontendForFaction = function(f31_arg0, f31_arg1)
	SendClientScriptNotify(f31_arg0, "changeFactionToken", CoD.CPUtility.GetTeamTokenXModel(f31_arg1))
	SendCustomClientScriptNotifyForAdjustedClient(f31_arg0, CoD.CPUtility.FrontendPlayerCharacterUpdate, "changeBody", CoD.CPUtility.GetFactionBodyIndexForPlayer(f31_arg1), Enum[@"emodes"][@"mode_campaign"], true)
	local f31_local0 = Engine[@"getplayerstats"](f31_arg0)
	local f31_local1 = f31_local0.companion:get()
	if f31_arg1 ~= CoD.CPUtility.GetFactionFromStats(f31_local0) then
		for f31_local5, f31_local6 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Enum[@"emodes"][@"mode_campaign"])) do
			if f31_local6[@"iscompanion"] ~= 0 and (not f31_local6[@"baseteam"] or f31_local6[@"baseteam"] == f31_arg1) then
				f31_local1 = f31_local6.bodyIndex
				break
			end
		end
	end
end
CoD.CPUtility.EnteredCP_FlowComplete = function(f32_arg0)
	CoD.CPUtility.SetupFrontendForFaction(f32_arg0, CoD.CPUtility.GetFactionFromStatsByController(f32_arg0))
	SendCustomClientScriptNotifyForAdjustedClient(f32_arg0, CoD.CPUtility.FrontendPlayerCharacterUpdate, "show")
end
CoD.CPUtility.SelectCompanion = function(f33_arg0, f33_arg1, f33_arg2)
	CoD.CPUtility.SelectCompanion_Internal(f33_arg0, f33_arg2.characterIndex)
end
CoD.CPUtility.ChooseFaction = function(f34_arg0, f34_arg1, f34_arg2)
	CoD.CPUtility.SelectFaction_Internal(f34_arg0, f34_arg2.faction)
end
CoD.CPUtility.FactionHighlighted = function(f35_arg0, f35_arg1, f35_arg2)
	CoD.CPUtility.SetupFrontendForFaction(f35_arg0, f35_arg2.faction)
end
CoD.CPUtility.UnhideAllCPLobbyItems = function(f36_arg0)
	if IsCampaign() then
		SendClientScriptNotifyForAdjustedClient(f36_arg0, CoD.CPUtility.FrontendPlayerCharacterUpdate, "show")
		CoD.CPUtility.FactionHighlighted(f36_arg0, nil, {
			faction = CoD.CPUtility.GetFactionFromStatsByController(f36_arg0),
		})
	end
end
CoD.CPUtility.SetupVehicleHack = function(f37_arg0, f37_arg1)
	local f37_local0 = "gamedata/tables/cp/cp_vehicleHacks.csv"
	local f37_local1 = DataSources.HUDItems.getModel(f37_arg1)
	f37_local1 = f37_local1:create("vehicleHack.mode")
	f37_local1 = f37_local1:get()
	local f37_local2 = {}
	local f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.cross = f37_local3[CoD.ButtonMappings.BUTTON_A]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.circle = f37_local3[CoD.ButtonMappings.BUTTON_B]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.square = f37_local3[CoD.ButtonMappings.BUTTON_X]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.triangle = f37_local3[CoD.ButtonMappings.BUTTON_Y]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.r1 = f37_local3[CoD.ButtonMappings.BUTTON_RSHLDR]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.l1 = f37_local3[CoD.ButtonMappings.BUTTON_LSHLDR]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.r2 = f37_local3[CoD.ButtonMappings.BUTTON_RTRIG]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.l2 = f37_local3[CoD.ButtonMappings.BUTTON_LTRIG]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.left = f37_local3[CoD.ButtonMappings.DPAD_LEFT]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.right = f37_local3[CoD.ButtonMappings.DPAD_RIGHT]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.up = f37_local3[CoD.ButtonMappings.DPAD_UP]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.down = f37_local3[CoD.ButtonMappings.DPAD_DOWN]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.l3 = f37_local3[CoD.ButtonMappings.BUTTON_LSTICK]:get()
	f37_local3 = DataSources.Controller.getModel(f37_arg1)
	f37_local2.r3 = f37_local3[CoD.ButtonMappings.BUTTON_RSTICK]:get()
	f37_local3 = {}
	local f37_local4 = 24
	for f37_local5 = 1, f37_local4, 1 do
		table.insert(f37_local3, "buttonTime" .. f37_local5)
		table.insert(f37_local3, "buttonType" .. f37_local5)
	end
	local f37_local5 = LuaEnum.createEnum("index", "difficulty", "numPrompts", unpack(f37_local3))
	local f37_local6 = tonumber(Engine[@"tablelookup"](f37_local0, f37_local5.numPrompts, f37_local5.index, f37_local1))
	local f37_local7 = DataSources.HUDItems.getModel(f37_arg1)
	f37_local7 = f37_local7:create("vehicleHack.level")
	local f37_local8 = f37_arg0.puzzleLevels
	if not f37_local8 then
		f37_arg0.puzzleLevels = {}
		f37_local8 = f37_arg0.puzzleLevels
		for f37_local9 = 1, f37_local4, 1 do
			local f37_local12 = f37_arg0.spinnerContainer["spinner" .. f37_local9]
			assert(f37_local12 and f37_local12.resultContainer)
			table.insert(f37_local8, {
				spinner = f37_local12,
				image = "$white",
				text = "",
			})
		end
	else
		f37_arg0:playClip("Failure")
		for f37_local13, f37_local12 in ipairs(f37_local8) do
			f37_local12.spinner:setState(f37_arg1, "DefaultState", false, true)
			if f37_local12.timer then
				f37_local12.timer:close()
				f37_local12.timer = nil
			end
		end
	end
	local f37_local9 = function()
		f37_local2.kbcross = Engine[@"keybinding"](f37_arg1, "+forward")
		f37_local2.kbsquare = Engine[@"keybinding"](f37_arg1, "+moveleft")
		f37_local2.kbtriangle = Engine[@"keybinding"](f37_arg1, "+moveright")
		f37_local2.kbcircle = Engine[@"keybinding"](f37_arg1, "+back")
	end
	local f37_local10 = function(f39_arg0, f39_arg1)
		f39_arg0.text = f37_local2["kb" .. Engine[@"tablelookup"](f37_local0, f37_local5["buttonType" .. f39_arg1], f37_local5.index, f37_local1)] or ""
		if #f39_arg0.text > 1 then
			f39_arg0.text = Engine[@"localize"](f39_arg0.text)
		end
		assert(f39_arg0.text ~= nil)
		f39_arg0.spinner.resultContainer.resultText:setText(Engine[@"toupper"](f39_arg0.text))
	end
	if CoD.isPC then
		f37_local9()
		f37_arg0:registerEventHandler("input_source_changed", function(element, event)
			f37_local9()
			for f40_local0 = 1, f37_local6, 1 do
				f37_local10(f37_local8[f40_local0], f40_local0)
			end
		end)
	end
	LuaUtils.shuffle(f37_local8)
	local f37_local11 = Dvar[@"hash_611459B159CA3AB5"]:exists()
	if f37_local11 then
		f37_local11 = Dvar[@"hash_611459B159CA3AB5"]:get() ~= 0
	end
	for f37_local13 = 1, f37_local6, 1 do
		if f37_local11 == false then
			f37_local8[f37_local13].delay = 0
		else
			f37_local8[f37_local13].delay = tonumber(Engine[@"tablelookup"](f37_local0, f37_local5["buttonTime" .. f37_local13], f37_local5.index, f37_local1))
		end
		f37_local8[f37_local13].image = f37_local2[Engine[@"tablelookup"](f37_local0, f37_local5["buttonType" .. f37_local13], f37_local5.index, f37_local1)] or "$white"
		if CoD.isPC then
			f37_local10(f37_local8[f37_local13], f37_local13)
		end
		f37_local8[f37_local13].spinner.resultContainer.result:setImage(RegisterImage(f37_local8[f37_local13].image))
		f37_local8[f37_local13].spinner:setState(f37_arg1, "DefaultState", true, true)
	end
	for f37_local13 = f37_local6 + 1, f37_local4, 1 do
		f37_local8[f37_local13].spinner:setState(f37_arg1, "Solved", true, true)
	end
	local f37_local13 = function(f41_arg0)
		f41_arg0.timer = LUI.UITimer.newElementTimer(f41_arg0.delay, true, function()
			f41_arg0.timer = nil
			f41_arg0.spinner:setState(f37_arg1, "Revealed", false, true)
		end)
		f37_arg0:addElement(f41_arg0.timer)
	end
	local f37_local12 = 0
	if f37_arg0._vehicleHackSubscription then
		f37_arg0:removeSubscription(f37_arg0._vehicleHackSubscription)
	end
	f37_arg0._vehicleHackSubscription = f37_arg0:subscribeToModel(f37_local7, function()
		local f43_local0 = f37_local7:get()
		if f37_local12 < f43_local0 then
			for f43_local1 = f37_local12 + 1, f43_local0, 1 do
				f37_local8[f43_local1].spinner:setState(f37_arg1, "Solved", false, true)
				if f37_local8[f43_local1].timer then
					f37_local8[f43_local1].timer:close()
					f37_local8[f43_local1].timer = nil
				end
			end
			f37_local12 = f43_local0
			if f37_local12 == f37_local6 then
				f37_arg0:setState(f37_arg1, "Solved", false, true)
			end
			f37_local13(f37_local8[f37_local12 + 1])
		elseif f37_local12 == 0 and not f37_local8[1].timer then
			f37_arg0:setState(f37_arg1, "DefaultState", false, true)
			f37_local13(f37_local8[1])
		elseif f43_local0 < f37_local12 and f37_local12 < f37_local6 then
			f37_arg0:playClip("Failure")
			if f37_local8[f37_local12 + 1].timer then
				f37_local8[f37_local12 + 1].timer:close()
				f37_local8[f37_local12 + 1].timer = nil
			end
			for f43_local1 = f37_local12 + 1, f43_local0 + 1, -1 do
				if f37_local8[f43_local1].timer then
					f37_local8[f43_local1].timer:close()
					f37_local8[f43_local1].timer = nil
				end
				if f37_local12 + 1 < f37_local4 then
					local f43_local4 = math.random(f37_local12 + 1, f37_local4)
					local f43_local5 = f37_local8[f43_local1].spinner
					f37_local8[f43_local1].spinner = f37_local8[f43_local4].spinner
					f37_local8[f43_local4].spinner = f43_local5
					if CoD.isPC then
						f37_local8[f43_local1].spinner.resultContainer.resultText:setText(Engine[@"toupper"](f37_local8[f43_local1].text))
						f37_local8[f43_local4].spinner.resultContainer.resultText:setText(Engine[@"toupper"](f37_local8[f43_local4].text))
					end
					f37_local8[f43_local1].spinner.resultContainer.result:setImage(RegisterImage(f37_local8[f43_local1].image))
					f37_local8[f43_local4].spinner.resultContainer.result:setImage(RegisterImage(f37_local8[f43_local4].image))
					f37_local8[f43_local4].spinner:setState(f37_arg1, f37_local8[f43_local1].spinner.currentState, true)
					f37_local8[f43_local1].spinner:setState(f37_arg1, "DefaultState", true, true)
				end
				f37_local8[f43_local1].spinner:setState(f37_arg1, "DefaultState", false, true)
			end
			f37_local12 = f43_local0
			f37_local13(f37_local8[f37_local12 + 1])
		end
	end)
end
DataSourceHelpers.PerControllerDataSourceSetup("SpinnerPuzzle", "hudItems.SpinnerPuzzle", function(f44_arg0, f44_arg1)
	local f44_local0 = function(f45_arg0)
		local f45_local0 = f44_arg0:create("piece" .. f45_arg0)
		local f45_local1 = f45_local0:create("highlighted")
		f45_local1:set(false)
		f45_local1 = f45_local0:create("lockedIn")
		f45_local1:set(false)
		f45_local1 = f45_local0:create("rotation")
		f45_local1:set(0)
		f45_local1 = f45_local0:create("visibleLines")
		f45_local1:set(0)
	end
	local f44_local1 = f44_arg0:create("active")
	f44_local1:set(false)
	f44_local1 = 6
	for f44_local2 = 0, f44_local1 - 1, 1 do
		f44_local0(f44_local2)
	end
end, false)
DataSourceHelpers.PerControllerDataSourceSetup("ThreeRings", "hudItems.ThreeRings", function(f46_arg0, f46_arg1)
	local f46_local0 = function(f47_arg0)
		local f47_local0 = f46_arg0:create(f47_arg0)
		local f47_local1 = f47_local0:create("rotation")
		f47_local1:set(0)
		f47_local1 = f47_local0:create("arcString")
		f47_local1:set("0 0.15")
		f47_local1 = f47_local0:create("state")
		f47_local1:set("inactive")
	end
	local f46_local1 = f46_arg0:create("active")
	f46_local1:set(false)
	f46_local1 = f46_arg0:create("buttonPromptActive")
	f46_local1:set(false)
	f46_local1 = f46_arg0:create("arrowRotation")
	f46_local1:set(0)
	f46_local1 = f46_arg0:create("activeRing")
	f46_local1:set("outer")
	f46_local0("inner")
	f46_local0("middle")
	f46_local0("outer")
end, false)
DataSourceHelpers.PerControllerDataSourceSetup("AxeHack", "hudItems.AxeHack", function(f48_arg0, f48_arg1)
	local f48_local0 = f48_arg0:create("active")
	f48_local0:set(false)
	f48_local0 = f48_arg0:create("arrowPos")
	f48_local0:set(0)
	f48_local0 = f48_arg0:create("sweetSpotPos")
	f48_local0:set(0)
	f48_local0 = f48_arg0:create("redHeight")
	f48_local0:set(0)
	f48_local0 = f48_arg0:create("yellowHeight")
	f48_local0:set(0)
end, false)
DataSourceHelpers.PerControllerDataSourceSetup("InterferenceSelect", "hudItems.interferenceSelect", function(f49_arg0, f49_arg1)
	local f49_local0 = f49_arg0:create("active")
	f49_local0:set(0)
	f49_local0 = f49_arg0:create("selectedIndex")
	f49_local0:set(0)
end, false)
DataSourceHelpers.PerControllerDataSourceSetup("InterferenceSelectorTablet", "InterferenceSelectorTablet", function(f50_arg0, f50_arg1)
	local f50_local0 = Engine[@"getcurrentmapname"]()
	local f50_local1 = Engine[@"getfactionforteam"](CoD.TeamUtility.GetTeamID(f50_arg1))
	local f50_local2 = CoD.BaseUtility.GetMapValue(f50_local0, @"hash_765873EF183A770A" .. f50_local1, nil) or ""
	local f50_local3 = CoD.BaseUtility.GetMapValue(f50_local0, @"hash_462D533E8A3E0AA5" .. f50_local1, nil) or ""
	local f50_local4 = f50_arg0:create("title")
	f50_local4:set(f50_local2)
	f50_local4 = f50_arg0:create("desc")
	f50_local4:set(f50_local3)
end, false)
DataSources.InterferenceSelection = DataSourceHelpers.ListSetup("InterferenceSelection", function(f51_arg0, f51_arg1)
	local f51_local0 = {}
	local f51_local1 = CoD.BaseUtility.GetMapValue(Engine[@"getcurrentmapname"](), "interferenceSelection_" .. Engine[@"getfactionforteam"](CoD.TeamUtility.GetTeamID(f51_arg0)), nil)
	if f51_local1 then
		for f51_local5, f51_local6 in ipairs(f51_local1) do
			table.insert(f51_local0, {
				models = {
					image = f51_local6[@"hash_31163F76402A0258"],
					desc = f51_local6[@"hash_4F33F29FEDB35478"],
					index = f51_local5,
				},
			})
		end
	end
	return f51_local0
end, true)
CoD.CPUtility.SetupCPAxeHackWidget = function(f52_arg0, f52_arg1, f52_arg2)
	f52_arg0:subscribeToGlobalModel(f52_arg2, "AxeHack", "arrowPos", function(model)
		local f53_local0 = 1 - model:get()
		local f53_local1, f53_local2 = f52_arg0:getLocalSize()
		local f53_local3 = f53_local0 * f53_local2
		local f53_local4, f53_local5 = f52_arg1:getLocalSize()
		f52_arg1:setTopBottom(0, 0, f53_local3 - f53_local5 / 2, f53_local3 + f53_local5 / 2)
	end)
end
CoD.CPUtility.SetupCPAxeHackWidgetRedHeight = function(f54_arg0, f54_arg1, f54_arg2)
	local f54_local0 = DataSources.AxeHack.getModel(f54_arg2)
	f54_local0 = f54_local0.sweetSpotPos
	local f54_local1 = DataSources.AxeHack.getModel(f54_arg2)
	f54_local1 = f54_local1.redHeight
	local f54_local2 = function()
		local f55_local0, f55_local1 = f54_arg0:getLocalSize()
		local f55_local2 = f54_local1:get()
		local f55_local3 = f55_local1 * (1 - f54_local0:get())
		f54_arg1:setTopBottom(0, 0, f55_local3 - f55_local2 * f55_local1 / 2, f55_local3 + f55_local2 * f55_local1 / 2)
	end
	f54_arg0:subscribeToGlobalModel(f54_arg2, "AxeHack", "redHeight", f54_local2)
	f54_arg0:subscribeToGlobalModel(f54_arg2, "AxeHack", "sweetSpotPos", f54_local2)
end
CoD.CPUtility.SetupCPAxeHackWidgetYellowHeight = function(f56_arg0, f56_arg1, f56_arg2)
	local f56_local0 = DataSources.AxeHack.getModel(f56_arg2)
	f56_local0 = f56_local0.sweetSpotPos
	local f56_local1 = DataSources.AxeHack.getModel(f56_arg2)
	f56_local1 = f56_local1.yellowHeight
	local f56_local2 = function()
		local f57_local0, f57_local1 = f56_arg0:getLocalSize()
		local f57_local2 = f56_local1:get()
		local f57_local3 = f57_local1 * (1 - f56_local0:get())
		f56_arg1:setTopBottom(0, 0, f57_local3 - f57_local2 * f57_local1 / 2, f57_local3 + f57_local2 * f57_local1 / 2)
	end
	f56_arg0:subscribeToGlobalModel(f56_arg2, "AxeHack", "yellowHeight", f56_local2)
	f56_arg0:subscribeToGlobalModel(f56_arg2, "AxeHack", "sweetSpotPos", f56_local2)
end
CoD.CPUtility.SpawnDynamicCPHUDWidgets = function(f58_arg0, f58_arg1)
	local f58_local0 = DataSources.WorldSpaceIndicators.getModel(f58_arg1)
	CoD.HUDUtility.SetupGrenadeWarningIndicators(f58_arg0, f58_arg1)
	local f58_local1 = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
		if worldIconModel then
			local f59_local0 = Engine[@"createmodel"](worldIconModel, "weakpoint_" .. f59_arg0 .. "_" .. f59_arg1)
			if f59_local0 then
				LUI.CreateModelAndInitialize(f59_local0, "status", Enum[@"weakpointwidgetstates"][@"weakpoint_state_default"])
				local f59_local1 = CoD.weakpointIndicator.new(f58_arg0, f58_arg1, 0, 0, 0, CoD.weakpointIndicator.__defaultWidth, 0, 0, 0, CoD.weakpointIndicator.__defaultHeight)
				f59_local1:setModel(f59_local0, f58_arg1)
				f59_local1:setupWeakpointIndicator(f58_arg1, f59_arg0, f59_arg1, f59_arg2, f59_arg3)
				LUI.OverrideFunction_CallOriginalFirst(f59_local1, "close", function()
					if LUI.DEV then
						local f60_local0 = LUI.DEV.ErrorIfModelsDoNotMatch(f59_local0, Engine[@"createmodel"](worldIconModel, "weakpoint_" .. f59_arg0 .. "_" .. f59_arg1))
					end
					Engine[@"unsubscribeandfreemodel"](f59_local0)
				end)
				return f59_local1
			end
		end
	end
	f58_arg0.weakpoints = {}
	f58_arg0:subscribeToGlobalModel(f58_arg1, "PerController", "scriptNotify", function(model)
		local f61_local0 = Engine[@"getmodelvalue"](model)
		local f61_local1 = {
			controller = f58_arg1,
			name = f61_local0,
			data = CoD.GetScriptNotifyData(model),
		}
		if f61_local0 == "weakpoint_update" then
			local f61_local2 = f61_local1.data[2]
			local f61_local3 = Engine[@"getistring"](f61_local1.data[3], "CS_LOCALIZED_STRINGS")
			if f61_local1.data[1] == 0 then
				if f58_arg0.weakpoints[f61_local2] and f58_arg0.weakpoints[f61_local2][f61_local3] then
					local f61_local4 = f58_arg0.weakpoints[f61_local2][f61_local3]:getModel(f58_arg1, "status")
					if f61_local4 then
						Engine[@"setmodelvalue"](f61_local4, Enum[@"weakpointwidgetstates"][@"weakpoint_state_closing"])
					end
					local f61_local5 = f58_arg0.weakpoints[f61_local2][f61_local3]
					f61_local5:addElement(LUI.UITimer.newElementTimer(1500, true, f61_local5.close, f61_local5))
					f58_arg0.weakpoints[f61_local2][f61_local3] = nil
				end
			elseif f61_local1.data[1] == 1 then
				if not f58_arg0.weakpoints[f61_local2] then
					f58_arg0.weakpoints[f61_local2] = {}
				end
				if not f58_arg0.weakpoints[f61_local2][f61_local3] then
					local f61_local6 = f58_local1(f61_local2, f61_local3, f61_local1.data[4], f61_local1.data[5])
					if f61_local6 then
						f58_arg0.weakpoints[f61_local2][f61_local3] = f61_local6
						f58_arg0.fullscreenContainer:addElement(f61_local6)
						f58_arg0:sendInitializationEvents(f58_arg1, f61_local6)
					end
				end
			elseif f61_local1.data[1] == 2 then
				if f58_arg0.weakpoints[f61_local2] and f58_arg0.weakpoints[f61_local2][f61_local3] then
					f58_arg0.weakpoints[f61_local2][f61_local3]:playClip("Damaged")
				end
			elseif f61_local1.data[1] == 3 and f58_arg0.weakpoints[f61_local2] and f58_arg0.weakpoints[f61_local2][f61_local3] then
				f58_arg0.weakpoints[f61_local2][f61_local3]:playClip("Repulsed")
			end
			return true
		else
		end
	end)
	local f58_local2 = DataSources.CurrentWeapon.getModel(f58_arg1)
	f58_local2 = f58_local2.viewmodelWeaponName
	if f58_local2 then
		f58_arg0:subscribeToModel(f58_local2, function(model)
			if IsCurrentViewmodelWeaponName(f58_arg1, @"spike_launcher") then
				f58_arg0.spikeLauncherCounter = CoD.SpikeLauncherSpikeCounter.new(f58_arg0, f58_arg1, 0, 0, 0, CoD.SpikeLauncherSpikeCounter.__defaultWidth, 0, 0, 0, CoD.SpikeLauncherSpikeCounter.__defaultHeight)
				f58_arg0:addElement(f58_arg0.spikeLauncherCounter)
				f58_arg0.spikeLauncherCounter:dispatchEventToChildren({
					name = "update_state",
					controller = f58_arg1,
				})
			elseif f58_arg0.spikeLauncherCounter ~= nil then
				f58_arg0.spikeLauncherCounter:close()
				f58_arg0.spikeLauncherCounter = nil
			end
		end)
	end
	local f58_local3 = f58_arg0.close
	f58_arg0.close = function(f63_arg0)
		f58_local3(f63_arg0)
		if f63_arg0.spikeLauncherCounter ~= nil then
			f63_arg0.spikeLauncherCounter:close()
		end
	end
	if f58_local0 then
		local f58_local4 = function(f64_arg0)
			local f64_local0 = f64_arg0:getFirstChild()
			while f64_local0 do
				if LUI.startswith(f64_local0.id, "bleedOutItem") then
					local f64_local1 = f64_local0:getModel(f58_arg1, "playerName")
					if f64_local1 then
						Engine[@"setmodelvalue"](f64_local1, Engine[@"getgamertagforclient"](f58_arg1, f64_local0.bleedOutClient))
					end
				end
				f64_local0 = f64_local0:getNextSibling()
			end
		end
		local f58_local5 = 0
		local f58_local6 = true
		while f58_local6 do
			local f58_local7 = f58_local5
			local f58_local8 = Engine[@"createmodel"](f58_local0, "bleedOutModel" .. f58_local7)
			local f58_local9 = Engine[@"createmodel"](f58_local8, "playerName")
			Engine[@"setmodelvalue"](f58_local9, GetClientName(f58_arg1, f58_local7))
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f58_local8, "prompt"), @"hash_48FE93EDC5208D8")
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f58_local8, "clockPercent"), 0)
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f58_local8, "bleedOutPercent"), 0)
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f58_local8, "stateFlags"), 0)
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f58_local8, "arrowAngle"), 0)
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f58_local8, "isCompanion"), false)
			local f58_local10 = CoD.bleedOutWidget.new(f58_arg0, f58_arg1, 0, 0, 0, CoD.bleedOutWidget.__defaultWidth, 0, 0, 0, CoD.bleedOutWidget.__defaultHeight)
			f58_local10.bleedOutClient = f58_local7
			f58_local10.id = "bleedOutItem" .. f58_local7
			f58_local10:setLeftRight(true, false, 0, 0)
			f58_local10:setTopBottom(true, false, 0, 0)
			f58_local10:setModel(f58_local8, f58_arg1)
			f58_local6 = f58_local10:setupBleedOutWidget(f58_arg1, f58_local7)
			f58_arg0.fullscreenContainer:addElement(f58_local10)
			local f58_local11 = Engine[@"getmodelforclient"](f58_local5)
			f58_local10:subscribeToModel(f58_local11.playerName, function(model)
				f58_local9:set(model:get())
			end)
			if not f58_arg0.fullscreenContainer._hasPlayerConnectedSubscription then
				f58_arg0.fullscreenContainer:subscribeToModel(Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f58_arg1), "playerConnected"), function(model)
					f58_local4(f58_arg0.fullscreenContainer)
				end)
				f58_arg0.fullscreenContainer._hasPlayerConnectedSubscription = true
			end
			f58_local5 = f58_local5 + 1
		end
	end
	f58_arg0.m_inputDisabled = true
end
CoD.CPUtility.ChangeGender = function(f67_arg0, f67_arg1, f67_arg2)
	if f67_arg1.gender then
		Engine[@"setgender"](f67_arg0, f67_arg1.gender)
		f67_arg2.__currentlySelectedGender = f67_arg1.gender
		SendCustomClientScriptNotifyForAdjustedClient(f67_arg0, CoD.PlayerRoleUtility.Heroes.heroUpdateEvent, {
			event_name = "changeGender",
			gender = f67_arg1.gender,
			mode = Enum[@"emodes"][@"mode_campaign"],
		})
	end
end
CoD.CPUtility.NewsAlertTypes = LuaEnum.createEnum("REGULAR_NEWS", "BREAKING_NEWS")
CoD.CPUtility.SetupNewsroomDataWatchers = function(f68_arg0, f68_arg1)
	local f68_local0 = CoD.BaseUtility.GetMapValue(Engine[@"getcurrentmapname"](), @"hash_13C66F2147C55B8D", nil)
	local f68_local1 = f68_local0 and Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f68_local0))
	local f68_local2 = f68_arg0:getModel()
	local f68_local3 = f68_local1
	local f68_local4 = f68_local1.scenes
	if f68_local4 then
		f68_local4 = f68_local1.scenes
		local f68_local5 = f68_local2:create("sceneIndex")
		f68_local4 = f68_local3 and f68_local4[(f68_local5:get() or 0) + 1]
	end
	if f68_local4 then
		local f68_local5 = f68_local2:create("torch.donatorName")
		f68_local5:set("")
		f68_local5 = f68_local2:create("torch.donatorAmount")
		f68_local5:set(0)
		f68_arg0:linkToElementModel(f68_arg0, "torch.donatorIndex", true, function(model)
			if f68_local4.torchdonatorentries then
				local f69_local0 = f68_local4.torchdonatorentries[(model:get() or 0) + 1] or {}
				if f69_local0 then
					local f69_local1 = f68_local2:create("torch.donatorName")
					f69_local1:set(f69_local0[@"name"] and Engine[@"localize"](f69_local0[@"name"]) or "")
					f69_local1 = f68_local2:create("torch.donatorAmount")
					f69_local1:set(f69_local0[@"amount"] or 0)
				end
			end
		end)
		f68_local5 = f68_local2:create("uns.header")
		f68_local5:set("")
		f68_local5 = f68_local2:create("uns.body")
		f68_local5:set("")
		f68_local2:create("uns.newsType")
		f68_arg0:linkToElementModel(f68_arg0, "uns.generalNewsIndex", true, function(model)
			if f68_local4.unsnewsentries then
				local f70_local0 = f68_local4.unsnewsentries[model:get() or 0] or {}
				local f70_local1 = f70_local0[@"header"] and Engine[@"localize"](f70_local0[@"header"]) or ""
				local f70_local2 = f70_local0[@"body"] and Engine[@"localize"](f70_local0[@"body"]) or ""
				f68_local2["uns.header"].set(f68_local2["uns.header"], f70_local1)
				f68_local2["uns.body"].set(f68_local2["uns.body"], f70_local2)
				local f70_local3 = CoD.CPUtility.NewsAlertTypes.REGULAR_NEWS
				if f70_local0[@"hash_1F5A9D1C35E8A1E7"] == 1 then
					f70_local3 = CoD.CPUtility.NewsAlertTypes.BREAKING_NEWS
				end
				if not f68_local2["uns.newsType"]:set(f70_local3) then
					f68_local2["uns.newsType"].forceNotifySubscriptions(f68_local2["uns.newsType"])
				end
			end
		end)
		f68_local5 = f68_local2:create("noble.body")
		f68_local5:set("")
		f68_local2:create("noble.newsType")
		f68_local5 = f68_local2:create("noble.flatImage")
		f68_local5:set("blacktransparent")
		f68_arg0:linkToElementModel(f68_arg0, "noble.generalNewsIndex", true, function(model)
			if f68_local4.noblenewsentries then
				local f71_local0 = f68_local4.noblenewsentries[model:get() or 0] or {}
				f68_local2["noble.body"].set(f68_local2["noble.body"], f71_local0[@"body"] and Engine[@"localize"](f71_local0[@"body"]) or "")
				local f71_local1 = CoD.CPUtility.NewsAlertTypes.REGULAR_NEWS
				if f71_local0[@"hash_1F5A9D1C35E8A1E7"] == 1 then
					f71_local1 = CoD.CPUtility.NewsAlertTypes.BREAKING_NEWS
				end
				if not f68_local2["noble.newsType"]:set(f71_local1) then
					f68_local2["noble.newsType"].forceNotifySubscriptions(f68_local2["noble.newsType"])
				end
			end
		end)
		f68_arg0:linkToElementModel(f68_arg0, "noble.imageIndex", true, function(model)
			local f72_local0 = "blacktransparent"
			local f72_local1 = model:get() or 0
			if f72_local1 > 0 and f68_local4.nobleimageentries then
				local f72_local2 = f68_local4.nobleimageentries[f72_local1]
				if f72_local2[@"graphic"] ~= "" then
					f72_local0 = f72_local2[@"graphic"] or f72_local0
				end
			end
			local f72_local2 = f68_local2:create("noble.flatImage")
			f72_local2:set(f72_local0)
		end)
	end
end
CoD.CPUtility.SetupNewsRoomTicker = function(f73_arg0, f73_arg1)
	if f73_arg0.__setupDone then
		return
	end
	f73_arg0.__setupDone = true
	local f73_local0 = f73_arg0:getModel()
	if not f73_local0 then
		return
	end
	local f73_local1 = {}
	local f73_local2 = 0
	while f73_arg0["entry" .. f73_local2] do
		local f73_local3 = f73_arg0["entry" .. f73_local2]
		local f73_local4 = f73_arg0["spacer" .. f73_local2]
		f73_local3:setAlpha(0)
		f73_local4:setAlpha(0)
		table.insert(f73_local1, {
			text = f73_local3,
			spacer = f73_local4,
			visible = false,
		})
		f73_local2 = f73_local2 + 1
	end
	local f73_local3 = Engine[@"hash_2E00B2F29271C60B"](@"hash_4E22B3E79F1C949D")
	local f73_local4 = f73_local3.scenes
	if f73_local4 then
		f73_local4 = f73_local3.scenes
		local f73_local5 = f73_local0:create("sceneIndex")
		f73_local4 = f73_local4[(f73_local5:get() or 0) + 1]
	end
	if f73_local4 then
		local f73_local5 = nil
		if f73_arg1 == CoD.CPUtility.NewsRoomChannels.UNS then
			f73_local5 = f73_local4.unstickerentries
		elseif f73_arg1 == CoD.CPUtility.NewsRoomChannels.NOBLE then
			f73_local5 = f73_local4.nobletickerentries
		elseif f73_arg1 == CoD.CPUtility.NewsRoomChannels.TORCH then
			f73_local5 = f73_local4.torchtickerentries
		end
		if f73_local5 and #f73_local5 > 0 then
			local f73_local6 = 0
			local f73_local7, f73_local8 = f73_arg0:getLocalSize()
			if #f73_local1 > 0 then
				f73_local2 = 1
				local f73_local9 = nil
				local f73_local10 = 20
				local f73_local11 = true
				f73_arg0:addElement(LUI.UITimer.newElementTimer(0, false, function(f74_arg0)
					table.insert(f73_local1, table.remove(f73_local1, 1))
					local f74_local0 = f73_local2
					f73_local2 = f73_local2 + 1
					if #f73_local5 < f73_local2 then
						f73_local2 = 1
					end
					local f74_local1 = function()
						f74_local0 = f74_local0 + 1
						if #f73_local5 < f74_local0 then
							f74_local0 = 1
						end
					end
					local f74_local2 = 0
					f73_local1[1].text:setText(Engine[@"localize"](f73_local5[f74_local0][@"entry"]))
					local f74_local3 = f73_local1[1].text:getTextWidth()
					local f74_local4, f74_local5 = f73_local1[1].spacer:getLocalSize()
					f74_local3 = f74_local3 + f74_local4
					f74_local1()
					local f74_local6 = f73_local9.interval
					local f74_local7
					if f74_arg0 then
						f74_local7 = f74_arg0.timeElapsed
						if not f74_local7 then
						else
							f74_local7 = f74_local3 * f73_local10 - f74_local6 - f74_local7
							f73_local9.interval = f74_local7
							local f74_local8 = function(f76_arg0)
								local f76_local0 = f76_arg0.text:getTextWidth()
								if not f76_arg0.visible then
									f76_arg0.text:completeAnimation()
									f76_arg0.text:setLeftRight(0, 0, f74_local2, f74_local2 + f76_local0 + 5)
									f76_arg0.text:setAlpha(1)
								end
								f76_arg0.text:beginAnimation(f74_local7)
								f76_arg0.text:setLeftRight(0, 0, f74_local2 - f74_local3, f74_local2 + f76_local0 + 5 - f74_local3)
								f74_local2 = f74_local2 + f76_local0
								local f76_local1, f76_local2 = f76_arg0.spacer:getLocalSize()
								if not f76_arg0.visible then
									f76_arg0.spacer:completeAnimation()
									f76_arg0.spacer:setLeftRight(0, 0, f74_local2, f74_local2 + f76_local1)
									f76_arg0.spacer:setAlpha(1)
								end
								f76_arg0.spacer:beginAnimation(f74_local7)
								f76_arg0.spacer:setLeftRight(0, 0, f74_local2 - f74_local3, f74_local2 + f76_local1 - f74_local3)
								f74_local2 = f74_local2 + f76_local1
								f76_arg0.visible = true
							end
							f74_local8(f73_local1[1])
							local f74_local9 = 2
							while f74_local2 - f74_local3 < f73_local7 and f74_local9 <= #f73_local1 do
								f73_local1[f74_local9].text:setText(Engine[@"localize"](f73_local5[f74_local0][@"entry"]))
								f74_local8(f73_local1[f74_local9])
								f74_local9 = f74_local9 + 1
								f74_local1()
							end
							while f74_local9 <= #f73_local1 do
								f73_local1[f74_local9].text:setAlpha(0)
								f73_local1[f74_local9].text:completeAnimation()
								f73_local1[f74_local9].spacer:setAlpha(0)
								f73_local1[f74_local9].spacer:completeAnimation()
								f73_local1[f74_local9].visible = false
								f74_local9 = f74_local9 + 1
							end
						end
					end
					f74_local7 = f73_local9.interval
				end))
			end
		end
	end
end
DataSources.CPObjectiveTeams = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	createFractionModelListener = function(f77_arg0, f77_arg1)
		if f77_arg1 then
			local f77_local0 = f77_arg1:create("fractionProgress")
			local f77_local1 = function()
				f77_local0:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f77_arg1.clearAll.currentCount:get() or 0, f77_arg1.clearAll.totalCount:get() or 0))
			end
			DataSources.CPObjectiveTeams.subscriptions[f77_arg0]:subscribeToModel(f77_arg1:create("clearAll.totalCount"), f77_local1)
			DataSources.CPObjectiveTeams.subscriptions[f77_arg0]:subscribeToModel(f77_arg1:create("clearAll.currentCount"), f77_local1)
		end
	end,
	createPercentModelListener = function(f79_arg0, f79_arg1, f79_arg2)
		if f79_arg1 then
			local f79_local0 = f79_arg1:create("percentProgress")
			local f79_local1 = function(f80_arg0)
				local f80_local0 = f80_arg0:get() or 0
				local f80_local1 = f79_arg1.radialTimerMaxTime:get() or 0
				local f80_local2 = 0
				if f80_local1 > 0 then
					f80_local2 = 1 - (f80_local0 - 1000) / f80_local1 * 1000
				end
				f79_local0:set(f80_local2)
			end
			local f79_local2 = function()
				f79_local0:set(f79_arg1.hardpoint.progress:get() or 0)
			end
			local f79_local3 = function()
				local f82_local0 = f79_arg1.clearAll.currentCount:get() or 0
				local f82_local1 = f79_arg1.clearAll.totalCount:get() or 0
				local f82_local2 = 0
				if f82_local1 > 0 then
					f82_local2 = f82_local0 / f82_local1
				end
				f79_local0:set(f82_local2)
			end
			local f79_local4 = function(f83_arg0)
				if DataSources.CPObjectiveTeams.subscriptions[f79_arg0].__timerMilliSecSubscription[f79_arg2] then
					DataSources.CPObjectiveTeams.subscriptions[f79_arg0]:removeSubscription(DataSources.CPObjectiveTeams.subscriptions[f79_arg0].__timerMilliSecSubscription[f79_arg2])
					DataSources.CPObjectiveTeams.subscriptions[f79_arg0].__timerMilliSecSubscription[f79_arg2] = nil
				end
				local f83_local0 = f83_arg0
				local f83_local1 = f83_arg0:get()
				if f83_local1 then
					f83_local1 = f83_arg0:get()
					f83_local1 = f83_local0 and f83_local1.timeRemainingMilliSec
				end
				if f83_local1 then
					DataSources.CPObjectiveTeams.subscriptions[f79_arg0].__timerMilliSecSubscription[f79_arg2] = DataSources.CPObjectiveTeams.subscriptions[f79_arg0]:subscribeToModel(f83_local1, f79_local1)
				end
			end
			DataSources.CPObjectiveTeams.subscriptions[f79_arg0].__timerMilliSecSubscription = {}
			DataSources.CPObjectiveTeams.subscriptions[f79_arg0]:subscribeToModel(f79_arg1:create("timer"), f79_local4)
			DataSources.CPObjectiveTeams.subscriptions[f79_arg0]:subscribeToModel(f79_arg1:create("hardpoint.progress"), f79_local2)
			DataSources.CPObjectiveTeams.subscriptions[f79_arg0]:subscribeToModel(f79_arg1:create("clearAll.currentCount"), f79_local3)
		end
	end,
	setupSubObjectiveModels = function(f84_arg0, f84_arg1, f84_arg2)
		local f84_local0 = Engine[@"getmodelforcontroller"](f84_arg0)
		f84_local0 = f84_local0.hudItems.cpObjective.perPlayer
		local f84_local1 = f84_arg1:create("subObjective1")
		f84_local1:set(f84_local0.subObjective1)
		f84_local1 = f84_arg1:create("subObjective2")
		f84_local1:set(f84_local0.subObjective2)
		f84_local1 = f84_arg1:create("subObjective3")
		f84_local1:set(f84_local0.subObjective3)
		f84_local1 = f84_arg2:create("subObjective1")
		f84_local1:set(f84_arg2.teamSubObjective1)
		f84_local1 = f84_arg2:create("subObjective2")
		f84_local1:set(f84_arg2.teamSubObjective2)
		f84_local1 = f84_arg2:create("subObjective3")
		f84_local1:set(f84_arg2.teamSubObjective3)
	end,
	prepare = function(f85_arg0, f85_arg1, f85_arg2)
		if not DataSources.CPObjectiveTeams.preparedForController then
			DataSources.CPObjectiveTeams.preparedForController = {}
		end
		if not DataSources.CPObjectiveTeams.subscriptions[f85_arg0] then
			DataSources.CPObjectiveTeams.subscriptions[f85_arg0] = LUI.UIElement.new()
		end
		DataSources.CPObjectiveTeams.subscriptions[f85_arg0]:unsubscribeFromAllModels()
		DataSources.CPObjectiveTeams.preparedForController[f85_arg0] = true
		local f85_local0 = DataSources.CPObjectiveTeams.subscriptions[f85_arg0]
		local f85_local1 = f85_local0
		f85_local0 = f85_local0.subscribeToModel
		local f85_local2 = DataSources.Factions.getModel(f85_arg0)
		f85_local0(f85_local1, f85_local2.playerFactionTeamEnum, function(f86_arg0)
			DataSources.CPObjectiveTeams.preparedForController[f85_arg0] = false
			DataSources.CPObjectiveTeams.prepare(f85_arg0)
		end, false)
		f85_local0 = Engine[@"getmodelforcontroller"](f85_arg0)
		f85_local0 = f85_local0:create("CPObjectiveTeams")
		f85_local1 = f85_local0:create("myTeam")
		f85_local2 = f85_local0:create("enemyTeam")
		local f85_local3 = Engine[@"getglobalmodel"]()
		f85_local3 = f85_local3.hudItems.cpObjective
		local f85_local4 = f85_local3.allies:create("timer")
		local f85_local5 = f85_local4
		f85_local4 = f85_local4.set
		local f85_local6 = Engine[@"getglobalmodel"]()
		f85_local4(f85_local5, f85_local6.bombTimer.bomb0)
		f85_local4 = f85_local3.axis:create("timer")
		f85_local5 = f85_local4
		f85_local4 = f85_local4.set
		f85_local6 = Engine[@"getglobalmodel"]()
		f85_local4(f85_local5, f85_local6.bombTimer.bomb1)
		DataSources.CPObjectiveTeams.createFractionModelListener(f85_arg0, f85_local3.allies)
		DataSources.CPObjectiveTeams.createFractionModelListener(f85_arg0, f85_local3.axis)
		DataSources.CPObjectiveTeams.createPercentModelListener(f85_arg0, f85_local3.allies, 1)
		DataSources.CPObjectiveTeams.createPercentModelListener(f85_arg0, f85_local3.axis, 2)
		if Engine[@"getteamid"](f85_arg0, Engine[@"getpredictedclientnum"](f85_arg0)) == Enum[@"team_t"][@"team_allies"] then
			f85_local1:set(f85_local3.allies)
			f85_local2:set(f85_local3.axis)
		else
			f85_local1:set(f85_local3.axis)
			f85_local2:set(f85_local3.allies)
		end
		DataSources.CPObjectiveTeams.setupSubObjectiveModels(f85_arg0, f85_local1:get(), f85_local2:get())
	end,
	getModel = function(f87_arg0)
		if not DataSources.CPObjectiveTeams.preparedForController or not DataSources.CPObjectiveTeams.preparedForController[f87_arg0] then
			DataSources.CPObjectiveTeams.prepare(f87_arg0)
		end
		local f87_local0 = Engine[@"getmodelforcontroller"](f87_arg0)
		return f87_local0:create("CPObjectiveTeams")
	end,
}
DataSources.CPObjectivePerPlayer = {
	getModel = function(f88_arg0)
		local f88_local0 = Engine[@"getmodelforcontroller"](f88_arg0)
		return f88_local0:create("hudItems.cpObjective.perPlayer")
	end,
}
DataSources.CurrentObjectiveInfo = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f89_arg0, f89_arg1, f89_arg2)
		if not DataSources.CurrentObjectiveInfo.preparedForController then
			DataSources.CurrentObjectiveInfo.preparedForController = {}
		end
		if not DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0] then
			DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0] = LUI.UIElement.new()
		end
		DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0]:unsubscribeFromAllModels()
		DataSources.CurrentObjectiveInfo.preparedForController[f89_arg0] = true
		local f89_local0 = Engine[@"getmodelforcontroller"](f89_arg0)
		f89_local0 = f89_local0:create("CurrentObjectiveInfo")
		local f89_local1 = f89_local0:create("currentObjId")
		local f89_local2 = f89_local0:create("previousObjId")
		local f89_local3 = f89_local0:create("objectiveIcon")
		local f89_local4 = f89_local0:create("waypointObjective1")
		local f89_local5 = f89_local0:create("waypointObjective2")
		local f89_local6 = f89_local0:create("waypointObjective3")
		f89_local4:create("objectiveModel")
		f89_local5:create("objectiveModel")
		f89_local6:create("objectiveModel")
		if not f89_local1:get() then
			f89_local1:set(0)
		end
		local f89_local7 = DataSources.CPObjectiveTeams.getModel(f89_arg0)
		f89_local7 = f89_local7.myTeam
		DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0]:subscribeToModel(f89_local7, function(model)
			DataSources.CurrentObjectiveInfo.preparedForController[f89_arg0] = false
			DataSources.CurrentObjectiveInfo.prepare(f89_arg0)
		end, false)
		if f89_local7 then
			f89_local7 = f89_local7:get()
		end
		if f89_local7 then
			local f89_local8 = function(f91_arg0)
				if f91_arg0 then
					f89_local2:set(f89_local1:get())
					f89_local1:set(f91_arg0)
				end
			end
			local f89_local9 = function(f92_arg0)
				local f92_local0 = f92_arg0 and CoD.HUDUtility.GetCachedObjective(Engine[@"getobjectivename"](f89_arg0, f92_arg0))
				if f92_local0 then
					local f92_local1 = Engine[@"getobjectiveteam"](f89_arg0, f92_arg0)
					local f92_local2 = Engine[@"getteamid"](f89_arg0, Engine[@"getpredictedclientnum"](f89_arg0))
					local f92_local3
					if f92_local1 ~= Enum[@"team_t"][@"team_neutral"] and f92_local1 ~= Enum[@"team_t"][@"team_free"] then
						f92_local3 = false
					else
						f92_local3 = true
					end
					local f92_local4 = f92_local1 == f92_local2
					local f92_local5 = f92_local0[@"hash_2E3FD1464311AFA1"] or @"blacktransparent"
					if f92_local3 then
						f92_local5 = f92_local0[@"hash_61F7C7371625DBE8"] or f92_local5
					elseif f92_local4 then
						f92_local5 = f92_local0[@"hash_A464F3B561F16A7"] or f92_local5
					else
						f92_local5 = f92_local0[@"hash_2207CD530AA845F4"] or f92_local5
					end
					f89_local3:set(f92_local5)
				end
			end
			local f89_local10 = function(f93_arg0, f93_arg1)
				if f93_arg1 ~= nil then
					local f93_local0 = f93_arg0.objectiveModel
					local f93_local1 = f93_local0
					f93_local0 = f93_local0.set
					local f93_local2 = Engine[@"getmodelforcontroller"](f89_arg0)
					f93_local0(f93_local1, f93_local2["objective" .. f93_arg1])
					Engine[@"forcenotifymodelsubscriptions"](f93_arg0)
				end
			end
			local f89_local11 = f89_local7:create("activeObjective.objId")
			f89_local8(f89_local11:get())
			DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0]:subscribeToModel(f89_local11, function(model)
				f89_local8(model:get())
			end, false)
			local f89_local12 = f89_local7:create("objectiveIconObjId")
			f89_local9(f89_local11:get())
			DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0]:subscribeToModel(f89_local12, function(model)
				f89_local9(model:get())
			end, false)
			local f89_local13 = f89_local7:create("waypointObjId1")
			f89_local10(f89_local4, f89_local13:get())
			DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0]:subscribeToModel(f89_local13, function(model)
				f89_local10(f89_local4, model:get())
			end, false)
			local f89_local14 = f89_local7:create("waypointObjId2")
			f89_local10(f89_local5, f89_local14:get())
			DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0]:subscribeToModel(f89_local14, function(model)
				f89_local10(f89_local5, model:get())
			end, false)
			local f89_local15 = f89_local7:create("waypointObjId3")
			f89_local10(f89_local6, f89_local15:get())
			DataSources.CurrentObjectiveInfo.subscriptions[f89_arg0]:subscribeToModel(f89_local15, function(model)
				f89_local10(f89_local6, model:get())
			end, false)
		end
	end,
	getModel = function(f99_arg0)
		if not DataSources.CurrentObjectiveInfo.preparedForController or not DataSources.CurrentObjectiveInfo.preparedForController[f99_arg0] then
			DataSources.CurrentObjectiveInfo.prepare(f99_arg0)
		end
		local f99_local0 = Engine[@"getmodelforcontroller"](f99_arg0)
		return f99_local0:create("CurrentObjectiveInfo")
	end,
}
DataSources.ClearAllLives = {
	prepared = false,
	preparedForController = {},
	subscriptions = {},
	prepare = function(f100_arg0, f100_arg1, f100_arg2)
		if not DataSources.ClearAllLives.preparedForController then
			DataSources.ClearAllLives.preparedForController = {}
		end
		if not DataSources.ClearAllLives.subscriptions[f100_arg0] then
			DataSources.ClearAllLives.subscriptions[f100_arg0] = LUI.UIElement.new()
		end
		DataSources.ClearAllLives.subscriptions[f100_arg0]:unsubscribeFromAllModels()
		DataSources.ClearAllLives.preparedForController[f100_arg0] = true
		local f100_local0 = function()
			DataSources.ClearAllLives.preparedForController[f100_arg0] = false
			DataSources.ClearAllLives.prepare(f100_arg0)
		end
		local f100_local1 = DataSources.CPObjectiveTeams.getModel(f100_arg0)
		f100_local1 = f100_local1.myTeam
		if f100_local1 then
			DataSources.ClearAllLives.subscriptions[f100_arg0]:subscribeToModel(f100_local1, f100_local0, false)
		end
		if f100_local1 then
			f100_local1 = f100_local1:get()
		end
		if f100_local1 then
			local f100_local2 = f100_local1:create("clearAll.totalCount")
			local f100_local3 = f100_local1:create("clearAll.currentCount")
			local f100_local4 = f100_local2:get() or 0
			local f100_local5 = f100_local3:get() or 0
			local f100_local6 = 0
			if f100_local4 > 0 then
				f100_local6 = f100_local5 / f100_local4
			end
			local f100_local7 = Engine[@"getmodelforcontroller"](f100_arg0)
			f100_local7 = f100_local7:create("ClearAllLives")
			local f100_local8 = f100_local7:create("numTotalCount")
			f100_local8:set(f100_local4)
			f100_local8 = f100_local7:create("numCurrentCount")
			f100_local8:set(f100_local5)
			f100_local8 = f100_local7:create("progress")
			f100_local8:set(f100_local6)
			DataSources.ClearAllLives.subscriptions[f100_arg0]:subscribeToModel(f100_local2, f100_local0, false)
			DataSources.ClearAllLives.subscriptions[f100_arg0]:subscribeToModel(f100_local3, f100_local0, false)
		end
	end,
	getModel = function(f102_arg0)
		if not DataSources.ClearAllLives.preparedForController or not DataSources.ClearAllLives.preparedForController[f102_arg0] then
			DataSources.ClearAllLives.prepare(f102_arg0)
		end
		local f102_local0 = Engine[@"getmodelforcontroller"](f102_arg0)
		return f102_local0:create("ClearAllLives")
	end,
}
CoD.CPUtility.InitObjectiveNotificationSlidingTransition = function(f103_arg0, f103_arg1, f103_arg2, f103_arg3, f103_arg4, f103_arg5)
	local f103_local0 = f103_arg0[f103_arg3]
	local f103_local1 = f103_arg0[f103_arg4]
	f103_arg1.__atTop = false
	f103_arg1.__originalPosition = {}
	f103_arg1.__savedPosition = {}
	local f103_local2 = function(f104_arg0)
		local f104_local0, f104_local1, f104_local2, f104_local3 = f103_arg1:getLocalLeftRight()
		local f104_local4, f104_local5, f104_local6, f104_local7 = f103_arg1:getLocalTopBottom()
		f104_arg0.leftPercent = f104_local0
		f104_arg0.rightPercent = f104_local1
		f104_arg0.topPercent = f104_local4
		f104_arg0.bottomPercent = f104_local5
		f104_arg0.left = f104_local2
		f104_arg0.right = f104_local3
		f104_arg0.top = f104_local6
		f104_arg0.bottom = f104_local7
	end
	local f103_local3 = function()
		f103_arg1:beginAnimation(CoD.CPUtility.NOTIFICATION_SLIDE_ANIM_TIME_MS, Enum[@"luitween"][@"luitween_ease_out"])
		local f105_local0, f105_local1, f105_local2, f105_local3 = f103_local0:getLocalTopBottom()
		f103_arg1:setTopBottom(f105_local0, f105_local1, f105_local2, f105_local3)
		local f105_local4 = f103_local1:getWidth()
		if f103_arg5 then
			if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f103_arg2, "CPObjectivePerPlayer", "isPvp", 1) then
				local f105_local5, f105_local6, f105_local7, f105_local8 = f103_local0:getLocalLeftRight()
				f103_arg1:setLeftRight(f105_local5, f105_local6, f105_local7, f105_local7 + f105_local4)
			else
				local f105_local5, f105_local6, f105_local7, f105_local8 = f103_local1:getLocalLeftRight()
				f103_arg1:setLeftRight(f105_local5, f105_local6, f105_local7, f105_local8)
			end
		else
			local f105_local5, f105_local6, f105_local7, f105_local8 = f103_local0:getLocalLeftRight()
			f103_arg1:setLeftRight(f105_local5, f105_local6, f105_local8 - f105_local4, f105_local8)
		end
	end
	f103_local2(f103_arg1.__originalPosition)
	f103_arg1:registerEventHandler(CoD.CPUtility.ObjectiveNotificationSlideToTopEvent, function(element, event)
		f103_local2(element.__savedPosition)
		element.__atTop = true
		f103_local3()
	end)
	f103_arg1:linkToElementModel(f103_arg1, "activeObjective.state", true, function(model)
		f103_arg1.__atTop = false
		if model:get() == CoD.CPUtility.CP_OBJ_INFO_STATE_INCOMPLETE then
			f103_arg1:setLeftRight(f103_arg1.__originalPosition.leftPercent, f103_arg1.__originalPosition.rightPercent, f103_arg1.__originalPosition.left, f103_arg1.__originalPosition.right)
			f103_arg1:setTopBottom(f103_arg1.__originalPosition.topPercent, f103_arg1.__originalPosition.bottomPercent, f103_arg1.__originalPosition.top, f103_arg1.__originalPosition.bottom)
		elseif f103_arg5 then
			f103_arg1:beginAnimation(CoD.CPUtility.NOTIFICATION_SLIDE_ANIM_TIME_MS, Enum[@"luitween"][@"luitween_ease_out"])
			f103_arg1:setLeftRight(f103_arg1.__savedPosition.leftPercent, f103_arg1.__savedPosition.rightPercent, f103_arg1.__savedPosition.left, f103_arg1.__savedPosition.right)
			f103_arg1:setTopBottom(f103_arg1.__savedPosition.topPercent, f103_arg1.__savedPosition.bottomPercent, f103_arg1.__savedPosition.top, f103_arg1.__savedPosition.bottom)
		end
	end)
	if f103_arg0._isPVPSubscription == nil then
		f103_arg0._isPVPSubscription = f103_arg0:subscribeToGlobalModel(f103_arg2, "CPObjectivePerPlayer", "isPvp", function(model)
			if f103_arg1.__atTop then
				f103_local3()
			end
		end)
	end
end
CoD.CPUtility.InitObjectiveNotificationWidget = function(f109_arg0, f109_arg1, f109_arg2, f109_arg3, f109_arg4, f109_arg5)
	local f109_local0 = function(f110_arg0, f110_arg1)
		local f110_local0, f110_local1, f110_local2, f110_local3 = f110_arg0:getLocalLeftRight()
		local f110_local4 = (f110_local3 + f110_local2) / 2
		f110_arg0:setLeftRight(f110_local0, f110_local1, f110_local4 - f110_arg1 * 0.5, f110_local4 + f110_arg1 * 0.5)
	end
	local f109_local1 = function(f111_arg0, f111_arg1)
		local f111_local0, f111_local1, f111_local2, f111_local3 = f111_arg0:getLocalTopBottom()
		local f111_local4 = (f111_local3 + f111_local2) / 2
		f111_arg0:setTopBottom(f111_local0, f111_local1, f111_local4 - f111_arg1 * 0.5, f111_local4 + f111_arg1 * 0.5)
	end
	local f109_local2 = function(f112_arg0)
		local f112_local0 = f109_arg0:getFirstChild()
		while f112_local0 do
			f112_local0:setState(f109_arg1, f112_arg0)
			f112_local0 = f112_local0:getNextSibling()
		end
	end
	f109_arg0:registerEventHandler(CoD.CPUtility.ObjectiveNotificationUpdateEvent, function(element, event)
		local f113_local0 = event.animTime or 0
		local f113_local1 = (event.textLength or 0) + f109_arg0:getSpacing() + f109_arg5 * 2
		local f113_local2 = f109_arg0[f109_arg2]
		if f113_local2 then
			f113_local1 = f113_local1 + f113_local2:getWidth()
		end
		local f113_local3 = f109_arg0:getParent()
		if f113_local3 then
			f113_local3:beginAnimation(f113_local0)
			f109_local0(f113_local3, f113_local1)
			if f109_arg0.__savedHeight then
				f109_local1(f113_local3, f109_arg0.__savedHeight)
			end
		end
		if event.stateName then
			if not f109_arg0.__stateChangeDelayTimer and f113_local0 > 0 then
				f109_arg0.__stateChangeDelayTimer = LUI.UITimer.newElementTimer(f113_local0 + CoD.CPUtility.NOTIFICATION_BUFFER_ANIM_TIME_MS, true, function()
					f109_local2(event.stateName)
					f109_arg0.__stateChangeDelayTimer:close()
					f109_arg0.__stateChangeDelayTimer = nil
				end)
				f109_arg0:addElement(f109_arg0.__stateChangeDelayTimer)
			elseif f113_local0 == 0 then
				f109_local2(event.stateName)
			end
		end
	end)
	f109_arg0:registerEventHandler(CoD.CPUtility.ObjectiveNotificationTransitionEvent, function(element, event)
		local f115_local0 = event.shortLabel
		if f115_local0 then
			local f115_local1 = f115_local0:getWidth()
			local f115_local2 = f115_local0:getParent()
			if f115_local2 then
				local f115_local3 = f109_arg0:getWidth()
				local f115_local4, f115_local5, f115_local6, f115_local7 = f115_local2:getLocalLeftRight()
				local f115_local8 = f115_local3 * 0.5 - f115_local3 * f115_local4 + f115_local6 - f115_local1 * 0.5
				f115_local0:beginAnimation(CoD.CPUtility.NOTIFICATION_SHRINK_ANIM_TIME_MS, Enum[@"luitween"][@"luitween_ease_out"])
				f115_local0:setLeftPx(f115_local8)
			end
			local f115_local3 = f109_arg0:getParent()
			if f115_local3 then
				f109_arg0.__savedHeight = f109_arg0:getHeight()
				f115_local3:beginAnimation(CoD.CPUtility.NOTIFICATION_SHRINK_ANIM_TIME_MS, Enum[@"luitween"][@"luitween_ease_out"])
				f109_local0(f115_local3, f109_arg3)
				f109_local1(f115_local3, f109_arg4)
			end
		end
	end)
end
CoD.CPUtility.InitObjectiveString = function(f116_arg0, f116_arg1, f116_arg2, f116_arg3)
	local f116_local0 = f116_arg0[f116_arg2]
	local f116_local1 = f116_arg0[f116_arg3]
	if not f116_local0 or not f116_local1 then
		return
	else
		local f116_local2 = function(f117_arg0, f117_arg1)
			local f117_local0 = CoD.HUDUtility.GetObjectiveDescription(f116_arg1, f116_arg0:getModel(), f117_arg0)
			local f117_local1 = CoD.HUDUtility.GetShortObjectiveDescription(f116_arg1, f116_arg0:getModel(), f117_arg0)
			local f117_local2 = string.sub(f117_local0, 2, -2)
			local f117_local3 = string.sub(f117_local1, 2, -2)
			local f117_local4 = 0
			if f117_local3 == "" then
				f117_local1 = f117_local0
			end
			local f117_local5, f117_local6 = string.find(f117_local2, f117_local3)
			if f117_local5 and f117_local5 > 1 then
				f116_local0:setText(string.sub(f117_local2, 1, f117_local5 - 1))
				f117_local4 = f116_local0:getGlobalTextWidth()
			end
			f116_local0:setText(f117_local0)
			f116_local1:setText(f117_local1)
			ScaleWidgetToLabelGlobalTextWidthCentered(f116_arg0, f116_local0, 0)
			f116_local1:beginAnimation(f117_arg1 or 0)
			f116_local1:setLeftPx(f117_local4)
		end
		f116_arg0.__updatedObjective = false
		f116_arg0:linkToElementModel(f116_arg0, "activeObjective.objId", true, function(model)
			local f118_local0 = model:get()
			if f118_local0 ~= nil and f118_local0 ~= 0 then
				f116_arg0.__currentObjId = f118_local0
				f116_local2(f118_local0, 0)
				f116_arg0.__updatedObjective = true
				f116_arg0:dispatchEventToParent({
					name = CoD.CPUtility.ObjectiveNotificationUpdateEvent,
					controller = f116_arg1,
					textLength = f116_local0:getGlobalTextWidth(),
					animTime = 0,
				})
			end
		end)
		f116_arg0:registerEventHandler("clip_over", function(element, event)
			if f116_arg0.__updatedObjective then
				f116_arg0.__updatedObjective = false
				f116_arg0:dispatchEventToParent({
					name = CoD.CPUtility.ObjectiveNotificationTransitionEvent,
					controller = f116_arg1,
					shortLabel = f116_local1,
				})
				if not f116_arg0.__slideToTopTimer then
					f116_arg0.__slideToTopTimer = LUI.UITimer.newElementTimer(CoD.CPUtility.NOTIFICATION_SHRINK_ANIM_TIME_MS + CoD.CPUtility.NOTIFICATION_BUFFER_ANIM_TIME_MS, true, function()
						f116_arg0:dispatchEventToParent({
							name = CoD.CPUtility.ObjectiveNotificationSlideToTopEvent,
							controller = f116_arg1,
						})
						f116_arg0.__slideToTopTimer:close()
						f116_arg0.__slideToTopTimer = nil
					end)
					f116_arg0:addElement(f116_arg0.__slideToTopTimer)
				end
			end
		end)
		f116_arg0:linkToElementModel(f116_arg0, "activeObjective.state", true, function(model)
			local f121_local0 = model:get()
			if f121_local0 ~= nil and f121_local0 ~= CoD.CPUtility.CP_OBJ_INFO_STATE_INCOMPLETE and not f116_arg0.__slideToMiddleTimer and f116_arg0.__currentObjId and f116_arg0.__currentObjId ~= 0 then
				f116_arg0.__slideToMiddleTimer = LUI.UITimer.newElementTimer(CoD.CPUtility.NOTIFICATION_SLIDE_ANIM_TIME_MS + CoD.CPUtility.NOTIFICATION_BUFFER_ANIM_TIME_MS, true, function()
					local f122_local0 = CoD.CPUtility.NOTIFICATION_SHRINK_ANIM_TIME_MS
					f116_local2(f116_arg0.__currentObjId, f122_local0)
					f116_arg0:dispatchEventToParent({
						name = CoD.CPUtility.ObjectiveNotificationUpdateEvent,
						controller = f116_arg1,
						textLength = f116_local0:getGlobalTextWidth(),
						animTime = f122_local0,
						stateName = CoD.CPUtility.ObjectiveCompleteStateName,
					})
					f116_arg0.__slideToMiddleTimer:close()
					f116_arg0.__slideToMiddleTimer = nil
				end)
				f116_arg0:addElement(f116_arg0.__slideToMiddleTimer)
			end
		end)
	end
end
CoD.CPUtility.GetObjectiveNotificationHeader = function(f123_arg0, f123_arg1, f123_arg2)
	local f123_local0 = tonumber(f123_arg2)
	if f123_local0 then
		local f123_local1 = Engine[@"getteamid"](f123_arg0, Engine[@"getpredictedclientnum"](f123_arg0))
		local f123_local2 = DataSources.CPObjectiveTeams.getModel(f123_arg0)
		f123_local2 = f123_local2.myTeam
		if f123_local2 then
			f123_local2 = f123_local2:get()
		end
		if f123_arg1 ~= f123_local2 then
			if f123_local0 == CoD.CPUtility.CP_OBJ_INFO_STATE_INCOMPLETE then
				return Engine[@"hash_4F9F1239CFD921FE"](@"hash_25EEC631C01CCFE7")
			else
				return ""
			end
		elseif f123_local0 == CoD.CPUtility.CP_OBJ_INFO_STATE_INCOMPLETE then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_2C1210DC4D4BB37A")
		elseif f123_local0 == CoD.CPUtility.CP_OBJ_INFO_STATE_SUCCESS then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_526AAAE2154A14FC")
		elseif f123_local0 == CoD.CPUtility.CP_OBJ_INFO_STATE_FAILURE then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_49F03C20A3866551")
		end
	end
	return ""
end
CoD.CPUtility.ShouldHideClearAllLife = function(f124_arg0)
	return CoD.CPUtility.ClearAllTransitionLives < f124_arg0
end
CoD.CPUtility.IsPlayerABot = function(f125_arg0, f125_arg1, f125_arg2)
	local f125_local0 = f125_arg0:getModel()
	if f125_arg2 ~= "" and f125_local0 then
		f125_local0 = f125_local0[f125_arg2]
	end
	if not f125_local0 then
		return false
	else
		local f125_local1 = f125_local0:get()
		if f125_local1 then
			local f125_local2 = Engine[@"getplayerlistdata"](f125_arg1, f125_local1)
			return f125_local2.isBot == true
		else
			return false
		end
	end
end
CoD.CPUtility.IsPlayerACompanion = function(f126_arg0, f126_arg1, f126_arg2)
	local f126_local0 = f126_arg0:getModel()
	if f126_arg2 ~= "" and f126_local0 then
		f126_local0 = f126_local0[f126_arg2]
	end
	if not f126_local0 then
		return false
	else
		local f126_local1 = f126_local0:get()
		if f126_local1 then
			local f126_local2 = Engine[@"getplayerlistdata"](f126_arg1, f126_local1)
			return f126_local2.isCompanion == true
		else
			return false
		end
	end
end
CoD.CPUtility.SetGotoPlayerColor = function(f127_arg0, f127_arg1)
	local f127_local0 = f127_arg1
	local f127_local1 = Engine[@"getclientnum"](f127_arg0)
	local f127_local2 = CoD.ColorUtility.GetColorBlindColorForPlayer(f127_arg0, "FriendlyBlue")
	if f127_local0 == f127_local1 then
		f127_local2 = CoD.ColorUtility.GetColorBlindColorForPlayer(f127_arg0, "PlayerYellow")
	else
	end
	return f127_local2.r, f127_local2.g, f127_local2.b
end
CoD.CPUtility.SetEscortTeamColor = function(f128_arg0, f128_arg1)
	local f128_local0 = f128_arg1
	local f128_local1 = CoD.ColorUtility.GetColorBlindColorForPlayer(f128_arg0, "EnemyOrange")
	if f128_local0 == 1 then
		f128_local1 = CoD.ColorUtility.GetColorBlindColorForPlayer(f128_arg0, "FriendlyBlue")
	end
	return f128_local1.r, f128_local1.g, f128_local1.b
end
CoD.CPUtility.GetSpecialistPromptImage = function(f129_arg0, f129_arg1)
	local f129_local0 = f129_arg1 + 1
	if f129_local0 < 2 then
		return "$blacktransparent"
	else
		local f129_local1 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Engine[@"currentsessionmode"](), f129_local0)
		if f129_local1 == nil or f129_local1.positionDraftIcon == nil then
			return "$blacktransparent"
		else
			return f129_local1.positionDraftIcon
		end
	end
end
CoD.CPUtility.LocalizeWithShortFriendlyAndEnemyTeams = function(f130_arg0, f130_arg1)
	local f130_local0 = CoD.TeamUtility.GetTeam(f130_arg0)
	local f130_local1 = nil
	if f130_local0 == Enum[@"team_t"][@"team_allies"] then
		f130_local1 = Enum[@"team_t"][@"team_axis"]
	else
		f130_local0 = Enum[@"team_t"][@"team_axis"]
		f130_local1 = Enum[@"team_t"][@"team_allies"]
	end
	return Engine[@"hash_4F9F1239CFD921FE"](f130_arg1, Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamShortName(f130_local0)), Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamShortName(f130_local1)))
end
CoD.CPUtility.LocalizeWithShortFriendlyTeam = function(f131_arg0, f131_arg1)
	local f131_local0 = CoD.TeamUtility.GetTeam(f131_arg0)
	if f131_local0 ~= Enum[@"team_t"][@"team_allies"] then
		f131_local0 = Enum[@"team_t"][@"team_axis"]
	end
	return Engine[@"hash_4F9F1239CFD921FE"](f131_arg1, Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamShortName(f131_local0)))
end
CoD.CPUtility.LocalizeWithShortEnemyTeam = function(f132_arg0, f132_arg1)
	local f132_local0 = CoD.TeamUtility.GetTeam(f132_arg0)
	local f132_local1 = nil
	if f132_local0 == Enum[@"team_t"][@"team_allies"] then
		f132_local1 = Enum[@"team_t"][@"team_axis"]
	else
		f132_local1 = Enum[@"team_t"][@"team_allies"]
	end
	return Engine[@"hash_4F9F1239CFD921FE"](f132_arg1, Engine[@"localize"](CoD.TeamUtility.GetDefaultTeamShortName(f132_local1)))
end
CoD.CPUtility.TEMP_GetOnlyOtherNonCompanionPlayerDefectionText = function(f133_arg0, f133_arg1)
	for f133_local0 = 0, LuaDefine.MAX_CLIENTS - 1, 1 do
		local f133_local3 = Engine[@"getmodelforclient"](f133_local0)
		if f133_local3.clientNum:get() ~= Engine[@"getclientnum"](f133_arg0) and not f133_local3.isBot:get() then
			local f133_local4
			if f133_local3.team:get() == Enum[@"team_t"][@"team_allies"] then
				f133_local4 = Enum[@"team_t"][@"team_axis"]
			else
				f133_local4 = Enum[@"team_t"][@"team_allies"]
			end
			return Engine[@"hash_4F9F1239CFD921FE"](f133_arg1, GetClientNameAndClanTag(f133_arg0, f133_local3.clientNum:get()), Engine[@"localize"](CoD.TeamUtility.GetDefaultTeamShortName(f133_local4)))
		end
	end
	return ""
end
CoD.CPUtility.TEMP_GetOnlyOtherNonCompanionPlayerDefectionColor = function(f134_arg0, f134_arg1)
	for f134_local0 = 0, LuaDefine.MAX_CLIENTS - 1, 1 do
		local f134_local3 = Engine[@"getmodelforclient"](f134_local0)
		if f134_local3.clientNum:get() ~= Engine[@"getclientnum"](f134_arg0) and not f134_local3.isBot:get() then
			local f134_local4 = f134_local3.team:get()
			local f134_local5 = CoD.TeamUtility.GetColorSetFriendlyOrShoutCasterColor(f134_arg0)
			if f134_local4 == CoD.TeamUtility.GetTeamID(f134_arg0) then
				f134_local5 = CoD.TeamUtility.GetColorSetEnemyOrShoutCasterColor(f134_arg0)
			end
			return CoD.ColorUtility.ExplodeColor(f134_local5)
		end
	end
	return 0, 0, 0
end
CoD.CPUtility.LocalizeShortTeamIntoString = function(f135_arg0, f135_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](f135_arg0, Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamShortName(f135_arg1)))
end
CoD.OverlayUtility.AddSystemOverlay("CPDefectPopup", {
	menuName = "SystemOverlay_FreeCursor",
	title = @"hash_1EC7F5F52C453C14",
	description = function(f136_arg0)
		local f136_local0
		if CoD.TeamUtility.GetTeam(f136_arg0) == Enum[@"team_t"][@"team_allies"] then
			f136_local0 = Enum[@"team_t"][@"team_axis"]
		else
			f136_local0 = Enum[@"team_t"][@"team_allies"]
		end
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_1FA69678D2B5CF93", Engine[@"hash_4F9F1239CFD921FE"](CoD.TeamUtility.GetDefaultTeamName(f136_local0)))
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f137_arg0)
		return function(f138_arg0, f138_arg1)
			SendOwnMenuResponse(f138_arg0, f138_arg1, "accept")
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = @"menu/yes",
	[CoD.OverlayUtility.bCirclePromptFn] = function(f139_arg0)
		return function(f140_arg0, f140_arg1)
			SendOwnMenuResponse(f140_arg0, f140_arg1, "decline")
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = @"menu/no",
})
CoD.CPUtility.AARObjectiveStates = LuaEnum.createEnum("STATE_INCOMPLETE", "STATE_SUCCESS", "STATE_FAILURE")
CoD.CPUtility.SetupInGameCPAARModels = function(f141_arg0, f141_arg1)
	local f141_local0 = f141_arg0:getModel()
	local f141_local1 = Engine[@"getcurrentmapname"]()
	local f141_local2 = function(f142_arg0, f142_arg1, f142_arg2, f142_arg3)
		if f142_arg1 == CoD.CPUtility.AARObjectiveStates.STATE_SUCCESS then
			return f142_arg3[f142_arg2 + 1][@"hash_496EF98AC24F8629"] or ""
		else
			return f142_arg3[f142_arg2 + 1][@"hash_5F170207A7A76F04"] or ""
		end
	end
	local f141_local3 = function(f143_arg0, f143_arg1)
		local f143_local0 = CoD.BaseUtility.GetMapValue(f141_local1, "aarHeaderStrings_" .. f143_arg0, nil)
		return f143_local0[f143_arg1 + 1][@"headertext"]
	end
	local f141_local4 = CoD.TeamUtility.GetTeamID(f141_arg1)
	if f141_local4 == Enum[@"team_t"][@"team_allies"] or f141_local4 == Enum[@"team_t"][@"team_axis"] then
		local f141_local5 = Engine[@"getfactionforteam"](f141_local4)
		local f141_local6 = CoD.BaseUtility.GetMapValue(f141_local1, "aarObjectives_" .. f141_local5, nil)
		local f141_local7 = f141_local0:create("missionResult")
		f141_local7:set(f141_local3(f141_local5, f141_local0.mission_result:get()))
		if f141_local6 then
			for f141_local7 = 0, math.min(9, #f141_local6 - 1), 1 do
				local f141_local10 = f141_local0:create("objective" .. f141_local7)
				local f141_local11 = "obj"
				f141_local11 = f141_local0["obj" .. f141_local7 .. "_result"]:get()
				local f141_local12 = f141_local10:create("description")
				f141_local12:set(f141_local2(f141_local5, f141_local11, f141_local7, f141_local6))
				f141_local12 = f141_local10:create("result")
				f141_local12:set(f141_local11)
			end
		end
	end
end
CoD.CPUtility.SetupChyron = function(f144_arg0, f144_arg1)
	local f144_local0 = f144_arg0:getModel()
	local f144_local1 = Engine[@"getcurrentmapname"]()
	for f144_local2 = 1, 5, 1 do
		local f144_local5 = CoD.BaseUtility.GetMapValue(f144_local1, @"chyronline" .. f144_local2, 0x0)
		local f144_local6 = f144_local0:create("line" .. f144_local2)
		f144_local6:set(f144_local5)
	end
	f144_arg0:appendEventHandler("clip_over", function()
		SendOwnMenuResponse(f144_arg0, f144_arg1, "closed")
		return true
	end)
end
CoD.CPUtility.GetLivesRemainingText = function(f146_arg0)
	if f146_arg0 == 1 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_55F52A17196D872D", f146_arg0)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7CC96249C0FC18E4", f146_arg0)
	end
end
CoD.CPUtility.GetLivesRemainingTitle = function(f147_arg0)
	if f147_arg0 == 1 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7157B8AEAE96B10C", f147_arg0)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4531E5936198E11F", f147_arg0)
	end
end
