CoD.ScoreboardUtility = {}
CoD.ScoreboardUtility.MinRowsToShowOnEachTeam = 4
CoD.ScoreboardUtility.MinRowsToShowOnEachTeamForFFA = 8
CoD.ScoreboardUtility.GoldenScoreRefs = {
	@"golden_kill_bonus",
	@"hash_7B62CCBE655DC08A",
}
CoD.ScoreboardUtility.ShowScoreboard = function(f1_arg0)
	Engine[@"showscoreboard"](f1_arg0)
end
CoD.ScoreboardUtility.HideScoreboard = function(f2_arg0, f2_arg1)
	Engine[@"hidescoreboard"](f2_arg1)
end
CoD.ScoreboardUtility.ShowInventory = function(f3_arg0)
	Engine[@"showinventory"](f3_arg0)
end
CoD.ScoreboardUtility.HideInventory = function(f4_arg0, f4_arg1)
	Engine[@"hideinventory"](f4_arg1)
	if CoD.isWarzone then
		SetControllerModelValue(f4_arg1, "hudItems.inventory.open", false)
	end
end
CoD.ScoreboardUtility.SetupGameStatusClientLists = function(f5_arg0, f5_arg1)
	f5_arg0.TeamList:updateDataSource(true)
	f5_arg0.EnemyList:updateDataSource(true)
	local f5_local0 = f5_arg0
	local f5_local1 = f5_arg0.subscribeToModel
	local f5_local2 = Engine[@"getmodelforcontroller"](f5_arg1)
	f5_local1(f5_local0, f5_local2:create("Clients.clientChangedTeam"), function(f6_arg0)
		f5_arg0.TeamList:updateDataSource(true)
		f5_arg0.EnemyList:updateDataSource(true)
	end)
	f5_local0 = f5_arg0
	f5_local1 = f5_arg0.subscribeToModel
	f5_local2 = Engine[@"getmodelforcontroller"](f5_arg1)
	f5_local1(f5_local0, f5_local2:create("Clients.clientCount"), function(f7_arg0)
		f5_arg0.TeamList:updateDataSource(true)
		f5_arg0.EnemyList:updateDataSource(true)
	end)
end
CoD.ScoreboardUtility.SetClientModelOnElement = function(f8_arg0, f8_arg1)
	local f8_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f8_arg0))
	if f8_local0 then
		f8_arg1:setModel(f8_local0, f8_arg0)
	end
end
CoD.ScoreboardUtility.UpdateScoreboardClientMuteButtonPrompt = function(f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0:getModel(f9_arg1, "clientNum")
	if not f9_local0 then
		return
	end
	local f9_local1 = Engine[@"getmodelvalue"](f9_local0)
	local f9_local2 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f9_arg1), "scoreboardInfo.muteButtonPromptVisible")
	local f9_local3 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f9_arg1), "scoreboardInfo.muteButtonPromptText")
	if f9_local1 and f9_local1 >= 0 and Engine[@"getclientnum"](f9_arg1) ~= f9_local1 then
		local f9_local4 = CoD.SafeGetModelValue(f9_arg0:getModel(), "clientNum")
		local f9_local5 = CoD.SafeGetModelValue(f9_arg0:getModel(), "isBot")
		local f9_local6 = Engine[@"setmodelvalue"]
		local f9_local7 = f9_local2
		local f9_local8
		if f9_local4 ~= nil then
			f9_local8 = not f9_local5
		else
			f9_local8 = false
		end
		f9_local6(f9_local7, f9_local8)
		if Engine[@"isplayermutedbyclientnum"](f9_arg1, Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]), f9_local4) then
			Engine[@"setmodelvalue"](f9_local3, @"hash_56BEF50FAD886D13")
		else
			Engine[@"setmodelvalue"](f9_local3, @"hash_322978D8B62A956")
		end
	else
		Engine[@"setmodelvalue"](f9_local2, false)
		Engine[@"setmodelvalue"](f9_local3, @"hash_322978D8B62A956")
	end
