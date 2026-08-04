CoD.ZombiesCallingsUtility = {}
require("ui/utility/overlayutility")
CoD.ZombiesCallingsUtility.CallingTaskInfo = {}
CoD.ZombiesCallingsUtility.EventInfo = {}
CoD.ZombiesCallingsUtility.DailyCallings = {}
CoD.ZombiesCallingsUtility.DailyCallingCompletionNP = 20
CoD.ZombiesCallingsUtility.FactionCallings = {}
CoD.ZombiesCallingsUtility.GlobalFactionAssets = {}
CoD.ZombiesCallingsUtility.FactionCallingsPerSeason = 12
CoD.ZombiesCallingsUtility.MaxFactionCallingSeasons = 8
CoD.ZombiesCallingsUtility.FactionCallingScreenStates = LuaEnum.createEnum("DEFAULT", "FACTION_RESPONSE", "FIRST_CALLING_INTERACTION", "FACTION_ACTIVATION", "FACTION_SELECTION", "FIRST_SEASON_INTERACTION")
CoD.ZombiesCallingsUtility.FactionCallingPact = {
	[@"classicpact"] = "classicpact_tasks",
	[@"rushpact"] = "rushpact_tasks",
	[@"tcmpact"] = "tcmpact_tasks",
	tcmgoal = "tcmgoal",
}
CoD.ZombiesCallingsUtility.FactionCirclePositions = {
	up = {
		index = 1,
		name = "Up",
	},
	right = {
		index = 2,
		name = "Right",
	},
	down = {
		index = 3,
		name = "Down",
	},
	left = {
		index = 4,
		name = "Left",
	},
}
CoD.ZombiesCallingsUtility.FactionCallingRewardCasts = {
	"cast1",
	"cast2",
	"cast3",
}
CoD.ZombiesCallingsUtility.FactionCallingRewards = {
	headgear = {
		name = @"hash_61DC2DDD0B1F9DBD",
		index = 1,
	},
	warpaint = {
		name = @"hash_6C6DA1503405E36F",
		index = 2,
	},
	outfit1 = {
		name = @"menu/outfit",
		index = 3,
	},
	outfit2 = {
		name = @"menu/outfit",
		index = 4,
	},
}
CoD.ZombiesCallingsUtility.FactionRewardCompletions = {
	faction = {},
	headgear = {
		rewardHashes = {
			"headgear",
		},
		rewardName = @"hash_6BEDB6D4C095DF18",
		rewardBundleName = @"hash_322E97F6C8A4F601",
		rewardBundleImage = @"hash_BC1670C43509A0F",
		lootIDList = "headgearcompletionlootidlist",
		lockedStringRef = @"hash_6870B21C867E3F75",
		unlockedStringRef = @"hash_6C0D1E181DE1250",
	},
	warpaint = {
		rewardHashes = {
			"warpaint",
		},
		rewardName = @"hash_63823C7E6A852C5C",
		rewardBundleName = @"hash_3355E058E2574C1E",
		rewardBundleImage = 0x11D6CA347C5082,
		lootIDList = "warpaintcompletionlootidlist",
		lockedStringRef = @"hash_48C500DADEF43424",
		unlockedStringRef = @"hash_2C4DAC68102D4665",
	},
	outfit = {
		rewardHashes = {
			"outfit1",
			"outfit2",
		},
		rewardName = @"menu/outfits",
		rewardBundleName = @"hash_589963FA265D123F",
		rewardBundleImage = @"hash_1FD88788D1A91631",
		lootIDList = "outfitcompletionlootidlist",
		lockedStringRef = 0x51DB02077F5563,
		unlockedStringRef = @"hash_22E60B3EA8AC5202",
	},
	total = {
		rewardHashes = {
			"headgear",
			"warpaint",
			"outfit1",
			"outfit2",
		},
		rewardName = @"hash_4E988984E0CE3479",
		rewardBundleName = @"hash_669D8EC8D4B3D59C",
		rewardBundleImage = @"hash_5A1BFC8A776B4744",
		lootIDList = "totalcompletionlootidlist",
		lockedStringRef = 0x7750FB069C619A,
		unlockedStringRef = @"hash_CC9603BBEDBF467",
	},
}
CoD.ZombiesCallingsUtility.GetFactionAsset = function(f1_arg0)
	if not CoD.ZombiesCallingsUtility.GlobalFactionAssets[f1_arg0] then
		CoD.ZombiesCallingsUtility.GlobalFactionAssets[f1_arg0] = Engine[@"hash_2E00B2F29271C60B"](f1_arg0)
	end
	return CoD.ZombiesCallingsUtility.GlobalFactionAssets[f1_arg0]
end
CoD.ZombiesCallingsUtility.GetFactionIndex = function(f2_arg0, f2_arg1)
	local f2_local0 = LuaUtils.GetCallingsBundle()
	if f2_local0 == nil or f2_local0.factioncallingseasons == nil then
		return nil
	end
	for f2_local4, f2_local5 in ipairs(f2_local0.factioncallingseasons[f2_arg0].factionlist) do
		if Engine[@"converttoxhash"](f2_local5[@"hash_237E6733A4393CBA"]) == f2_arg1 then
			return f2_local4
		end
	end
	return nil
end
CoD.ZombiesCallingsUtility.AddFactionCallingStatUnlocks = function(f3_arg0)
	local f3_local0 = LuaUtils.GetCallingsBundle()
	if f3_local0 == nil or f3_local0.factioncallingseasons == nil then
		return
	end
	for f3_local28, f3_local29 in ipairs(f3_local0.factioncallingseasons) do
		local f3_local30 = f3_local28
		if f3_local29.factionlist then
			for f3_local25, f3_local26 in ipairs(f3_local29.factionlist) do
				local f3_local27 = Engine[@"converttoxhash"](f3_local26[@"hash_237E6733A4393CBA"])
				if f3_local27 then
					for f3_local23, f3_local24 in ipairs(CoD.ZombiesCallingsUtility.FactionCallingRewardCasts) do
						local f3_local10 = f3_local26.rewardcastlist
						if f3_local10 then
							f3_local10 = f3_local26.rewardcastlist[f3_local23]
						end
						if f3_local10 then
							for f3_local21, f3_local22 in pairs(CoD.ZombiesCallingsUtility.FactionCallingRewards) do
								local f3_local14 = f3_local10.rewardlist
								if f3_local14 then
									f3_local14 = f3_local10.rewardlist[f3_local22.index]
								end
								if f3_local14 and f3_local14.lootidlist then
									for f3_local18, f3_local19 in ipairs(f3_local14.lootidlist) do
										local f3_local20 = f3_local19.lootid
										if f3_local20 and f3_local20 ~= 0x0 then
											f3_arg0[f3_local20] = {
												storageFile = Enum.StorageFileType[@"hash_A57D6164B91A8FC"],
												path = {
													"playercalling",
													"seasons",
													f3_local30 - 1,
													"factions",
													f3_local27,
													"rewards",
													f3_local24,
													"purchased",
													f3_local21,
												},
												lockedStringRef = f3_local29[@"hash_4A8862EC304FADC2"] or 0x0,
												unlockedStringRef = f3_local29[@"hash_428BDC3E140560DF"] or 0x0,
												itemUnlockable = function()
													return IsBooleanDvarSet("faction_callings_enabled_zm") and f3_local30 <= f4_local0
												end,
											}
										end
									end
								end
							end
						end
					end
				end
			end
		end
		for f3_local25, f3_local26 in pairs(CoD.ZombiesCallingsUtility.FactionRewardCompletions) do
			local f3_local27 = f3_local25
			if f3_local27 == "faction" and f3_local29.factionlist then
				for f3_local23, f3_local24 in ipairs(f3_local29.factionlist) do
					local f3_local10 = Engine[@"converttoxhash"](f3_local24[@"hash_237E6733A4393CBA"])
					if f3_local10 and f3_local24.factioncompletionlootidlist then
						for f3_local21, f3_local22 in ipairs(f3_local24.factioncompletionlootidlist) do
							local f3_local14 = f3_local22.lootid
							if f3_local14 and f3_local14 ~= 0x0 then
								f3_arg0[f3_local14] = {
									itemOwned = function(f5_arg0)
										return CoD.ZombiesCallingsUtility.GetFactionCompletion(f5_arg0, f3_local30, f3_local10)
									end,
									lockedStringRef = f3_local24[@"hash_95AB4C5895FD60C"] or 0x0,
									unlockedStringRef = f3_local24[@"hash_186A87D51B516DBD"] or 0x0,
									itemUnlockable = function()
										return IsBooleanDvarSet("faction_callings_enabled_zm") and f3_local30 <= f6_local0
									end,
								}
							end
						end
					end
				end
			elseif f3_local29[f3_local26.lootIDList] then
				for f3_local23, f3_local24 in ipairs(f3_local29[f3_local26.lootIDList]) do
					local f3_local10 = f3_local24.lootid
					if f3_local10 and f3_local10 ~= 0x0 then
						f3_arg0[f3_local10] = {
							itemOwned = function(f7_arg0)
								return CoD.ZombiesCallingsUtility.GetRewardCompletion(f7_arg0, f3_local30, f3_local27)
							end,
							lockedStringRef = f3_local29[f3_local26.lockedStringRef] or 0x0,
							unlockedStringRef = f3_local29[f3_local26.unlockedStringRef] or 0x0,
							itemUnlockable = function()
								return IsBooleanDvarSet("faction_callings_enabled_zm") and f3_local30 <= f8_local0
							end,
						}
					end
				end
			end
		end
	end
end
CoD.ZombiesCallingsUtility.NotificationType = LuaEnum.createEnum("SPECIAL_EVENT", "DAILY_TASK", "FACTION_TASK", "FACTION_PACT")
CoD.ZombiesCallingsUtility.UpdateTimerModelsCustom = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = Engine[@"getdvarstring"](f9_arg1)
	if not f9_local0 or f9_local0 == "" then
		f9_local0 = Engine.GetCurrentUTCTimeStr()
	end
	local f9_local1 = Engine[@"hash_690B6BCE69A8E08B"](f9_local0)
	local f9_local2 = Engine[@"hash_2786FFC9E621CAB7"]()
	local f9_local3 = 0
	local f9_local4 = ""
	if f9_local2 < f9_local1 then
		f9_local3 = tonumber(Engine.Int64AsString(f9_local1 - f9_local2))
		f9_local4 = LuaUtils.SecondsToTimeRemainingString(f9_local3)
	end
	f9_local4 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0CE2452CF87DB1", f9_local4)
	local f9_local5 = f9_arg0:getModel()
	local f9_local6 = f9_local5:create(f9_arg2)
	f9_local6 = f9_local6:set(f9_local3)
	local f9_local7 = f9_local5:create(f9_arg3)
	f9_local7 = f9_local7:set(f9_local4)
end
CoD.ZombiesCallingsUtility.StartTimerCheckCustom = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4)
	CoD.ZombiesCallingsUtility.UpdateTimerModelsCustom(f10_arg0, f10_arg2, f10_arg3, f10_arg4)
	f10_arg0:addElement(LUI.UITimer.newElementTimer(250, false, function()
		CoD.ZombiesCallingsUtility.UpdateTimerModelsCustom(f10_arg0, f10_arg2, f10_arg3, f10_arg4)
	end))
