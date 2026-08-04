CoD.ChallengesUtility = {}
CoD.ChallengesUtility.NearCompletionMaxNumChallengesShown = 10
CoD.ChallengesUtility.NearCompletionLists = {}
CoD.ChallengesUtility.IndexCol = 0
CoD.ChallengesUtility.TierIdCol = 1
CoD.ChallengesUtility.TargetValCol = 2
CoD.ChallengesUtility.StatTypeCol = 3
CoD.ChallengesUtility.StatsNameCol = 4
CoD.ChallengesUtility.NameStringCol = 5
CoD.ChallengesUtility.XpEarnedCol = 6
CoD.ChallengesUtility.ChallengeStatNameCol = 10
CoD.ChallengesUtility.UnlockRankCol = 11
CoD.ChallengesUtility.UnlockPLevelCol = 14
CoD.ChallengesUtility.CategoryCol = 16
CoD.ChallengesUtility.IsMasteryCol = 18
CoD.ChallengesUtility.VialsEarnedCol = 24
CoD.ChallengesUtility.ChallengeCategoryTable = {
	mp = {
		operations = {
			"bootcamp",
			"killer",
			"humiliation",
			"precision",
			"killjoys",
		},
		career = {
			"gamevictories",
			"tourofduty",
			"gameheroics",
			"weaponproficiency",
			"specialized",
			"marksman",
		},
		scorestreaks = {
			"airassault",
			"groundassault",
			"support",
		},
		prestige = {
			"handling",
			"efficiency",
			"tacticalkits",
			"gear",
			"perks",
			"equipment",
			"wildcards",
		},
	},
	zm = {
		expert = {
			"hunter",
			"survivalist",
			"strategist",
		},
		toolkit = {
			"elixirs_and_talismans",
			"weapons_and_equipment",
			"prestigious",
		},
	},
	wz = {
		career = {
			"professional",
			"survivalist",
		},
		operations = {
			"heroics",
			"vehicular",
		},
	},
}
CoD.ChallengesUtility.ChallengeCategoryDisplayName = {
	operations = @"challenge/operations",
	career = @"challenge/career",
	scorestreaks = @"challenge/scorestreaks",
	prestige = @"challenge/prestige",
}
CoD.ChallengesUtility.ChallengeCategorySortOrder = {
	[Enum.eModes.mode_multiplayer] = {
		mp = 0,
		bootcamp = 1,
		killer = 2,
		humiliation = 3,
		precision = 4,
		killjoys = 5,
		gamevictories = 6,
		tourofduty = 7,
		gameheroics = 8,
		weaponproficiency = 9,
		marksman = 10,
		specialized = 11,
		airassault = 12,
		groundassault = 13,
		support = 14,
		handling = 15,
		efficiency = 16,
		tacticalkits = 17,
		gear = 18,
		perks = 19,
		equipment = 20,
		wildcards = 21,
	},
	[Enum.eModes.mode_zombies] = {
		zm = 0,
		hunter = 1,
		survivalist = 2,
		strategist = 3,
		elixirs_and_talismans = 4,
		weapons_and_equipment = 5,
		prestigious = 6,
	},
	[Enum.eModes.mode_warzone] = {
		wz = 0,
		professional = 1,
		survivalist = 2,
		heroics = 3,
		vehicular = 4,
	},
}
CoD.ChallengesUtility.ChallengeTypeHashToEnum = {
	global = Enum.statsMilestoneTypes_t[@"milestone_global"],
	daily = Enum.statsMilestoneTypes_t[@"milestone_daily"],
	group = Enum.statsMilestoneTypes_t[@"milestone_group"],
	attachment = Enum.statsMilestoneTypes_t[@"milestone_attachments"],
	gamemode = Enum.statsMilestoneTypes_t[@"milestone_gamemode"],
	specialist = Enum.statsMilestoneTypes_t[@"milestone_specialist"],
}
CoD.ChallengesUtility.SetupCategoryStatsDatasource = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = Engine.GetChallengeInfoForImages(f1_arg0, nil, f1_arg1)
	local f1_local1 = {
		[f1_arg2] = {},
		[f1_arg2] = 0,
		[f1_arg2] = 0,
	}
	for f1_local8, f1_local9 in pairs(CoD.ChallengesUtility.ChallengeCategoryTable[f1_arg2]) do
		for f1_local5, f1_local6 in ipairs(f1_local9) do
			f1_local1[f1_local6] = {}
			f1_local1[f1_local6].numComplete = 0
			f1_local1[f1_local6].numTotal = 0
		end
		f1_local1[f1_local8] = {}
		f1_local1[f1_local8].numComplete = 0
		f1_local1[f1_local8].numTotal = 0
	end
	f1_local2 = nil
	f1_local3 = Engine.GetModelForController(f1_arg0)
	if f1_arg1 == Enum.eModes.mode_multiplayer then
		f1_local2 = f1_local3:create("ChallengesMPCategoryStats")
	elseif f1_arg1 == Enum.eModes.mode_zombies then
		f1_local2 = f1_local3:create("ChallengesZMCategoryStats")
	else
		f1_local2 = f1_local3:create("ChallengesWZCategoryStats")
	end
	for f1_local10, f1_local11 in ipairs(f1_local0) do
		local f1_local7 = f1_local11.challengeCategory
		if not f1_local11.isMastery and f1_local7 ~= "darkops" then
			assert(f1_local1[f1_local7])
			f1_local1[f1_local7].numTotal = f1_local1[f1_local7].numTotal + 1
			local f1_local12
			if f1_local11.currChallengeStatValue < Engine[@"hash_4C6F8EC444864600"]("gamedata/stats/" .. f1_arg2 .. "/statsmilestones" .. f1_local11.tableNum + 1 .. ".csv", f1_local11.currentChallengeRow or f1_local11.challengeRow, CoD.ChallengesUtility.TargetValCol) then
				f1_local12 = not Dvar[@"allitemsunlocked"]:get()
			else
				f1_local12 = false
			end
			if not f1_local12 then
				f1_local1[f1_local7].numComplete = f1_local1[f1_local7].numComplete + 1
			end
			local f1_local13, f1_local14, f1_local15, f1_local16 = CoD.ChallengesUtility.SetupIsCategoryLocked(f1_arg0, f1_arg1, f1_arg2, f1_local11)
			f1_local1[f1_local7].categoryLocked = f1_local1[f1_local7].categoryLocked or f1_local13
			f1_local1[f1_local7].categoryLockedText = f1_local1[f1_local7].categoryLockedText or f1_local14
			f1_local1[f1_local7].unlockRank = f1_local1[f1_local7].unlockRank or f1_local15
			f1_local1[f1_local7].unlockPLevel = f1_local1[f1_local7].unlockPLevel or f1_local16
		end
		if f1_local11.isMastery and f1_local1[f1_local7] then
			f1_local1[f1_local7].masteryIconId = f1_local11.imageID
		end
	end
	for f1_local10, f1_local11 in pairs(CoD.ChallengesUtility.ChallengeCategoryTable[f1_arg2]) do
		local f1_local7, f1_local5, f1_local6 = false
		for f1_local13, f1_local14 in ipairs(f1_local11) do
			if not f1_local7 and f1_local1[f1_local14].categoryLocked then
				if f1_local1[f1_local14].unlockPLevel and (not f1_local6 or f1_local1[f1_local14].unlockPLevel < f1_local6) then
					f1_local6 = f1_local1[f1_local14].unlockPLevel
				elseif f1_local1[f1_local14].unlockRank and (not f1_local5 or f1_local1[f1_local14].unlockRank < f1_local5) then
					f1_local5 = f1_local1[f1_local14].unlockRank
				end
			else
				f1_local7 = true
			end
			f1_local1[f1_local10].numComplete = f1_local1[f1_local10].numComplete + f1_local1[f1_local14].numComplete
			f1_local1[f1_local10].numTotal = f1_local1[f1_local10].numTotal + f1_local1[f1_local14].numTotal
		end
		if not f1_local7 then
			if f1_local6 then
				f1_local1[f1_local10].categoryLocked = true
				f1_local1[f1_local10].categoryLockedText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_57FFD6D29AEB436E", f1_local6)
			elseif f1_local5 then
				f1_local1[f1_local10].categoryLocked = true
				f1_local1[f1_local10].categoryLockedText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_381C07BC4A11544D", f1_local5)
			end
		else
			f1_local1[f1_local10].categoryLocked = false
		end
		f1_local1[f1_local10].isSuperCategory = true
		f1_local1[f1_arg2].numComplete = f1_local1[f1_arg2].numComplete + f1_local1[f1_local10].numComplete
		f1_local1[f1_arg2].numTotal = f1_local1[f1_arg2].numTotal + f1_local1[f1_local10].numTotal
	end
	for f1_local10, f1_local11 in pairs(f1_local1) do
		local f1_local7 = 0
		if f1_local11.numTotal ~= 0 then
			f1_local7 = f1_local11.numComplete / f1_local11.numTotal
		end
		local f1_local5 = f1_local2:create(f1_local10)
		local f1_local6 = f1_local5:create("percentComplete")
		f1_local6:set(f1_local7)
		f1_local6 = f1_local5:create("categoryLocked")
		f1_local6:set(f1_local11.categoryLocked)
		f1_local6 = f1_local5:create("categoryLockedText")
		f1_local6:set(f1_local11.categoryLockedText)
		if f1_local11.masteryIconId then
			f1_local6 = f1_local5:create("iconId")
			f1_local6:set(f1_local11.masteryIconId)
		end
	end
	return f1_local2
end
CoD.ChallengesUtility.RefreshCategoryStats = function(f2_arg0, f2_arg1)
	if f2_arg1:get() then
		local f2_local0 = CoD.StartMenuUtility.GetSessionModeFromLobby()
		if not f2_local0 then
			return
		elseif f2_local0 == Enum.eModes.mode_multiplayer then
			DataSources.ChallengesMPCategoryStats.init(f2_arg0)
		elseif f2_local0 == Enum.eModes.mode_zombies then
			DataSources.ChallengesZMCategoryStats.init(f2_arg0)
		elseif f2_local0 == Enum.eModes.mode_warzone then
			DataSources.ChallengesWZCategoryStats.init(f2_arg0)
		end
	end
end
DataSources.ChallengesMPCategoryStats = {
	init = function(f3_arg0)
		return CoD.ChallengesUtility.SetupCategoryStatsDatasource(f3_arg0, Enum.eModes.mode_multiplayer, "mp")
	end,
	getModel = function(f4_arg0)
		local f4_local0 = Engine.GetModel(Engine.GetModelForController(f4_arg0), "ChallengesMPCategoryStats")
		if f4_local0 == nil then
			f4_local0 = DataSources.ChallengesMPCategoryStats.init(f4_arg0)
		end
		return f4_local0
	end,
}
DataSources.ChallengesZMCategoryStats = {
	init = function(f5_arg0)
		return CoD.ChallengesUtility.SetupCategoryStatsDatasource(f5_arg0, Enum.eModes.mode_zombies, "zm")
	end,
	getModel = function(f6_arg0)
		local f6_local0 = Engine.GetModel(Engine.GetModelForController(f6_arg0), "ChallengesZMCategoryStats")
		if f6_local0 == nil then
			f6_local0 = DataSources.ChallengesZMCategoryStats.init(f6_arg0)
		end
		return f6_local0
	end,
}
DataSources.ChallengesWZCategoryStats = {
	init = function(f7_arg0)
		return CoD.ChallengesUtility.SetupCategoryStatsDatasource(f7_arg0, Enum.eModes.mode_warzone, "wz")
	end,
	getModel = function(f8_arg0)
		local f8_local0 = Engine.GetModel(Engine.GetModelForController(f8_arg0), "ChallengesWZCategoryStats")
		if f8_local0 == nil then
			f8_local0 = DataSources.ChallengesWZCategoryStats.init(f8_arg0)
		end
		return f8_local0
	end,
}
CoD.ChallengesUtility.CreateChallengeTab = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5)
	if not CoD.ChallengesUtility.IsCategoryLocked(f9_arg0, f9_arg4) then
		table.insert(f9_arg1, {
			models = {
				name = f9_arg2,
				tabWidget = f9_arg3,
				tabIcon = "",
				tabCategory = f9_arg4,
				available = true,
			},
			properties = {
				tabId = f9_arg4,
				selectIndex = f9_arg5 == f9_arg4,
			},
		})
	end