end
CoD.ScoreboardUtility.ToggleClientMute = function(f10_arg0, f10_arg1)
	Engine[@"blockgamefromkeyevent"]()
	local f10_local0 = f10_arg0:getModel()
	local f10_local1 = f10_local0 and f10_local0.clientNum
	if f10_local1 then
		f10_local1 = f10_local1:get()
	end
	if f10_local1 and f10_local1 >= 0 and Engine[@"getclientnum"](f10_arg1) ~= f10_local1 then
		Engine[@"toggleplayermute"](f10_arg1, f10_local1, Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
		CoD.ScoreboardUtility.UpdateScoreboardClientMuteButtonPrompt(f10_arg0, f10_arg1)
	end
end
CoD.ScoreboardUtility.CreatedSortKey = function(f11_arg0, f11_arg1, f11_arg2)
	local f11_local0 = Engine[@"getmodelforcontroller"](f11_arg0)
	if not f11_local0["scoreboardInfo.sortKey" .. f11_arg1] then
		local f11_local1 = Engine[@"profilevalueasstring"](f11_arg0, "scoreboardSortKey" .. f11_arg1)
		if f11_local1 == nil or f11_local1 == "" or not IsObjectiveBasedGametype() and f11_local1 == "scoreboard.objScore" then
			f11_local1 = f11_arg2
		end
		local f11_local2 = f11_local0:create("scoreboardInfo.sortKey" .. f11_arg1)
		f11_local2:set(f11_local1)
	end
end
CoD.ScoreboardUtility.InitScoreboardSortKey = function(f12_arg0)
	local f12_local0 = Engine[@"getscoreboardcolumnname"](f12_arg0, 0)
	local f12_local1 = Engine[@"getscoreboardcolumnname"](f12_arg0, 1)
	local f12_local2 = Engine[@"getscoreboardcolumnname"](f12_arg0, 2)
	CoD.ScoreboardUtility.CreatedSortKey(f12_arg0, 0, "scoreboard." .. string.lower(f12_local0))
	CoD.ScoreboardUtility.CreatedSortKey(f12_arg0, 1, "scoreboard." .. string.lower(f12_local1))
	CoD.ScoreboardUtility.CreatedSortKey(f12_arg0, 2, "scoreboard." .. string.lower(f12_local2))
end
CoD.ScoreboardUtility.SetRowHeader = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = Engine[@"getscoreboardcolumnheader"](f13_arg0, f13_arg2)
	if CoD.AARUtility.IsGameTypeEqualToString("bounty", f13_arg0) and string.lower(f13_local0) == "score" then
		f13_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"mpui/cash")
	end
	if CoD.AARUtility.IsGameTypeEqualToString("dm", f13_arg0) and string.lower(f13_local0) == "kills" then
		f13_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5AB2B22D8DAC768C")
	end
	if CoD.AARUtility.IsGameTypeEqualToString("infect", f13_arg0) and string.lower(f13_local0) == "objectives" then
		f13_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"mpui/infects")
	end
	if CoD.AARUtility.IsGameTypeEqualToString("prop", f13_arg0) and string.lower(f13_local0) == "time" then
		f13_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3AD795C41AE2FC56")
	end
	f13_arg1:setText(f13_local0)
end
CoD.ScoreboardUtility.SetCurrentFocusedClient = function(f14_arg0, f14_arg1)
	local f14_local0 = f14_arg0:getModel()
	if f14_local0 then
		local f14_local1 = Engine[@"getmodelforcontroller"](f14_arg1)
		if f14_local1.currentFocusedClient then
			f14_local1.currentFocusedClient:set(f14_local0)
		end
	end
	CoD.ScoreboardUtility.UpdateScoreboardClientMuteButtonPrompt(f14_arg0, f14_arg1)
end
CoD.ScoreboardUtility.SetCurrentFocusedClientToLocalPlayer = function(f15_arg0, f15_arg1)
	local f15_local0 = Engine[@"getmodelforcontroller"](f15_arg1)
	local f15_local1 = f15_local0.clientModel:get()
	local f15_local2 = f15_arg0:findItem({
		clientNum = f15_local1.clientNum:get(),
	}, nil, true, nil)
	if f15_local2 and f15_local2:getModel() and f15_local0.currentFocusedClient then
		f15_local0.currentFocusedClient:set(f15_local2:getModel())
	end
end
CoD.ScoreboardUtility.SetSavedActiveItemToLocalPlayer = function(f16_arg0, f16_arg1)
	local f16_local0 = Engine[@"getmodelforcontroller"](f16_arg1)
	local f16_local1 = f16_local0.clientModel:get()
	local f16_local2 = f16_arg0:findItem({
		clientNum = f16_local1.clientNum:get(),
	}, nil, true, nil)
	if f16_local2 then
		f16_arg0.savedActiveIndex = f16_local2.gridInfoTable.zeroBasedIndex
	end
end
CoD.ScoreboardUtility.SetupFooterSubscription = function(f17_arg0, f17_arg1)
	local f17_local0 = Engine[@"getmodelforcontroller"](f17_arg1)
	if not f17_local0.currentFocusedClient then
		local f17_local1 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f17_arg1))
		f17_local0:create("currentFocusedClient")
	end
	f17_arg0:subscribeToModel(f17_local0.currentFocusedClient, function(model)
		f17_arg0:setModel(model:get(), f17_arg1)
	end)