end
CoD.ZombiesCallingsUtility.AddZombieCallingsNotification = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = LuaUtils.GetCallingsBundle()
	if f12_local0 == nil then
		return
	end
	local f12_local1 = CoD.GetScriptNotifyData(f12_arg2)
	local f12_local2 = f12_local1[1]
	if f12_local2 == CoD.ZombiesCallingsUtility.NotificationType.SPECIAL_EVENT then
		local f12_local3 = f12_local1[2]
		local f12_local4 = f12_local1[3]
		local f12_local5 = CoD.SpecialEventUtility.GetSpecialEventInfo(f12_local3)
		if f12_local5 then
			local f12_local6 = CoD.ZombiesCallingsUtility.GetEventInfo(f12_local5.statHash)
			local f12_local7 = CoD.ZombiesCallingsUtility.GetCallingTaskInfo(f12_local5[f12_local4].name)
			f12_arg1:appendNotification({
				clip = "TextandImageCallings",
				title = Engine[@"hash_4F9F1239CFD921FE"](@"menu/task_complete", f12_local7[@"taskname"]),
				description = f12_local6.event.eventname,
				taskImage = RegisterImage(f12_local7.image),
			})
		end
	elseif f12_local2 == CoD.ZombiesCallingsUtility.NotificationType.DAILY_TASK then
		local f12_local3 = f12_local1[2]
		local f12_local4 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f12_local0.tasklist[f12_local1[2] + 1][@"task"]))
		f12_arg1:appendNotification({
			clip = "TextandImageCallings",
			title = Engine[@"hash_4F9F1239CFD921FE"](@"menu/task_complete", f12_local4[@"taskname"]),
			description = @"hash_7FADDBA964DEE5E1",
			taskImage = RegisterImage(f12_local4.image),
		})
	elseif f12_local2 == CoD.ZombiesCallingsUtility.NotificationType.FACTION_TASK then
		local f12_local3 = f12_local1[2]
		local f12_local4 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f12_local0.tasklist[f12_local1[2] + 1][@"task"]))
		f12_arg1:appendNotification({
			clip = "TextandImageCallings",
			title = Engine[@"hash_4F9F1239CFD921FE"](@"menu/task_complete", f12_local4[@"taskname"]),
			description = @"menu/faction_calling",
			taskImage = RegisterImage(f12_local4.image),
		})
	elseif f12_local2 == CoD.ZombiesCallingsUtility.NotificationType.FACTION_PACT then
		local f12_local3 = f12_local1[2]
		local f12_local4 = f12_local1[3]
		local f12_local5 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f12_local0.factioncallingseasons[f12_local1[3]].factionlist[f12_local3][@"hash_237E6733A4393CBA"]))
		f12_arg1:appendNotification({
			clip = "TextandImageCallings",
			title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6FF2D60C66A90DF"),
			description = f12_local5[@"factionname"],
			taskImage = RegisterImage(f12_local5[@"tokenimage"]),
		})
	end
end
CoD.ZombiesCallingsUtility.GetCallingTaskInfo = function(f13_arg0)
	local f13_local0 = function()
		local f14_local0 = LuaUtils.GetCallingsBundle()
		for f14_local4, f14_local5 in ipairs(f14_local0.tasklist) do
			local f14_local6 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f14_local5[@"task"]))
			CoD.ZombiesCallingsUtility.CallingTaskInfo[f14_local6[@"taskname"]] = f14_local6
		end
	end
	if not CoD.ZombiesCallingsUtility.CallingTaskInfo[f13_arg0] then
		f13_local0()
	end
	return CoD.ZombiesCallingsUtility.CallingTaskInfo[f13_arg0]
end
CoD.ZombiesCallingsUtility.GetEventInfo = function(f15_arg0)
	local f15_local0 = function(f16_arg0)
		local f16_local0 = LuaUtils.GetCallingsBundle()
		for f16_local12, f16_local13 in ipairs(f16_local0.eventlist) do
			local f16_local14 = Engine[@"converttoxhash"](f16_local13.event)
			if f16_local14 == f16_arg0 then
				local f16_local4 = Engine[@"hash_2E00B2F29271C60B"](f16_local14)
				local f16_local5 = {}
				if f16_local4.rewardlist then
					for f16_local9, f16_local10 in ipairs(f16_local4.rewardlist) do
						local f16_local11 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f16_local10.reward))
						f16_local5[f16_local11.stat] = f16_local11
					end
				end
				CoD.ZombiesCallingsUtility.EventInfo[f16_arg0] = {
					event = f16_local4,
					rewards = f16_local5,
				}
			end
		end
	end
	if not CoD.ZombiesCallingsUtility.EventInfo[f15_arg0] then
		f15_local0(f15_arg0)
	end
	return CoD.ZombiesCallingsUtility.EventInfo[f15_arg0]
end
CoD.ZombiesCallingsUtility.GetCurrentDailyCallingInfo = function()
	return CoD.ZombiesCallingsUtility.GetDailyCallingInfo(Engine[@"getdvarint"]("zm_active_daily_calling"))
end
CoD.ZombiesCallingsUtility.GetCurrentDailyCallingProgressInfo = function(f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = nil
	if not f18_arg1 then
		f18_local0 = CoD.ZombiesCallingsUtility.GetCurrentDailyCallingInfo()
	elseif f18_arg2 then
		f18_local0 = CoD.ZombiesCallingsUtility.GetDailyCallingInfo(f18_arg2)
	end
	if f18_local0 then
		local f18_local1 = LUI.ShallowCopy(f18_local0)
		if not f18_arg1 then
			f18_arg1 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer(f18_arg0)
		end
		if f18_arg1 and f18_arg1.daily_calling_stats then
			f18_local1.progress = f18_arg1.daily_calling_stats.progress:get()
			return f18_local1
		end
	end
	return nil
end
CoD.ZombiesCallingsUtility.GetDailyCallingInfo = function(f19_arg0)
	if f19_arg0 and 0 < f19_arg0 and not CoD.ZombiesCallingsUtility.DailyCallings[f19_arg0] then
		local f19_local0 = nil
		local f19_local1 = LuaUtils.GetCallingsBundle()
		if f19_local1 then
			local f19_local2 = f19_arg0 + 1
			local f19_local3 = f19_local1.dailyschedule
			if f19_local3 then
				f19_local3 = f19_local1.dailyschedule[f19_local2]
			end
			if f19_local3 then
				local f19_local4 = f19_local3.xp
				local f19_local5 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f19_local3[@"task"]))
				f19_local0 = {
					name = f19_local5[@"taskname"],
					target = f19_local5[@"dailytarget"],
					xp = f19_local4,
				}
			end
		end
		CoD.ZombiesCallingsUtility.DailyCallings[f19_arg0] = f19_local0
	end
	return CoD.ZombiesCallingsUtility.DailyCallings[f19_arg0]
end
CoD.ZombiesCallingsUtility.GetDailyCallingRewardModels = function(f20_arg0, f20_arg1, f20_arg2)
	local f20_local0 = {}
	local f20_local1 = f20_arg2.daily_calling_stats.current_daily_calling:get()
	local f20_local2 = CoD.ZombiesCallingsUtility.GetCurrentDailyCallingProgressInfo(f20_arg0, f20_arg1, f20_local1)
	local f20_local3 = CoD.ZombiesCallingsUtility.GetCurrentDailyCallingProgressInfo(f20_arg0, f20_arg2, f20_local1)
	local f20_local4 = CoD.ZombiesCallingsUtility.GetDailyCallingInfo(f20_local1)
	if f20_local2 and f20_local3 and f20_local4 then
		local f20_local5 = f20_local2.progress
		local f20_local6 = f20_local3.progress
		local f20_local7 = f20_local4.target
		if f20_local5 < f20_local7 and f20_local7 <= f20_local6 then
			local f20_local8 = CoD.ZombiesCallingsUtility.GetCallingTaskInfo(f20_local4.name)
			if f20_local8 then
				local f20_local9 = {
					mainTitle = @"hash_7FADDBA964DEE5E1",
					levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_E7E238DA43A9CC9", Engine[@"hash_4F9F1239CFD921FE"](f20_local8[@"taskname"])),
					mainIcon = f20_local8.image,
					rewardType = CoD.AARUtility.AARRewardType.DAILY_CALLING,
					totalXP = Engine[@"hash_4F9F1239CFD921FE"](@"rank/xp", f20_local4.xp),
				}
				local f20_local10 = CoD.ZombiesCallingsUtility.DailyCallingCompletionNP
				f20_local9.reward1Icon = "ui_icon_nebulium_medium"
				f20_local9.reward1Desc = Engine[@"hash_4F9F1239CFD921FE"](@"menu/multiplier_x", f20_local10)
				f20_local9.npEarned = f20_local10
				table.insert(f20_local0, f20_local9)
			end
		end
	end
	return f20_local0
end
CoD.ZombiesCallingsUtility.SubscribeToAutoEvents = function(f21_arg0, f21_arg1)
	local f21_local0 = Engine.GetGlobalModel()
	f21_local0 = f21_local0:create("AutoEvents")
	f21_arg0:subscribeToModel(f21_local0:create("cycled"), function()
		local f22_local0 = DataSources.SpecialEventCurrentStepInfo.getModel(f21_arg1)
		local f22_local1 = DataSources.DailyCallingInfo.getModel(f21_arg1)
	end, false)
end
CoD.ZombiesCallingsUtility.EnableLiveDailyCallingsCountDownTimer = function(f23_arg0)
	if not IsBooleanDvarSet("daily_callings_enabled_zm") then
		return
	else
		f23_arg0:registerEventHandler("daily_callings_autoevents_tick", function(element, event)
			LuaUtils.UpdateDailyCallingDvar()
		end)
		f23_arg0:addElement(LUI.UITimer.new(100, "daily_callings_autoevents_tick", false, f23_arg0))
	end