end
DataSources.MasterCallingCard = {
	getModel = function(f10_arg0)
		local f10_local0 = Engine.GetModel(Engine.GetModelForController(f10_arg0), "MasterCallingCard")
		if f10_local0 == nil then
			f10_local0 = Engine.CreateModel(Engine.GetModelForController(f10_arg0), "MasterCallingCard")
			f10_local0:create("title")
			f10_local0:create("description")
			f10_local0:create("icon")
			f10_local0:create("percentComplete")
			f10_local0:create("isLocked")
			f10_local0:create("statFractionText")
			f10_local0:create("xp")
			local f10_local1 = f10_local0:create("maxTier")
			f10_local1:set(0)
			f10_local1 = f10_local0:create("currentTier")
			f10_local1:set(0)
			f10_local1 = f10_local0:create("tierStatus")
			f10_local1:set("")
		end
		return f10_local0
	end,
	setModelValues = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4, f11_arg5, f11_arg6)
		local f11_local0 = Engine.GetModel(Engine.GetModelForController(f11_arg0), "MasterCallingCard")
		if f11_local0 == nil then
			f11_local0 = DataSources.MasterCallingCard.getModel(f11_arg0)
		end
		f11_local0.title:set(f11_arg1)
		f11_local0.description:set(f11_arg2)
		f11_local0.icon:set(f11_arg3)
		f11_local0.percentComplete:set(f11_arg4)
		local f11_local1 = f11_local0.isLocked
		local f11_local2 = f11_local1
		f11_local1 = f11_local1.set
		local f11_local3
		if f11_arg4 < 1 then
			f11_local3 = not Dvar[@"allitemsunlocked"]:get()
		else
			f11_local3 = false
		end
		f11_local1(f11_local2, f11_local3)
		if f11_arg5 then
			f11_local0.statFractionText:set(f11_arg5)
		end
		if f11_arg6 then
			f11_local0.xp:set(f11_arg6)
		else
			f11_local0.xp:set(0)
		end
	end,
}
DataSources.MasterCTCallingCard = {
	getModel = function(f12_arg0)
		local f12_local0 = Engine.GetModel(Engine.GetModelForController(f12_arg0), "MasterCTCallingCard")
		if f12_local0 == nil then
			f12_local0 = Engine.CreateModel(Engine.GetModelForController(f12_arg0), "MasterCTCallingCard")
			f12_local0:create("title")
			f12_local0:create("description")
			f12_local0:create("iconId")
			f12_local0:create("icon")
			f12_local0:create("statPercent")
			f12_local0:create("percentComplete")
			f12_local0:create("statFractionText")
			f12_local0:create("isLocked")
		end
		return f12_local0
	end,
	setModelValues = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5)
		local f13_local0 = Engine.GetModel(Engine.GetModelForController(f13_arg0), "MasterCTCallingCard")
		if f13_local0 == nil then
			f13_local0 = DataSources.MasterCTCallingCard.getModel(f13_arg0)
		end
		f13_local0.title:set(f13_arg1)
		f13_local0.description:set(f13_arg2)
		f13_local0.iconId:set(f13_arg3)
		f13_local0.icon:set(CoD.ChallengesUtility.GetBackgroundByID(f13_arg3))
		f13_local0.statPercent:set(Dvar[@"allitemsunlocked"]:get() and 1 or f13_arg4 / f13_arg5)
		f13_local0.percentComplete:set(Dvar[@"allitemsunlocked"]:get() and 1 or f13_arg4 / f13_arg5)
		f13_local0.statFractionText:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f13_arg4, f13_arg5))
		local f13_local1 = f13_local0.isLocked
		local f13_local2 = f13_local1
		f13_local1 = f13_local1.set
		local f13_local3
		if f13_arg4 < f13_arg5 then
			f13_local3 = not Dvar[@"allitemsunlocked"]:get()
		else
			f13_local3 = false
		end
		f13_local1(f13_local2, f13_local3)
	end,
}
DataSources.ChallengesTabs = ListHelper_SetupDataSource("ChallengesTabs", function(f14_arg0)
	local f14_local0 = {}
	local f14_local1 = Engine.GetGlobalModel()
	f14_local1 = f14_local1.defaultChallengeTab:get()
	local f14_local2 = CoD.StartMenuUtility.GetSessionModeFromLobby()
	if f14_local2 == Enum.eModes.mode_multiplayer then
		CoD.ChallengesUtility.CreateChallengeTab(f14_arg0, f14_local0, @"challenge/operations", "CoD.Challenges_FrameWidget_Operations", "operations", f14_local1)
		CoD.ChallengesUtility.CreateChallengeTab(f14_arg0, f14_local0, @"challenge/career", "CoD.Challenges_FrameWidget_Career", "career", f14_local1)
		CoD.ChallengesUtility.CreateChallengeTab(f14_arg0, f14_local0, @"challenge/scorestreaks", "CoD.Challenges_FrameWidget_Scorestreaks", "scorestreaks", f14_local1)
		CoD.ChallengesUtility.CreateChallengeTab(f14_arg0, f14_local0, @"challenge/prestige", "CoD.Challenges_FrameWidget_Prestige", "prestige", f14_local1)
	elseif f14_local2 == Enum.eModes.mode_zombies then
		CoD.ChallengesUtility.CreateChallengeTab(f14_arg0, f14_local0, @"hash_6892ED10E8BF4877", "CoD.Challenges_FrameWidget_Expert", "expert", f14_local1)
		CoD.ChallengesUtility.CreateChallengeTab(f14_arg0, f14_local0, @"hash_1677D363E896D453", "CoD.Challenges_FrameWidget_Toolkit", "toolkit", f14_local1)
	else
		CoD.ChallengesUtility.CreateChallengeTab(f14_arg0, f14_local0, @"challenge/career", "CoD.ChallengesFramewidgetCareerWZ", "career", f14_local1)
		CoD.ChallengesUtility.CreateChallengeTab(f14_arg0, f14_local0, @"challenge/operations", "CoD.ChallengesFramewidgetOperationsWZ", "operations", f14_local1)
	end
	return f14_local0
end)
DataSources.OperationsTabs = ListHelper_SetupDataSource("OperationsTabs", function(f15_arg0)
	local f15_local0 = {}
	local f15_local1 = Engine.GetGlobalModel()
	f15_local1 = f15_local1.challengeCategory:get()
	CoD.ChallengesUtility.CreateChallengeTab(f15_arg0, f15_local0, "challenge/bootcamp", "CoD.ChallengesStickerbook", "bootcamp", f15_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f15_arg0, f15_local0, @"challenge/killer", "CoD.ChallengesStickerbook", "killer", f15_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f15_arg0, f15_local0, "challenge/humiliation", "CoD.ChallengesStickerbook", "humiliation", f15_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f15_arg0, f15_local0, "challenge/precision", "CoD.ChallengesStickerbook", "precision", f15_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f15_arg0, f15_local0, "challenge/killjoys", "CoD.ChallengesStickerbook", "killjoys", f15_local1)
	return f15_local0
end)
DataSources.CareerTabs = ListHelper_SetupDataSource("CareerTabs", function(f16_arg0)
	local f16_local0 = {}
	local f16_local1 = Engine.GetGlobalModel()
	f16_local1 = f16_local1.challengeCategory:get()
	CoD.ChallengesUtility.CreateChallengeTab(f16_arg0, f16_local0, "challenge/gamevictories", "CoD.ChallengesStickerbook", "gamevictories", f16_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f16_arg0, f16_local0, "challenge/tourofduty", "CoD.ChallengesStickerbook", "tourofduty", f16_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f16_arg0, f16_local0, "challenge/gameheroics", "CoD.ChallengesStickerbook", "gameheroics", f16_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f16_arg0, f16_local0, "challenge/weaponproficiency", "CoD.ChallengesStickerbook", "weaponproficiency", f16_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f16_arg0, f16_local0, "challenge/marksman", "CoD.ChallengesStickerbook", "marksman", f16_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f16_arg0, f16_local0, @"challenge/specialized", "CoD.ChallengesStickerbook", "specialized", f16_local1)
	return f16_local0
end)
DataSources.ScorestreaksTabs = ListHelper_SetupDataSource("ScorestreaksTabs", function(f17_arg0)
	local f17_local0 = {}
	local f17_local1 = Engine.GetGlobalModel()
	f17_local1 = f17_local1.challengeCategory:get()
	CoD.ChallengesUtility.CreateChallengeTab(f17_arg0, f17_local0, "challenge/airassault", "CoD.ChallengesStickerbook", "airassault", f17_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f17_arg0, f17_local0, "challenge/groundassault", "CoD.ChallengesStickerbook", "groundassault", f17_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f17_arg0, f17_local0, @"challenge/support", "CoD.ChallengesStickerbook", "support", f17_local1)
	return f17_local0
end)
DataSources.PrestigeTabs = ListHelper_SetupDataSource("PrestigeTabs", function(f18_arg0)
	local f18_local0 = {}
	local f18_local1 = Engine.GetGlobalModel()
	f18_local1 = f18_local1.challengeCategory:get()
	CoD.ChallengesUtility.CreateChallengeTab(f18_arg0, f18_local0, @"challenge/handling", "CoD.ChallengesStickerbook", "handling", f18_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f18_arg0, f18_local0, @"challenge/efficiency", "CoD.ChallengesStickerbook", "efficiency", f18_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f18_arg0, f18_local0, "challenge/tacticalkits", "CoD.ChallengesStickerbook", "tacticalkits", f18_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f18_arg0, f18_local0, @"challenge/gear", "CoD.ChallengesStickerbook", "gear", f18_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f18_arg0, f18_local0, @"challenge/perks", "CoD.ChallengesStickerbook", "perks", f18_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f18_arg0, f18_local0, @"challenge/equipment", "CoD.ChallengesStickerbook", "equipment", f18_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f18_arg0, f18_local0, @"challenge/wildcards", "CoD.ChallengesStickerbook", "wildcards", f18_local1)
	return f18_local0
end)
DataSources.ToolkitTabs = ListHelper_SetupDataSource("ToolkitTabs", function(f19_arg0)
	local f19_local0 = {}
	local f19_local1 = Engine.GetGlobalModel()
	f19_local1 = f19_local1.challengeCategory:get()
	CoD.ChallengesUtility.CreateChallengeTab(f19_arg0, f19_local0, @"hash_221B7E9D719708D1", "CoD.ChallengesStickerbook", "elixirs_and_talismans", f19_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f19_arg0, f19_local0, "zm_challenges/weapons_and_equipment", "CoD.ChallengesStickerbook", "weapons_and_equipment", f19_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f19_arg0, f19_local0, "zm_challenges/prestigious", "CoD.ChallengesStickerbook", "prestigious", f19_local1)
	return f19_local0
end)
DataSources.ExpertTabs = ListHelper_SetupDataSource("ExpertTabs", function(f20_arg0)
	local f20_local0 = {}
	local f20_local1 = Engine.GetGlobalModel()
	f20_local1 = f20_local1.challengeCategory:get()
	CoD.ChallengesUtility.CreateChallengeTab(f20_arg0, f20_local0, "zm_challenges/hunter", "CoD.ChallengesStickerbook", "hunter", f20_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f20_arg0, f20_local0, "zm_challenges/survivalist", "CoD.ChallengesStickerbook", "survivalist", f20_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f20_arg0, f20_local0, "zm_challenges/strategist", "CoD.ChallengesStickerbook", "strategist", f20_local1)
	return f20_local0
end)
DataSources.CareerWZTabs = ListHelper_SetupDataSource("CareerWZTabs", function(f21_arg0)
	local f21_local0 = {}
	local f21_local1 = Engine.GetGlobalModel()
	f21_local1 = f21_local1.challengeCategory:get()
	CoD.ChallengesUtility.CreateChallengeTab(f21_arg0, f21_local0, @"hash_5A9AFC6579AE78B3", "CoD.ChallengesStickerbook", "professional", f21_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f21_arg0, f21_local0, @"hash_562FE35AC4EC80DE", "CoD.ChallengesStickerbook", "survivalist", f21_local1)
	return f21_local0
end)
DataSources.OperationsWZTabs = ListHelper_SetupDataSource("OperationsWZTabs", function(f22_arg0)
	local f22_local0 = {}
	local f22_local1 = Engine.GetGlobalModel()
	f22_local1 = f22_local1.challengeCategory:get()
	CoD.ChallengesUtility.CreateChallengeTab(f22_arg0, f22_local0, @"hash_56074D9A1B1A097D", "CoD.ChallengesStickerbook", "heroics", f22_local1)
	CoD.ChallengesUtility.CreateChallengeTab(f22_arg0, f22_local0, @"hash_6D30385BBBC1DD9D", "CoD.ChallengesStickerbook", "vehicular", f22_local1)
	return f22_local0
end)
CoD.ChallengesUtility.SetupTierListDatasource = function(f23_arg0)
	DataSources.TierIconList = DataSourceHelpers.ListSetup("TierIconList", function(f24_arg0)
		local f24_local0 = {}
		local f24_local1 = f23_arg0:getModel()
		if not f24_local1 then
			return f24_local0
		end
		local f24_local2 = f24_local1.maxTier
		if f24_local2 then
			f24_local2 = f24_local1.maxTier:get()
		end
		local f24_local3 = f24_local1.currentTier
		if f24_local3 then
			f24_local3 = f24_local1.currentTier:get()
		end
		local f24_local4 = f24_local1.xp
		if f24_local4 then
			f24_local4 = f24_local1.xp:get()
		end
		local f24_local5 = f24_local1.isWZ
		if f24_local5 then
			f24_local5 = f24_local1.isWZ:get()
		end
		if f24_local2 == nil or f24_local3 == nil or f24_local4 == nil then
			return f24_local0
		end
		local f24_local6 = true
		for f24_local7 = 0, f24_local2, 1 do
			table.insert(f24_local0, {
				models = {
					tierText = Engine[@"hash_4F9F1239CFD921FE"](CoD.ChallengesUtility.GetChallengeTierNumeral(f24_local7)),
					isReached = f24_local6,
					isCurrentTier = f24_local7 == f24_local3,
					xp = f24_local4,
					isWZ = f24_local5,
				},
				properties = {},
			})
			if f24_local7 == f24_local3 then
				f24_local6 = false
			end
		end
		return f24_local0
	end, false)
end
CoD.ChallengesUtility.ClearTierListDatasource = function(f25_arg0)
	DataSources.TierIconList = nil
end
CoD.ChallengesUtility.IsLegendaryCallingCard = function(f26_arg0)
	return CoD.BlackMarketUtility.GetRarityTypeForLootItemFromName(f26_arg0) == "legendary"
end
CoD.ChallengesUtility.IsWidgetBasedCallingCard = function(f27_arg0)
	if CoD[f27_arg0] and CoD[f27_arg0].new then
		return true
	else
		return false
	end
end
CoD.ChallengesUtility.SetCallingCardForWidget = function(f28_arg0, f28_arg1, f28_arg2)
	local f28_local0 = function()
		if f28_arg0.__backgroundImage and f28_arg0.framedWidget then
			f28_arg0.framedWidget.CardIcon:setImage(RegisterImage(f28_arg0.__backgroundImage))
		end
	end
	if not f28_arg0.__hasUpdateImageCallbacks then
		f28_arg0.__hasUpdateImageCallbacks = true
		LUI.OverrideFunction_CallOriginalFirst(f28_arg0, "createFrameWidget", f28_local0)
		LUI.OverrideFunction_CallOriginalFirst(f28_arg0, "changeFrameWidget", f28_local0)
	end
	local f28_local1 = false
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		local f28_local2 = 19
		local f28_local3 = Engine.TableLookup(CoD.backgroundsTable, f28_local2, f28_local2, f28_arg1)
		if f28_local3 and f28_local3 ~= 0x0 then
			f28_arg0.__backgroundImage = f28_arg1
			f28_arg0.isWidgetBasedCallingCard = nil
			f28_arg0:changeFrameWidget(CoD.CallingCards_BasicImage)
			f28_local1 = true
		end
	end
	if not f28_local1 then
		if CoD.ChallengesUtility.IsWidgetBasedCallingCard(f28_arg1) then
			f28_arg0.__backgroundImage = nil
			f28_arg0.isWidgetBasedCallingCard = true
			f28_arg0:changeFrameWidget(CoD[f28_arg1])
		else
			if Engine.IsInGame() and (CoD.isCampaign or CoD.isZombie) then
				local f28_local4 = Engine.TableLookup(CoD.backgroundsTable, 11, 3, f28_arg1)
				if f28_local4 ~= nil and Engine[@"hash_4238317564B9D47B"](f28_local4) then
					f28_arg1 = f28_local4
				end
			end
			f28_arg0.__backgroundImage = f28_arg1
			f28_arg0.isWidgetBasedCallingCard = nil
			f28_arg0:changeFrameWidget(CoD.CallingCards_BasicImage)
		end
	end
end
CoD.ChallengesUtility.ResetCategoryStats = function(f30_arg0)
	DataSources.ChallengesMPCategoryStats.init(f30_arg0)
	DataSources.ChallengesZMCategoryStats.init(f30_arg0)
end
CoD.ChallengesUtility.ResetNearCompletion = function(f31_arg0)
	for f31_local6, f31_local7 in pairs(CoD.ChallengesUtility.NearCompletionLists) do
		for f31_local3, f31_local4 in pairs(f31_local7) do
			f31_local7[f31_local3] = nil
		end
		CoD.ChallengesUtility.NearCompletionLists[f31_local6] = nil
	end
	DataSources.ChallengesMPNearCompletion.init(f31_arg0)
	DataSources.ChallengesZMNearCompletion.init(f31_arg0)
end
CoD.ChallengesUtility.GetGameModeInfo = function()
	local f32_local0 = CoD.StartMenuUtility.GetSessionModeFromLobby()
	if not f32_local0 then
		return nil
	end
	local f32_local1 = {}
	if f32_local0 == Enum.eModes.mode_multiplayer then
		f32_local1.name = "mp"
	elseif f32_local0 == Enum.eModes.mode_zombies then
		f32_local1.name = "zm"
	elseif f32_local0 == Enum.eModes.mode_warzone then
		f32_local1.name = "wz"
	end
	f32_local1.index = f32_local0
	return f32_local1
