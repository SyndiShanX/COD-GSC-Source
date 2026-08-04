CoD.PCKoreaEventUtility = {}
CoD.PCKoreaEventUtility.GetWeekStartTime = function()
	return {
		1551203968,
		1551808768,
		1552413568,
		1553018368,
	}
end
CoD.PCKoreaEventUtility.GetWeekEndTime = function()
	return {
		1551808768,
		1552413568,
		1553018368,
		1553623168,
	}
end
CoD.PCKoreaEventUtility.eventEndTime = "1553623200"
CoD.PCKoreaEventUtility.GetRewardsImage = function()
	return {
		"uie_ui_icon_igrevent_reward_1",
		"uie_ui_icon_igrevent_reward_2",
		"uie_ui_icon_igrevent_reward_3",
		"uie_ui_icon_igrevent_reward_4",
	}
end
DataSources.PCKoreaEventWeekList = ListHelper_SetupDataSource("PCKoreaEventWeekList", function(f4_arg0)
	local f4_local0 = 86400
	local f4_local1 = 3600
	local f4_local2 = 3
	local f4_local3 = CoD.PCKoreaEventUtility.GetRewardsImage()
	local f4_local4 = {}
	local f4_local5 = Engine[@"hash_2E43D4F4AB33D421"](f4_arg0)
	local f4_local6 = Engine[@"hash_691D6FDBC677ECD8"]()
	local f4_local7 = CoD.PCKoreaEventUtility.GetWeekStartTime()
	local f4_local8 = CoD.PCKoreaEventUtility.GetWeekEndTime()
	for f4_local9 = 1, #f4_local5.weekly_completion, 1 do
		local f4_local12 = false
		local f4_local13 = false
		local f4_local14 = false
		local f4_local15 = false
		local f4_local16 = f4_local5.weekly_completion[f4_local9].days_completed
		local f4_local17 = f4_local5.prev_weekly_completion[f4_local9].days_completed
		local f4_local18 = ""
		if f4_local7[f4_local9] < f4_local6 and f4_local6 < f4_local8[f4_local9] then
			f4_local12 = true
			local f4_local19, f4_local20, f4_local21, f4_local22 = CoD.PCKoreaEventUtility.GetTimeFromUnixTime(f4_local8[f4_local9] - f4_local6)
			f4_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3DA746FFD2F61827", f4_local19, f4_local20)
		elseif f4_local8[f4_local9] < f4_local6 and f4_local16 < f4_local2 then
			f4_local13 = true
		end
		local f4_local19 = {}
		local f4_local20 = {
			isCompleted = f4_local2 <= f4_local16,
			isActive = f4_local12,
			isFailed = f4_local13,
			weekNumber = f4_local9,
		}
		local f4_local21
		if f4_local2 > f4_local16 or f4_local16 == f4_local17 then
			f4_local21 = false
		else
			f4_local21 = true
		end
		f4_local20.showCompletedAnimation = f4_local21
		f4_local20.weekTimeRemaining = f4_local18
		f4_local20.rewardImage = f4_local3[f4_local9]
		f4_local19.models = f4_local20
		f4_local20 = "PCKoreaEventWeek" .. f4_local9
		DataSources[f4_local20] = CoD.PCKoreaEventUtility.SetupKoreaDayListDataSource(f4_local20, f4_local16, f4_local17, f4_local12, f4_local13)
		f4_local19.models.dayList = f4_local20
		table.insert(f4_local4, f4_local19)
	end
	return f4_local4
end, true)
CoD.PCKoreaEventUtility.SetupKoreaDayListDataSource = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	return DataSourceHelpers.ListSetup(f5_arg0, function(f6_arg0)
		return CoD.PCKoreaEventUtility.GetEventweekProgression(f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	end, false, false, false)
end
CoD.PCKoreaEventUtility.GetEventweekProgression = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = {}
	for f7_local1 = 1, 3, 1 do
		local f7_local4 = {}
		local f7_local5 = {
			isCompleted = f7_local1 <= f7_arg0,
			isActive = f7_arg2 and f7_arg0 < f7_local1,
			isFailed = f7_arg3,
		}
		local f7_local6
		if f7_arg0 ~= f7_local1 or f7_arg0 == f7_arg1 then
			f7_local6 = false
		else
			f7_local6 = true
		end
		f7_local5.showCompletedAnimation = f7_local6
		f7_local4.models = f7_local5
		table.insert(f7_local0, f7_local4)
	end
	return f7_local0
end
DataSources.PCKoreaEventCurrentDayProgression = {
	prepare = function(f8_arg0, f8_arg1, f8_arg2)
		local f8_local0 = 60
		local f8_local1 = 120
		local f8_local2 = 30
		local f8_local3 = Engine.CreateModel(Engine.GetModelForController(f8_arg0), "PCKoreaEventCurrentDayProgression")
		local f8_local4 = Engine[@"hash_2E43D4F4AB33D421"](f8_arg0)
		local f8_local5 = math.floor(f8_local4.progress_today / f8_local2 * f8_local0)
		local f8_local6
		if f8_local4.next_day_utc ~= f8_local4.prev_next_day_utc then
			f8_local6 = 0
			if not f8_local6 then
			else
				local f8_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B14283B7023E6C6", math.ceil(f8_local2 - (f8_local4.progress_today / f8_local2 * f8_local0 - f8_local5) * f8_local2))
				Engine.SetModelValue(Engine.CreateModel(f8_local3, "progression"), f8_local6 / f8_local0)
				Engine.SetModelValue(Engine.CreateModel(f8_local3, "progressBarRatio"), f8_local6 / f8_local1 * f8_local0)
				Engine.SetModelValue(Engine.CreateModel(f8_local3, "showStarCompletedAnimation"), false)
				Engine.SetModelValue(Engine.CreateModel(f8_local3, "showCompletedAnimation"), false)
				Engine.SetModelValue(Engine.CreateModel(f8_local3, "timeRemaining"), f8_local7)
				return f8_local3
			end
		end
		f8_local6 = f8_local4.prev_progress_today
	end,
	getModel = function(f9_arg0)
		if not DataSources.PCKoreaEventCurrentDayProgression.prepared then
			return DataSources.PCKoreaEventCurrentDayProgression.prepare(f9_arg0)
		else
			return Engine.CreateModel(Engine.GetGlobalModel(), "PCKoreaEventCurrentDayProgression")
		end
	end,
}
DataSources.PCKoreaEventProgression = {
	prepare = function(f10_arg0, f10_arg1, f10_arg2)
		local f10_local0 = Engine.CreateModel(Engine.GetModelForController(f10_arg0), "PCKoreaEventProgression")
		local f10_local1 = Engine[@"hash_2E43D4F4AB33D421"](f10_arg0)
		local f10_local2 = 3
		local f10_local3, f10_local4, f10_local5, f10_local6 = CoD.PCKoreaEventUtility.GetTimeFromUnixTime(Engine.GetSecondsRemainingServer(CoD.PCKoreaEventUtility.eventEndTime))
		local f10_local7 = CoD.PCKoreaEventUtility.GetCurrentWeekData(f10_arg0)
		local f10_local8 = true
		for f10_local9 = 1, #f10_local1.weekly_completion, 1 do
			if f10_local1.weekly_completion[f10_local9].days_completed < f10_local2 then
				f10_local8 = false
			end
		end
		Engine.SetModelValue(Engine.CreateModel(f10_local0, "isCompleted"), f10_local8)
		Engine.SetModelValue(Engine.CreateModel(f10_local0, "timeRemaining"), Engine[@"hash_4F9F1239CFD921FE"](@"hash_875394DD29160DA", f10_local3, f10_local4, f10_local5, f10_local6))
		Engine.SetModelValue(Engine.CreateModel(f10_local0, "isCurrentWeekCompleted"), false)
		Engine.SetModelValue(Engine.CreateModel(f10_local0, "currentWeekRewardImage"), f10_local7.weekRewardImage)
		Engine.SetModelValue(Engine.CreateModel(f10_local0, "rewardPopUpImage"), f10_local7.popUpWeekRewardImage)
		Engine.SetModelValue(Engine.CreateModel(f10_local0, "rewardPopUpText"), f10_local7.weekRewardText)
		Engine.SetModelValue(Engine.CreateModel(f10_local0, "showCompletedMonthPopUp"), false)
		return f10_local0
	end,
	getModel = function(f11_arg0)
		if not DataSources.PCKoreaEventProgression.prepared then
			return DataSources.PCKoreaEventProgression.prepare(f11_arg0)
		else
			return Engine.CreateModel(Engine.GetGlobalModel(), "PCKoreaEventProgression")
		end
	end,
}
CoD.PCKoreaEventUtility.SetupKoreaEventRemainingTime = function(f12_arg0, f12_arg1)
	f12_arg0:registerEventHandler("korea_event_tick", function(element, event)
		CoD.PCKoreaEventUtility.TickKoreaEvent(f12_arg1)
	end)
	f12_arg0:addElement(LUI.UITimer.new(100, "korea_event_tick", false, f12_arg0))
end
CoD.PCKoreaEventUtility.GetTimeFromUnixTime = function(f14_arg0)
	local f14_local0 = 86400
	local f14_local1 = 3600
	local f14_local2 = 60
	local f14_local3 = math.floor(f14_arg0 / f14_local0)
	local f14_local4 = math.floor((f14_arg0 - f14_local3 * f14_local0) / f14_local1)
	local f14_local5 = math.floor((f14_arg0 - f14_local3 * f14_local0 - f14_local4 * f14_local1) / f14_local2)
	return f14_local3, f14_local4, f14_local5, f14_arg0 - f14_local3 * f14_local0 - f14_local4 * f14_local1 - f14_local5 * f14_local2
end
CoD.PCKoreaEventUtility.TickKoreaEvent = function(f15_arg0)
	local f15_local0 = Engine.GetModel(Engine.GetModelForController(f15_arg0), "PCKoreaEventProgression.timeRemaining")
	if f15_local0 then
		local f15_local1, f15_local2, f15_local3, f15_local4 = CoD.PCKoreaEventUtility.GetTimeFromUnixTime(Engine.GetSecondsRemainingServer(CoD.PCKoreaEventUtility.eventEndTime))
		f15_local0:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_875394DD29160DA", f15_local1, f15_local2, f15_local3, f15_local4))
	end
end
CoD.PCKoreaEventUtility.GetCurrentWeekData = function(f16_arg0)
	local f16_local0 = Engine[@"hash_691D6FDBC677ECD8"]()
	local f16_local1 = CoD.PCKoreaEventUtility.GetWeekStartTime()
	local f16_local2 = CoD.PCKoreaEventUtility.GetWeekEndTime()
	local f16_local3 = Engine[@"hash_2E43D4F4AB33D421"](f16_arg0)
	local f16_local4 = nil
	local f16_local5 = CoD.PCKoreaEventUtility.GetRewardsImage()
	local f16_local6 = {
		"uie_ui_icon_igrevent_reward_1",
		"uie_ui_icon_igrevent_reward_2",
		"uie_ui_icon_igrevent_reward_3",
		"uie_ui_icon_igrevent_reward_4",
	}
	local f16_local7 = {
		@"hash_79E0BE9E9E425726",
		@"hash_2388F0DF7F9F9652",
		@"hash_7EF2768330FA5343",
		@"hash_6B82397B2896BC0D",
	}
	for f16_local8 = 1, #f16_local3.weekly_completion, 1 do
		f16_local4 = f16_local8
		if f16_local1[f16_local8] < f16_local0 and f16_local0 < f16_local2[f16_local8] then
			break
		end
	end
	return {
		popUpWeekRewardImage = f16_local6[f16_local4],
		weekRewardImage = f16_local5[f16_local4],
		prevDaysCompleted = f16_local3.prev_weekly_completion[f16_local4].days_completed,
		currentDaysCompleted = f16_local3.weekly_completion[f16_local4].days_completed,
		weekRewardText = f16_local7[f16_local4],
	}
end
CoD.PCKoreaEventUtility.ShouldShowTierAnimation = function(f17_arg0, f17_arg1)
	local f17_local0 = 30
	local f17_local1 = 60
	return math.floor(f17_arg0 / f17_local0 * f17_local1) ~= math.floor(f17_arg1 / f17_local0 * f17_local1)
end
CoD.PCKoreaEventUtility.AnimateKoreaEventBar = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	local f18_local0 = 60
	local f18_local1 = 120
	local f18_local2 = 3
	local f18_local3 = 90
	local f18_local4 = Engine[@"hash_2E43D4F4AB33D421"](f18_arg1)
	local f18_local5 = Engine.GetModel(Engine.GetModelForController(f18_arg1), "PCKoreaEventProgression")
	local f18_local6 = Engine.GetModel(Engine.GetModelForController(f18_arg1), "PCKoreaEventCurrentDayProgression")
	local f18_local7
	if f18_local4.next_day_utc ~= f18_local4.prev_next_day_utc then
		f18_local7 = 0
		if not f18_local7 then
		else
			local f18_local8 = f18_local4.progress_today
			local f18_local9 = CoD.PCKoreaEventUtility.GetCurrentWeekData(f18_arg1)
			if f18_local5 and f18_local6 then
				local f18_local10 = 3000
				local f18_local11 = 0
				f18_arg0._delayAnimTimer = LUI.UITimer.newElementTimer(1000, false, function(f19_arg0)
					f18_arg0._barAnimTimer = LUI.UITimer.newElementTimer(10, false, function(f20_arg0)
						f18_local11 = f18_local11 + f20_arg0.timeElapsed
						local f20_local0 = f18_local11 / f18_local10
						f20_local0 = f20_local0 * (2 - f20_local0)
						if f18_local10 <= f18_local11 then
							local f20_local1
							if f18_local3 > f18_local8 / f18_local0 or f18_local7 / f18_local0 > f18_local3 or f18_local8 / f18_local0 >= f18_local1 then
								f20_local1 = false
							else
								f20_local1 = true
							end
							local f20_local2 = CoD.PCKoreaEventUtility.ShouldShowTierAnimation(f18_local8, f18_local7)
							f18_local6.progressBarRatio:set(f18_local8 / f18_local1 * f18_local0)
							f18_local6.progression:set(f18_local8 / f18_local0)
							f18_local6.showCompletedAnimation:set(f20_local2)
							f18_local6.showStarCompletedAnimation:set(f20_local1)
							if f18_local9.prevDaysCompleted ~= f18_local9.currentDaysCompleted and f18_local2 <= f18_local9.currentDaysCompleted then
								if f18_local5.isCompleted:get() then
									f18_local5.showCompletedMonthPopUp:set(true)
								else
									f18_local5.isCurrentWeekCompleted:set(true)
								end
							end
							f18_arg0._barAnimTimer:close()
						else
							local f20_local1 = f20_local0 * (f18_local8 - f18_local7) + f18_local7
							local f20_local2
							if f18_local3 > f20_local1 / f18_local0 or f18_local7 / f18_local0 > f18_local3 or f20_local1 / f18_local0 >= f18_local1 then
								f20_local2 = false
							else
								f20_local2 = true
							end
							local f20_local3 = CoD.PCKoreaEventUtility.ShouldShowTierAnimation(f18_local7, f20_local1)
							f18_local6.progression:set(f20_local1 / f18_local0)
							f18_local6.progressBarRatio:set(f20_local1 / f18_local1 * f18_local0)
							f18_local6.showCompletedAnimation:set(f20_local3)
							f18_local6.showStarCompletedAnimation:set(f20_local2)
						end
					end)
					f18_arg0:addElement(f18_arg0._barAnimTimer)
					f18_arg0._delayAnimTimer:close()
				end)
				f18_arg0:addElement(f18_arg0._delayAnimTimer)
			end
		end
	end
	f18_local7 = f18_local4.prev_progress_today
end