end
DataSources.DailyCallingInfo = {
	getModel = function(f25_arg0)
		local f25_local0 = Engine.GetModelForController(f25_arg0)
		local f25_local1 = f25_local0:create("dailyCallingInfo")
		local f25_local2 = f25_local1:create("taskName")
		local f25_local3 = f25_local1:create("taskDescription")
		local f25_local4 = f25_local1:create("taskIcon")
		local f25_local5 = f25_local1:create("target")
		local f25_local6 = f25_local1:create("taskProgress")
		local f25_local7 = f25_local1:create("taskProgressString")
		local f25_local8 = f25_local1:create("showDailyLayout")
		local f25_local9 = f25_local1:create("allTasksComplete")
		local f25_local10 = f25_local1:create("allTasksCompleteText")
		local f25_local11 = f25_local1:create("eventName")
		f25_local1:create("timeRemaining")
		f25_local1:create("timeRemainingString")
		if IsBooleanDvarSet("daily_callings_enabled_zm") then
			LuaUtils.UpdateDailyCalling(f25_arg0)
			local f25_local12 = CoD.ZombiesCallingsUtility.GetCurrentDailyCallingProgressInfo(f25_arg0)
			if f25_local12 then
				local f25_local13 = f25_local12.name
				local f25_local14 = CoD.ZombiesCallingsUtility.GetCallingTaskInfo(f25_local13)
				local f25_local15 = f25_local14[@"descsimple"]
				local f25_local16 = f25_local14.image
				local f25_local17 = f25_local12.progress
				local f25_local18 = f25_local12.target
				local f25_local19 = 0
				if f25_local18 ~= 0 then
					f25_local19 = f25_local17 / f25_local18
				end
				local f25_local20 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f25_local17, f25_local18)
				local f25_local21 = @"hash_7FADDBA964DEE5E1"
				f25_local2:set(f25_local13)
				f25_local3:set(f25_local15)
				f25_local4:set(f25_local16)
				f25_local5:set(f25_local18)
				f25_local6:set(f25_local19)
				f25_local7:set(f25_local20)
				f25_local8:set(true)
				f25_local9:set(false)
				f25_local10:set(0x0)
				f25_local11:set(f25_local21)
				local f25_local22 = @"hash_44E98C3D70CFD643"
				f25_local9:set(f25_local18 <= f25_local17)
				f25_local10:set(f25_local22)
			end
		else
			f25_local2:set(0x0)
			f25_local3:set(0x0)
			f25_local4:set(0x0)
			f25_local5:set(0)
			f25_local6:set(0)
			f25_local7:set("")
			f25_local8:set(true)
			f25_local9:set(false)
			f25_local10:set(0x0)
			f25_local11:set(0x0)
			f25_local9:set(false)
			f25_local10:set(0x0)
		end
		return f25_local1
	end,
}
DataSources.DailyCallingRewards = DataSourceHelpers.ListSetup("DailyCallingRewards", function(f26_arg0, f26_arg1)
	local f26_local0 = {}
	local f26_local1 = Engine.GetGlobalModel()
	f26_local1 = f26_local1:create("AutoEvents")
	f26_local1 = f26_local1:create("cycled")
	local f26_local2 = CoD.ZombiesCallingsUtility.GetCurrentDailyCallingProgressInfo(f26_arg0)
	if f26_local2 and IsBooleanDvarSet("daily_callings_enabled_zm") then
		table.insert(f26_local0, {
			models = {
				rewardImage = "t7_hud_mp_notifications_xp_blue",
				rewardText = Engine[@"hash_4F9F1239CFD921FE"](@"rank/xp", f26_local2.xp),
			},
		})
		table.insert(f26_local0, {
			models = {
				rewardImage = "ui_icon_nebulium_medium",
				rewardText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/multiplier_x", CoD.ZombiesCallingsUtility.DailyCallingCompletionNP),
			},
		})
	end
	if f26_arg1.cycledSubscription == nil then
		f26_arg1.cycledSubscription = f26_arg1:subscribeToModel(f26_local1, function()
			f26_arg1:updateDataSource()
		end, false)
	end
	return f26_local0
end, true)
CoD.ZombiesCallingsUtility.GetFactionPactsCompleted = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
	if not f28_arg1 then
		f28_arg1 = LuaUtils.GetCallingsStats(f28_arg0)
	end
	return f28_arg1.seasons[f28_arg2 - 1].factions[f28_arg3].pactscompleted:get()
end
CoD.ZombiesCallingsUtility.GetFactionCallingInfoInternal = function(f29_arg0, f29_arg1, f29_arg2)
	local f29_local0 = {}
	local f29_local1 = LuaUtils.GetCallingsBundle()
	if f29_local1 == nil then
		return f29_local0
	else
		local f29_local2 = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3, f30_arg4)
			local f30_local0 = Engine[@"hash_2E00B2F29271C60B"](f30_arg2)
			table.insert(f30_arg0[f30_arg1].tasks, {
				name = f30_local0[@"taskname"],
				target = f30_arg3,
				xp = f30_arg4,
			})
		end
		local f29_local3 = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
			f31_arg0[f31_arg1] = {}
			f31_arg0[f31_arg1].tasks = {}
			f31_arg0[f31_arg1].gametype = f31_arg2
			f31_arg0[f31_arg1].isGoal = f31_arg1 == CoD.ZombiesCallingsUtility.FactionCallingPact.tcmgoal
			if f31_arg3.array then
				for f31_local3, f31_local4 in ipairs(f31_arg3.array) do
					f29_local2(f31_arg0, f31_arg1, Engine[@"converttoxhash"](f31_local4[@"task"]), f31_local4.target, f31_local4.xp)
				end
			else
				f29_local2(f31_arg0, f31_arg1, Engine[@"converttoxhash"](f31_arg3.task), f31_arg3.target, f31_arg3.xp)
			end
		end
		f29_local3(f29_local0, CoD.ZombiesCallingsUtility.FactionCallingPact[@"classicpact"], "zclassic", {
			array = f29_local1.factioncallings[f29_arg2].classicpact,
		})
		f29_local3(f29_local0, CoD.ZombiesCallingsUtility.FactionCallingPact[@"rushpact"], "zstandard", {
			array = f29_local1.factioncallings[f29_arg2].rushpact,
		})
		local f29_local4 = f29_local1.factioncallingseasons[f29_arg0].callinglist[f29_arg1]
		f29_local3(f29_local0, CoD.ZombiesCallingsUtility.FactionCallingPact[@"tcmpact"], f29_local4[@"tcmgametype"], {
			array = f29_local4.tcmpact,
		})
		f29_local3(f29_local0, CoD.ZombiesCallingsUtility.FactionCallingPact.tcmgoal, f29_local4[@"tcmgametype"], {
			task = f29_local4.tcmgoal,
			target = f29_local4[@"tcmgoaltarget"],
			xp = f29_local4[@"tcmgoalxp"],
		})
		return f29_local0
	end
end
CoD.ZombiesCallingsUtility.GetFactionCallingInfo = function(f32_arg0, f32_arg1, f32_arg2)
	if not CoD.ZombiesCallingsUtility.FactionCallings[f32_arg0] then
		CoD.ZombiesCallingsUtility.FactionCallings[f32_arg0] = {}
	end
	if not CoD.ZombiesCallingsUtility.FactionCallings[f32_arg0][f32_arg1] then
		CoD.ZombiesCallingsUtility.FactionCallings[f32_arg0][f32_arg1] = {}
	end
	if not CoD.ZombiesCallingsUtility.FactionCallings[f32_arg0][f32_arg1][f32_arg2] then
		CoD.ZombiesCallingsUtility.FactionCallings[f32_arg0][f32_arg1][f32_arg2] = {}
		local f32_local0 = LuaUtils.GetCallingsBundle()
		if f32_local0 == nil or f32_local0.factioncallingseasons == nil then
			return nil
		end
		local f32_local1 = CoD.ZombiesCallingsUtility.GetFactionIndex
		local f32_local2 = f32_arg0
		CoD.ZombiesCallingsUtility.FactionCallings[f32_arg0][f32_arg1][f32_arg2].pacts = CoD.ZombiesCallingsUtility.GetFactionCallingInfoInternal(f32_arg0, f32_arg1, (f32_local0.factioncallingseasons[f32_arg0].factionlist[f32_local1(f32_arg0, f32_arg2)][@"hash_582A0B09F49B603"] - 1 + f32_arg1 - 1) % #f32_local0.factioncallings + 1)
	end
	return CoD.ZombiesCallingsUtility.FactionCallings[f32_arg0][f32_arg1][f32_arg2]
end
CoD.ZombiesCallingsUtility.GetFactionCallingProgressInfo = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4)
	local f33_local0 = nil
	if f33_arg2 and f33_arg3 and f33_arg4 then
		local f33_local1 = CoD.ZombiesCallingsUtility.GetFactionCallingInfo(f33_arg2, f33_arg3, f33_arg4)
		f33_local0 = f33_local1
	end
	if f33_local0 then
		local f33_local2 = function(f34_arg0)
			local f34_local0 = {}
			for f34_local4, f34_local5 in pairs(f34_arg0) do
				if type(f34_local5) == "table" then
					f34_local0[f34_local4] = f33_local1(f34_local5)
				else
					f34_local0[f34_local4] = f34_local5
				end
			end
			return f34_local0
		end
		f33_local2 = f33_local2(f33_local0)
		if not f33_arg1 then
			f33_arg1 = LuaUtils.GetCallingsStats(f33_arg0)
		end
		if f33_arg1 and f33_local2.pacts then
			for f33_local11, f33_local12 in pairs(f33_local2.pacts) do
				if #f33_local12.tasks == 1 then
					f33_local12.tasks[1].progress = f33_arg1.seasons[f33_arg2 - 1].callings[f33_arg3 - 1][f33_local11].progress:get()
				end
				for f33_local9, f33_local10 in ipairs(f33_local12.tasks) do
					f33_local10.progress = f33_arg1.seasons[f33_arg2 - 1].callings[f33_arg3 - 1][f33_local11][f33_local9 - 1].progress:get()
				end
			end
			return f33_local2
		else
		end
	end
	return nil
end
CoD.ZombiesCallingsUtility.GetFactionCallingCompletion = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
	if not f35_arg1 then
		f35_arg1 = LuaUtils.GetCallingsStats(f35_arg0)
	end
	local f35_local0 = CoD.ZombiesCallingsUtility.GetFactionCallingProgressInfo(f35_arg0, f35_arg1, f35_arg2, f35_arg3, f35_arg1.seasons[f35_arg2 - 1][@"hash_7E597FBE41270A4D"]:get())
	if not f35_local0 then
		return nil
	end
	local f35_local1 = function(f36_arg0)
		f36_arg0.complete = f36_arg0.target <= f36_arg0.progress
		return f36_arg0.complete
	end
	local f35_local2 = function(f37_arg0)
		f37_arg0.complete = true
		for f37_local3, f37_local4 in ipairs(f37_arg0.tasks) do
			if not f35_local1(f37_local4) and f37_arg0.complete then
				f37_arg0.complete = false
			end
		end
		return f37_arg0.complete
	end
	f35_local0.complete = true
	for f35_local6, f35_local7 in pairs(f35_local0.pacts) do
		if not f35_local2(f35_local7) and f35_local0.complete then
			f35_local0.complete = false
		end
	end
	if f35_local0.complete then
		f35_local0.percentComplete = 1
	else
		f35_local3 = 0
		f35_local4 = 0
		for f35_local11, f35_local12 in pairs(f35_local0.pacts) do
			for f35_local8, f35_local9 in ipairs(f35_local12.tasks) do
				if not f35_local9.complete then
					f35_local3 = f35_local3 + f35_local9.progress / f35_local9.target
				else
					f35_local3 = f35_local3 + 1
				end
				f35_local4 = f35_local4 + 1
			end
		end
		if f35_local4 ~= 0 then
			f35_local0.percentComplete = f35_local3 / f35_local4
		else
			f35_local0.percentComplete = 1
		end
	end
	return f35_local0
end
CoD.ZombiesCallingsUtility.GetFactionCallingAARInfo = function(f38_arg0, f38_arg1, f38_arg2)
	local f38_local0 = f38_arg1.playercalling
	if not f38_local0 then
		return nil
	else
		local f38_local1 = LuaUtils.GetCallingsBundle()
		if f38_local1 == nil or f38_local1.factioncallingseasons == nil then
			return nil
		else
			local f38_local2 = f38_local0.currentseason:get() + 1
			local f38_local3 = f38_local0.currentcallingid:get() + 1
			local f38_local4 = CoD.ZombiesCallingsUtility.GetFactionCallingCompletion(f38_arg0, f38_arg1.playercalling, f38_local2, f38_local3)
			local f38_local5 = CoD.ZombiesCallingsUtility.GetFactionCallingCompletion(f38_arg0, f38_arg2.playercalling, f38_local2, f38_local3)
			local f38_local6 = f38_local0.currentfaction:get()
			local f38_local7 = CoD.ZombiesCallingsUtility.GetFactionIndex(f38_local2, f38_local6)
			return {
				prematchCallingInfo = f38_local4,
				currentCallingInfo = f38_local5,
				season = f38_local2,
				callingInSeason = f38_local3,
				factionHash = f38_local6,
				factionIndex = f38_local7,
				factionAsset = Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f38_local1.factioncallingseasons[f38_local2].factionlist[f38_local7][@"hash_237E6733A4393CBA"])),
				bundle = f38_local1,
			}
		end
	end