end
CoD.ChallengesUtility.GetChallengeTypeString = function(f33_arg0)
	return @"challenge/" .. "TYPE_" .. f33_arg0
end
CoD.ChallengesUtility.TierString = {
	[0] = "challenge/tier_0",
	[1] = "challenge/tier_1",
	[2] = "challenge/tier_2",
	[3] = "challenge/tier_3",
	[4] = "challenge/tier_4",
}
CoD.ChallengesUtility.GetChallengeTierNumeral = function(f34_arg0)
	local f34_local0
	if 0 <= f34_arg0 and f34_arg0 < 5 then
		f34_local0 = CoD.ChallengesUtility.TierString[f34_arg0]
		if not f34_local0 then
		else
			return f34_local0
		end
	end
	f34_local0 = 0x0
end
CoD.ChallengesUtility.GetLocalizedNameAndDescriptionForChallengeInfo = function(f35_arg0)
	local f35_local0 = "mp"
	if f35_arg0.mode == Enum.eModes.mode_zombies then
		f35_local0 = "zm"
	elseif f35_arg0.mode == Enum.eModes.mode_warzone then
		f35_local0 = "wz"
	end
	local f35_local1 = "gamedata/stats/" .. f35_local0 .. "/statsmilestones" .. f35_arg0.tableNum + 1 .. ".csv"
	local f35_local2 = Engine[@"hash_4C6F8EC444864600"](f35_local1, f35_arg0.challengeRow, CoD.ChallengesUtility.NameStringCol)
	local f35_local3 = f35_local2 .. "_DESC"
	local f35_local4 = ""
	if f35_arg0.challengeType == Enum.statsMilestoneTypes_t[@"milestone_weapon"] then
		f35_local4 = Engine[@"hash_4F9F1239CFD921FE"](Engine.GetItemName(f35_arg0.itemIndex, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f35_arg0.mode))
	elseif f35_arg0.challengeType == Enum.statsMilestoneTypes_t[@"milestone_group"] then
		f35_local4 = Engine[@"hash_4F9F1239CFD921FE"](CoD.ChallengesUtility.GetChallengeTypeString(Engine.GetItemGroupByIndex(f35_arg0.itemIndex)))
	elseif f35_arg0.challengeType == Enum.statsMilestoneTypes_t[@"milestone_attachments"] then
		f35_local4 = Engine.Localize(Engine.GetAttachmentNameByIndex(f35_arg0.itemIndex))
	elseif f35_arg0.challengeType == Enum.statsMilestoneTypes_t[@"milestone_gamemode"] then
		local f35_local5 = Engine[@"getgametypeinfo"](Engine.GetGametypeName(f35_arg0.itemIndex))
		local f35_local6 = Engine[@"hash_4F9F1239CFD921FE"]
		local f35_local7
		if f35_local5 then
			f35_local7 = f35_local5[@"challengetypestring"]
			if not f35_local7 then
			else
				f35_local4 = f35_local6(f35_local7)
			end
		end
		f35_local7 = 0x0
	end
	return Engine.Localize(f35_local2, "", f35_local4, CoD.ChallengesUtility.GetLocalizedTierText(f35_local1, f35_arg0.challengeRow)), Engine.Localize(f35_local3, Engine[@"hash_4C6F8EC444864600"](f35_local1, f35_arg0.challengeRow, CoD.ChallengesUtility.TargetValCol), f35_local4)
end
CoD.ChallengesUtility.GetLocalizedTierText = function(f36_arg0, f36_arg1)
	local f36_local0 = ""
	if f36_arg0 ~= nil and f36_arg1 ~= nil then
		local f36_local1, f36_local2 = false
		local f36_local3 = tonumber(Engine[@"hash_4C6F8EC444864600"](f36_arg0, f36_arg1, 1))
		if f36_local3 > 0 or tonumber(Engine[@"hash_4C6F8EC444864600"](f36_arg0, f36_arg1 + 1, 1)) == 1 then
			f36_local1 = true
		end
		if f36_local1 == true then
			f36_local0 = Engine[@"hash_4F9F1239CFD921FE"](CoD.ChallengesUtility.GetChallengeTierNumeral(f36_local3))
		end
	end
	return f36_local0
end
CoD.ChallengesUtility.GetBackgroundByID = function(f37_arg0)
	local f37_local0 = 3
	local f37_local1 = 19
	local f37_local2 = 1
	local f37_local3 = f37_arg0
	if f37_local3 < 0 then
		f37_local3 = 0
	end
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		local f37_local4 = Engine.TableLookup(CoD.backgroundsTable, f37_local1, f37_local2, f37_local3)
		if f37_local4 and f37_local4 ~= 0x0 then
			return f37_local4
		end
	end
	return Engine.TableLookup(CoD.backgroundsTable, f37_local0, f37_local2, f37_local3)
end
CoD.ChallengesUtility.GetChallengeTable = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4)
	local f38_local0 = {}
	local f38_local1 = Engine.GetChallengeInfoForImages(f38_arg0, f38_arg3, f38_arg1)
	if not f38_local1 then
		return f38_local0
	end
	local f38_local2 = Engine.GetPlayerStats(f38_arg0, CoD.STATS_LOCATION_NORMAL, f38_arg1)
	local f38_local3 = 0
	local f38_local4 = 0
	if f38_local2 and f38_local2.PlayerStatsList then
		f38_local3 = f38_local2.PlayerStatsList.RANK.StatValue:get()
		f38_local4 = f38_local2.PlayerStatsList.PLEVEL.StatValue:get()
	end
	if f38_arg4 then
		table.sort(f38_local1, f38_arg4)
	end
	for f38_local31, f38_local32 in ipairs(f38_local1) do
		local f38_local33 = f38_local32.challengeRow
		local f38_local34 = f38_local32.currentChallengeRow
		local f38_local35 = f38_local32.challengeCategory
		local f38_local36 = f38_local32.tableNum
		local f38_local37 = f38_local32.isMastery
		local f38_local38 = f38_local32.challengeType
		local f38_local28 = f38_local32.prevChallengeStatValue or 0
		local f38_local29 = f38_local32.currChallengeStatValue
		local f38_local39 = f38_local32.imageID
		local f38_local17 = 0
		local f38_local18 = 0
		local f38_local26 = 0
		local f38_local19 = ""
		local f38_local40, f38_local23, f38_local24, f38_local27, f38_local25 = nil
		if f38_local33 ~= nil then
			local f38_local8 = "gamedata/stats/" .. f38_arg2 .. "/statsmilestones" .. f38_local36 + 1 .. ".csv"
			local f38_local9 = tonumber(Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local33, CoD.ChallengesUtility.TierIdCol))
			local f38_local10 = Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local33, CoD.ChallengesUtility.TargetValCol)
			local f38_local11 = Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local33, CoD.ChallengesUtility.NameStringCol)
			local f38_local12 = Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local33, CoD.ChallengesUtility.NameStringCol) .. "_DESC"
			local f38_local13 = tonumber(Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local33, CoD.ChallengesUtility.XpEarnedCol))
			local f38_local14 = Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local33, CoD.ChallengesUtility.UnlockRankCol)
			local f38_local15 = Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local33, CoD.ChallengesUtility.UnlockPLevelCol)
			local f38_local16 = CoD.ChallengesUtility.GetLocalizedTierText(f38_local8, f38_local33)
			if f38_local14 ~= "" then
				f38_local17 = tonumber(f38_local14)
			end
			if f38_local15 ~= "" then
				f38_local18 = tonumber(f38_local15)
			end
			if f38_local38 == Enum.statsMilestoneTypes_t[@"milestone_weapon"] then
				f38_local19 = Engine[@"hash_4F9F1239CFD921FE"](Engine.GetItemName(f38_local32.itemIndex, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f38_arg1))
			elseif f38_local38 == Enum.statsMilestoneTypes_t[@"milestone_group"] then
				f38_local19 = Engine[@"hash_4F9F1239CFD921FE"](CoD.ChallengesUtility.GetChallengeTypeString(Engine.GetItemGroupByIndex(f38_local32.itemIndex)))
			elseif f38_local38 == Enum.statsMilestoneTypes_t[@"milestone_attachments"] then
				f38_local19 = Engine.Localize(Engine.GetAttachmentNameByIndex(f38_local32.itemIndex))
			elseif f38_local38 == Enum.statsMilestoneTypes_t[@"milestone_gamemode"] then
				local f38_local20 = Engine[@"getgametypeinfo"](Engine.GetGametypeName(f38_local32.itemIndex))
				local f38_local21 = Engine[@"hash_4F9F1239CFD921FE"]
				local f38_local22
				if f38_local20 then
					f38_local22 = f38_local20[@"challengetypestring"]
					if not f38_local22 then
					else
						f38_local19 = f38_local21(f38_local22)
					end
				end
				f38_local22 = 0x0
			end
			if f38_local16 ~= "" then
				f38_local23 = true
			end
			if not f38_local37 then
				if f38_local4 < f38_local18 then
					f38_local24 = true
					f38_local25 = Engine[@"hash_4F9F1239CFD921FE"]("class/prestige_unlock_desc", f38_local18)
				elseif f38_local4 == 0 and f38_local3 < f38_local17 then
					f38_local24 = true
					f38_local25 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/unlocked_at", CoD.GetRankName(f38_local17, 0, f38_arg1), f38_local17 + 1)
				end
			end
			if f38_local23 and f38_local24 then
				f38_local16 = Engine.Localize(CoD.ChallengesUtility.TierString[0])
			end
			local f38_local20 = f38_local32.currentChallengeRow
			if f38_local20 then
				f38_local12 = Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local20, CoD.ChallengesUtility.NameStringCol) .. "_DESC"
				if f38_local23 then
					f38_local26 = tonumber(Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local20, CoD.ChallengesUtility.TierIdCol))
					f38_local10 = Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local20, CoD.ChallengesUtility.TargetValCol)
					f38_local13 = tonumber(Engine[@"hash_4C6F8EC444864600"](f38_local8, f38_local20, CoD.ChallengesUtility.XpEarnedCol))
					f38_local16 = CoD.ChallengesUtility.GetLocalizedTierText(f38_local8, f38_local20)
				end
			end
			f38_local27 = Engine.Localize(f38_local11, "", f38_local19, f38_local16)
			if not f38_local25 then
				f38_local25 = Engine.Localize(f38_local12, f38_local10, f38_local19)
			end
			if Dvar[@"allitemsunlocked"]:get() then
				f38_local28 = f38_local10
				f38_local29 = f38_local10
			end
			local f38_local21 = f38_local28 / f38_local10
			local f38_local22 = f38_local29 / f38_local10
			local f38_local30 = f38_local22 < 1
			if f38_local35 == "darkops" and not f38_local37 and f38_local30 then
				f38_local27 = Engine[@"hash_4F9F1239CFD921FE"](@"challenge/classified")
				f38_local25 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5D39450F492BCD23")
			end
			table.insert(f38_local0, {
				models = {
					title = f38_local27,
					description = f38_local25,
					iconId = f38_local39,
					icon = CoD.ChallengesUtility.GetBackgroundByID(f38_local39),
					maxTier = f38_local9,
					currentTier = f38_local26,
					previousVal = f38_local28,
					currentVal = f38_local29,
					prevStatPercent = f38_local21,
					statPercent = Dvar[@"allitemsunlocked"]:get() and 1 or f38_local22,
					statFractionText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f38_local29, f38_local10),
					tierStatus = Engine[@"hash_4F9F1239CFD921FE"]("challenge/tier_status", f38_local26 + 1, f38_local9 + 1),
					xp = f38_local13,
					percentComplete = f38_local22,
					isLocked = f38_local30 and not Dvar[@"allitemsunlocked"]:get(),
					isWZ = f38_arg1 == Enum.eModes.mode_warzone,
				},
				properties = {
					isMastery = f38_local37,
					isDarkOps = f38_local35 == "darkops",
					category = f38_local35,
					targetVal = f38_local10,
				},
			})
		end
	end
	return f38_local0
end
CoD.ChallengesUtility.GetDailyChallenge = function(f39_arg0, f39_arg1, f39_arg2)
	return nil
end
CoD.ChallengesUtility.UpdateDailyChallengeModel = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	local f40_local0 = CoD.ChallengesUtility.GetDailyChallenge(f40_arg0, f40_arg2, f40_arg3)
	if not f40_local0 then
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "description"), "")
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "fractionText"), "0/1")
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "image"), "")
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "progressPercentage"), 0)
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "rewardText"), "")
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "title"), "")
		return
	else
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "description"), f40_local0.challengeDescription)
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "fractionText"), Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f40_local0.currChallengeStatValue, f40_local0.targetVal))
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "image"), f40_local0.image)
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "progressPercentage"), f40_local0.percentComplete)
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "rewardText"), f40_local0.rewardText)
		Engine.SetModelValue(Engine.CreateModel(f40_arg1, "title"), f40_local0.challengeName)
	end
end
CoD.ChallengesUtility.MakeChallengeTierString = function(f41_arg0)
	local f41_local0 = f41_arg0
	if f41_arg0 == 0x0 or f41_arg0 == "" then
		return ""
	else
		return Engine.Localize(@"hash_1E743A7E5D0C37CD", LocalizeString(PrependString(@"challenge/" .. "TIER_", f41_local0)))
	end
end
CoD.ChallengesUtility.SetTotalMasterInfo = function(f42_arg0)
	local f42_local0 = CoD.ChallengesUtility.GetGameModeInfo()
	if not f42_local0 then
		return nil
	end
	local f42_local1 = CoD.ChallengesUtility.GetChallengeTable(f42_arg0, f42_local0.index, f42_local0.name, "onehundredpercent", nil)
	local f42_local2 = 0
	local f42_local3 = 0
	local f42_local4 = nil
	for f42_local8, f42_local9 in ipairs(f42_local1) do
		local f42_local10 = f42_local9.models
		if f42_local9.properties.isMastery then
			f42_local4 = f42_local9
		end
		f42_local3 = f42_local3 + 1
		if not f42_local10.isLocked then
			f42_local2 = f42_local2 + 1
		end
	end
	if f42_local4 then
		f42_local5 = f42_local4.models
		f42_local6 = nil
		if f42_local0.index == Enum.eModes.mode_multiplayer then
			f42_local7 = Engine.CreateModel(Engine.GetModelForController(f42_arg0), "ChallengesMPCategoryStats")
			f42_local6 = f42_local7.mp.percentComplete:get()
		elseif f42_local0.index == Enum.eModes.mode_zombies then
			f42_local7 = Engine.CreateModel(Engine.GetModelForController(f42_arg0), "ChallengesZMCategoryStats")
			f42_local6 = f42_local7.zm.percentComplete:get()
		else
			f42_local7 = Engine.CreateModel(Engine.GetModelForController(f42_arg0), "ChallengesWZCategoryStats")
			f42_local6 = f42_local7.wz.percentComplete:get()
		end
		DataSources.MasterCallingCard.setModelValues(f42_arg0, f42_local5.title, f42_local5.description, f42_local5.icon, f42_local6)
	end
