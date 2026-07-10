CoD.SpecialEventUtility = {}
CoD.SpecialEventUtility.EventStepStatus = LuaEnum.createEnum("COMPLETED", "CURRENT", "INCOMPLETE")
CoD.SpecialEventUtility.SpecialEventTable = "gamedata/stats/zm/zm_event_callings.csv"
CoD.SpecialEventUtility.SpecialEvent_EventCol = 0
CoD.SpecialEventUtility.SpecialEvent_CallingNameCol = 1
CoD.SpecialEventUtility.SpecialEvent_TierCol = 2
CoD.SpecialEventUtility.SpecialEvent_TargetCol = 3
CoD.SpecialEventUtility.SpecialEvent_NameCol = 5
CoD.SpecialEventUtility.SpecialEvent_XPCol = 6
CoD.SpecialEventUtility.SpecialEvent_RewardCol = 7
CoD.SpecialEventUtility.SpecialEvents = {}
CoD.SpecialEventUtility.GetCurrentSpecialEventInfo = function()
	return CoD.SpecialEventUtility.GetSpecialEventInfo(Engine[0x22EAAB59AA27E9B](0x4323BF8006C003F))
end
CoD.SpecialEventUtility.GetSpecialEventInfo = function(f2_arg0)
	if f2_arg0 and 0 < f2_arg0 and not CoD.SpecialEventUtility.SpecialEvents[f2_arg0] then
		local f2_local0 = {}
		local f2_local1 = Engine[0x63FBABD1982143E](CoD.SpecialEventUtility.SpecialEventTable)
		local f2_local2 = 0x0
		local f2_local3 = 0
		for f2_local4 = 0, f2_local1 - 1, 1 do
			if Engine[0xC6F8EC444864600](CoD.SpecialEventUtility.SpecialEventTable, f2_local4, CoD.SpecialEventUtility.SpecialEvent_EventCol) == f2_arg0 then
				local f2_local7 = {}
				local f2_local8 = Engine[0xC6F8EC444864600](CoD.SpecialEventUtility.SpecialEventTable, f2_local4, CoD.SpecialEventUtility.SpecialEvent_CallingNameCol)
				local f2_local9 = Engine[0xC6F8EC444864600](CoD.SpecialEventUtility.SpecialEventTable, f2_local4, CoD.SpecialEventUtility.SpecialEvent_TierCol)
				local f2_local10 = Engine[0xC6F8EC444864600](CoD.SpecialEventUtility.SpecialEventTable, f2_local4, CoD.SpecialEventUtility.SpecialEvent_TargetCol)
				local f2_local11 = Engine[0xC6F8EC444864600](CoD.SpecialEventUtility.SpecialEventTable, f2_local4, CoD.SpecialEventUtility.SpecialEvent_NameCol)
				local f2_local12 = Engine[0xC6F8EC444864600](CoD.SpecialEventUtility.SpecialEventTable, f2_local4, CoD.SpecialEventUtility.SpecialEvent_XPCol)
				local f2_local13 = Engine[0xC6F8EC444864600](CoD.SpecialEventUtility.SpecialEventTable, f2_local4, CoD.SpecialEventUtility.SpecialEvent_RewardCol)
				f2_local2 = f2_local8
				f2_local7.tier = f2_local9
				f2_local7.target = f2_local10
				f2_local7.name = f2_local11
				f2_local7.xp = f2_local12
				f2_local7.reward = f2_local13
				f2_local3 = f2_local3 + 1
				f2_local0[f2_local9] = f2_local7
			end
		end
		if 0 < #f2_local0 then
			f2_local0.statHash = f2_local2
			f2_local0.numTiers = f2_local3
			CoD.SpecialEventUtility.SpecialEvents[f2_arg0] = f2_local0
		end
	end
	return CoD.SpecialEventUtility.SpecialEvents[f2_arg0]