end
CoD.ScoreboardUtility.SetupResetToLocalPlayerSubscription = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = f19_arg0
	local f19_local1 = f19_arg0.subscribeToModel
	local f19_local2 = Engine[@"getmodelforcontroller"](f19_arg2)
	f19_local1(f19_local0, f19_local2["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f20_arg0)
		CoD.ScoreboardUtility.SetCurrentFocusedClientToLocalPlayer(f19_arg1, f19_arg2)
	end, false)
end
CoD.ScoreboardUtility.UpdateScoreboardTabsFocus = function(f21_arg0)
	assert(f21_arg0.Tabs)
	CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f21_arg0.Tabs)
end
CoD.ScoreboardUtility.SetupTeamLists = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4, f22_arg5)
	local f22_local0 = math.ceil(Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])) / 2)
	if f22_local0 > 6 then
		f22_local0 = 6
	end
	f22_arg2.friendlyTeam = true
	f22_arg2.showHealthBar = false
	f22_arg2.minVisibleClients = f22_local0
	f22_arg3.enemyTeam = true
	f22_arg3.showHealthBar = false
	f22_arg3.minVisibleClients = f22_local0
	f22_arg4.friendlyTeam = true
	f22_arg4.showHealthBar = false
	f22_arg4.minVisibleClients = f22_local0
	f22_arg5.enemyTeam = true
	f22_arg5.showHealthBar = false
	f22_arg5.minVisibleClients = f22_local0
	local f22_local1 = function()
		f22_arg2:updateDataSource(true)
		f22_arg3:updateDataSource(true)
		f22_arg4:updateDataSource(true)
		f22_arg5:updateDataSource(true)
	end
	local f22_local2 = f22_arg0
	local f22_local3 = f22_arg0.subscribeToModel
	local f22_local4 = Engine[@"getmodelforcontroller"](f22_arg1)
	f22_local3(f22_local2, f22_local4:create("Clients.clientCount"), function(f24_arg0)
		f22_local1()
	end)
	f22_local2 = f22_arg0
	f22_local3 = f22_arg0.subscribeToModel
	f22_local4 = Engine[@"getmodelforcontroller"](f22_arg1)
	f22_local3(f22_local2, f22_local4:create("Clients.clientChangedTeam"), function(f25_arg0)
		f22_local1()
	end)
end
CoD.ScoreboardUtility.CanShowScoreboard = function(f26_arg0)
	local f26_local0
	if not Engine[@"isvisibilitybitset"](f26_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f26_arg0) then
		f26_local0 = CoD.isMultiplayer
		if not f26_local0 then
			if not GameEnded(f26_arg0) then
				f26_local0 = not CoD.WZUtility.IsWarzoneMapDisabled(f26_arg0)
			else
				f26_local0 = false
			end
		end
	else
		f26_local0 = false
	end
	return f26_local0
end
CoD.ScoreboardUtility.CanHideScoreboard = function(f27_arg0)
	local f27_local0 = Engine[@"isvisibilitybitset"](f27_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
	if f27_local0 then
		if not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f27_arg0) then
			f27_local0 = CoD.isMultiplayer
			if not f27_local0 then
				f27_local0 = not GameEnded(f27_arg0)
			end
		else
			f27_local0 = false
		end
	end
	return f27_local0
end
CoD.ScoreboardUtility.IsScoreboardItemDraining = function(f28_arg0, f28_arg1)
	local f28_local0 = f28_arg0:getModel()
	if not f28_local0 then
		return
	else
		local f28_local1 = f28_local0[f28_arg1]
		if not f28_local1 or not f28_local1:get() then
			return
		else
			local f28_local2 = tonumber(f28_local1:get())
			if f28_local2 == 0 and f28_local1.lastPower then
				f28_local1.lastPower:set(0)
				return false
			elseif f28_local1.lastPower then
				local f28_local3 = f28_local2 < f28_local1.lastPower:get()
				f28_local1.lastPower:set(f28_local2)
				return f28_local3
			else
				local f28_local4 = f28_local1:create("lastPower")
				f28_local4:set(0)
				return false
			end
		end
	end
end
CoD.ScoreboardUtility.IsScoreboardItemCharged = function(f29_arg0)
	local f29_local0 = f29_arg0:getModel()
	return f29_local0.powerRatio:get() == 1
end
CoD.ScoreboardUtility.IsActiveRowClientNum = function(f30_arg0, f30_arg1)
	local f30_local0 = Engine[@"getmodelforcontroller"](f30_arg0)
	if f30_local0.scoreboardActiveClient then
		return CoD.SafeGetModelValue(f30_arg1:getModel(), "clientNum") == f30_local0.scoreboardActiveClient:get()
	else
		return false
	end