end
CoD.ChallengesUtility.SetTotalMasterCTInfo = function(f43_arg0)
	local f43_local0, f43_local1, f43_local2, f43_local3, f43_local4 = CoD.CTUtility.GetCTMasterChallenge(f43_arg0)
	DataSources.MasterCTCallingCard.setModelValues(f43_arg0, f43_local2, f43_local3, f43_local4, f43_local0, f43_local1)
end
DataSources.ChallengeCards = DataSourceHelpers.ListSetup("ChallengeCards", function(f44_arg0)
	local f44_local0 = {}
	local f44_local1 = Engine.GetGlobalModel()
	f44_local1 = f44_local1.challengeCategory
	if f44_local1 then
		f44_local1 = Engine.GetGlobalModel()
		f44_local1 = f44_local1.challengeCategory:get()
	end
	if not f44_local1 then
		return f44_local0
	end
	local f44_local2 = CoD.ChallengesUtility.GetGameModeInfo()
	if not f44_local2 then
		return f44_local0
	end
	local f44_local3 = CoD.ChallengesUtility.GetChallengeTable(f44_arg0, f44_local2.index, f44_local2.name, f44_local1, function(f45_arg0, f45_arg1)
		return tonumber(f45_arg0.imageID) < tonumber(f45_arg1.imageID)
	end)
	local f44_local4 = 0
	local f44_local5 = 0
	local f44_local6 = nil
	for f44_local10, f44_local11 in ipairs(f44_local3) do
		local f44_local12 = f44_local11.models
		if f44_local11.properties.isMastery then
			f44_local6 = f44_local11
		end
		table.insert(f44_local0, f44_local11)
		f44_local5 = f44_local5 + 1
		if not f44_local12.isLocked then
			f44_local4 = f44_local4 + 1
		end
	end
	if f44_local6 then
		f44_local7 = f44_local6.models
		DataSources.MasterCallingCard.setModelValues(f44_arg0, f44_local7.title, f44_local7.description, f44_local7.icon, f44_local4 / f44_local5, Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f44_local4, f44_local5), f44_local7.xp)
	end
	if #f44_local0 > 0 then
		f44_local0[1].properties.selectIndex = true
	end
	return f44_local0
end)
CoD.ChallengesUtility.GetChallengeCardsForSessionMode = function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
	local f46_local0 = {}
	if not CoD.ChallengesUtility.GetGameModeInfo() then
		return f46_local0
	end
	local f46_local1 = CoD.ChallengesUtility.ChallengeCategorySortOrder[f46_arg1]
	local f46_local2 = true
	local f46_local3 = false
	local f46_local4
	if f46_arg1 ~= Enum.eModes.mode_multiplayer and f46_arg1 ~= Enum.eModes.mode_warzone then
		f46_local4 = false
	else
		f46_local4 = true
	end
	local f46_local5 = false
	local f46_local6 = CoD.ChallengesUtility.GetChallengeTable(f46_arg0, f46_arg1, f46_arg2, nil, nil)
	if f46_arg3 then
		table.sort(f46_local6, function(f47_arg0, f47_arg1)
			if f47_arg0.models.isLocked ~= f47_arg1.models.isLocked then
				return f47_arg1.models.isLocked
			else
				local f47_local0 = f47_arg0.properties.category
				local f47_local1 = f47_arg1.properties.category
				if f47_local0 ~= f47_local1 then
					if f46_local1[f47_local0] and f46_local1[f47_local1] then
						return f46_local1[f47_local0] < f46_local1[f47_local1]
					else
						return f46_local1[f47_local0] ~= nil
					end
				else
					return tonumber(f47_arg0.models.iconId) < tonumber(f47_arg1.models.iconId)
				end
			end
		end)
	end
	for f46_local10, f46_local11 in ipairs(f46_local6) do
		local f46_local12 = f46_local11.properties
		if f46_local2 and not f46_local3 and f46_local11.models.isLocked then
			CoD.PrestigeUtility.AddPrestigeCallingCards(f46_arg0, f46_arg1, f46_local0)
			f46_local3 = true
		end
		if f46_local4 and not f46_local5 and f46_local11.models.isLocked then
			CoD.RankUtility.AddRankCallingCards(f46_arg0, f46_arg1, f46_local0)
			f46_local5 = true
		end
		if not f46_local12.isMastery and (not f46_local12.isDarkOps or f46_local11.models.statPercent >= 1) then
			table.insert(f46_local0, f46_local11)
		end
	end
	if f46_local2 and not f46_local3 then
		CoD.PrestigeUtility.AddPrestigeCallingCards(f46_arg0, f46_arg1, f46_local0)
	end
	if f46_local4 and not f46_local5 then
		CoD.RankUtility.AddRankCallingCards(f46_arg0, f46_arg1, f46_local0)
	end
	return f46_local0
end
CoD.ChallengesUtility.AddMasteryChallengeCardsToList = function(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
	local f48_local0 = {}
	local f48_local1 = CoD.ChallengesUtility.GetChallengeTable(f48_arg0, f48_arg1, f48_arg2, nil, function(f49_arg0, f49_arg1)
		if f49_arg0.isLocked ~= f49_arg1.isLocked then
			return f49_arg1.isLocked
		else
			local f49_local0 = CoD.ChallengesUtility.ChallengeCategorySortOrder[f48_arg1]
			if f49_arg0.challengeCategory ~= f49_arg1.challengeCategory then
				if f49_local0[f49_arg0.challengeCategory] and f49_local0[f49_arg1.challengeCategory] then
					return f49_local0[f49_arg0.challengeCategory] < f49_local0[f49_arg1.challengeCategory]
				else
					return f49_local0[f49_arg0.challengeCategory] ~= nil
				end
			else
				return tonumber(f49_arg0.imageID) < tonumber(f49_arg1.imageID)
			end
		end
	end)
	local f48_local2 = {}
	local f48_local3 = 0
	local f48_local4 = 0
	for f48_local8, f48_local9 in ipairs(f48_local1) do
		local f48_local10 = f48_local9.properties
		if f48_local10.isMastery then
			if not f48_local10.isDarkOps then
				f48_local0[f48_local10.category] = f48_local9
				if f48_local10.category ~= "onehundredpercent" then
					f48_local3 = f48_local3 + 1
				end
			end
		end
		if not f48_local2[f48_local10.category] then
			f48_local2[f48_local10.category] = 0
		end
		if not f48_local9.models.isLocked then
			f48_local2[f48_local10.category] = f48_local2[f48_local10.category] + 1
		end
	end
	for f48_local8, f48_local9 in pairs(f48_local2) do
		if f48_local0[f48_local8] then
			f48_local0[f48_local8].models.percentComplete = f48_local9 / f48_local0[f48_local8].properties.targetVal
			f48_local0[f48_local8].models.isLocked = f48_local0[f48_local8].models.percentComplete < 1
			if not f48_local0[f48_local8].models.isLocked then
				f48_local4 = f48_local4 + 1
			end
			f48_local0[f48_local8].models.statFractionText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f48_local9, f48_local0[f48_local8].properties.targetVal)
			table.insert(f48_arg3, f48_local0[f48_local8])
		end
	end
	f48_local0.onehundredpercent.models.percentComplete = f48_local4 / f48_local3
	f48_local0.onehundredpercent.models.isLocked = f48_local0.onehundredpercent.models.percentComplete < 1
	f48_local0.onehundredpercent.models.statFractionText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f48_local4, f48_local3)
	table.insert(f48_arg3, f48_local0.onehundredpercent)
	if f48_arg1 == Enum.eModes.mode_warzone then
		f48_local5 = CoD.RankUtility.GetRankMasterCard(f48_arg0, f48_arg1)
		if f48_local5 then
			table.insert(f48_arg3, f48_local5)
		end
	end
	f48_local5 = CoD.PrestigeUtility.GetMasterPrestigeCard(f48_arg0, f48_arg1)
	if f48_local5 then
		table.insert(f48_arg3, f48_local5)
	end
end
CoD.ChallengesUtility.GetMasteryChallengeCards = function(f50_arg0, f50_arg1)
	local f50_local0 = {}
	CoD.ChallengesUtility.AddMasteryChallengeCardsToList(f50_arg0, Enum.eModes.mode_multiplayer, "mp", f50_local0)
	if not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
		CoD.ChallengesUtility.AddMasteryChallengeCardsToList(f50_arg0, Enum.eModes.mode_zombies, "zm", f50_local0)
	end
	CoD.ChallengesUtility.AddMasteryChallengeCardsToList(f50_arg0, Enum.eModes.mode_warzone, "wz", f50_local0)
	local f50_local1 = CoD.ChallengesUtility.AddGlobalChallengesToList(f50_arg0, {})
	if not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
		table.insert(f50_local0, f50_local1)
	end
	local f50_local2, f50_local3, f50_local4, f50_local5, f50_local6 = CoD.CTUtility.GetCTMasterChallenge(f50_arg0)
	local f50_local7 = table.insert
	local f50_local8 = f50_local0
	local f50_local9 = {}
	local f50_local10 = {
		title = Engine[@"hash_4F9F1239CFD921FE"](f50_local4),
		description = Engine[@"hash_4F9F1239CFD921FE"](f50_local5),
		iconId = f50_local6,
		icon = CoD.ChallengesUtility.GetBackgroundByID(f50_local6),
		percentComplete = f50_local2 / f50_local3,
		statFractionText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f50_local2, f50_local3),
	}
	local f50_local11
	if f50_local2 ~= f50_local3 then
		f50_local11 = not Dvar[@"allitemsunlocked"]:get()
	else
		f50_local11 = false
	end
	f50_local10.isLocked = f50_local11
	f50_local9.models = f50_local10
	f50_local9.properties = {
		ctChallenge = true,
	}
	f50_local7(f50_local8, f50_local9)
	f50_local7 = {}
	if not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
		f50_local8 = CoD.ChallengesUtility.AddDarkOpsChallengeCardsToList(f50_arg0, Enum.eModes.mode_zombies, "zm", f50_local7)
		if f50_local8 and not f50_local8.models.isLocked then
			table.insert(f50_local0, f50_local8)
		end
	end
	if f50_arg1 then
		table.sort(f50_local0, function(f51_arg0, f51_arg1)
			local f51_local0 = f51_arg0.models
			local f51_local1 = f51_arg1.models
			if f51_local0.isLocked ~= f51_local1.isLocked then
				return f51_local1.isLocked
			else
				return tonumber(f51_local0.iconId) < tonumber(f51_local1.iconId)
			end
		end)
	end
	return f50_local0
end
CoD.ChallengesUtility.AddDefaultCallingCardsToList = function(f52_arg0, f52_arg1)
	for f52_local8, f52_local9 in ipairs(Engine.GetBackgroundsForCategoryName(f52_arg0, "default")) do
		if not f52_local9.isBGLocked then
			local f52_local3 = table.insert
			local f52_local4 = f52_arg1
			local f52_local5 = {}
			local f52_local6 = {
				title = Engine.Localize(f52_local9.description),
				description = "",
				iconId = f52_local9.id,
				icon = CoD.ChallengesUtility.GetBackgroundByID(f52_local9.id),
			}
			local f52_local7 = f52_local9.isBGLocked
			if f52_local7 then
				f52_local7 = not Dvar[@"allitemsunlocked"]:get()
			end
			f52_local6.isLocked = f52_local7
			f52_local5.models = f52_local6
			f52_local5.properties = {
				trialUnlocked = true,
			}
			f52_local3(f52_local4, f52_local5)
		end
	end
end
CoD.ChallengesUtility.AddCombatTrainingChallengesToList = function(f53_arg0, f53_arg1)
	for f53_local0 = 1, CoD.CTUtility.NumCTChallenges, 1 do
		local f53_local3, f53_local4, f53_local5, f53_local6, f53_local7, f53_local8 = CoD.CTUtility.GetCTChallenge(f53_arg0, f53_local0)
		if f53_local3 == nil then
			f53_local3 = 0
		end
		local f53_local9 = table.insert
		local f53_local10 = f53_arg1
		local f53_local11 = {}
		local f53_local12 = {
			title = Engine[@"hash_4F9F1239CFD921FE"](f53_local6),
			description = Engine[@"hash_4F9F1239CFD921FE"](f53_local7),
			iconId = f53_local8,
			icon = CoD.ChallengesUtility.GetBackgroundByID(f53_local8),
			percentComplete = f53_local3 / f53_local4,
			statFractionText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f53_local3, f53_local4),
		}
		local f53_local13
		if not f53_local5 then
			f53_local13 = not Dvar[@"allitemsunlocked"]:get()
		else
			f53_local13 = false
		end
		f53_local12.isLocked = f53_local13
		f53_local11.models = f53_local12
		f53_local11.properties = {
			ctChallenge = true,
		}
		f53_local9(f53_local10, f53_local11)
	end
end
CoD.ChallengesUtility.GetGeneralCallingCards = function(f54_arg0, f54_arg1)
	local f54_local0 = {}
	CoD.ChallengesUtility.AddDefaultCallingCardsToList(f54_arg0, f54_local0)
	if IsOnlineGame() then
		if not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
			CoD.ChallengesUtility.AddGlobalChallengesToList(f54_arg0, f54_local0)
		end
		CoD.ChallengesUtility.AddCombatTrainingChallengesToList(f54_arg0, f54_local0)
	end
	for f54_local4, f54_local5 in ipairs(f54_local0) do
		f54_local5.index = f54_local4
	end
	if f54_arg1 then
		table.sort(f54_local0, function(f55_arg0, f55_arg1)
			local f55_local0 = f55_arg0.models
			local f55_local1 = f55_arg1.models
			if f55_local0.isLocked ~= f55_local1.isLocked then
				return f55_local1.isLocked
			else
				return tonumber(f55_arg0.index) < tonumber(f55_arg1.index)
			end
		end)
	end
	return f54_local0