end
CoD.ZombiesCallingsUtility.CloseFactionCallingFullscreenOverlay = function(f39_arg0, f39_arg1)
	CoD.AARUtility.ProcessAAROverlays(GoBack(f39_arg0, f39_arg1), f39_arg1)
end
CoD.ZombiesCallingsUtility.ShowFactionCallingFullscreen = function(f40_arg0)
	local f40_local0, f40_local1 = CoD.AARUtility.GetStats(f40_arg0)
	return #CoD.ZombiesCallingsUtility.GetFactionCallingFullscreenModels(f40_arg0, f40_local0, f40_local1) > 0
end
CoD.ZombiesCallingsUtility.GetFactionCallingFullscreenModels = function(f41_arg0, f41_arg1, f41_arg2)
	local f41_local0 = {}
	local f41_local1 = CoD.ZombiesCallingsUtility.GetFactionCallingAARInfo(f41_arg0, f41_arg1, f41_arg2)
	if not f41_local1 then
		return f41_local0
	end
	local f41_local2 = CoD.ZombiesCallingsUtility.GetFactionPactsCompleted(f41_arg0, f41_arg1.playercalling, f41_local1.season, f41_local1.factionHash)
	for f41_local7, f41_local8 in pairs(CoD.ZombiesCallingsUtility.FactionCallingPact) do
		if not f41_local1.prematchCallingInfo.pacts[f41_local8].complete and f41_local1.currentCallingInfo.pacts[f41_local8].complete then
			f41_local2 = f41_local2 + 1
			local f41_local6 = {
				mainTitle = @"hash_6FF2D60C66A90DF",
				factionName = f41_local1.factionAsset[@"factionname"],
			}
			if CoD.ZombiesCallingsUtility.FactionCallingsPerSeason < f41_local2 then
				f41_local6.message = 0x0
			else
				f41_local6.message = f41_local1.bundle.factioncallingseasons[f41_local1.season].factionlist[f41_local1.factionIndex].factionlorelist[f41_local2][@"lore"]
			end
			f41_local6.newPactsCompleted = f41_local2
			table.insert(f41_local0, f41_local6)
		end
	end
	if not f41_local1.prematchCallingInfo.complete and f41_local1.currentCallingInfo.complete then
		table.insert(f41_local0, {
			mainTitle = @"hash_22A24BEE97FF0D65",
			factionName = f41_local1.factionAsset[@"factionname"],
			message = f41_local1.bundle.factioncallingseasons[f41_local1.season].callinglist[f41_local1.callingInSeason].factionresponses[f41_local1.factionIndex][@"hash_3F21ECA631599F79"],
		})
	end
	return f41_local0
end
CoD.ZombiesCallingsUtility.GetFactionCallingRewardModels = function(f42_arg0, f42_arg1, f42_arg2)
	local f42_local0 = {}
	local f42_local1 = CoD.ZombiesCallingsUtility.GetFactionCallingAARInfo(f42_arg0, f42_arg1, f42_arg2)
	if not f42_local1 then
		return f42_local0
	end
	for f42_local8, f42_local9 in pairs(CoD.ZombiesCallingsUtility.FactionCallingPact) do
		if not f42_local1.prematchCallingInfo.pacts[f42_local9].complete and f42_local1.currentCallingInfo.pacts[f42_local9].complete then
			local f42_local5 = {}
			local f42_local6 = CoD.GameTypeUtility.GameTypeToLocalizeName(f42_local1.prematchCallingInfo.pacts[f42_local9].gametype)
			f42_local5.mainTitle = @"menu/faction_calling"
			local f42_local7 = ""
			if f42_local1.prematchCallingInfo.pacts[f42_local9].isGoal then
				f42_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_53815835F2593D1", f42_local6)
			else
				f42_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1442F1290B5BE066", f42_local6)
			end
			f42_local5.levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_E7E238DA43A9CC9", f42_local7)
			f42_local5.mainIcon = f42_local1.factionAsset.image
			f42_local5.rewardType = CoD.AARUtility.AARRewardType.FACTION_CALLING
			f42_local5.isFactionPact = true
			f42_local5.challengeName = f42_local1.factionAsset[@"factionname"]
			f42_local5.challengeDesc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7E3CA357FB929775")
			f42_local5.challengeImage = f42_local1.factionAsset[@"tokenimage"]
			table.insert(f42_local0, f42_local5)
		end
	end
	for f42_local8, f42_local9 in pairs(CoD.ZombiesCallingsUtility.FactionCallingPact) do
		for f42_local5 = 1, #f42_local1.prematchCallingInfo.pacts[f42_local9].tasks, 1 do
			if not f42_local1.prematchCallingInfo.pacts[f42_local9].tasks[f42_local5].complete and f42_local1.currentCallingInfo.pacts[f42_local9].tasks[f42_local5].complete then
				local f42_local10 = CoD.ZombiesCallingsUtility.GetCallingTaskInfo(f42_local1.prematchCallingInfo.pacts[f42_local9].tasks[f42_local5].name)
				if f42_local10 then
					table.insert(f42_local0, {
						mainTitle = @"menu/faction_calling",
						levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_E7E238DA43A9CC9", Engine[@"hash_4F9F1239CFD921FE"](f42_local10[@"taskname"])),
						mainIcon = f42_local10.image,
						rewardType = CoD.AARUtility.AARRewardType.FACTION_CALLING,
						isFactionPact = false,
						totalXP = Engine[@"hash_4F9F1239CFD921FE"](@"rank/xp", f42_local1.prematchCallingInfo.pacts[f42_local9].tasks[f42_local5].xp),
					})
				end
			end
		end
	end
	return f42_local0
end
CoD.ZombiesCallingsUtility.GetRewardCompletion = function(f43_arg0, f43_arg1, f43_arg2)
	local f43_local0 = LuaUtils.GetCallingsStats(f43_arg0)
	local f43_local1 = CoD.ZombiesCallingsUtility.FactionRewardCompletions[f43_arg2].rewardHashes
	if not f43_local1 or #f43_local1 == 0 then
		return false
	end
	local f43_local2 = LuaUtils.GetCallingsBundle()
	if not f43_local2 then
		return false
	end
	for f43_local17, f43_local18 in pairs(CoD.ZombiesCallingsUtility.FactionCirclePositions) do
		local f43_local19 = f43_local2.factioncallingseasons[f43_arg1].factionlist[f43_local18.index]
		if f43_local19 then
			local f43_local6 = Engine[@"converttoxhash"](f43_local19[@"hash_237E6733A4393CBA"])
			for f43_local13, f43_local14 in ipairs(CoD.ZombiesCallingsUtility.FactionCallingRewardCasts) do
				for f43_local10, f43_local11 in ipairs(f43_local1) do
					if f43_local0.seasons[f43_arg1 - 1].factions[f43_local6].rewards[f43_local14].purchased[f43_local11]:get() == 0 then
						return false
					end
				end
			end
		end
	end
	return true
end
CoD.ZombiesCallingsUtility.GetFactionCompletion = function(f44_arg0, f44_arg1, f44_arg2)
	local f44_local0 = LuaUtils.GetCallingsStats(f44_arg0)
	for f44_local7, f44_local8 in ipairs(CoD.ZombiesCallingsUtility.FactionCallingRewardCasts) do
		for f44_local4, f44_local5 in pairs(CoD.ZombiesCallingsUtility.FactionCallingRewards) do
			if f44_local0.seasons[f44_arg1 - 1].factions[f44_arg2].rewards[f44_local8].purchased[f44_local4]:get() == 0 then
				return false
			end
		end
	end
	return true
end
CoD.ZombiesCallingsUtility.GetFactionRewardCompletionInfo = function(f45_arg0, f45_arg1)
	local f45_local0 = {}
	for f45_local12, f45_local13 in pairs(CoD.ZombiesCallingsUtility.FactionRewardCompletions) do
		if not f45_local0[f45_local12] then
			f45_local0[f45_local12] = {}
		end
		if f45_local12 == "faction" then
			f45_local0[f45_local12].factions = {}
			local f45_local4 = LuaUtils.GetCallingsBundle()
			if f45_local4 then
				for f45_local9, f45_local10 in pairs(CoD.ZombiesCallingsUtility.FactionCirclePositions) do
					local f45_local11 = f45_local4.factioncallingseasons[f45_arg1].factionlist[f45_local10.index]
					if f45_local11 then
						local f45_local8 = Engine[@"converttoxhash"](f45_local11[@"hash_237E6733A4393CBA"])
						f45_local0[f45_local12].factions[f45_local8] = {
							complete = CoD.ZombiesCallingsUtility.GetFactionCompletion(f45_arg0, f45_arg1, f45_local8),
						}
					end
				end
			end
		end
		f45_local0[f45_local12].complete = CoD.ZombiesCallingsUtility.GetRewardCompletion(f45_arg0, f45_arg1, f45_local12)
	end
	return f45_local0
end
CoD.ZombiesCallingsUtility.InitFactionCircleModel = function(f46_arg0, f46_arg1)
	local f46_local0 = f46_arg1:getModel()
	if not f46_local0 then
		return
	end
	local f46_local1 = nil
	for f46_local8, f46_local9 in pairs(CoD.ZombiesCallingsUtility.FactionCirclePositions) do
		f46_local1 = f46_local0:create(f46_local9.name)
		if f46_local1 then
			local f46_local5 = f46_local1:create("factionHash")
			f46_local5 = f46_local5:get()
			local f46_local6 = DataSources.ZMFactionCallingGlobal.getModel(f46_arg0)
			local f46_local7 = f46_local6:create("factionHash")
			if f46_local5 == f46_local7:get() then
				break
			end
		end
	end
	if f46_local1 then
		f46_local2 = f46_local0:create("selectedFactionCircleModel")
		f46_local2:set(f46_local1)
	end
end
CoD.ZombiesCallingsUtility.SetFactionCircleModelToElementModel = function(f47_arg0, f47_arg1, f47_arg2)
	local f47_local0 = f47_arg1:getModel()
	if not f47_local0 then
		return
	else
		local f47_local1 = f47_arg2:getModel()
		if not f47_local1 then
			return
		else
			local f47_local2 = f47_local0:create("selectedFactionCircleModel")
			f47_local2:set(f47_local1)
		end
	end