end
CoD.SpecialEventUtility.GetSpecialEventTierInfo = function(f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = CoD.SpecialEventUtility.GetSpecialEventInfo(f3_arg1)
	if f3_local0 then
		return f3_local0[f3_arg2]
	else
		return nil
	end
end
CoD.SpecialEventUtility.GetCurrentSpecialEventTierInfo = function(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = nil
	if not f4_arg1 then
		f4_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
	elseif f4_arg2 then
		f4_local0 = CoD.SpecialEventUtility.GetSpecialEventInfo(f4_arg2)
	end
	if f4_local0 then
		if not f4_arg1 then
			f4_arg1 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer(f4_arg0)
		end
		if f4_arg1 then
			local f4_local1 = f4_arg1.event_calling_stats[f4_local0.statHash]
			if f4_local1 then
				local f4_local2 = f4_local1[0xC45A76A298BA4B6]:get()
				local f4_local3 = f4_local1[0x9909144862249C6]:get()
				local f4_local4 = f4_local0[f4_local2 + 1]
				if f4_local4 then
					f4_local4.progress = f4_local3
					return f4_local4
				end
			end
		end
	end
	return nil
end
DataSources.SpecialEventCurrentStepInfo = {
	getModel = function(f5_arg0)
		local f5_local0 = Engine[0x4DF5CFBC1771947](f5_arg0)
		local f5_local1 = f5_local0:create("specialEventCurrentStepInfo")
		local f5_local2 = f5_local1:create("currentStepNumber")
		local f5_local3 = f5_local1:create("totalStepNumber")
		local f5_local4 = f5_local1:create("stepProgress")
		local f5_local5 = f5_local1:create("taskName")
		local f5_local6 = f5_local1:create("taskDescription")
		local f5_local7 = f5_local1:create("taskIcon")
		local f5_local8 = f5_local1:create("target")
		local f5_local9 = f5_local1:create("taskProgress")
		local f5_local10 = f5_local1:create("taskProgressString")
		local f5_local11 = f5_local1:create("showDailyLayout")
		local f5_local12 = f5_local1:create("taskLargeRewardIcon")
		local f5_local13 = f5_local1:create("taskLargeRewardName")
		local f5_local14 = f5_local1:create("allTasksComplete")
		local f5_local15 = f5_local1:create("allTasksCompleteText")
		local f5_local16 = f5_local1:create("eventName")
		f5_local1:create("timeRemaining")
		f5_local1:create("timeRemainingString")
		local f5_local17 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
		if f5_local17 then
			local f5_local18 = f5_local17.numTiers
			local f5_local19 = CoD.SpecialEventUtility.GetCurrentSpecialEventTierInfo(f5_arg0)
			if f5_local19 then
				local f5_local20 = f5_local19.tier
				local f5_local21 = Engine[0xF9F1239CFD921FE](0xB428662D95FCC11, f5_local20, f5_local18)
				local f5_local22 = f5_local19.name
				local f5_local23 = CoD.ZombiesCallingsUtility.GetCallingTaskInfo(f5_local22)
				local f5_local24 = f5_local23[0xEA461D5E8A182EA]
				local f5_local25 = f5_local23[0xAB612888528489A]
				local f5_local26 = f5_local19.progress
				local f5_local27 = f5_local19.target
				local f5_local28 = 0
				if f5_local27 ~= 0 then
					f5_local28 = f5_local26 / f5_local27
				end
				local f5_local29 = Engine[0xF9F1239CFD921FE](0x31CF0F51CCA3A27, f5_local26, f5_local27)
				local f5_local30 = CoD.ZombiesCallingsUtility.GetEventInfo(f5_local17.statHash)
				local f5_local31 = f5_local30.rewards[f5_local19.reward]
				local f5_local32 = f5_local31[0xAB612888528489A]
				local f5_local33 = f5_local31[0x5EAEF67427CA780]
				local f5_local34 = f5_local30.event[0x55FF29A262A17DC]
				f5_local2:set(f5_local20)
				f5_local3:set(f5_local18)
				f5_local4:set(f5_local21)
				f5_local5:set(f5_local22)
				f5_local6:set(f5_local24)
				f5_local7:set(f5_local25)
				f5_local8:set(f5_local27)
				f5_local9:set(f5_local28)
				f5_local10:set(f5_local29)
				f5_local11:set(f5_local18 <= 1)
				f5_local12:set(f5_local32)
				f5_local13:set(f5_local33)
				f5_local14:set(false)
				f5_local15:set(0x0)
				f5_local16:set(f5_local34)
			else
				local f5_local20 = CoD.ZombiesCallingsUtility.GetEventInfo(f5_local17.statHash)
				local f5_local21 = f5_local20.event[0xC1998404F3713DB]
				f5_local14:set(true)
				f5_local15:set(f5_local21)
			end
		end
		return f5_local1
	end,
}
DataSources.SpecialEventRewards = DataSourceHelpers.ListSetup("SpecialEventRewards", function(f6_arg0, f6_arg1)
	local f6_local0 = {}
	local f6_local1 = Engine[0x8DF2E5447F384B9]()
	f6_local1 = f6_local1:create("AutoEvents")
	f6_local1 = f6_local1:create("cycled")
	local f6_local2 = CoD.SpecialEventUtility.GetCurrentSpecialEventTierInfo(f6_arg0)
	if f6_local2 then
		table.insert(f6_local0, {
			models = {
				rewardImage = 0x620E589747ADBAB,
				rewardText = Engine[0xF9F1239CFD921FE](0xD6137AA2004DB90, f6_local2.xp),
			},
		})
	end
	if f6_arg1.cycledSubscription == nil then
		f6_arg1.cycledSubscription = f6_arg1:subscribeToModel(f6_local1, function()
			f6_arg1:updateDataSource()
		end, false)
	end
	return f6_local0
end, true)
DataSources.SpecialEventSteps = DataSourceHelpers.ListSetup("SpecialEventSteps", function(f8_arg0, f8_arg1)
	local f8_local0 = {}
	local f8_local1 = Engine[0x8DF2E5447F384B9]()
	f8_local1 = f8_local1:create("AutoEvents")
	f8_local1 = f8_local1:create("cycled")
	local f8_local2 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
	if f8_local2 then
		local f8_local3 = f8_local2.numTiers
		local f8_local4 = CoD.SpecialEventUtility.GetCurrentSpecialEventTierInfo(f8_arg0)
		if f8_local4 then
			local f8_local5 = f8_local4.tier
			for f8_local6 = 1, f8_local3, 1 do
				local f8_local9 = CoD.SpecialEventUtility.EventStepStatus.INCOMPLETE
				if f8_local6 == f8_local5 then
					f8_local9 = CoD.SpecialEventUtility.EventStepStatus.CURRENT
				elseif f8_local6 < f8_local5 then
					f8_local9 = CoD.SpecialEventUtility.EventStepStatus.COMPLETED
				end
				table.insert(f8_local0, {
					models = {
						stepStatus = f8_local9,
					},
				})
			end
		end
	end
	if f8_arg1.cycledSubscription == nil then
		f8_arg1.cycledSubscription = f8_arg1:subscribeToModel(f8_local1, function()
			f8_arg1:updateDataSource()
		end, false)
	end
	return f8_local0
end, true)
CoD.SpecialEventUtility.GetSpecialEventRewardModels = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = {}
	local f10_local1 = f10_arg2[0xC539A1B16B48B16]:get()
	local f10_local2 = CoD.SpecialEventUtility.GetCurrentSpecialEventTierInfo(f10_arg0, f10_arg1, f10_local1)
	local f10_local3 = CoD.SpecialEventUtility.GetCurrentSpecialEventTierInfo(f10_arg0, f10_arg2, f10_local1)
	local f10_local4 = CoD.SpecialEventUtility.GetSpecialEventInfo(f10_local1)
	if CoD.BaseUtility.IsDvarEnabled("ui_specialEventAAROverride") then
		f10_local1 = Engine[0x22EAAB59AA27E9B](0x4323BF8006C003F)
		f10_local4 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
		f10_local2 = {
			tier = 1,
		}
		f10_local3 = {
			tier = f10_local4.numTiers + 1,
		}
	end
	if f10_local2 and f10_local4 then
		local f10_local5 = f10_local2.tier
		local f10_local6 = f10_local4.numTiers
		local f10_local7 = f10_local6 + 1
		if f10_local3 then
			f10_local7 = f10_local3.tier
		end
		local f10_local8 = CoD.ZombiesCallingsUtility.GetEventInfo(f10_local4.statHash)
		for f10_local9 = f10_local5, f10_local7 - 1, 1 do
			local f10_local12 = {}
			local f10_local13 = CoD.SpecialEventUtility.GetSpecialEventTierInfo(f10_arg0, f10_local1, f10_local9)
			if f10_local13 then
				local f10_local14 = CoD.ZombiesCallingsUtility.GetCallingTaskInfo(f10_local13.name)
				f10_local12.mainTitle = f10_local8.event[0x55FF29A262A17DC]
				f10_local12.levelText = Engine[0xF9F1239CFD921FE](0xE7E238DA43A9CC9, Engine[0xF9F1239CFD921FE](f10_local14[0x7598EB883D65047]))
				f10_local12.mainIcon = f10_local14[0xAB612888528489A]
				f10_local12.rewardType = CoD.AARUtility.AARRewardType.SPECIAL_EVENT
				local f10_local15 = f10_local8.rewards[f10_local13.reward]
				f10_local12.reward1Title = f10_local15[0x5EAEF67427CA780]
				f10_local12.reward1Icon = f10_local15[0xAB612888528489A]
			end
			f10_local12.tierProgress = f10_local9 + 1
			f10_local12.tierMax = f10_local6
			if f10_local12.tierProgress <= f10_local12.tierMax then
				f10_local12.tierProgressText = Engine[0xF9F1239CFD921FE](0xF9EDEA02A28CA27, f10_local12.tierProgress, f10_local12.tierMax)
			else
				f10_local12.tierProgressText = Engine[0xF9F1239CFD921FE](0xFAA4F4EF7E9C980)
			end
			f10_local12.isTiered = f10_local12.tierMax > 1
			f10_local12.totalXP = Engine[0xF9F1239CFD921FE](0xD6137AA2004DB90, f10_local13.xp)
			table.insert(f10_local0, f10_local12)
		end
	end
	return f10_local0
end