end
DataSources.CallingCardsSorted = DataSourceHelpers.ListSetup("CallingCardsSorted", function(f56_arg0)
	local f56_local0 = Engine.GetGlobalModel()
	f56_local0 = f56_local0.callingCardCategory:get()
	local f56_local1 = {}
	if f56_local0 == "mp" then
		f56_local1 = CoD.ChallengesUtility.GetChallengeCardsForSessionMode(f56_arg0, Enum.eModes.mode_multiplayer, f56_local0, true)
	elseif f56_local0 == "zm" then
		f56_local1 = CoD.ChallengesUtility.GetChallengeCardsForSessionMode(f56_arg0, Enum.eModes.mode_zombies, f56_local0, true)
	elseif f56_local0 == "wz" then
		f56_local1 = CoD.ChallengesUtility.GetChallengeCardsForSessionMode(f56_arg0, Enum.eModes.mode_warzone, f56_local0, true)
	elseif f56_local0 == "general" then
		f56_local1 = CoD.ChallengesUtility.GetGeneralCallingCards(f56_arg0, true)
	elseif f56_local0 == "masters" then
		f56_local1 = CoD.ChallengesUtility.GetMasteryChallengeCards(f56_arg0, true)
	end
	for f56_local5, f56_local6 in pairs(f56_local1) do
		if not f56_local6.properties then
			f56_local6.properties = {}
		end
		if f56_local6.properties.globalChallenge == nil then
			f56_local6.properties.globalChallenge = false
		end
		if f56_local6.properties.ctChallenge == nil then
			f56_local6.properties.ctChallenge = false
		end
		if f56_local6.properties.isPrestige == nil then
			f56_local6.properties.isPrestige = false
		end
		if f56_local6.properties.isRank == nil then
			f56_local6.properties.isRank = false
		end
		f56_local6.properties.category = f56_local0
		if f56_local6.properties.trialUnlocked then
			f56_local6.models.trialLocked = false
		else
			f56_local6.models.trialLocked = Engine[@"hash_5CB675CA7856DA25"]()
		end
	end
	if #f56_local1 > 0 then
		f56_local1[1].properties.selectIndex = true
	end
	return f56_local1
end, true)
CoD.ChallengesUtility.AddGlobalChallengesToList = function(f57_arg0, f57_arg1)
	local f57_local0 = "gamedata/stats/GlobalChallenges.csv"
	local f57_local1 = "gamedata/emblems/backgrounds.csv"
	local f57_local2 = 1
	local f57_local3 = 3
	local f57_local4 = 4
	local f57_local5 = CoD.isPC
	if f57_local5 then
		f57_local5 = CoD.PCKoreaUtility.ShowKorea15Plus()
	end
	local f57_local6 = 19
	local f57_local7 = 1
	local f57_local8 = 2
	local f57_local9 = 3
	local f57_local10 = 4
	local f57_local11 = 5
	local f57_local12 = 6
	local f57_local13 = 7
	local f57_local14 = 8
	local f57_local15 = 9
	local f57_local16 = Engine.StorageGetBuffer(f57_arg0, Enum.StorageFileType[@"hash_5D5A7695E03A7A90"])
	local f57_local17 = Engine.StorageGetBuffer(f57_arg0, Enum.StorageFileType[@"hash_A57D6164B91A8FC"])
	local f57_local18 = Engine.StorageGetBuffer(f57_arg0, Enum.StorageFileType[@"hash_1AB0E693244221BC"])
	local f57_local19 = 0
	local f57_local20 = 0
	while true do
		local f57_local21 = tonumber(Engine[@"hash_4C6F8EC444864600"](f57_local0, f57_local20, f57_local7))
		local f57_local22 = tonumber(Engine[@"hash_4C6F8EC444864600"](f57_local0, f57_local20, f57_local8))
		local f57_local23 = tonumber(Engine[@"hash_4C6F8EC444864600"](f57_local0, f57_local20, f57_local9))
		local f57_local24 = Engine[@"hash_4C6F8EC444864600"](f57_local0, f57_local20, f57_local10)
		local f57_local25 = Engine[@"hash_4C6F8EC444864600"](f57_local0, f57_local20, f57_local11)
		local f57_local26 = Engine[@"hash_4C6F8EC444864600"](f57_local0, f57_local20, f57_local12)
		local f57_local27 = Engine[@"hash_4C6F8EC444864600"](f57_local0, f57_local20, f57_local13)
		local f57_local28 = Engine[@"hash_4C6F8EC444864600"](f57_local0, f57_local20, f57_local14)
		local f57_local29 = nil
		if f57_local5 then
			f57_local29 = Engine.TableLookup(f57_local1, f57_local6, f57_local4, f57_local28)
		end
		if not f57_local29 or f57_local29 == 0x0 then
			f57_local29 = Engine.TableLookup(f57_local1, f57_local3, f57_local4, f57_local28)
		end
		local f57_local30 = Engine.TableLookup(f57_local1, f57_local2, f57_local4, f57_local28)
		if f57_local21 == 0 then
			local f57_local31 = f57_local19 / f57_local20
			local f57_local32 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f57_local19, f57_local20)
			DataSources.MasterCallingCard.setModelValues(f57_arg0, Engine[@"hash_4F9F1239CFD921FE"](f57_local27), Engine[@"hash_4F9F1239CFD921FE"](f57_local28), f57_local29, f57_local31, f57_local32)
			local f57_local33 = {}
			local f57_local34 = {
				title = Engine[@"hash_4F9F1239CFD921FE"](f57_local27),
				description = Engine[@"hash_4F9F1239CFD921FE"](f57_local28),
				icon = f57_local29,
				iconId = f57_local30,
				statPercent = Dvar[@"allitemsunlocked"]:get() and 1 or f57_local31,
			}
			local f57_local35
			if f57_local31 < 1 then
				f57_local35 = not Dvar[@"allitemsunlocked"]:get()
			else
				f57_local35 = false
			end
			f57_local34.isLocked = f57_local35
			f57_local34.statFractionText = f57_local32
			f57_local34.xp = 0
			f57_local34.isWZ = false
			f57_local33.models = f57_local34
			return f57_local33
		else
			local f57_local31
			if f57_local26 ~= 0x0 then
				f57_local31 = {
					f57_local24,
					f57_local25,
					f57_local26,
				}
				if not f57_local31 then
				else
					local f57_local32, f57_local33, f57_local34 = nil
					local f57_local35 = false
					if f57_local24 ~= 0x0 then
						f57_local32 = CoD.PlayerStatsUtility.HashStorageLookup(f57_local16, f57_local31)
						f57_local33 = CoD.PlayerStatsUtility.HashStorageLookup(f57_local17, f57_local31)
						f57_local34 = CoD.PlayerStatsUtility.HashStorageLookup(f57_local18, f57_local31)
						if f57_local25 == "rank" then
							f57_local35 = true
							f57_local21 = f57_local21 - 1
							f57_local22 = f57_local22 - 1
							f57_local23 = f57_local23 - 1
							if f57_local24 == "playerstatslist" then
								local f57_local36 = "plevel"
								local f57_local37
								if f57_local26 ~= 0x0 then
									f57_local37 = {
										f57_local24,
										f57_local36,
										f57_local26,
									}
									if not f57_local37 then
									else
										local f57_local38 = CoD.PlayerStatsUtility.HashStorageLookup(f57_local16, f57_local37)
										local f57_local39 = CoD.PlayerStatsUtility.HashStorageLookup(f57_local17, f57_local37)
										if f57_local38 and f57_local38 > 0 then
											f57_local32 = f57_local21
										end
										if f57_local39 and f57_local39 > 0 then
											f57_local33 = f57_local22
										end
									end
								end
								f57_local37 = {
									f57_local24,
									f57_local36,
								}
							end
						elseif f57_local25 == "weapon_launcher" then
							f57_local32 = CoD.PlayerStatsUtility.HashStorageLookup(f57_local16, {
								"playerstatslist",
								@"hash_BE93D1227E6DB1",
							})
						end
					else
						local f57_local36 = DataSources.ChallengesMPCategoryStats.getModel(f57_arg0)
						if f57_local36.mp.percentComplete:get() > 0 then
							local f57_local40 = 1
						end
						f57_local32 = f57_local40 or 0
						f57_local36 = DataSources.ChallengesZMCategoryStats.getModel(f57_arg0)
						if f57_local36.zm.percentComplete:get() > 0 then
							local f57_local41 = 1
						end
						f57_local33 = f57_local41 or 0
						f57_local36 = DataSources.ChallengesWZCategoryStats.getModel(f57_arg0)
						if f57_local36.wz.percentComplete:get() > 0 then
							local f57_local42 = 1
						end
						f57_local34 = f57_local42 or 0
					end
					if not f57_local32 then
						f57_local32 = 0
					end
					if not f57_local33 then
						f57_local33 = 0
					end
					if not f57_local34 then
						f57_local34 = 0
					end
					if f57_local21 < f57_local32 then
						f57_local32 = f57_local21
					end
					if f57_local22 < f57_local33 then
						f57_local33 = f57_local22
					end
					if f57_local23 < f57_local34 then
						f57_local34 = f57_local23
					end
					local f57_local36 = (f57_local32 + f57_local33 + f57_local34) / (f57_local21 + f57_local22 + f57_local23)
					if f57_local36 == 1 then
						f57_local19 = f57_local19 + 1
					end
					local f57_local37 = f57_local32 / f57_local21
					local f57_local38 = f57_local33 / f57_local22
					local f57_local39 = f57_local34 / f57_local23
					local f57_local43
					if f57_local37 == 1 then
						f57_local43 = 1
						if not f57_local43 then
						else
							local f57_local44
							if f57_local38 == 1 then
								f57_local44 = 1
								if not f57_local44 then
								else
									local f57_local45
									if f57_local39 == 1 then
										f57_local45 = 1
										if not f57_local45 then
										else
											local f57_local46 = f57_local43 + f57_local44 + f57_local45
											local f57_local47, f57_local48, f57_local49 = nil
											if not f57_local35 then
												if f57_local37 < 1 then
													local f57_local50 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f57_local32, f57_local21)
												end
												f57_local47 = f57_local50 or Engine[@"hash_4F9F1239CFD921FE"](@"hash_2459775A6A6CBBF4")
												if f57_local38 < 1 then
													local f57_local51 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f57_local33, f57_local22)
												end
												f57_local48 = f57_local51 or Engine[@"hash_4F9F1239CFD921FE"](@"hash_2459775A6A6CBBF4")
												if f57_local39 < 1 then
													local f57_local52 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f57_local34, f57_local23)
												end
												f57_local49 = f57_local52 or Engine[@"hash_4F9F1239CFD921FE"](@"hash_2459775A6A6CBBF4")
											else
												f57_local47 = f57_local32 + 1
												f57_local48 = f57_local33 + 1
												f57_local49 = f57_local34 + 1
											end
											local f57_local53 = table.insert
											local f57_local54 = f57_arg1
											local f57_local55 = {}
											local f57_local56 = {
												mpProgress = {
													current = f57_local32,
													target = f57_local21,
													percent = f57_local37,
													statFractionText = f57_local47,
												},
												zmProgress = {
													current = f57_local33,
													target = f57_local22,
													percent = f57_local38,
													statFractionText = f57_local48,
												},
												wzProgress = {
													current = f57_local34,
													target = f57_local23,
													percent = f57_local39,
													statFractionText = f57_local49,
												},
												title = Engine[@"hash_4F9F1239CFD921FE"](f57_local27),
												description = Engine[@"hash_4F9F1239CFD921FE"](f57_local28),
												icon = f57_local29,
												iconId = f57_local30,
												statPercent = Dvar[@"allitemsunlocked"]:get() and 1 or f57_local36,
											}
											local f57_local57
											if f57_local36 < 1 then
												f57_local57 = not Dvar[@"allitemsunlocked"]:get()
											else
												f57_local57 = false
											end
											f57_local56.isLocked = f57_local57
											f57_local56.statFractionText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f57_local46, 3)
											f57_local55.models = f57_local56
											f57_local55.properties = {
												globalChallenge = true,
											}
											f57_local53(f57_local54, f57_local55)
											f57_local20 = f57_local20 + 1
										end
									end
									f57_local45 = 0
								end
							end
							f57_local44 = 0
						end
					end
					f57_local43 = 0
				end
			end
		end
		f57_local31 = {
			f57_local24,
			f57_local25,
		}
	end
end
CoD.ChallengesUtility.UpdateCallingCardProfilerType = function(f58_arg0, f58_arg1)
	local f58_local0 = Engine.GetModelForController(f58_arg0)
	if f58_arg1.globalChallenge then
		f58_local0.hudItems.callingCardProfilingType:set("global")
	elseif f58_arg1.ctChallenge then
		f58_local0.hudItems.callingCardProfilingType:set("ct")
	elseif f58_arg1.isPrestige then
		f58_local0.hudItems.callingCardProfilingType:set("prestige")
	elseif f58_arg1.isRank then
		f58_local0.hudItems.callingCardProfilingType:set("prestige")
	else
		f58_local0.hudItems.callingCardProfilingType:set("default")
	end
	if f58_arg1.isMastery then
		f58_local0.hudItems.profilingMasterCallingCard:set(1)
	else
		f58_local0.hudItems.profilingMasterCallingCard:set(0)
	end