end
CoD.ZombiesCallingsUtility.TryPurchaseReward = function(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
	local f48_local0 = f48_arg3:getModel()
	if not f48_local0 then
		return
	end
	local f48_local1 = f48_arg3.factionHash
	local f48_local2 = CoD.ZombiesCallingsUtility.GetFactionTokens(f48_arg1, f48_local1)
	if CoD.SafeGetModelValue(f48_local0, "purchased") then
		LuaUtils.ShowMessageDialog(f48_arg1, Enum.MessageDialogType[@"message_dialog_type_warning"], Engine[@"hash_4F9F1239CFD921FE"](@"hash_7C0691CE32B2B9FE"), Engine[@"hash_4F9F1239CFD921FE"](@"hash_69AE5112F8179F4E"))
	elseif f48_local2 > 0 then
		OpenSystemOverlay(f48_arg0, f48_arg2, f48_arg1, "FactionRewardConfirmation", {
			_listElement = f48_arg3,
			_model = f48_local0,
			_statTable = {
				seasonId = f48_arg3.seasonId,
				factionHash = f48_arg3.factionHash,
				castHash = f48_arg3.castHash,
				rewardHash = f48_arg3.rewardHash,
			},
		})
	else
		LuaUtils.ShowMessageDialog(f48_arg1, Enum.MessageDialogType[@"message_dialog_type_error"], Engine[@"hash_4F9F1239CFD921FE"](@"hash_27A5B9FFE84B2B9", CoD.ZombiesCallingsUtility.GetFactionName(f48_local1)), Engine[@"hash_4F9F1239CFD921FE"](@"hash_21EC34717A510BE7"))
	end
end
CoD.ZombiesCallingsUtility.SetFactionRewardNameToElementName = function(f49_arg0, f49_arg1)
	local f49_local0 = f49_arg1:getModel()
	if not f49_local0 then
		return
	else
		local f49_local1 = CoD.SafeGetModelValue(f49_local0, "name") or 0x0
		local f49_local2 = DataSources.ZMFactionCallingGlobal.getModel(f49_arg0)
		local f49_local3 = f49_local2:create("focusedRewardName")
		f49_local3:set(f49_local1)
	end
end
CoD.ZombiesCallingsUtility.FactionCircleModelEqualToElementModel = function(f50_arg0, f50_arg1, f50_arg2)
	local f50_local0 = f50_arg1:getModel()
	if not f50_local0 then
		return false
	else
		local f50_local1 = f50_arg2:getModel()
		if not f50_local1 then
			return false
		else
			local f50_local2 = f50_local0:create("selectedFactionCircleModel")
			return f50_local2:get() == f50_local1
		end
	end
end
CoD.ZombiesCallingsUtility.SetActiveListItemToCurrentCalling = function(f51_arg0, f51_arg1)
	local f51_local0 = DataSources.ZMFactionCallingGlobal.getModel(f51_arg0)
	local f51_local1 = f51_local0:create("callingId")
	f51_arg1:findItem({
		callingId = f51_local1:get(),
	}, nil, true, false)
end
CoD.ZombiesCallingsUtility.ProceedToNextScreenState = function(f52_arg0)
	local f52_local0 = DataSources.ZMFactionCallingGlobal.getModel(f52_arg0)
	f52_local0 = f52_local0:create("FactionCallingScreenState")
	local f52_local1 = LuaUtils.GetCallingsStats(f52_arg0)
	local f52_local2 = f52_local1.currentseason
	local f52_local3 = f52_local1.currentcallingid
	local f52_local4 = f52_local1.currentfaction
	if f52_local0:get() == CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FIRST_SEASON_INTERACTION then
		f52_local0:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FACTION_SELECTION)
	elseif f52_local0:get() == CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FACTION_SELECTION then
		local f52_local5 = f52_local1.seasons
		local f52_local6 = f52_local2
		if f52_local5[f52_local2:get()][@"hash_4E145BC7755A9A8B"]:get() == 0 then
			f52_local5 = f52_local1.seasons
			f52_local6 = f52_local2
			f52_local5[f52_local2:get()][@"hash_4E145BC7755A9A8B"]:set(1)
			f52_local5 = f52_local1.seasons
			f52_local6 = f52_local2
			f52_local5[f52_local2:get()][@"hash_7E597FBE41270A4D"]:set(f52_local4:get())
			f52_local5 = DataSources.ZMFactionCallingGlobal.getModel(f52_arg0)
			Engine.ForceNotifyModelSubscriptions(f52_local5:create("seasonId"))
		end
		f52_local5 = f52_local1.seasons
		f52_local6 = f52_local2
		f52_local5 = f52_local5[f52_local2:get()].factions
		f52_local6 = f52_local4
		f52_local5[f52_local4:get()][@"hash_346F514A63AA16E2"]:set(1)
		f52_local0:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FACTION_ACTIVATION)
	elseif f52_local0:get() == CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FACTION_ACTIVATION then
		local f52_local5 = f52_local1.seasons
		local f52_local6 = f52_local2
		f52_local5 = f52_local5[f52_local2:get()].callings
		f52_local6 = f52_local3
		if f52_local5[f52_local3:get()][@"hash_4E145BC7755A9A8B"]:get() ~= 0 then
			f52_local1[@"hash_5BF1EBBFA7B16C64"]:set(1)
			f52_local0:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.DEFAULT)
		else
			f52_local0:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FIRST_CALLING_INTERACTION)
		end
	elseif f52_local0:get() == CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FIRST_CALLING_INTERACTION then
		f52_local0:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FACTION_RESPONSE)
	elseif f52_local0:get() == CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FACTION_RESPONSE then
		local f52_local5 = f52_local1.seasons
		local f52_local6 = f52_local2
		f52_local5 = f52_local5[f52_local2:get()].callings
		f52_local6 = f52_local3
		f52_local5[f52_local3:get()][@"hash_4E145BC7755A9A8B"]:set(1)
		f52_local1[@"hash_5BF1EBBFA7B16C64"]:set(1)
		f52_local0:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.DEFAULT)
	elseif f52_local0:get() == CoD.ZombiesCallingsUtility.FactionCallingScreenStates.DEFAULT then
	else
		assert(false)
	end
	LuaUtils.StorageWriteZMProgression(f52_arg0)
	CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f52_arg0)
end
CoD.ZombiesCallingsUtility.InitZMFactionCallingModels = function(f53_arg0)
	LuaUtils.UpdateFactionCallings(f53_arg0)
	local f53_local0 = DataSources.ZMFactionCallingGlobal.getModel(f53_arg0)
	local f53_local1 = LuaUtils.GetCallingsStats(f53_arg0)
	if f53_local1[@"hash_5BF1EBBFA7B16C64"]:get() ~= 0 or IsBooleanDvarSet(@"hash_58F994187B13BED2") then
		f53_local0.FactionCallingScreenState:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.DEFAULT)
	else
		local f53_local2 = f53_local1.seasons
		local f53_local3 = f53_local1.currentseason
		if f53_local2[REG4:get()][@"hash_4E145BC7755A9A8B"]:get() ~= 0 then
			f53_local0.FactionCallingScreenState:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FACTION_SELECTION)
		else
			f53_local0.FactionCallingScreenState:set(CoD.ZombiesCallingsUtility.FactionCallingScreenStates.FIRST_SEASON_INTERACTION)
		end
	end
	CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f53_arg0)
end
CoD.ZombiesCallingsUtility.InitZMFactionRewardModels = function(f54_arg0)
	LuaUtils.UpdateFactionCallings(f54_arg0)
	CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f54_arg0)