end
CoD.ScoreboardUtility.UpdatePingValue = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
	if not f31_arg0.__lastUpdated then
		f31_arg0.__lastUpdated = Engine[@"milliseconds"]()
		f31_arg0.__lastPing = 0
	end
	local f31_local0 = Engine[@"milliseconds"]()
	if f31_arg0.__lastUpdated + 1000 * f31_arg1 <= f31_local0 then
		local f31_local1 = f31_arg2.ping:get()
		f31_arg0.__lastUpdated = f31_local0
		f31_arg0.__lastPing = f31_local1
		return Engine[@"hash_4F9F1239CFD921FE"](@"menu/pc_ping", f31_local1)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"menu/pc_ping", f31_arg0.__lastPing or 0)
	end
end
DataSources.TabbedScoreboardTabs = ListHelper_SetupDataSource("TabbedScoreboardTabs", function(f32_arg0)
	local f32_local0 = {}
	if not IsGameTypeWarzone() then
		table.insert(f32_local0, {
			models = {
				tabName = Engine[@"hash_4F9F1239CFD921FE"](@"mpui/scoreboard"),
				action = CoD.ScoreboardUtility.SwitchTabbedScoreboardTabs,
				param = CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES,
			},
			properties = {
				visibleWidgetName = "TabbedScoreboardScores",
			},
		})
	end
	if not CoD.IsShoutcaster(f32_arg0) then
		table.insert(f32_local0, {
			models = {
				tabName = Engine[@"hash_4F9F1239CFD921FE"](@"menu/map"),
				action = CoD.ScoreboardUtility.SwitchTabbedScoreboardTabs,
				param = CoD.HUDUtility.GameStatusMode.MODE_SHOW_MAP,
			},
			properties = {
				visibleWidgetName = "ScoreboardGameStatus",
			},
		})
	end
	return f32_local0
end)
DataSources.TeamClients = {
	prepare = function(f33_arg0, f33_arg1, f33_arg2)
		local f33_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f33_arg0))
		f33_local0 = f33_local0:create("team")
		f33_local0 = f33_local0:get()
		if f33_local0 == Enum[@"team_t"][@"team_spectator"] then
			if CoD.ShoutcasterProfileVarBool(f33_arg0, "shoutcaster_ds_flip_scorepane") then
				f33_local0 = Enum[@"team_t"][@"team_axis"]
			else
				f33_local0 = Enum[@"team_t"][@"team_allies"]
			end
		end
		local f33_local1 = Engine[@"hash_4FCDE749B09C3D6"](f33_arg0)
		f33_arg1.clients = {}
		for f33_local5, f33_local6 in pairs(f33_local1) do
			if f33_local0 == f33_local6 then
				table.insert(f33_arg1.clients, f33_local5)
			end
		end
	end,
	getCount = function(f34_arg0)
		return #f34_arg0.clients
	end,
	getItem = function(f35_arg0, f35_arg1, f35_arg2)
		return Engine[@"getmodelforclient"](f35_arg1.clients[f35_arg2])
	end,
}
DataSources.EnemyClients = {
	prepare = function(f36_arg0, f36_arg1, f36_arg2)
		local f36_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f36_arg0))
		f36_local0 = f36_local0:create("team")
		f36_local0 = f36_local0:get()
		if f36_local0 == Enum[@"team_t"][@"team_spectator"] then
			if CoD.ShoutcasterProfileVarBool(f36_arg0, "shoutcaster_ds_flip_scorepane") then
				f36_local0 = Enum[@"team_t"][@"team_axis"]
			else
				f36_local0 = Enum[@"team_t"][@"team_allies"]
			end
		end
		local f36_local1 = Engine[@"hash_4FCDE749B09C3D6"](f36_arg0)
		f36_arg1.clients = {}
		for f36_local5, f36_local6 in pairs(f36_local1) do
			if CoD.TeamUtility.IsValidPlayerTeam(f36_local6) and f36_local6 ~= f36_local0 then
				table.insert(f36_arg1.clients, f36_local5)
			end
		end
	end,
	getCount = function(f37_arg0)
		return #f37_arg0.clients
	end,
	getItem = function(f38_arg0, f38_arg1, f38_arg2)
		return Engine[@"getmodelforclient"](f38_arg1.clients[f38_arg2])
	end,
}
DataSources.ScoreboardSortOptions = ListHelper_SetupDataSource("ScoreboardSortOptions", function(f39_arg0)
	local f39_local0 = {}
	local f39_local1 = Engine[@"getmodelforcontroller"](f39_arg0)
	f39_local1 = f39_local1.scoreboardInfo.sortKey:get()
	local f39_local2 = {
		selectIndex = true,
	}
	local f39_local3 = table.insert
	local f39_local4 = f39_local0
	local f39_local5 = {
		models = {
			id = "scoreboard.score",
			name = @"mpui/score",
			icon = "icon_scoreboard_badge_total_score128",
		},
	}
	if f39_local1 == "scoreboard.score" then
		local f39_local6 = f39_local2
	end
	f39_local5.properties = f39_local6 or nil
	f39_local3(f39_local4, f39_local5)
	f39_local3 = table.insert
	f39_local4 = f39_local0
	f39_local5 = {
		models = {
			id = "scoreboard.damageDone",
			name = @"hash_189FE6A116A1EE1F",
			icon = "icon_scoreboard_badge_damage_dealt128",
		},
	}
	if f39_local1 == "scoreboard.damageDone" then
		local f39_local7 = f39_local2
	end
	f39_local5.properties = f39_local7 or nil
	f39_local3(f39_local4, f39_local5)
	if IsObjectiveBasedGametype() then
		f39_local3 = table.insert
		f39_local4 = f39_local0
		f39_local5 = {
			models = {
				id = "scoreboard.objScore",
				name = @"hash_77C9E518376089AE",
				icon = "icon_scoreboard_badge_objective_score128",
			},
		}
		if f39_local1 == "scoreboard.objScore" then
			local f39_local8 = f39_local2
		end
		f39_local5.properties = f39_local8 or nil
		f39_local3(f39_local4, f39_local5)
	end
	f39_local3 = table.insert
	f39_local4 = f39_local0
	f39_local5 = {
		models = {
			id = "scoreboard.kills",
			name = @"mpui/kills",
			icon = "icon_scoreboard_badge_kills128",
		},
	}
	if f39_local1 == "scoreboard.kills" then
		local f39_local9 = f39_local2
	end
	f39_local5.properties = f39_local9 or nil
	f39_local3(f39_local4, f39_local5)
	f39_local3 = table.insert
	f39_local4 = f39_local0
	f39_local5 = {
		models = {
			id = "scoreboard.kadratio",
			name = @"hash_E50610A9265658A",
			icon = "icon_scoreboard_badge_kad_ratio128",
		},
	}
	if f39_local1 == "scoreboard.kadratio" then
		local f39_local10 = f39_local2
	end
	f39_local5.properties = f39_local10 or nil
	f39_local3(f39_local4, f39_local5)
	return f39_local0
end)
CoD.ScoreboardUtility.SwitchTabbedScoreboardTabs = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4)
	local f40_local0 = f40_arg3
	BlockGameFromKeyEvent(f40_arg2)
	local f40_local1 = Engine[@"getmodelforcontroller"](f40_arg2)
	f40_local1.scoreboardInfo.activeTab:set(f40_local0)