end
DataSources.CallingCardsGlobalChallenges = DataSourceHelpers.ListSetup("CallingCardsGlobalChallenges", function(f59_arg0)
	local f59_local0 = {}
	CoD.ChallengesUtility.AddGlobalChallengesToList(f59_arg0, f59_local0)
	return f59_local0
end)
DataSources.ChallengesNearCompletionList = DataSourceHelpers.ListSetup("ChallengesNearCompletionList", function(f60_arg0)
	local f60_local0 = {}
	local f60_local1 = CoD.ChallengesUtility.GetGameModeInfo()
	if not f60_local1 then
		return f60_local0
	end
	local f60_local2 = function(f61_arg0, f61_arg1)
		return tonumber(f61_arg0.imageID) < tonumber(f61_arg1.imageID)
	end
	if CoD.ChallengesUtility.NearCompletionLists[f60_local1.index] ~= nil then
		return CoD.ChallengesUtility.NearCompletionLists[f60_local1.index]
	end
	local f60_local3 = CoD.ChallengesUtility.GetChallengeTable(f60_arg0, f60_local1.index, f60_local1.name, nil, f60_local2)
	table.sort(f60_local3, function(f62_arg0, f62_arg1)
		if f62_arg0.models.statPercent ~= f62_arg1.models.statPercent then
			return f62_arg1.models.statPercent < f62_arg0.models.statPercent
		else
			return f62_arg0.models.iconId < f62_arg1.models.iconId
		end
	end)
	for f60_local7, f60_local8 in ipairs(f60_local3) do
		if not f60_local8.properties.isMastery and not f60_local8.properties.isDarkOps and f60_local8.models.statPercent < 1 then
			table.insert(f60_local0, f60_local8)
			if CoD.ChallengesUtility.NearCompletionMaxNumChallengesShown <= #f60_local0 then
				break
			end
		end
	end
	CoD.ChallengesUtility.NearCompletionLists[f60_local1.index] = f60_local0
	return f60_local0
end)
DataSources.WZAARChallengeContainerList = DataSourceHelpers.ListSetup("WZAARChallengeContainerList", function(f63_arg0, f63_arg1)
	local f63_local0 = {}
	if not IsOnlineGame() then
		return f63_local0
	end
	local f63_local1 = CoD.ChallengesUtility.GetGameModeInfo()
	if not f63_local1 then
		return f63_local0
	end
	local f63_local2 = CoD.ChallengesUtility.GetChallengeTable(f63_arg0, f63_local1.index, f63_local1.name, nil, function(f64_arg0, f64_arg1)
		return tonumber(f64_arg0.imageID) < tonumber(f64_arg1.imageID)
	end)
	if not f63_arg1._challengePreMatchModels then
		f63_arg1._challengePreMatchModels = {}
		for f63_local6, f63_local7 in ipairs(f63_local2) do
			f63_local7.models.tierCompleted = false
			f63_arg1._challengePreMatchModels[f63_local7.models.iconId] = f63_local7.models
		end
	else
		for f63_local6, f63_local7 in ipairs(f63_local2) do
			local f63_local8 = f63_arg1._challengePreMatchModels[f63_local7.models.iconId]
			if f63_local8.currentTier < f63_local7.models.currentTier then
				f63_local7.models = f63_local8
				f63_local7.models.tierCompleted = true
				f63_local7.models.statPercent = 1
			end
		end
	end
	table.sort(f63_local2, function(f65_arg0, f65_arg1)
		local f65_local0
		if f65_arg0.models.prevStatPercent >= 1 or f65_arg0.models.statPercent < 1 then
			f65_local0 = false
		else
			f65_local0 = true
		end
		local f65_local1
		if f65_arg1.models.prevStatPercent >= 1 or f65_arg1.models.statPercent < 1 then
			f65_local1 = false
		else
			f65_local1 = true
		end
		if f65_local0 ~= f65_local1 then
			return f65_local0
		else
			local f65_local2 = f65_arg0.models.statPercent - f65_arg0.models.prevStatPercent
			local f65_local3 = f65_arg1.models.statPercent - f65_arg1.models.prevStatPercent
			if f65_local2 ~= f65_local3 then
				return f65_local3 < f65_local2
			elseif f65_arg0.models.statPercent ~= f65_arg1.models.statPercent then
				return f65_arg1.models.statPercent < f65_arg0.models.statPercent
			else
				return f65_arg0.models.iconId < f65_arg1.models.iconId
			end
		end
	end)
	for f63_local6, f63_local7 in ipairs(f63_local2) do
		if not f63_local7.properties.isMastery and f63_local7.models.prevStatPercent < 1 then
			if f63_local7.properties.isDarkOps then
				if f63_local7.models.statPercent >= 1 then
					f63_local7.models.isContract = false
					f63_local7.models.title = Engine[@"hash_4F9F1239CFD921FE"](f63_local7.models.title)
					table.insert(f63_local0, f63_local7)
					if #f63_local0 >= 3 then
						break
					end
				end
			end
			f63_local7.models.isContract = false
			f63_local7.models.title = Engine[@"hash_4F9F1239CFD921FE"](f63_local7.models.title)
			table.insert(f63_local0, f63_local7)
			if #f63_local0 >= 3 then
				break
			end
		end
	end
	f63_local3 = DataSources.Contracts.getModel(f63_arg0)
	f63_local3 = f63_local3.dailyActive
	f63_local4 = DataSources.Contracts.getModel(f63_arg0)
	f63_local4 = f63_local4.contractSlot1
	f63_local5 = DataSources.Contracts.getModel(f63_arg0)
	f63_local5 = f63_local5.contractSlot2
	f63_local6 = function(f66_arg0)
		if not f66_arg0 then
			return
		elseif f66_arg0.progressRatioIngame:get() - f66_arg0.progressRatio:get() > 0 then
			for f66_local7, f66_local8 in ipairs(f63_local0) do
				local f66_local3 = false
				if f66_local8.models.isContract then
					if f66_local8.models.statPercent == f66_arg0.progressRatioIngame:get() then
						f66_local3 = f66_local8.models.xp < f66_arg0.xpReward:get()
					else
						f66_local3 = f66_local8.models.statPercent < f66_arg0.progressRatioIngame:get()
					end
				elseif f66_local8.models.statPercent >= 1 then
					f66_local3 = f66_arg0.progressRatioIngame:get() >= 1
				else
					f66_local3 = true
				end
				if f66_local3 then
					for f66_local4 = #f63_local0, f66_local7 + 1, -1 do
						f63_local0[f66_local4].models = f63_local0[f66_local4 - 1].models
					end
					f63_local0[f66_local7].models = {
						title = Engine[@"hash_4F9F1239CFD921FE"](f66_arg0.displayName:get()),
						description = f66_arg0.description:get(),
						xp = f66_arg0.xpReward:get(),
						statPercent = f66_arg0.progressRatioIngame:get(),
						prevStatPercent = f66_arg0.progressRatio:get(),
						statFractionText = f66_arg0.progressRatioText:get(),
						rewardIcon = f66_arg0.rewardIcon:get(),
						cases = f66_arg0.rewardAmount:get(),
						isContract = true,
						maxTier = 0x0,
					}
					return
				end
			end
		end
	end
	f63_local6(f63_local3)
	f63_local6(f63_local4)
	f63_local6(f63_local5)
	if #f63_local0 > 0 then
		f63_local7 = Engine.GetModelForController(f63_arg0)
		local f63_local8 = f63_local7.hudItems.warzone:create("wzAAR.challengeProgEarned")
		f63_local8:set(true)
	end
	return f63_local0
end)
DataSources.DarkOpsCallingCards = DataSourceHelpers.ListSetup("DarkOpsCallingCards", function(f67_arg0)
	local f67_local0 = {}
	local f67_local1 = CoD.ChallengesUtility.GetGameModeInfo()
	local f67_local2 = CoD.ChallengesUtility.AddDarkOpsChallengeCardsToList(f67_arg0, f67_local1.index, f67_local1.name, f67_local0)
	if f67_local2 then
		local f67_local3 = f67_local2.models
		DataSources.MasterCallingCard.setModelValues(f67_arg0, f67_local3.title, f67_local3.description, f67_local3.icon, f67_local3.percentComplete, f67_local3.statFractionText)
	end
	return f67_local0
end)
CoD.ChallengesUtility.AddDarkOpsChallengeCardsToList = function(f68_arg0, f68_arg1, f68_arg2, f68_arg3)
	local f68_local0 = CoD.ChallengesUtility.GetChallengeTable(f68_arg0, f68_arg1, f68_arg2, "darkops", function(f69_arg0, f69_arg1)
		return tonumber(f69_arg0.imageID) < tonumber(f69_arg1.imageID)
	end)
	local f68_local1 = 0
	local f68_local2 = 0
	local f68_local3 = nil
	for f68_local7, f68_local8 in ipairs(f68_local0) do
		local f68_local9 = f68_local8.models
		if f68_local8.properties.isMastery then
			f68_local3 = f68_local8
		end
		table.insert(f68_arg3, f68_local8)
		f68_local2 = f68_local2 + 1
		if not f68_local9.isLocked then
			f68_local1 = f68_local1 + 1
		end
	end
	if f68_local3 then
		f68_local4 = f68_local3.models
		f68_local5 = {}
		f68_local6 = {
			title = f68_local4.title,
			description = f68_local4.description,
			iconId = f68_local4.iconId,
			icon = f68_local4.icon,
			percentComplete = f68_local1 / f68_local2,
			statFractionText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f68_local1, f68_local2),
		}
		if f68_local1 < f68_local2 then
			f68_local7 = not Dvar[@"allitemsunlocked"]:get()
		else
			f68_local7 = false
		end
		f68_local6.isLocked = f68_local7
		f68_local5.models = f68_local6
		return f68_local5
	else
	end
end
CoD.ChallengesUtility.GetCTChallengeTable = function(f70_arg0)
	local f70_local0 = {}
	for f70_local1 = 1, CoD.CTUtility.NumCTChallenges, 1 do
		local f70_local4, f70_local5, f70_local6, f70_local7, f70_local8, f70_local9 = CoD.CTUtility.GetCTChallenge(f70_arg0, f70_local1)
		if not f70_local6 then
			f70_local9 = 0
		end
		local f70_local10 = table.insert
		local f70_local11 = f70_local0
		local f70_local12 = {}
		local f70_local13 = {
			title = f70_local7,
			description = f70_local8,
			iconId = f70_local9,
			icon = CoD.ChallengesUtility.GetBackgroundByID(f70_local9),
			statPercent = Dvar[@"allitemsunlocked"]:get() and 1 or f70_local4 / f70_local5,
			statFractionText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f70_local4, f70_local5),
		}
		local f70_local14
		if not f70_local6 then
			f70_local14 = not Dvar[@"allitemsunlocked"]:get()
		else
			f70_local14 = false
		end
		f70_local13.isLocked = f70_local14
		f70_local12.models = f70_local13
		f70_local10(f70_local11, f70_local12)
	end
	return f70_local0
end
DataSources.CombatTrainingCallingCards = DataSourceHelpers.ListSetup("CombatTrainingCallingCards", function(f71_arg0)
	local f71_local0 = {}
	return CoD.ChallengesUtility.GetCTChallengeTable(f71_arg0)
end)
DataSources.CallingCardsBlackMarket = DataSourceHelpers.ListSetup("CallingCardsBlackMarket", function(f72_arg0)
	local f72_local0 = {}
	for f72_local5, f72_local6 in ipairs(CoD.BlackMarketUtility.CommonCallingCardsTable) do
		local f72_local7 = table.insert
		local f72_local8 = f72_local0
		local f72_local9 = {}
		local f72_local10 = {
			displayName = f72_local6.displayName,
			rarity = f72_local6.rarity,
			iconId = f72_local6.iconId,
			category = @"menu/calling_card",
			setInfo = "",
			unlockInfo = f72_local6.lootInfo.unlockInfo or "",
		}
		local f72_local4 = f72_local6.lootInfo.owned
		if not f72_local4 then
			f72_local4 = not f72_local6.lootInfo.isLoot
		end
		f72_local10.owned = f72_local4
		f72_local4 = f72_local6.lootInfo.available
		if not f72_local4 then
			f72_local4 = not f72_local6.lootInfo.isLoot
		end
		f72_local10.available = f72_local4
		f72_local9.models = f72_local10
		f72_local9.properties = {
			category = "loot",
			subCategory = "lootSingleSet",
		}
		f72_local7(f72_local8, f72_local9)
	end
	table.sort(f72_local0, function(f73_arg0, f73_arg1)
		if f73_arg0.models.owned ~= f73_arg1.models.owned then
			return f73_arg0.models.owned
		else
			return f73_arg0.models.iconId < f73_arg1.models.iconId
		end
	end)
	return f72_local0
end)
DataSources.CallingCardSetBlackMarket = DataSourceHelpers.ListSetup("CallingCardSetBlackMarket", function(f74_arg0, f74_arg1)
	local f74_local0 = {}
	local f74_local1 = DataSources.EmblemCallingCardBreadcrumbs.getModel(f74_arg0)
	local f74_local2 = function(f75_arg0, f75_arg1, f75_arg2, f75_arg3, f75_arg4)
		CoD.perController[f75_arg2].callingCardSetRef = f75_arg3.setRef
		CoD.perController[f75_arg2].isBlackMarketCallingCardNonSet = f75_arg3.nonSet == true
		local f75_local0 = OpenOverlay(f75_arg4, "CallingCards_BlackMarket", f75_arg2, {
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f75_arg2, Enum.eModes.mode_multiplayer),
		})
		f75_local0.callingCardShowcaseSlot = f75_arg4.callingCardShowcaseSlot
		f75_local0.callingCardShowcaseIsBM = true
	end
	DataSources.EmblemCallingCardBreadcrumbs.updateCallingCardLootSingleCardSetBreadcrumbs(f74_arg1.menu, f74_arg0)
	if #CoD.BlackMarketUtility.CommonCallingCardsTable > 0 then
		table.insert(f74_local0, {
			models = {
				setInfo = "",
				rarity = Enum.LootRarityType[@"loot_rarity_type_count"],
				iconId = 0,
				category = 0x0,
				numOwned = 0,
				nonSet = true,
				skipDefaultTitle = true,
				breadcrumb = f74_local1.lootSingleSet,
			},
			properties = {
				action = f74_local2,
				actionParam = {
					nonSet = true,
				},
			},
		})
	end
	for f74_local8, f74_local9 in pairs(CoD.BlackMarketUtility.CallingCardsTable) do
		local f74_local6 = nil
		if f74_local9.bonusCardInfo and f74_local9.bonusCardInfo.iconId and f74_local9.breadcrumbCount then
			f74_local6 = f74_local1:create(f74_local9.bonusCardInfo.iconId)
			local f74_local7 = f74_local6:create("breadcrumbCount")
			f74_local7:set(f74_local9.breadcrumbCount)
		end
		table.insert(f74_local0, {
			models = {
				setInfo = f74_local9.setInfoString,
				rarity = f74_local9.rarity,
				iconId = f74_local9.iconId,
				category = 0x0,
				numOwned = f74_local9.numOwned,
				breadcrumb = f74_local6,
			},
			properties = {
				action = f74_local2,
				actionParam = {
					setRef = f74_local9.setRef,
				},
			},
		})
	end
	return f74_local0
end, true)
DataSourceHelpers.PerControllerDataSourceSetup(
	"CallingCardsBlackMarketMasterCard",
	"CallingCardsBlackMarketMasterCard",
	function(f76_arg0, f76_arg1)
		f76_arg0:create("displayName")
		f76_arg0:create("setInfo")
		f76_arg0:create("unlockInfo")
		f76_arg0:create("rarity")
		f76_arg0:create("iconId")
		f76_arg0:create("category")
		f76_arg0:create("owned")
		f76_arg0:create("available")
		f76_arg0:create("categoryTab")
	end,
	true,
	{
		setModelValues = function(f77_arg0, f77_arg1)
			local f77_local0 = Engine.GetModelForController(f77_arg0)
			f77_local0 = f77_local0.CallingCardsBlackMarketMasterCard
			if f77_local0 == nil then
				f77_local0 = DataSources.CallingCardsBlackMarketMasterCard.getModel(f77_arg0)
			end
			local f77_local1 = f77_arg1.bonusCardInfo
			if f77_local1 then
				f77_local0.displayName:set(f77_local1.displayName)
				f77_local0.setInfo:set(f77_local1.setInfoString)
				f77_local0.unlockInfo:set(f77_local1.lootInfo.unlockInfo)
				f77_local0.rarity:set(f77_local1.rarity)
				f77_local0.iconId:set(f77_local1.iconId)
				f77_local0.category:set(@"menu/calling_card")
				f77_local0.owned:set(f77_local1.lootInfo.owned)
				f77_local0.available:set(f77_local1.lootInfo.available)
				f77_local0.categoryTab:set("loot")
			end
		end,
	}
)
DataSources.CallingCardsBlackMarketCardSet = DataSourceHelpers.ListSetup("CallingCardsBlackMarketCardSet", function(f78_arg0)
	local f78_local0 = {}
	local f78_local1 = {}
	if CoD.perController[f78_arg0].callingCardSetRef then
		f78_local1 = CoD.BlackMarketUtility.GetCallingCardSetTable(CoD.perController[f78_arg0].callingCardSetRef)
	end
	if f78_local1 and f78_local1.callingCards then
		local f78_local2 = f78_local1.bonusCardInfo
		for f78_local11, f78_local12 in ipairs(f78_local1.callingCards) do
			if not f78_local12.lootInfo.setMaster then
				local f78_local6 = table.insert
				local f78_local7 = f78_local0
				local f78_local8 = {}
				local f78_local9 = {
					displayName = f78_local12.displayName,
					rarity = f78_local12.rarity,
					iconId = f78_local12.iconId,
					category = @"menu/calling_card",
					setInfo = f78_local1.setInfoString,
					unlockInfo = f78_local12.lootInfo.unlockInfo or "",
				}
				local f78_local10 = f78_local12.lootInfo.owned
				if not f78_local10 then
					f78_local10 = not f78_local12.lootInfo.isLoot
				end
				f78_local9.owned = f78_local10
				f78_local10 = f78_local12.lootInfo.available
				if not f78_local10 then
					f78_local10 = not f78_local12.lootInfo.isLoot
				end
				f78_local9.available = f78_local10
				f78_local8.models = f78_local9
				f78_local8.properties = {
					category = "loot",
					breadcrumbModelName = f78_local2 and f78_local2.iconId,
				}
				f78_local6(f78_local7, f78_local8)
			end
		end
	end
	if not LuaUtils.IsTableEmpty(f78_local1) then
		DataSources.CallingCardsBlackMarketMasterCard.setModelValues(f78_arg0, f78_local1)
	end
	return f78_local0
end, true)
DataSources.CallingCardsTabs = ListHelper_SetupDataSource("CallingCardsTabs", function(f79_arg0, f79_arg1)
	local f79_local0 = {}
	local f79_local1 = DataSources.EmblemCallingCardBreadcrumbs.getModel(f79_arg0)
	local f79_local2 = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3)
		local f80_local0 = nil
		if f79_local1 and f79_local1["callingcards_" .. f80_arg2] then
			f80_local0 = f79_local1["callingcards_" .. f80_arg2]
		end
		table.insert(f79_local0, {
			models = {
				name = f80_arg0,
				tabWidget = f80_arg1,
				breadcrumb = f80_local0,
				tabCategory = f80_arg2,
				available = f80_arg3,
			},
		})
	end
	f79_local2(@"menu/general", "CoD.CallingCardsStickerbook", "general", true)
	if IsOnlineGame() then
		f79_local2("menu/multiplayer", "CoD.CallingCardsStickerbook", "mp", true)
		if not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
			f79_local2("menu/zombies", "CoD.CallingCardsStickerbook", "zm", true)
		end
		f79_local2("menu/warzone", "CoD.CallingCardsStickerbook", "wz", true)
		f79_local2(@"menu/masters", "CoD.CallingCardsStickerbook", "masters", true)
		if CoD.BlackMarketUtility.BuildCallingCardSets(f79_arg0, f79_arg1.menu) then
			f79_local2(@"menu/black_market", "CoD.CallingCards_Set_BlackMarket", "loot", true)
		end
	end
	return f79_local0