end
DataSourceHelpers.PerControllerDataSourceSetup("FactionInspect", "FactionInspect", function(f55_arg0, f55_arg1)
	f55_arg0:create("artifactModel")
end, false)
CoD.ZombiesCallingsUtility.GetFactionCircleModels = function(f56_arg0, f56_arg1, f56_arg2)
	local f56_local0 = LuaUtils.GetCallingsBundle()
	if f56_local0 == nil then
		return nil
	end
	local f56_local1 = f56_local0.factioncallingseasons[f56_arg1].factionlist[f56_arg2]
	if f56_local1 == nil then
		return nil
	end
	local f56_local2 = LuaUtils.GetCallingsStats(f56_arg0)
	local f56_local3 = Engine[@"converttoxhash"](f56_local1[@"hash_237E6733A4393CBA"])
	local f56_local4 = f56_local2.seasons[f56_arg1 - 1].factions[f56_local3][@"hash_346F514A63AA16E2"]:get() == 0
	local f56_local5 = f56_local2.seasons[f56_arg1 - 1].factions[f56_local3].pactscompleted:get()
	local f56_local6 = 0x0
	local f56_local7 = 0x0
	local f56_local8 = 0x0
	if f56_local4 then
		f56_local6 = f56_local1[@"hash_4F9D43DDC39BE49C"] or 0x0
		f56_local7 = f56_local1[0x29D84303DB4FDB] or 0x0
		f56_local8 = @"hash_7CB535FFCF764548"
	else
		local f56_local9 = CoD.ZombiesCallingsUtility.GetFactionAsset(f56_local3)
		if f56_local9 then
			f56_local6 = f56_local9[@"selectionprompt"] or 0x0
			f56_local7 = f56_local9[@"confirmationprompt"] or 0x0
		end
		f56_local8 = @"hash_2B5C6013897E7F20"
	end
	local f56_local9 = function(f57_arg0, f57_arg1, f57_arg2)
		DataSources[f57_arg0] = DataSourceHelpers.ListSetup(f57_arg0, function(f58_arg0, f58_arg1)
			local f58_local0 = {}
			for f58_local4, f58_local5 in pairs(CoD.ZombiesCallingsUtility.FactionCallingRewards) do
				local f58_local6 = f56_local1.rewardcastlist[f57_arg2].rewardlist[f58_local5.index]
				if f58_local6 then
					table.insert(f58_local0, {
						models = {
							image = f58_local6.image or "blacktransparent",
							name = f58_local6.name or 0x0,
							purchased = f56_local2.seasons[f56_arg1 - 1].factions[f56_local3].rewards[f57_arg1].purchased[f58_local4]:get() ~= 0,
							lootId = f58_local6.lootid or 0x0,
						},
						properties = {
							seasonId = f56_arg1,
							factionHash = f56_local3,
							castHash = f57_arg1,
							rewardHash = f58_local4,
							sortOrder = f58_local5.index,
						},
					})
				end
			end
			table.sort(f58_local0, function(f59_arg0, f59_arg1)
				return f59_arg0.properties.sortOrder < f59_arg1.properties.sortOrder
			end)
			if #f58_local0 > 0 then
				f58_local0[1].properties.first = true
				f58_local0[#f58_local0].properties.last = true
			end
			return f58_local0
		end, nil, nil, nil)
		return f57_arg0
	end
	local f56_local10 = function(f60_arg0)
		local f60_local0 = f60_arg0
		DataSources[f60_local0] = DataSourceHelpers.ListSetup(f60_local0, function(f61_arg0, f61_arg1)
			local f61_local0 = {}
			if not CoD.ZombiesCallingsUtility.FactionCallingRewardCasts[f56_arg1] then
				return f61_local0
			end
			for f61_local4, f61_local5 in ipairs(CoD.ZombiesCallingsUtility.FactionCallingRewardCasts) do
				local f61_local6 = f56_local1.rewardcastlist[f61_local4]
				if f61_local6 then
					table.insert(f61_local0, {
						models = {
							castName = f61_local6[@"castname"] or 0x0,
							rewards = f56_local9(f60_local0 .. "_" .. f61_local4, f61_local5, f61_local4),
						},
						properties = {},
					})
				end
			end
			if #f61_local0 > 0 then
				f61_local0[1].properties.first = true
				f61_local0[#f61_local0].properties.last = true
			end
			return f61_local0
		end, nil, nil, nil)
		return f60_local0
	end
	local f56_local11 = function(f62_arg0)
		local f62_local0 = f62_arg0
		DataSources[f62_local0] = DataSourceHelpers.ListSetup(f62_local0, function(f63_arg0, f63_arg1)
			local f63_local0 = {}
			local f63_local1 = f56_local1.factionlorelist
			for f63_local2 = 1, math.min(f56_local5, #f63_local1), 1 do
				table.insert(f63_local0, {
					models = {
						message = f63_local1[f63_local2][@"lore"] or 0x0,
					},
					properties = {},
				})
			end
			if #f63_local0 > 0 then
				f63_local0[1].properties.first = true
				f63_local0[#f63_local0].properties.last = true
			end
			return f63_local0
		end, nil, nil, nil)
		return f62_local0
	end
	return {
		factionHash = f56_local3,
		isFirstTime = f56_local4,
		selectionPrompt = f56_local6,
		confirmationPrompt = f56_local7,
		confirmationTitle = f56_local8,
		seasonId = f56_arg1,
		rewardCasts = f56_local10("rewardCasts_" .. f56_arg1 .. "_" .. f56_arg2),
		factionLore = f56_local11("factionLore_" .. f56_arg1 .. "_" .. f56_arg2),
	}
end
CoD.ZombiesCallingsUtility.GetFactionArtifactModels = function(f64_arg0, f64_arg1, f64_arg2)
	local f64_local0 = {}
	local f64_local1 = CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f64_arg0)
	local f64_local2 = CoD.ZombiesCallingsUtility.FactionCallingsPerSeason
	if f64_arg2 <= f64_arg1 then
		local f64_local3 = f64_local1:create("latestCallingId")
		f64_local2 = f64_local3:get()
	end
	local f64_local3 = function(f65_arg0, f65_arg1)
		local f65_local0 = LuaUtils.GetCallingsBundle()
		if f65_local0 == nil then
			return ""
		else
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FD4CBD5EDED0247", Engine[@"hash_4F9F1239CFD921FE"](f65_local0.factioncallingseasons[f65_arg0][@"seasonname"]), Engine[@"hash_4F9F1239CFD921FE"](@"hash_4B8B9F328BC7D3AE", f65_arg1 .. ""))
		end
	end
	local f64_local4 = function(f66_arg0)
		local f66_local0 = f66_arg0
		local f66_local1 = f64_arg1
		local f66_local2 = f64_local2
		local f66_local3 = f64_local1:create("seasonId")
		DataSources[f66_local0] = DataSourceHelpers.ListSetup(f66_local0, function(f67_arg0, f67_arg1)
			local f67_local0 = {}
			local f67_local1 = LuaUtils.GetCallingsBundle()
			if f67_local1 == nil then
				return f67_local0
			end
			for f67_local2 = 1, f66_local2, 1 do
				local f67_local5 = CoD.ZombiesCallingsUtility.GetFactionCallingCompletion(f67_arg0, nil, f66_local1, f67_local2)
				table.insert(f67_local0, {
					models = {
						seasonId = f66_local1,
						callingId = f67_local2,
						callingName = f64_local3(f66_local1, f67_local2),
						complete = f67_local5.complete,
						percentComplete = f67_local5.percentComplete,
						callingIntroMessage = f67_local1.factioncallingseasons[f66_local1].callinglist[f67_local2][@"callingintro"],
					},
					properties = {
						hideActivationPrompt = true,
					},
				})
			end
			if f67_arg1.seasonSubscription == nil then
				f67_arg1.seasonSubscription = f67_arg1:subscribeToModel(f66_local3, function()
					f67_arg1:updateDataSource()
				end, false)
			end
			if #f67_local0 > 0 then
				f67_local0[1].properties.first = true
				f67_local0[#f67_local0].properties.last = true
			end
			return f67_local0
		end, nil, nil, nil)
		return f66_local0
	end
	for f64_local8, f64_local9 in pairs(CoD.ZombiesCallingsUtility.FactionCirclePositions) do
		f64_local0[f64_local9.name] = CoD.ZombiesCallingsUtility.GetFactionCircleModels(f64_arg0, f64_arg1, f64_local9.index)
	end
	f64_local0.seasonId = f64_arg1
	f64_local0.selectedFactionCircleModel = Engine.GetGlobalModel()
	f64_local0.callings = f64_local4("factionArtifactCallings_" .. f64_arg1)
	f64_local5 = LuaUtils.GetCallingsBundle()
	if f64_local5 then
		f64_local0.seasonIntroMessage = f64_local5.factioncallingseasons[f64_arg1][@"seasonintro"]
	end
	return f64_local0
end
DataSources.FactionArtifact = ListHelper_SetupDataSource("FactionArtifact", function(f69_arg0, f69_arg1)
	local f69_local0 = {}
	local f69_local1 = CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f69_arg0)
	local f69_local2 = f69_local1:create("latestSeasonId")
	f69_local2 = f69_local2:get()
	local f69_local3 = f69_local1:create("seasonId")
	f69_local3 = f69_local3:get()
	for f69_local4 = 1, f69_local2, 1 do
		table.insert(f69_local0, {
			models = CoD.ZombiesCallingsUtility.GetFactionArtifactModels(f69_arg0, f69_local4, f69_local2),
			properties = {
				selectIndex = f69_local3 == f69_local4,
			},
		})
	end
	return f69_local0
end, true)
CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels = function(f70_arg0, f70_arg1)
	if not f70_arg1 then
		f70_arg1 = DataSources.ZMFactionCallingGlobal.getModel(f70_arg0)
	end
	local f70_local0 = f70_arg1:create("seasonId")
	local f70_local1 = f70_arg1:create("latestSeasonId")
	local f70_local2 = f70_arg1:create("callingId")
	local f70_local3 = f70_arg1:create("latestCallingId")
	local f70_local4 = f70_arg1:create("factionHash")
	local f70_local5 = f70_arg1:create("isCallingLive")
	local f70_local6 = LuaUtils.GetCallingsStats(f70_arg0)
	f70_local0:set(f70_local6.currentseason:get() + 1)
	f70_local1:set(f70_local6.currentseasondvar:get() + 1)
	f70_local2:set(f70_local6.currentcallingid:get() + 1)
	f70_local3:set(f70_local6[@"hash_4D468697915DFAA"]:get() + 1)
	f70_local4:set(f70_local6.currentfaction:get())
	f70_local5:set(f70_local6[@"hash_5BF1EBBFA7B16C64"]:get() ~= 0)
	return f70_arg1
end
CoD.ZombiesCallingsUtility.SetupFactionCallingFullscreenModels = function(f71_arg0)
	local f71_local0, f71_local1 = CoD.AARUtility.GetStats(f71_arg0)
	local f71_local2 = CoD.ZombiesCallingsUtility.GetFactionCallingFullscreenModels(f71_arg0, f71_local0, f71_local1)
	local f71_local3 = DataSources.AARFactionCalling.getModel(f71_arg0)
	local f71_local4 = f71_local3:create("Fullscreens")
	for f71_local8, f71_local9 in ipairs(f71_local2) do
		local f71_local10 = f71_local4:create(f71_local8)
		local f71_local11 = f71_local10:create("mainTitle")
		f71_local11:set(f71_local9.mainTitle)
		f71_local11 = f71_local10:create("factionName")
		f71_local11:set(f71_local9.factionName)
		f71_local11 = f71_local10:create("message")
		f71_local11:set(f71_local9.message)
		f71_local11 = f71_local10:create("shouldProgressFactionCircle")
		f71_local11:set(f71_local9.newPactsCompleted ~= nil)
		f71_local11 = f71_local10:create("newPactsCompleted")
		f71_local11:set(f71_local9.newPactsCompleted)
	end
	f71_local5 = f71_local3:create("NumFullscreens")
	f71_local5:set(#f71_local2)
	f71_local5 = f71_local3:create("CurrentFullscreenIndex")
	f71_local5:set(0)
	CoD.ZombiesCallingsUtility.NextFactionCallingFullscreen(f71_arg0)
end
CoD.ZombiesCallingsUtility.NextFactionCallingFullscreen = function(f72_arg0)
	local f72_local0 = DataSources.AARFactionCalling.getModel(f72_arg0)
	local f72_local1 = f72_local0:create("CurrentFullscreenIndex")
	f72_local1:set(f72_local1:get() + 1)
	local f72_local2 = f72_local0:create("Fullscreens")
	if f72_local2[f72_local1:get()] then
		local f72_local3 = f72_local0:create("FactionCallingFullscreenModels")
		f72_local3:set(f72_local2[f72_local1:get()])
		Engine.ForceNotifyModelSubscriptions(f72_local0:create("UpdateFullscreenWidget"))
	end
end
CoD.ZombiesCallingsUtility.FactionCallingFullscreensRemaining = function(f73_arg0)
	local f73_local0 = DataSources.AARFactionCalling.getModel(f73_arg0)
	local f73_local1 = f73_local0:create("CurrentFullscreenIndex")
	f73_local1 = f73_local1:get()
	local f73_local2 = f73_local0:create("NumFullscreens")
	f73_local2 = f73_local2:get()
	return f73_local2 and f73_local1 and f73_local1 < f73_local2
end
DataSourceHelpers.PerControllerDataSourceSetup("AARFactionCalling", "AARFactionCalling", function(f74_arg0, f74_arg1)
	f74_arg0:create("Fullscreens")
	f74_arg0:create("FactionCallingFullscreenModels")
	f74_arg0:create("UpdateFullscreenWidget")
	f74_arg0:create("CurrentFullscreenIndex")
	f74_arg0:create("NumFullscreens")
end, false)
DataSourceHelpers.PerControllerDataSourceSetup("ZMFactionCallingGlobal", "ZMFactionCallingGlobal", function(f75_arg0, f75_arg1)
	CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f75_arg1, f75_arg0)
	f75_arg0:create("FactionCallingScreenState")
	f75_arg0:create("focusedRewardName")
	f75_arg0:create("updateRewards")
end, false)
DataSources.ZMFactionCallings = ListHelper_SetupDataSource("ZMFactionCallings", function(f76_arg0, f76_arg1)
	local f76_local0 = {}
	local f76_local1 = CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f76_arg0)
	local f76_local2 = f76_local1:create("latestSeasonId")
	f76_local2 = f76_local2:get()
	local f76_local3 = f76_local1:create("seasonId")
	local f76_local4 = f76_local3:get()
	local f76_local5 = f76_local1:create("updatePacts")
	local f76_local6 = CoD.ZombiesCallingsUtility.FactionCallingsPerSeason
	if f76_local2 <= f76_local4 then
		local f76_local7 = f76_local1:create("latestCallingId")
		f76_local6 = f76_local7:get()
	end
	local f76_local7 = f76_local1:create("callingId")
	f76_local7 = f76_local7:get()
	local f76_local8 = function(f77_arg0, f77_arg1, f77_arg2)
		DataSources[f77_arg1] = DataSourceHelpers.ListSetup(f77_arg1, function(f78_arg0, f78_arg1)
			local f78_local0 = {}
			for f78_local5, f78_local6 in ipairs(f77_arg0.tasks) do
				local f78_local7 = f78_local6.name
				local f78_local8 = CoD.ZombiesCallingsUtility.GetCallingTaskInfo(f78_local7)
				local f78_local9 = table.insert
				local f78_local10 = f78_local0
				local f78_local11 = {}
				local f78_local12 = {
					icon = f78_local8.image,
					name = f78_local7,
					desc = f78_local8[@"descsimple"],
					xp = f78_local6.xp,
					progress = f78_local6.progress,
					target = f78_local6.target,
				}
				local f78_local4
				if f78_local6.target > 0 then
					f78_local4 = f78_local6.progress / f78_local6.target
					if not f78_local4 then
					else
						f78_local12.percentComplete = f78_local4
						f78_local12.complete = f78_local6.target <= f78_local6.progress
						f78_local12.isBig = f77_arg0.isGoal
						f78_local12.callingId = f77_arg2
						f78_local11.models = f78_local12
						f78_local11.properties = {}
						f78_local9(f78_local10, f78_local11)
					end
				end
				f78_local4 = 1
			end
			if #f78_local0 > 0 then
				f78_local0[1].properties.first = true
				f78_local0[#f78_local0].properties.last = true
			end
			if f78_arg1.seasonSubscription == nil then
				f78_arg1.seasonSubscription = f78_arg1:subscribeToModel(f76_local5, function()
					f78_arg1:updateDataSource()
				end, false)
			end
			return f78_local0
		end, nil, nil, nil)
		return f77_arg1
	end
	local f76_local9 = function(f80_arg0, f80_arg1, f80_arg2)
		local f80_local0 = ""
		for f80_local5, f80_local6 in pairs(Engine.GetGametypesBase()) do
			if Engine[@"converttoxhash"](f80_local6.gametype) == f80_arg0.gametype then
				local f80_local4 = @"hash_468080C1400F120E"
				if f80_arg0.isGoal then
				else
					f80_local0 = Engine[@"hash_4F9F1239CFD921FE"](f80_local4, Engine.Localize(f80_local6.name))
					break
				end
				f80_local4 = @"hash_651E474C461D1613"
			end
		end
		return {
			tasks = f76_local8(f80_arg0, f80_arg1, f80_arg2),
			pactName = f80_local0,
			complete = f80_arg0.complete,
		}
	end
	local f76_local10 = function(f81_arg0, f81_arg1)
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FD4CBD5EDED0247", Engine[@"hash_4F9F1239CFD921FE"](@"hash_3213968D264A3F4F", f81_arg0 .. ""), Engine[@"hash_4F9F1239CFD921FE"](@"hash_4B8B9F328BC7D3AE", f81_arg1 .. ""))
	end
	for f76_local11 = 1, f76_local6, 1 do
		local f76_local14 = CoD.ZombiesCallingsUtility.GetFactionCallingCompletion(f76_arg0, nil, f76_local4, f76_local11)
		table.insert(f76_local0, {
			models = {
				seasonId = f76_local4,
				callingId = f76_local11,
				callingName = f76_local10(f76_local4, f76_local11),
				complete = f76_local14.complete,
				percentComplete = f76_local14.percentComplete,
				classicPact = f76_local9(f76_local14.pacts[CoD.ZombiesCallingsUtility.FactionCallingPact[@"classicpact"]], "classicPactTasks_" .. f76_local4 .. "_" .. f76_local11, f76_local11),
				rushPact = f76_local9(f76_local14.pacts[CoD.ZombiesCallingsUtility.FactionCallingPact[@"rushpact"]], "rushPactTasks_" .. f76_local4 .. "_" .. f76_local11, f76_local11),
				tcmPact = f76_local9(f76_local14.pacts[CoD.ZombiesCallingsUtility.FactionCallingPact[@"tcmpact"]], "tcmPactTasks_" .. f76_local4 .. "_" .. f76_local11, f76_local11),
				tcmGoal = f76_local9(f76_local14.pacts[CoD.ZombiesCallingsUtility.FactionCallingPact.tcmgoal], "tcmGoalTasks_" .. f76_local4 .. "_" .. f76_local11, f76_local11),
			},
			properties = {
				selectIndex = f76_local7 == f76_local11,
				hideActivationPrompt = false,
			},
		})
	end
	if #f76_local0 > 0 then
		f76_local0[1].properties.first = true
		f76_local0[#f76_local0].properties.last = true
	end
	if f76_arg1.seasonSubscription == nil then
		f76_arg1.seasonSubscription = f76_arg1:subscribeToModel(f76_local3, function()
			f76_arg1:updateDataSource()
			Engine.ForceNotifyModelSubscriptions(f76_local5)
		end, false)
	end
	return f76_local0
end, true)
CoD.OverlayUtility.AddSystemOverlay("FactionSelectionConfirmation", {
	menuName = "SystemOverlay_Full",
	title = function(f83_arg0, f83_arg1)
		local f83_local0 = f83_arg1._model
		if not f83_local0 then
			return 0x0
		else
			local f83_local1 = f83_local0:create("confirmationTitle")
			return f83_local1:get() or 0x0
		end
	end,
	description = function(f84_arg0, f84_arg1)
		local f84_local0 = f84_arg1._model
		if not f84_local0 then
			return 0x0
		else
			local f84_local1 = f84_local0:create("confirmationPrompt")
			return f84_local1:get() or 0x0
		end
	end,
	image = function(f85_arg0, f85_arg1)
		local f85_local0 = f85_arg1._model
		if not f85_local0 then
			return "blacktransparent"
		else
			local f85_local1 = f85_local0:create("factionHash")
			f85_local1 = f85_local1:get()
			if not f85_local1 then
				return "blacktransparent"
			else
				local f85_local2 = CoD.ZombiesCallingsUtility.GetFactionAsset(f85_local1)
				if not f85_local2 then
					return "blacktransparent"
				else
					return f85_local2.image or "blacktransparent"
				end
			end
		end
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	openMethod = CoD.OverlayUtility.OpenMethods.Popup,
	frameWidget = "CoD.FactionCalling_FactionConfirmation",
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.ContinuePropertyName] = function(f86_arg0, f86_arg1)
		return function(f87_arg0, f87_arg1)
			local f87_local0 = f86_arg1._model:create("factionHash")
			f87_local0 = f87_local0:get()
			if f87_local0 then
				local f87_local1 = LuaUtils.GetCallingsStats(f87_arg1)
				f87_local1.currentfaction:set(f87_local0)
				CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f87_arg1)
			end
			GoBack(f87_arg0, f87_arg1)
			CoD.ZombiesCallingsUtility.ProceedToNextScreenState(f87_arg1)
		end
	end,
	listDatasource = function(f88_arg0, f88_arg1)
		DataSources.FirstTimeFactionRewards = DataSourceHelpers.ListSetup("FirstTimeFactionRewards", function()
			local f89_local0 = f88_arg1._model
			local f89_local1 = f89_local0:create("isFirstTime")
			f89_local1 = f89_local1:get()
			local f89_local2 = {}
			local f89_local3 = LuaUtils.GetCallingsBundle()
			if f89_local1 and f89_local3 then
				local f89_local4 = f89_local0:create("seasonId")
				f89_local4 = f89_local4:get()
				local f89_local5 = f89_local0:create("factionHash")
				f89_local5 = f89_local5:get()
				local f89_local6 = CoD.ZombiesCallingsUtility.GetFactionAsset(f89_local5)
				local f89_local7 = CoD.ZombiesCallingsUtility.GetFactionIndex(f89_local4, f89_local5)
				table.insert(f89_local2, {
					models = {
						image = f89_local3.factioncallingseasons[f89_local4].factionlist[f89_local7][@"hash_4FCE1D23739384E8"] or "blacktransparent",
						factionName = f89_local6[@"factionname"],
						isSticker = true,
						isRewardCompletion = false,
					},
				})
				table.insert(f89_local2, {
					models = {
						image = f89_local3.factioncallingseasons[f89_local4].factionlist[f89_local7][@"hash_7DFE3C8BFD2DB555"] or "blacktransparent",
						factionName = f89_local6[@"factionname"],
						isSticker = false,
						isRewardCompletion = false,
					},
				})
			end
			return f89_local2
		end, true)
		return "FirstTimeFactionRewards"
	end,
})
CoD.OverlayUtility.AddSystemOverlay("CallingActivation", {
	menuName = "SystemOverlay_Full",
	title = @"menu/confirm_selection",
	description = @"hash_533AA81FF351B3F4",
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	openMethod = CoD.OverlayUtility.OpenMethods.Popup,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.ContinuePropertyName] = function(f90_arg0, f90_arg1)
		return function(f91_arg0, f91_arg1)
			local f91_local0 = CoD.SafeGetModelValue(f90_arg1._model, "callingId")
			if f91_local0 then
				local f91_local1 = LuaUtils.GetCallingsStats(f91_arg1)
				f91_local1.currentcallingid:set(f91_local0 - 1)
				LuaUtils.StorageWriteZMProgression(f91_arg1)
				CoD.ZombiesCallingsUtility.ResyncZMFactionCallingStatModels(f91_arg1)
			end
			GoBack(f91_arg0, f91_arg1)
		end
	end,
})
CoD.OverlayUtility.AddSystemOverlay("FactionRewardConfirmation", {
	menuName = "SystemOverlay_Full",
	title = @"menu/confirm_selection",
	image = function(f92_arg0, f92_arg1)
		return CoD.SafeGetModelValue(f92_arg1._model, "image") or "blacktransparent"
	end,
	supportText = function(f93_arg0, f93_arg1)
		return CoD.SafeGetModelValue(f93_arg1._model, "name") or 0x0
	end,
	description = function(f94_arg0, f94_arg1)
		return Engine[@"hash_4F9F1239CFD921FE"](0x1588E3BAA6AB99, CoD.ZombiesCallingsUtility.GetFactionName(f94_arg1._statTable.factionHash))
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	openMethod = CoD.OverlayUtility.OpenMethods.Popup,
	frameWidget = "CoD.FactionRewards_RewardConfirmation",
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.ContinuePropertyName] = function(f95_arg0, f95_arg1)
		return function(f96_arg0, f96_arg1)
			local f96_local0 = f95_arg1._statTable
			local f96_local1 = LuaUtils.GetCallingsStats(f96_arg1)
			local f96_local2 = function(f97_arg0, f97_arg1)
				for f97_local9, f97_local10 in pairs(CoD.ZombiesCallingsUtility.FactionRewardCompletions) do
					if f97_local9 == "faction" then
						for f97_local7, f97_local8 in pairs(f97_arg1[f97_local9].factions) do
							local f97_local6 = f97_local8.complete
							if f97_local6 then
								f97_local6 = not f97_arg0[f97_local9].factions[f97_local7].complete
							end
							f97_local8.complete = f97_local6
						end
					end
					local f97_local3 = f97_arg1[f97_local9]
					local f97_local4 = f97_arg1[f97_local9].complete
					if f97_local4 then
						f97_local4 = not f97_arg0[f97_local9].complete
					end
					f97_local3.complete = f97_local4
				end
			end
			local f96_local3 = function(f98_arg0)
				for f98_local8, f98_local9 in pairs(CoD.ZombiesCallingsUtility.FactionRewardCompletions) do
					if f98_local8 == "faction" then
						for f98_local6, f98_local7 in pairs(f98_arg0[f98_local8].factions) do
							if f98_local7.complete then
								return true
							end
						end
					end
					if f98_arg0[f98_local8].complete then
						return true
					end
				end
				return false
			end
			local f96_local4 = CoD.ZombiesCallingsUtility.GetFactionRewardCompletionInfo(f96_arg1, f96_local0.seasonId)
			f96_local1.seasons[f96_local0.seasonId - 1].factions[f96_local0.factionHash].rewards[f96_local0.castHash].purchased[f96_local0.rewardHash]:set(1)
			local f96_local5 = CoD.ZombiesCallingsUtility.GetFactionRewardCompletionInfo(f96_arg1, f96_local0.seasonId)
			f96_local2(f96_local4, f96_local5)
			LuaUtils.StorageWriteZMProgression(f96_arg1)
			local f96_local6 = DataSources.ZMFactionCallingGlobal.getModel(f96_arg1)
			Engine.ForceNotifyModelSubscriptions(f96_local6:create("updateRewards"))
			local f96_local7 = GoBack(f96_arg0, f96_arg1)
			local f96_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A89E5FA4D0CD0AD", Engine[@"hash_4F9F1239CFD921FE"](CoD.ZombiesCallingsUtility.FactionCallingRewards[f96_local0.rewardHash].name or 0x0))
			if f96_local3(f96_local5) then
				OpenSystemOverlay(f96_arg0, f96_local7, f96_arg1, "FactionRewardCompletion", {
					rewardCompletionTable = f96_local5,
					rewardDescription = f96_local8,
					seasonId = f96_local0.seasonId,
				})
			else
				CoD.OverlayUtility.ShowToast("FactionReward", nil, f96_local8)
			end
		end
	end,
})
CoD.OverlayUtility.AddSystemOverlay("FactionRewardCompletion", {
	menuName = "SystemOverlay_Full",
	title = "menu/congratulations_caps",
	image = "blacktransparent",
	description = function(f99_arg0, f99_arg1)
		local f99_local0 = f99_arg1.rewardCompletionTable
		local f99_local1 = {}
		for f99_local10, f99_local11 in pairs(CoD.ZombiesCallingsUtility.FactionRewardCompletions) do
			if f99_local10 == "faction" then
				for f99_local8, f99_local9 in pairs(f99_local0[f99_local10].factions) do
					if f99_local9.complete then
						table.insert(f99_local1, CoD.ZombiesCallingsUtility.GetFactionName(f99_local8))
					end
				end
			end
			if f99_local0[f99_local10].complete then
				table.insert(f99_local1, f99_local11.rewardName)
			end
		end
		if #f99_local1 == 1 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_36D3321233A3192A", Engine[@"hash_4F9F1239CFD921FE"](f99_local1[1]))
		elseif #f99_local1 == 2 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_39330E53A5AC04A9", Engine[@"hash_4F9F1239CFD921FE"](f99_local1[1]), Engine[@"hash_4F9F1239CFD921FE"](f99_local1[2]))
		elseif #f99_local1 == 3 then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5B52101A0A4B8DB3", Engine[@"hash_4F9F1239CFD921FE"](f99_local1[1]), Engine[@"hash_4F9F1239CFD921FE"](f99_local1[2]), Engine[@"hash_4F9F1239CFD921FE"](f99_local1[3]))
		elseif #f99_local1 > 3 then
			f99_local2 = nil
			for f99_local3 = 1, #f99_local1 - 1, 1 do
				local f99_local5
				if f99_local2 then
					f99_local5 = f99_local2 .. ", "
					if not f99_local5 then
					else
						f99_local2 = f99_local5 .. f99_local1[f99_local3]
					end
				end
				f99_local5 = ""
			end
			if f99_local2 == nil then
				return ""
			else
				return Engine[@"hash_4F9F1239CFD921FE"](@"hash_39330E53A5AC04A9", f99_local2, Engine[@"hash_4F9F1239CFD921FE"](f99_local1[#f99_local1]))
			end
			f99_local2 = f99_local5 .. f99_local1[f99_local3]
		end
		return ""
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	openMethod = CoD.OverlayUtility.OpenMethods.Popup,
	frameWidget = "CoD.FactionRewards_RewardCompletion",
	[CoD.OverlayUtility.ContinuePropertyName] = function(f100_arg0, f100_arg1)
		return function(f101_arg0, f101_arg1)
			local f101_local0 = f100_arg1.rewardCompletionTable
			GoBack(f101_arg0, f101_arg1)
			if f100_arg1.rewardDescription and f100_arg1.rewardDescription ~= "" then
				CoD.OverlayUtility.ShowToast("FactionReward", nil, f100_arg1.rewardDescription)
			end
			for f101_local9, f101_local10 in pairs(CoD.ZombiesCallingsUtility.FactionRewardCompletions) do
				if f101_local9 == "faction" then
					for f101_local7, f101_local8 in pairs(f101_local0[f101_local9].factions) do
						if f101_local8.complete then
							CoD.OverlayUtility.ShowToast("FactionReward", nil, Engine[@"hash_4F9F1239CFD921FE"](@"hash_7B0CF0329CDD2111", Engine[@"hash_4F9F1239CFD921FE"](CoD.ZombiesCallingsUtility.GetFactionName(f101_local7))))
						end
					end
				end
				if f101_local0[f101_local9].complete then
					CoD.OverlayUtility.ShowToast("FactionReward", nil, Engine[@"hash_4F9F1239CFD921FE"](@"hash_7B0CF0329CDD2111", Engine[@"hash_4F9F1239CFD921FE"](f101_local10.rewardName)))
				end
			end
		end
	end,
	listDatasource = function(f102_arg0, f102_arg1)
		DataSources.FactionRewardCompletion = DataSourceHelpers.ListSetup("FactionRewardCompletion", function()
			local f103_local0 = f102_arg1.rewardCompletionTable
			local f103_local1 = {}
			local f103_local2 = LuaUtils.GetCallingsBundle()
			if not f103_local2 then
				return f103_local1
			end
			local f103_local3 = f103_local2.factioncallingseasons[f102_arg1.seasonId]
			for f103_local13, f103_local14 in pairs(CoD.ZombiesCallingsUtility.FactionRewardCompletions) do
				if f103_local13 == "faction" then
					for f103_local10, f103_local11 in pairs(f103_local0[f103_local13].factions) do
						local f103_local12 = f103_local3.factionlist[CoD.ZombiesCallingsUtility.GetFactionIndex(f102_arg1.seasonId, f103_local10)]
						if f103_local11.complete and f103_local12 then
							table.insert(f103_local1, {
								models = {
									image = f103_local12[@"hash_7B30604BEB4B9BFA"],
									factionName = f103_local12[@"hash_490E669FF2063466"],
									subtitle = Engine[@"hash_4F9F1239CFD921FE"](@"hash_186C4700A0C8A7B6", CoD.ZombiesCallingsUtility.GetFactionName(f103_local10)),
									isSticker = false,
									isRewardCompletion = true,
								},
							})
						end
					end
				end
				if f103_local0[f103_local13].complete then
					table.insert(f103_local1, {
						models = {
							image = f103_local3[f103_local14.rewardBundleImage],
							factionName = f103_local3[f103_local14.rewardBundleName],
							subtitle = Engine[@"hash_4F9F1239CFD921FE"](@"hash_186C4700A0C8A7B6", f103_local14.rewardName),
							isSticker = false,
							isRewardCompletion = true,
						},
					})
				end
			end
			return f103_local1
		end, true)
		return "FactionRewardCompletion"
	end,
})
CoD.ZombiesCallingsUtility.SendClientScriptMenuChangeNotify = function(f104_arg0, f104_arg1, f104_arg2)
	SendClientScriptMenuChangeNotifyWithState(f104_arg0, f104_arg1, f104_arg2, f104_arg1.currentState)
end
CoD.ZombiesCallingsUtility.GetFactionName = function(f105_arg0)
	local f105_local0 = CoD.ZombiesCallingsUtility.GetFactionAsset(f105_arg0)
	if not f105_local0 then
		return 0x0
	else
		return f105_local0[@"factionname"] or 0x0
	end
end
CoD.ZombiesCallingsUtility.GetFactionCircleImage = function(f106_arg0)
	local f106_local0 = CoD.ZombiesCallingsUtility.GetFactionAsset(f106_arg0)
	if not f106_local0 then
		return "blacktransparent"
	else
		return f106_local0.image or "blacktransparent"
	end
end
CoD.ZombiesCallingsUtility.GetFactionTokenImage = function(f107_arg0)
	local f107_local0 = CoD.ZombiesCallingsUtility.GetFactionAsset(f107_arg0)
	if not f107_local0 then
		return "blacktransparent"
	else
		return f107_local0[@"tokenimage"] or "blacktransparent"
	end
end
CoD.ZombiesCallingsUtility.GetFactionWelcomeMessage = function(f108_arg0)
	local f108_local0 = CoD.ZombiesCallingsUtility.GetFactionAsset(f108_arg0)
	if not f108_local0 then
		return 0x0
	else
		return f108_local0[@"activationmessage"] or 0x0
	end
end
CoD.ZombiesCallingsUtility.GetSeasonName = function(f109_arg0)
	local f109_local0 = LuaUtils.GetCallingsBundle()
	if f109_local0 == nil then
		return 0x0
	else
		local f109_local1 = f109_local0.factioncallingseasons[f109_arg0]
		if f109_local1 == nil then
			return 0x0
		else
			return f109_local1[@"seasonname"] or 0x0
		end
	end
end
CoD.ZombiesCallingsUtility.GetSeasonIntroMessage = function(f110_arg0)
	local f110_local0 = LuaUtils.GetCallingsBundle()
	if f110_local0 == nil then
		return 0x0
	else
		local f110_local1 = f110_local0.factioncallingseasons[f110_arg0]
		if f110_local1 == nil then
			return 0x0
		else
			return f110_local1[@"seasonintro"] or 0x0
		end
	end
end
CoD.ZombiesCallingsUtility.GetCallingIntroMessage = function(f111_arg0, f111_arg1)
	local f111_local0 = LuaUtils.GetCallingsBundle()
	if f111_local0 == nil then
		return 0x0
	else
		local f111_local1 = f111_local0.factioncallingseasons[f111_arg1]
		if f111_local1 == nil then
			return 0x0
		else
			local f111_local2 = DataSources.ZMFactionCallingGlobal.getModel(f111_arg0)
			f111_local2 = f111_local2:create("callingId")
			if f111_local2:get() == nil then
				return 0x0
			else
				local f111_local3 = f111_local1.callinglist[f111_local2:get()]
				if f111_local3 == nil then
					return 0x0
				else
					return f111_local3[@"callingintro"] or 0x0
				end
			end
		end
	end
end
CoD.ZombiesCallingsUtility.GetCallingFactionResponse = function(f112_arg0, f112_arg1)
	local f112_local0 = LuaUtils.GetCallingsBundle()
	if f112_local0 == nil then
		return 0x0
	else
		local f112_local1 = f112_local0.factioncallingseasons[f112_arg1]
		if f112_local1 == nil then
			return 0x0
		else
			local f112_local2 = DataSources.ZMFactionCallingGlobal.getModel(f112_arg0)
			f112_local2 = f112_local2:create("callingId")
			if f112_local2:get() == nil then
				return 0x0
			else
				local f112_local3 = f112_local1.callinglist[f112_local2:get()]
				if f112_local3 == nil then
					return 0x0
				else
					local f112_local4 = DataSources.ZMFactionCallingGlobal.getModel(f112_arg0)
					f112_local4 = f112_local4:create("factionHash")
					if f112_local4:get() == nil then
						return 0x0
					else
						local f112_local5 = f112_local3.factionresponses[CoD.ZombiesCallingsUtility.GetFactionIndex(f112_arg1, f112_local4:get())]
						if f112_local5 == nil then
							return 0x0
						else
							return f112_local5[@"introresponse"] or 0x0
						end
					end
				end
			end
		end
	end
end
CoD.ZombiesCallingsUtility.GetFactionTokens = function(f113_arg0, f113_arg1)
	local f113_local0 = LuaUtils.GetCallingsStats(f113_arg0)
	local f113_local1 = 0
	local f113_local2 = 0
	for f113_local3 = 1, CoD.ZombiesCallingsUtility.MaxFactionCallingSeasons, 1 do
		local f113_local6 = f113_local0.seasons[f113_local3 - 1].factions[f113_arg1]
		f113_local1 = f113_local1 + f113_local6.pactscompleted:get()
		for f113_local13, f113_local14 in ipairs(CoD.ZombiesCallingsUtility.FactionCallingRewardCasts) do
			for f113_local10, f113_local11 in pairs(CoD.ZombiesCallingsUtility.FactionCallingRewards) do
				if f113_local6.rewards[f113_local14].purchased[f113_local10]:get() ~= 0 then
					f113_local2 = f113_local2 + 1
				end
			end
		end
	end
	assert(f113_local2 <= f113_local1)
	return f113_local1 - f113_local2
end