end
CoD.ScoreboardUtility.GetScoreboardTeamTable = function(f41_arg0, f41_arg1)
	local f41_local0 = Engine[@"getteampositions"](f41_arg0, Engine[@"getcurrentteamcount"]())
	if Engine[@"getcurrentteamcount"]() < 2 and f41_arg1 == 2 then
		return {}
	end
	local f41_local1 = f41_local0[f41_arg1].team
	local f41_local2 = 0
	local f41_local3 = 0
	if f41_local1 ~= Enum[@"team_t"][@"team_free"] then
		f41_local2 = Engine[@"getscoreboardteamclientcount"](Enum[@"team_t"][@"team_allies"])
		f41_local3 = Engine[@"getscoreboardteamclientcount"](Enum[@"team_t"][@"team_axis"])
	else
		f41_local2 = Engine[@"getscoreboardteamclientcount"](Enum[@"team_t"][@"team_free"])
	end
	local f41_local4 = CoD.ScoreboardUtility.MinRowsToShowOnEachTeam
	if Engine[@"getcurrentteamcount"]() < 2 then
		f41_local4 = CoD.ScoreboardUtility.MinRowsToShowOnEachTeamForFFA
	end
	f41_local4 = math.max(f41_local4, math.max(f41_local2, f41_local3))
	local f41_local5 = {}
	for f41_local6 = 1, f41_local4, 1 do
		local f41_local9 = "team: " .. f41_local1 .. " client: " .. f41_local6 - 1
		local f41_local10 = -1
		if Engine[@"getscoreboardteamclientcount"](f41_local1) < f41_local6 then
			f41_local9 = "team: " .. f41_local1 .. " client: -1"
		else
			f41_local10 = Engine[@"getscoreboardplayerdata"](f41_local6 - 1, f41_local1, Enum[@"scoreboardcolumns_e"][@"scoreboard_column_clientnum"])
		end
		table.insert(f41_local5, {
			models = {
				clientInfo = f41_local9 .. " " .. Engine[@"milliseconds"](),
				clientNum = tonumber(f41_local10),
			},
		})
	end
	return f41_local5