end, true)
CoD.ChallengesUtility.GetEmblemBackgroundImageText = function(f81_arg0, f81_arg1)
	local f81_local0, f81_local1 = Engine.GetChallengeUnlockEmblemInfo(f81_arg0, f81_arg1)
	if f81_local0 < 0 then
		return f81_local1
	end
	local f81_local2 = @"menu/calling_card"
	local f81_local3 = CoD.backgroundsTable
	local f81_local4 = {
		15,
		11,
		3,
	}
	if f81_local1 then
		f81_local3 = CoD.emblemIconsTable
		f81_local2 = @"menu/emblem"
		f81_local4 = {
			3,
		}
		if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
			table.insert(f81_local4, 1, 13)
		end
	elseif CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		table.insert(f81_local4, 1, 18)
	end
	local f81_local5 = 0x0
	for f81_local9, f81_local10 in ipairs(f81_local4) do
		f81_local5 = Engine[@"hash_4C6F8EC444864600"](f81_local3, f81_local0, f81_local10)
		if f81_local5 ~= 0x0 then
			break
		end
	end
	return f81_local1, f81_local5, f81_local2
end
CoD.ChallengesUtility.IsSpecialistTransmissionChallenge = function(f82_arg0, f82_arg1, f82_arg2)
	if f82_arg0 == Enum.statsMilestoneTypes_t[@"milestone_specialist"] then
		if LUI.startswith(Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(f82_arg1 + 1), f82_arg2, Enum.milestoneTableColumns_t[@"milestone_column_statname"]), "transmission") then
			return true
		end
	elseif f82_arg0 == Enum.statsMilestoneTypes_t[@"milestone_global"] then
		local f82_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(f82_arg1 + 1), f82_arg2, Enum.milestoneTableColumns_t[@"milestone_column_statname"])
		if f82_local0 == "specialist_transmissions" or f82_local0 == "hero_transmissions" then
			return true
		end
	end
	return false
end
CoD.ChallengesUtility.IsTerribleKnifeChallenge = function(f83_arg0, f83_arg1, f83_arg2)
	if f83_arg0 == Enum.statsMilestoneTypes_t[@"milestone_group"] and Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(f83_arg1 + 1), f83_arg2, Enum.milestoneTableColumns_t[@"milestone_column_include"]) == "weapon_knife" then
		return true
	else
		return false
	end
end
CoD.ChallengesUtility.IsHiddenPostShipChallenge = function(f84_arg0, f84_arg1, f84_arg2)
	local f84_local0 = {
		"melee_knuckles",
		"melee_butterfly",
		"melee_wrench",
		"pistol_shotgun",
		"melee_crowbar",
		"melee_sword",
		"ar_garand",
		"special_crossbow",
	}
	local f84_local1 = {
		"_gold",
		"_for_diamond",
	}
	local f84_local2 = Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(f84_arg1 + 1), f84_arg2, Enum.milestoneTableColumns_t[@"milestone_column_challengestatname"])
	for f84_local9, f84_local10 in ipairs(f84_local0) do
		for f84_local6, f84_local7 in ipairs(f84_local1) do
			if f84_local2 == f84_local10 .. f84_local7 then
				return true
			end
		end
	end
	f84_local3 = Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(f84_arg1 + 1), f84_arg2, Enum.milestoneTableColumns_t[@"milestone_column_include"])
	if f84_local2 == "weapons_mastery" and f84_local3 ~= "knife_loadout" then
		return true
	elseif f84_local2 == "secondary_mastery" and f84_local3 ~= "weapon_knife" then
		return true
	else
		return false
	end
end
CoD.ChallengesUtility.SpecialistRewardTiers = LuaEnum.createEnum("Default", "Epic", "CompletionEpic")
CoD.ChallengesUtility.CamoRewardTiers = LuaEnum.createEnum("Default", "Gold", "Diamond", "DarkMatter")
CoD.ChallengesUtility.EmblemRewardTiers = LuaEnum.createEnum("Default", "Mastery")
CoD.ChallengesUtility.DefaultRewardTiers = LuaEnum.createEnum("Default")
CoD.ChallengesUtility.GetChallengeRewardDisplayTier = function(f85_arg0)
	local f85_local0 = CoD.ChallengesUtility.DefaultRewardTiers.Default
	local f85_local1 = ""
	if IsMultiplayer() then
		if f85_arg0.camoInfo then
			f85_local1 = "camo"
			if f85_arg0.camoInfo.camoRef == "camo_darkmatter" then
				f85_local0 = CoD.ChallengesUtility.CamoRewardTiers.DarkMatter
			elseif f85_arg0.camoInfo.camoRef == "camo_diamond" then
				f85_local0 = CoD.ChallengesUtility.CamoRewardTiers.Diamond
			elseif f85_arg0.camoInfo.camoRef == "camo_gold" then
				f85_local0 = CoD.ChallengesUtility.CamoRewardTiers.Gold
			else
				f85_local0 = CoD.ChallengesUtility.CamoRewardTiers.Default
			end
		elseif f85_arg0.reticleInfo then
			f85_local1 = "reticle"
		elseif f85_arg0.emblemInfo then
			f85_local1 = "emblem"
			if f85_arg0.emblemInfo.isMastery then
				f85_local0 = CoD.ChallengesUtility.EmblemRewardTiers.Mastery
			else
				f85_local0 = CoD.ChallengesUtility.EmblemRewardTiers.Default
			end
		end
	end
	return f85_local0, f85_local1
end
CoD.ChallengesUtility.GetChallengeRewardIconAndCategoryName = function(f86_arg0)
	local f86_local0 = Engine.CurrentSessionMode()
	if f86_arg0 == "darkops" then
		local f86_local1 = nil
		if f86_local0 == Enum.eModes.mode_multiplayer then
			f86_local1 = "ui_icon_challenges_mpdarkops_large"
		elseif f86_local0 == Enum.eModes.mode_zombies then
			f86_local1 = "ui_icon_challenges_zmdarkops_large"
		else
			f86_local1 = "ui_icon_challenges_wzdarkops_large"
		end
		return f86_local1, @"challenge/darkops"
	end
	local f86_local1 = nil
	if f86_local0 == Enum.eModes.mode_multiplayer then
		f86_local1 = "mp"
	elseif f86_local0 == Enum.eModes.mode_zombies then
		f86_local1 = "zm"
	else
		f86_local1 = "wz"
	end
	for f86_local8, f86_local9 in pairs(CoD.ChallengesUtility.ChallengeCategoryTable[f86_local1]) do
		for f86_local5, f86_local6 in pairs(f86_local9) do
			if f86_local6 == f86_arg0 then
				return @"hash_1CBC192FB58C7151" .. f86_local1 .. f86_local8 .. "_large", CoD.ChallengesUtility.ChallengeCategoryDisplayName[f86_local8]
			end
		end
	end
	return "blacktransparent", "null/empty"
