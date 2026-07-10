CoD.PCAchievementsUtility = {}
CoD.PCAchievementsUtility.CreatePCAchievementTable = function(f1_arg0, f1_arg1)
	local f1_local0 = f1_arg1[@"enabled"]
	local f1_local1 = {}
	local f1_local2 = {
		name = f1_arg1[@"title"],
		desc = f1_arg1[@"description"],
		image = f1_arg1[@"image"],
		score = f1_arg1[@"score"],
		maxValue = 1,
	}
	local f1_local3
	if f1_local0 then
		f1_local3 = 1
		if not f1_local3 then
		else
			f1_local2.currentValue = f1_local3
			f1_local2.isCompleted = f1_local0
			if f1_local0 then
				f1_local3 = 1
				if not f1_local3 then
				else
					f1_local2.progressBarRatio = f1_local3
					f1_local1.models = f1_local2
					return f1_local1
				end
			end
			f1_local3 = 0
		end
	end
	f1_local3 = 0
end
DataSources.PCAchievementNotification = {
	getModel = function(f2_arg0)
		local f2_local0 = Engine[@"getmodelforcontroller"](f2_arg0)
		local f2_local1 = f2_local0["PC.Achievement.Notification"]
		if not f2_local1 then
			f2_local1 = f2_local0:create("PC.Achievement.Notification")
			local f2_local2 = f2_local1:create("name")
			f2_local2:set("ACHIEVEMENTS/ZM_TOWERS_ARENA_TITLE")
			f2_local2 = f2_local1:create("score")
			f2_local2:set("0")
			f2_local2 = f2_local1:create("image")
			f2_local2:set("t7_icon_achievement_safehouse_01")
			f2_local2 = f2_local1:create("showNotification")
			f2_local2:set(false)
		end
		return f2_local1
	end,
}
CoD.PCAchievementsUtility.ShowAchievementNotification = function(f3_arg0, f3_arg1)
	if f3_arg1 then
		local f3_local0 = DataSources.PCAchievementNotification.getModel(f3_arg1)
		f3_local0 = f3_local0.showNotification:get()
		if f3_local0 then
			if f3_arg0._achievementNotificationTimer then
				f3_arg0._achievementNotificationTimer:close()
				f3_arg0._achievementNotificationTimer = nil
			end
			f3_arg0._achievementNotificationTimer = LUI.UITimer.newElementTimer(5000, true, function()
				local f4_local0 = DataSources.PCAchievementNotification.getModel(f3_arg1)
				f4_local0.showNotification:set(false)
				f3_arg0._achievementNotificationTimer:close()
				f3_arg0._achievementNotificationTimer = nil
			end)
			f3_arg0:addElement(f3_arg0._achievementNotificationTimer)
		end
		return f3_local0
	else
		return false
	end
end
DataSources.PCTotalAchievementsScore = {
	getModel = function(f5_arg0)
		local f5_local0 = Engine[@"getmodelforcontroller"](f5_arg0)
		local f5_local1 = f5_local0["PC.Achievement.TotalScore"]
		if not f5_local1 then
			f5_local1 = f5_local0:create("PC.Achievement.TotalScore")
			local f5_local2 = f5_local1:create("maxScore")
			f5_local2:set("0")
			f5_local2 = f5_local1:create("score")
			f5_local2:set("0")
			f5_local2 = f5_local1:create("progress")
			f5_local2:set("0")
		end
		return f5_local1
	end,
}
CoD.PCAchievementsUtility.PreparePCAchievementListFromAsset = function(f6_arg0)
	local f6_local0 = 0
	local f6_local1 = 0
	local f6_local2 = {}
	local f6_local3 = DataSources.PCTotalAchievementsScore.getModel(f6_arg0)
	for f6_local8, f6_local9 in ipairs(Engine[@"hash_254F61DB6DD339F5"](f6_arg0)) do
		local f6_local10 = CoD.PCAchievementsUtility.CreatePCAchievementTable(f6_arg0, f6_local9)
		if f6_local10 then
			table.insert(f6_local2, f6_local10)
			local f6_local7 = f6_local10.models.score
			f6_local1 = f6_local1 + f6_local7
			if f6_local10.models.isCompleted then
				f6_local0 = f6_local0 + f6_local7
			end
		end
	end
	if f6_local3 then
		f6_local3.score:set(f6_local0)
		f6_local3.maxScore:set(f6_local1)
		if f6_local1 ~= 0 then
			f6_local3.progress:set(f6_local0 / f6_local1)
		else
			f6_local3.progress:set(0)
		end
	end
	return f6_local2
end
DataSources.PCAchievement = DataSourceHelpers.ListSetup("PC.Achievement.AchievementList", function(f7_arg0)
	return CoD.PCAchievementsUtility.PreparePCAchievementListFromAsset(f7_arg0)
end)
CoD.PCAchievementsUtility.PrepareAchievementProgressBar = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = f8_arg2
	if f8_arg2.ProgressBar then
		f8_local0 = f8_arg2.ProgressBar
	end
	if f8_arg1 == nil then
		local f8_local1 = f8_local0:getModel()
	end
	if f8_arg1 and f8_local0 and f8_local0.ProgressBarFiller and f8_local0.ProgressBarBacking then
		f8_local0.ProgressBarFiller:setWidth(f8_local0.ProgressBarBacking:getWidth() * f8_arg1.currentValue:get() / f8_arg1.maxValue:get())
	end
end
CoD.PCAchievementsUtility.IsAchievementCompleted = function(f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0:getModel()
	if f9_local0 == nil then
		return false
	else
		return f9_local0.isCompleted:get()
	end
end