end
CoD.ScoreboardUtility.UpdateScoreboardTeamScores = function(f42_arg0)
	local f42_local0 = Engine[@"getcurrentteamcount"]()
	local f42_local1 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f42_arg0), "scoreboardInfo")
	local f42_local2 = Engine[@"getteampositions"](f42_arg0, f42_local0)
	local f42_local3 = {}
	for f42_local4 = 1, f42_local0, 1 do
		local f42_local7 = {}
		local f42_local8 = f42_local2[f42_local4].team
		f42_local7.FactionName = ""
		f42_local7.FactionIcon = ""
		f42_local7.Score = f42_local2[f42_local4].score
		if f42_local8 ~= Enum[@"team_t"][@"team_free"] then
			f42_local7.FactionName = CoD.TeamUtility.GetTeamNameCaps(f42_local8)
			f42_local7.FactionIcon = CoD.TeamUtility.GetTeamFactionIcon(f42_local8)
			f42_local7.FactionColor = CoD.TeamUtility.GetTeamFactionColor(f42_local8)
		end
		table.insert(f42_local3, f42_local7)
	end
	for f42_local12, f42_local7 in ipairs(f42_local3) do
		for f42_local9, f42_local10 in pairs(f42_local7) do
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f42_local1, "team" .. f42_local12 .. f42_local9), f42_local10)
		end
	end
end
CoD.ScoreboardUtility.GetTeamEnumAndClientIndex = function(f43_arg0)
	local f43_local0, f43_local1, f43_local2, f43_local3 = string.match(f43_arg0, "(%a+):%s*(%d+)%s+(%a+):%s*(-*%d+)")
	return tonumber(f43_local1), tonumber(f43_local3)
end
CoD.ScoreboardUtility.SetNemesisInfoModels = function(f44_arg0, f44_arg1)
	local f44_local0 = CoD.GetPlayerStats(f44_arg0)
	local f44_local1 = f44_local0.AfterActionReportStats
	local f44_local2 = f44_local1.nemesisKills:get()
	local f44_local3 = f44_local1.nemesisKilledBy:get()
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f44_arg1, "nemesisXuid"), Engine[@"stringtoxuiddecimal"](f44_local1.nemesisXuid:get()))
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f44_arg1, "nemesisKills"), f44_local2)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f44_arg1, "nemesisKilledBy"), f44_local3)
end
CoD.ScoreboardUtility.SetScoreboardUIModels = function(f45_arg0)
	local f45_local0 = Engine[@"getcurrentteamcount"]()
	local f45_local1 = Engine[@"getmodelforcontroller"](f45_arg0)
	local f45_local2 = Engine[@"createmodel"](f45_local1, "scoreboardInfo")
	local f45_local3 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](0), "scoreboardInfo")
	if not Engine[@"getmodel"](f45_local1, "forceScoreboard") then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local1, "forceScoreboard"), 0)
	end
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f45_arg0), "updateClientDeadStatus"), 0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "muteButtonPromptVisible"), false)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "muteButtonPromptText"), 0x0)
	local f45_local4 = MapNameToLocalizedMapName(Engine[@"getcurrentmapname"]())
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "mapName"), f45_local4)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local3, "mapName"), f45_local4)
	if Engine[@"ismultiplayergame"]() then
		if not Engine[@"isingame"]() then
			CoD.ScoreboardUtility.SetNemesisInfoModels(f45_arg0, f45_local2)
		end
		local f45_local5 = Engine[@"getteampositions"](f45_arg0, f45_local0)
		local f45_local6 = {}
		for f45_local7 = 1, f45_local0, 1 do
			local f45_local10 = {}
			local f45_local11 = f45_local5[f45_local7].team
			f45_local10.FactionName = ""
			f45_local10.FactionIcon = ""
			f45_local10.Score = f45_local5[f45_local7].score
			if f45_local11 ~= Enum[@"team_t"][@"team_free"] then
				f45_local10.FactionName = CoD.TeamUtility.GetTeamNameCaps(f45_local11)
				f45_local10.FactionIcon = CoD.TeamUtility.GetTeamFactionIcon(f45_local11)
				f45_local10.FactionColor = CoD.TeamUtility.GetTeamFactionColor(f45_local11)
			end
			table.insert(f45_local6, f45_local10)
		end
		for f45_local15, f45_local10 in ipairs(f45_local6) do
			for f45_local12, f45_local13 in pairs(f45_local10) do
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "team" .. f45_local15 .. f45_local12), f45_local13)
			end
		end
		f45_local7 = Engine[@"getgametypeinfo"](Engine[@"hash_36F8027A8BC75673"]())
		f45_local8 = f45_local7.nameRefCaps
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "gameType"), f45_local8)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local3, "gameType"), f45_local8)
		if f45_local0 < 2 then
			f45_local9 = Engine[@"getmodel"](f45_local1, "gameScore.playerScore")
			if f45_local9 then
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "team1Score"), Engine[@"getmodelvalue"](f45_local9))
			else
				local f45_local5 = 5
				for f45_local6 = 1, f45_local5, 1 do
					Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "column" .. f45_local6 .. "Header"), Engine[@"getscoreboardcolumnheader"](f45_arg0, f45_local6 - 1))
				end
			end
		else
			local f45_local5 = 5
			for f45_local6 = 1, f45_local5, 1 do
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "column" .. f45_local6 .. "Header"), Engine[@"getscoreboardcolumnheader"](f45_arg0, f45_local6 - 1))
			end
		end
	end
	local f45_local5 = 5
	for f45_local6 = 1, f45_local5, 1 do
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f45_local2, "column" .. f45_local6 .. "Header"), Engine[@"getscoreboardcolumnheader"](f45_arg0, f45_local6 - 1))
	end