end
CoD.ChallengesUtility.DiamondCamoImages = {
	weapon_assault = "ui_icon_camonotification_diamond_ar",
	weapon_smg = "ui_icon_camonotification_diamond_smg",
	weapon_lmg = "ui_icon_camonotification_diamond_lmg",
	weapon_sniper = "ui_icon_camonotification_diamond_snipers",
	weapon_cqb = "ui_icon_camonotification_diamond_shotguns",
	weapon_tactical = "ui_icon_camonotification_diamond_tactical",
	weapon_pistol = "ui_icon_camonotification_diamond_pistols",
	knife_loadout = "ui_icon_camonotification_diamond_knife",
	bowie_knife = "ui_icon_camonotification_diamond_knife",
	launcher_standard_t8 = "ui_icon_camonotification_diamond_launchers",
	ar_standard_t8 = "ui_icon_camonotification_diamond_ar",
	smg_fastburst_t8 = "ui_icon_camonotification_diamond_smg",
	pistol_fullauto_t8 = "ui_icon_camonotification_diamond_pistols",
	melee_secretsanta_t8 = "ui_icon_camonotification_diamond_knife",
	melee_slaybell_t8 = "ui_icon_camonotification_diamond_knife",
	melee_demohammer_t8 = "ui_icon_camonotification_diamond_knife",
	melee_coinbag_t8_mp = "ui_icon_camonotification_diamond_knife",
	smg_folding_t8 = "ui_icon_camonotification_diamond_smg",
	shotgun_fullauto_t8_mp = "ui_icon_camonotification_diamond_shotguns",
	sniper_mini14_t8 = "ui_icon_camonotification_diamond_snipers",
	melee_cutlass_t8 = "ui_icon_camonotification_diamond_knife",
	melee_club_t8 = "ui_icon_camonotification_diamond_knife",
	ar_peacekeeper_t8 = "ui_icon_camonotification_diamond_ar",
	special_ballisticknife_t8_dw = "ui_icon_camonotification_diamond_knife",
	lmg_stealth_t8 = "ui_icon_camonotification_diamond_lmg",
	sniper_locus_t8 = "ui_icon_camonotification_diamond_snipers",
	tr_flechette_t8 = "ui_icon_camonotification_diamond_tactical",
	ar_galil_t8 = "ui_icon_camonotification_diamond_ar",
	melee_zombiearm_t8 = "ui_icon_camonotification_diamond_knife",
	special_crossbow_t8 = "ui_icon_camonotification_diamond_knife",
	shotgun_precision_t8 = "ui_icon_camonotification_diamond_shotguns",
	sniper_damagesemi_t8 = "ui_icon_camonotification_diamond_snipers",
	tr_damageburst_t8 = "ui_icon_camonotification_diamond_tactical",
}
CoD.ChallengesUtility.ZombiesTrialsExpToMedalImages = {
	[0] = {
		[1000] = "uie_trial_medal_bronze",
		[2000] = "uie_trial_medal_silver",
		[3000] = "uie_trial_medal_gold",
	},
	[1] = {
		[1000] = 0x772C55AAA62BD0,
		[2000] = @"hash_FD6B3DF8A0BA964",
		[3000] = @"hash_18F9261A2CAA7739",
	},
}
CoD.ChallengesUtility.GetChallengeRewardInfo = function(f87_arg0, f87_arg1, f87_arg2, f87_arg3, f87_arg4, f87_arg5)
	local f87_local0 = CoD.getStatsMilestoneTable(f87_arg1 + 1)
	local f87_local1 = Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_string"])
	local f87_local2 = tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_tierid"]))
	local f87_local3 = tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2 + 1, Enum.milestoneTableColumns_t[@"milestone_column_tierid"]))
	local f87_local4 = tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_targetvalue"])) or 0
	local f87_local5 = Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_unlockitem"])
	local f87_local6 = Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_unlockimage"])
	local f87_local7 = Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_unlockheroitem"])
	local f87_local8 = Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_challengestatname"])
	local f87_local9 = false
	local f87_local10 = Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_category"])
	local f87_local11 = tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_xpearned"]))
	local f87_local12 = tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_vialsearned"]))
	local f87_local13 = Engine.CurrentSessionMode()
	if f87_local2 and f87_local2 > 0 then
		f87_local9 = true
	elseif f87_local3 and f87_local3 == 1 then
		f87_local9 = true
	end
	local f87_local14 = ""
	if f87_local1 then
		if f87_local5 ~= 0x0 then
			f87_local14 = f87_local1 .. "_AWARD"
		else
			f87_local14 = f87_local1
		end
	end
	local f87_local15 = 0
	local f87_local16 = nil
	local f87_local17 = ""
	if f87_local9 == true then
		f87_local16 = CoD.ChallengesUtility.TierString[f87_local2]
		if f87_local16 then
			f87_local17 = Engine.Localize(f87_local16)
		end
		local f87_local18 = f87_arg2 + 1
		local f87_local19 = f87_local2
		local f87_local20 = tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_local18, Enum.milestoneTableColumns_t[@"milestone_column_tierid"])) or -1
		while f87_local19 < f87_local20 do
			f87_local19 = f87_local20
			f87_local18 = f87_local18 + 1
			f87_local20 = tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_local18, Enum.milestoneTableColumns_t[@"milestone_column_tierid"])) or -1
		end
		f87_local15 = f87_local19
	end
	local f87_local18 = nil
	local f87_local19 = "MENU/NEW"
	local f87_local20 = "blacktransparent"
	local f87_local21 = "null/empty"
	local f87_local22 = ""
	local f87_local23 = ""
	f87_local20, f87_local21 = CoD.ChallengesUtility.GetChallengeRewardIconAndCategoryName(f87_local10)
	local f87_local24 = 0x0
	local f87_local25 = nil
	if f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_global"] then
		f87_local18 = Engine.Localize(f87_local14, f87_local4, "", f87_local17)
		f87_local19 = Engine.Localize(f87_local1 .. "_DESC", f87_local4, "", f87_local17)
	elseif f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_daily"] then
		f87_local18 = Engine.Localize(f87_local1)
		f87_local19 = "MENU/DAILY_CHALLENGE_COMPLETED"
	elseif f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_group"] then
		local f87_local26 = Engine[@"hash_4F9F1239CFD921FE"](CoD.ChallengesUtility.GetChallengeTypeString(Engine.GetItemGroupByIndex(f87_arg4)))
		f87_local18 = Engine.Localize(f87_local1, f87_local4, f87_local26, f87_local17)
		f87_local19 = Engine.Localize(f87_local1 .. "_DESC", f87_local4, f87_local26, f87_local17)
	elseif f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_gamemode"] then
		local f87_local26 = Engine[@"hash_36F8027A8BC75673"]()
		if (not f87_local26 or f87_local26 == "") and CoD.isFrontend then
			f87_local26 = CoD.AARUtility.GetCurrentGametype(f87_arg0)
		end
		if f87_local26 then
			local f87_local27 = Engine[@"getgametypeinfo"](f87_local26)
			local f87_local28 = Engine[@"hash_4F9F1239CFD921FE"]
			local f87_local29
			if f87_local27 then
				f87_local29 = f87_local27[@"challengetypestring"]
				if not f87_local29 then
				else
					f87_local28 = f87_local28(f87_local29)
					f87_local18 = Engine.Localize(f87_local14, f87_local4, f87_local28, f87_local17)
					f87_local19 = Engine.Localize(f87_local1 .. "_DESC", f87_local4, f87_local28, f87_local17)
				end
			end
			f87_local29 = 0x0
		end
	elseif f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_weapon"] then
		f87_local24 = Engine.GetItemName(f87_arg4)
		f87_local18 = Engine.Localize(f87_local14, f87_local4, f87_local24, f87_local17)
		f87_local23 = Engine.Localize(f87_local1 .. "_DESC", f87_local4, f87_local24)
		if LUI.startswith(f87_local10, "camo") then
			f87_local19 = Engine[@"hash_4F9F1239CFD921FE"](f87_local24)
		else
			f87_local19 = f87_local23
		end
	elseif f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_attachments"] then
		local f87_local26 = Engine.GetAttachmentNameByIndex(f87_arg4)
		f87_local18 = Engine.Localize(f87_local14, f87_local4, f87_local26, f87_local17)
		f87_local19 = Engine.Localize(f87_local1 .. "_DESC", f87_local4, f87_local26, f87_local17)
		if f87_local5 and f87_local5 ~= 0x0 then
			local f87_local27 = Engine.GetAttachmentRefByIndex(f87_arg4)
			f87_local20 = @"hash_256868FEED8DA814" .. f87_local27
			local f87_local28 = string.sub(f87_local10, string.len("reticle_") + 1)
			local f87_local29 = f87_local28 / CoD.WeaponOptionsUtility.maxReticles
			if f87_local27 then
				f87_local25 = {
					displayString = Engine[@"hash_4F9F1239CFD921FE"](CoD.BaseUtility.GetLocStringListEntry(@"hash_2CDB9A1280306634" .. f87_local27, f87_local29 + 1)),
					image = Engine[@"converttoxhash"](f87_local27 .. "_" .. f87_local28),
					attachmentName = f87_local26,
				}
			end
		end
	elseif f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_specialist"] then
		local f87_local26 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f87_local13, f87_arg5)
		f87_local18 = Engine.Localize(f87_local14, "", f87_local26.displayName)
	end
	local f87_local26 = nil
	if LUI.startswith(f87_local10, "camo") then
		local f87_local27 = Engine.TableLookup(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"], Enum.attachmentTableColumn_e[@"attachmenttable_column_reference"], f87_local10)
		f87_local18 = Engine.Localize(f87_local14, f87_local27)
		if f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_global"] then
			if f87_local5 == "camo_darkmatter" then
				f87_local20 = "ui_icon_camonotification_darkmatter"
			else
				local f87_local28 = Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_include"])
				if not f87_local28 then
					f87_local20 = "blacktransparent"
				else
					f87_local20 = CoD.ChallengesUtility.DiamondCamoImages[f87_local28[1]] or "blacktransparent"
				end
			end
		elseif f87_arg3 == Enum.statsMilestoneTypes_t[@"milestone_group"] then
			if f87_local5 == "camo_diamond" then
				local f87_local28 = Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_include"])
				if not f87_local28 then
					f87_local20 = "blacktransparent"
				else
					f87_local20 = CoD.ChallengesUtility.DiamondCamoImages[f87_local28[1]] or "blacktransparent"
				end
			end
		else
			local f87_local28 = CoD.CACUtility.GetUnlockableItemInfo(f87_arg4, f87_local13)
			if f87_local28 then
				if f87_local13 ~= Enum.eModes.mode_zombies then
					f87_local20 = f87_local28.nameHash .. "_" .. f87_local10 .. "_icon"
				else
					f87_local20 = Engine.GetItemImage(f87_arg4)
				end
			else
				f87_local20 = "blacktransparent"
			end
		end
		if f87_local13 == Enum.eModes.mode_zombies and not IsBooleanDvarSet("ui_zmenablemasterycamos") and (LUI.startswith(f87_local10, "camo_darkmatter") or f87_local10 == "camo_diamond" or f87_local10 == "camo_gold") then
			return nil
		end
		f87_local26 = {
			displayString = f87_local18,
			weaponName = f87_local24,
			image = Engine.TableLookup(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"], Enum.attachmentTableColumn_e[@"attachmenttable_column_reference"], f87_local10),
			camoRef = f87_local10,
			aarDisplayString = Engine.Localize(f87_local27),
			aarDescription = f87_local23,
		}
	elseif f87_local10 == "activecamounveil" then
		if Engine.TableLookup(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"hash_9A2FFE632B9ED93"], Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f87_local5) then
			local f87_local28 = Engine.TableLookup(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"attachmenttable_column_name"], Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f87_local5)
			f87_local20 = @"hash_18CDADFEDA5A37F" .. Engine.TableLookup(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"attachmenttable_column_reference"], Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f87_local5) .. "_icon"
			f87_local26 = {
				displayString = f87_local28,
				weaponName = Engine.GetItemName(f87_arg4, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"]),
				image = Engine.TableLookup(CoD.attachmentTable, Enum.attachmentTableColumn_e[@"attachmenttable_column_image"], Enum.attachmentTableColumn_e[@"hash_2419575E672F6FA2"], f87_local5),
				camoRef = nil,
				useRotatedIcon = true,
				category = f87_local10,
				aarDisplayString = Engine.Localize(f87_local28),
			}
		end
	elseif f87_local10 == "zm" then
		local f87_local27 = Engine.GetGametypeSetting("zmtrialsvariant")
		if CoD.ChallengesUtility.ZombiesTrialsExpToMedalImages[f87_local27] then
			local f87_local30 = CoD.ChallengesUtility.ZombiesTrialsExpToMedalImages[f87_local27][f87_local11]
		end
		f87_local20 = f87_local30 or "blacktransparent"
	end
	local f87_local27 = function(f88_arg0, f88_arg1)
		local f88_local0
		if Engine[@"hash_4C6F8EC444864600"](f88_arg0, f88_arg1, Enum.milestoneTableColumns_t[@"milestone_column_ismastery"]) ~= "1" and Engine[@"hash_4C6F8EC444864600"](f88_arg0, f88_arg1, Enum.milestoneTableColumns_t[@"milestone_column_isexpert"]) ~= "1" then
			f88_local0 = false
		else
			f88_local0 = true
		end
		return f88_local0
	end
	local f87_local28 = nil
	if f87_arg4 then
		local f87_local29, f87_local31, f87_local32 = CoD.ChallengesUtility.GetEmblemBackgroundImageText(tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2, Enum.milestoneTableColumns_t[@"milestone_column_index"])), f87_arg4)
		local f87_local33
		if f87_local29 then
			f87_local33 = 0x0
			if not f87_local33 then
			else
				local f87_local34, f87_local35, f87_local36 = nil
				if f87_local9 and f87_local2 < f87_local15 then
					f87_local34, f87_local35, f87_local36 = CoD.ChallengesUtility.GetEmblemBackgroundImageText(tonumber(Engine[@"hash_4C6F8EC444864600"](f87_local0, f87_arg2 + f87_local15 - f87_local2, Enum.milestoneTableColumns_t[@"milestone_column_index"])), f87_arg4)
				end
				if not f87_local31 then
					f87_local31 = f87_local35
				end
				if not f87_local32 then
					f87_local32 = f87_local36
				end
				if f87_local31 or f87_local35 then
					f87_local28 = {
						displayString = f87_local32 and Engine.Localize(f87_local32),
						image = f87_local31,
						maxTierImage = f87_local35,
						rewardSize = f87_local33,
						isMastery = f87_local27(f87_local0, f87_arg2),
					}
				end
			end
		end
		f87_local33 = "callingcard"
	end
	local f87_local29 = nil
	if f87_local11 and f87_local11 > 0 then
		local f87_local31 = nil
		if CoD.isWarzone then
			f87_local31 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1BCE3D9B07DE63B7", f87_local11)
		else
			f87_local31 = Engine[@"hash_4F9F1239CFD921FE"](@"rank/xp", f87_local11)
		end
		f87_local29 = {
			displayString = f87_local31,
			image = "t7_hud_mp_notifications_xp_blue",
		}
	end
	local f87_local31 = nil
	if f87_local12 and f87_local12 > 0 then
		f87_local31 = {
			displayString = Engine[@"hash_4F9F1239CFD921FE"]("zmui/bgb_tokens_gained_reward", f87_local12),
			image = "t7_hud_zm_vial_256",
		}
	end
	return {
		categoryName = f87_local21,
		challengeString = f87_local1,
		challengeAwardString = f87_local14,
		localizedTierText = f87_local17,
		currentTier = f87_local2,
		maxTier = f87_local15,
		titleText = f87_local18,
		subtitleText = f87_local19,
		icon = f87_local20,
		reticleInfo = f87_local25,
		camoInfo = f87_local26,
		emblemInfo = f87_local28,
		xpInfo = f87_local29,
		vialInfo = f87_local31,
	}
end
CoD.ChallengesUtility.IsCallingCardEquipped = function(f89_arg0)
	local f89_local0 = f89_arg0:getModel()
	if f89_local0 then
		f89_local0 = f89_arg0:getModel()
		f89_local0 = f89_local0.iconID
		if f89_local0 then
			f89_local0 = f89_arg0:getModel()
			f89_local0 = f89_local0.iconID:get()
		end
	end
	local f89_local1 = Engine.GetEmblemBackgroundId()
	return f89_local1 and f89_local0 and f89_local0 == f89_local1
end
CoD.ChallengesUtility.UpdateCallingCard = function(f90_arg0, f90_arg1, f90_arg2, f90_arg3, f90_arg4)
	local f90_local0 = {
		"icon",
		"iconId",
		"emblemBacking",
		"backgroundId",
		"selectedBg",
		"identityBadge.xuid",
		"xuid",
		"clientNum",
	}
	if f90_arg2._backingSubscription ~= nil then
		f90_arg2:removeSubscription(f90_arg2._backingSubscription)
	end
	for f90_local1 = 1, #f90_local0, 1 do
		local f90_local4 = f90_local0[f90_local1]
		local f90_local5 = Engine.GetModel(f90_arg4, f90_local4)
		if f90_local5 then
			f90_arg2._backingSubscription = f90_arg2:subscribeToModel(f90_local5, function(model)
				local modelValue = Engine.GetModelValue(model)
				if f90_local4 == "identityBadge.xuid" then
					local f91_local1 = modelValue
					modelValue = CoD.FreeCursorUtility.XUIDToEmblemBackgroundId(modelValue)
					if Engine[@"islocalclient"](f91_local1) then
						modelValue = ValidateEmblemBackground(f90_arg1, modelValue)
					end
				elseif f90_local4 == "xuid" then
					modelValue = CoD.FreeCursorUtility.XUIDToEmblemBackgroundId(modelValue)
				elseif f90_local4 == "clientNum" then
					modelValue = CoD.FreeCursorUtility.XUIDToEmblemBackgroundId(GetClientGameLobbyXUIDForClientNum(modelValue))
				elseif f90_local4 == "icon" then
					CoD.ChallengesUtility.SetCallingCardForWidget(f90_arg3, modelValue, f90_arg0.id)
					return
				end
				if modelValue and modelValue > -1 then
					CoD.ChallengesUtility.SetCallingCardForWidget(f90_arg3, CoD.ChallengesUtility.GetBackgroundByID(modelValue), f90_arg0.id)
				end
			end)
			break
		end
	end
end
CoD.ChallengesUtility.SetupIsCategoryLocked = function(f92_arg0, f92_arg1, f92_arg2, f92_arg3)
	local f92_local0 = f92_arg3.challengeRow
	if f92_local0 ~= nil then
		local f92_local1 = Engine.GetPlayerStats(f92_arg0, CoD.STATS_LOCATION_NORMAL, f92_arg1)
		local f92_local2 = 0
		local f92_local3 = 0
		if f92_local1 then
			f92_local2 = f92_local1.PlayerStatsList.RANK.StatValue:get()
			f92_local3 = f92_local1.PlayerStatsList.PLEVEL.StatValue:get()
		end
		local f92_local4 = "gamedata/stats/" .. string.upper(f92_arg2) .. "/statsmilestones" .. f92_arg3.tableNum + 1 .. ".csv"
		local f92_local5 = tonumber(Engine[@"hash_4C6F8EC444864600"](f92_local4, f92_local0, CoD.ChallengesUtility.UnlockRankCol))
		local f92_local6 = tonumber(Engine[@"hash_4C6F8EC444864600"](f92_local4, f92_local0, CoD.ChallengesUtility.UnlockPLevelCol))
		if f92_local3 < f92_local6 then
			return true, Engine[@"hash_4F9F1239CFD921FE"](@"hash_57FFD6D29AEB436E", f92_local6), nil, f92_local6
		elseif f92_local3 > 0 then
			return false
		elseif f92_local2 < f92_local5 then
			return true, Engine[@"hash_4F9F1239CFD921FE"](@"hash_381C07BC4A11544D", f92_local5 + 1), f92_local5 + 1, nil
		end
	end
	return false
end
CoD.ChallengesUtility.IsCategoryLocked = function(f93_arg0, f93_arg1)
	local f93_local0 = CoD.StartMenuUtility.GetSessionModeFromLobby()
	local f93_local1 = nil
	if f93_local0 == Enum.eModes.mode_multiplayer then
		f93_local1 = DataSources.ChallengesMPCategoryStats.getModel(f93_arg0)
	elseif f93_local0 == Enum.eModes.mode_zombies then
		f93_local1 = DataSources.ChallengesZMCategoryStats.getModel(f93_arg0)
	else
		f93_local1 = DataSources.ChallengesWZCategoryStats.getModel(f93_arg0)
	end
	return f93_local1[f93_arg1].categoryLocked:get()
end
CoD.ChallengesUtility.SetDarkOpsModeIcon = function(f94_arg0)
	local f94_local0 = CoD.StartMenuUtility.GetSessionModeFromLobby()
	local f94_local1 = Engine.GetModelForController(f94_arg0)
	if f94_local0 == Enum.eModes.mode_multiplayer then
		f94_local1.hudItems.darkOpsModeIcon:set("ui_icon_challenges_mpdarkops_large")
	elseif f94_local0 == Enum.eModes.mode_zombies then
		f94_local1.hudItems.darkOpsModeIcon:set("ui_icon_challenges_zmdarkops_large")
	elseif f94_local0 == Enum.eModes.mode_warzone then
		f94_local1.hudItems.darkOpsModeIcon:set("ui_icon_challenges_wzdarkops_large")
	end
end
CoD.ChallengesUtility.UpdateCardListFromTabChanged = function(f95_arg0, f95_arg1, f95_arg2)
	local f95_local0 = f95_arg1:getModel(f95_arg2, "tabCategory")
	if f95_local0 then
		local f95_local1 = Engine.GetModelValue(f95_local0)
		SetGlobalModelValue("challengeCategory", f95_local1)
		SetGlobalModelValue("callingCardCategory", f95_local1)
		local f95_local2 = f95_arg0.TabFrame.framedWidget
		if f95_local2 then
			f95_local2 = f95_arg0.TabFrame.framedWidget.CardGrid
		end
		if f95_local2 then
			f95_local2:updateDataSource()
		end
	end
end