end
CoD.ScoreboardUtility.MPScrPostLaod = function(f46_arg0, f46_arg1, f46_arg2)
	f46_arg0.ScoreFeedItem0.TextBox:setText("")
	local f46_local0, f46_local1, f46_local2, f46_local3 = f46_arg0.ScoreFeedItem0:getLocalTopBottom()
	local f46_local4 = f46_local3 - f46_local2
	f46_arg0.ScoreFeedItem0.top = f46_local2
	local f46_local5 = f46_arg0.MPScrPlusPointsContainer
	f46_local5.lastAnim = 0
	local f46_local6 = function(f47_arg0, f47_arg1)
		if f47_arg0 == 0 or f47_arg0 > 10000 then
			return
		end
		local f47_local0 = CoD.MPScr_PlusPointsContainer.new(f46_arg2, f46_arg1, 0, 0, 0, CoD.MPScr_PlusPointsContainer.__defaultWidth, 0, 0, 0, CoD.MPScr_PlusPointsContainer.__defaultHeight)
		f47_local0.MPScrPlusPoints.Score:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A0F614541A9DE14", f47_arg0))
		f47_local0:setState(f46_arg1, "DefaultState")
		if f47_arg1 then
			f47_local0.MPScrPlusPoints:playClip("GoldenScore")
		else
			f47_local0.MPScrPlusPoints:playClip("DefaultClip")
		end
		f46_local5.lastAnim = f46_local5.lastAnim + 1
		if not f47_local0:hasClip("Anim" .. f46_local5.lastAnim) then
			f46_local5.lastAnim = 1
		end
		f47_local0:registerEventHandler("clip_over", function(element, event)
			element:close()
		end)
		f46_local5:addElement(f47_local0)
		f46_arg2:sendInitializationEvents(f46_arg1, f47_local0)
		f47_local0:playClip("Anim" .. f46_local5.lastAnim)
	end
	f46_arg0.AddScoreFeed = function(f49_arg0, f49_arg1, f49_arg2, f49_arg3)
		for f49_local0 = 10, 1, -1 do
			local f49_local3 = f46_arg0["ScoreFeedItem" .. f49_local0]
			local f49_local4 = f46_arg0["ScoreFeedItem" .. f49_local0 - 1]
			if f49_local4 and f49_local4.text then
				if not f49_local3 then
					f46_arg0["ScoreFeedItem" .. f49_local0] = CoD.MPScrFeedItem.new(f46_arg2, f46_arg1, 0, 0, 0, CoD.MPScrFeedItem.__defaultWidth, 0, 0, 0, CoD.MPScrFeedItem.__defaultHeight)
					f49_local3 = f46_arg0["ScoreFeedItem" .. f49_local0]
					f46_arg0:addElement(f49_local3)
					f46_arg2:sendInitializationEvents(f46_arg1, f49_local3)
				end
				f49_local3:setLeftRight(f49_local4:getLocalLeftRight())
				f49_local3:setTopBottom(f46_local0, f46_local1, f49_local4.top, f49_local4.top + f46_local4)
				f49_local3.text = f49_local4.text
				f49_local3.TextBox:setText(f49_local3.text)
				f49_local3:beginAnimation("keyframe", 100, false, true, CoD.TweenType.Linear)
				local f49_local5, f49_local6, f49_local7, f49_local8 = f49_local3:getLocalTopBottom()
				f49_local3:setTopBottom(f49_local5, f49_local6, f49_local7 + f46_local4, f49_local8 + f46_local4)
				f49_local3.top = f49_local7 + f46_local4
				if f49_local4.isPositionScore then
					f49_local3:playClip("PositionScore")
				elseif f49_local4.isGoldenScore then
					f49_local3:playClip("GoldenScore")
				else
					f49_local3:playClip("DefaultClip")
				end
				f49_local3.isPositionScore = f49_local4.isPositionScore
				f49_local3.isGoldenScore = f49_local4.isGoldenScore
			end
		end
		f46_arg0.ScoreFeedItem0.text = f49_arg1
		f46_arg0.ScoreFeedItem0.TextBox:setText(f46_arg0.ScoreFeedItem0.text)
		f46_arg0.ScoreFeedItem0.isPositionScore = f49_arg2
		f46_arg0.ScoreFeedItem0.isGoldenScore = f49_arg3
		if f49_arg2 then
			f46_arg0.ScoreFeedItem0:playClip("PositionScore")
		elseif f49_arg3 then
			f46_arg0.ScoreFeedItem0:playClip("GoldenScore")
		else
			f46_arg0.ScoreFeedItem0:playClip("DefaultClip")
		end
	end
	f46_arg0.AddCenterScore = function(f50_arg0, f50_arg1, f50_arg2, f50_arg3)
		if f50_arg1 ~= nil then
			if f50_arg2 >= 0 and f50_arg2 <= 0 then
				return
			elseif f50_arg0.currentScore == nil then
				f50_arg0.currentScore = 0
			end
			f50_arg0.currentScore = f50_arg0.currentScore + f50_arg2
			local f50_local0
			if f50_arg2 > 0 then
				f50_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"mp/plus")
				if not f50_local0 then
				else
					f50_arg0.Score:setText(f50_local0 .. f50_arg0.currentScore)
					local f50_local1 = false
					local f50_local2 = false
					if not CoD.IsShoutcaster(f46_arg1) and f50_arg3 ~= nil then
						f50_local1 = Engine[@"hash_4C6F8EC444864600"](CoD.scoreInfoTable, f50_arg3, 14) == "True"
						local f50_local3 = Engine[@"hash_25DC2BA4A99CE43E"](CoD.scoreInfoTable, f50_arg3, Enum[@"escoreinfotablecolumns"][@"scoreinfotable_script_reference"])
						for f50_local7, f50_local8 in ipairs(CoD.ScoreboardUtility.GoldenScoreRefs) do
							if f50_local3 == f50_local8 then
								f50_local2 = true
								break
							end
						end
					end
					if f50_local1 then
						f46_arg0:playClip("PositionScore")
					else
						f46_arg0:playClip("NormalScore")
					end
					if f50_arg1 ~= @"score/kill" and f50_arg1 ~= @"hash_480234A872BD64AC" then
						f50_arg0:AddScoreFeed(Engine[@"localize"](f50_arg1), f50_local1, f50_local2)
					end
					if f50_local2 then
						f46_local6(25, f50_local2)
					end
				end
			end
			f50_local0 = ""
		elseif f50_arg0.streakLabel ~= nil then
			f50_arg0.streakLabel:out()
			f50_arg0.streakLabel = nil
		end
	end
	f46_arg0:registerEventHandler("clip_over", function(element, event)
		element.currentScore = 0
		for f51_local0 = 0, 10, 1 do
			if not element["ScoreFeedItem" .. f51_local0] then
				break
			elseif f51_local0 == 0 then
				local f51_local3 = "ScoreFeedItem"
				element["ScoreFeedItem" .. f51_local0].TextBox:setText("")
				f51_local3 = "ScoreFeedItem"
				element["ScoreFeedItem" .. f51_local0].text = nil
			else
				element["ScoreFeedItem" .. f51_local0]:close()
				element["ScoreFeedItem" .. f51_local0] = nil
			end
		end
	end)
end
CoD.ScoreboardUtility.CloseOccluders = function(f52_arg0, f52_arg1)
	if CoD.isPC and f52_arg1.occludedBy then
		local f52_local0 = f52_arg1
		while f52_local0 and f52_local0.occludedBy do
			f52_local0 = f52_local0.occludedBy
		end
		GoBackToMenu(f52_local0, f52_arg0, f52_arg1.menuName)
	end
end
