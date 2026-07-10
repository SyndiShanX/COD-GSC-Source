require("x64:76d8d58932b4f69")
require("x64:45d84eeaa678589")
CoD.PC_Korea_Event_Week_Progression = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Week_Progression.__defaultWidth = 560
CoD.PC_Korea_Event_Week_Progression.__defaultHeight = 111
CoD.PC_Korea_Event_Week_Progression.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_Week_Progression)
	self.id = "PC_Korea_Event_Week_Progression"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StarsBG = LUI.UIImage.new(0, 0, 0, 448, 0, 1, 0, 0)
	StarsBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_week_bg"))
	StarsBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	StarsBG:setShaderVector(0, 0, 0, 0, 0)
	StarsBG:setupNineSliceShader(64, 64)
	self:addElement(StarsBG)
	self.StarsBG = StarsBG
	local CurrentWeekBG = LUI.UIImage.new(0, 0, 0, 448, 0, 1, 0, 0)
	CurrentWeekBG:setAlpha(0)
	CurrentWeekBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_currentweek_bg"))
	CurrentWeekBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	CurrentWeekBG:setShaderVector(0, 0, 0, 0, 0)
	CurrentWeekBG:setupNineSliceShader(64, 64)
	self:addElement(CurrentWeekBG)
	self.CurrentWeekBG = CurrentWeekBG
	local CompletedWeekBG = LUI.UIImage.new(0, 0, 0, 448, 0, 1, 0, 0)
	CompletedWeekBG:setAlpha(0)
	CompletedWeekBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_completedweek_bg"))
	CompletedWeekBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	CompletedWeekBG:setShaderVector(0, 0, 0, 0, 0)
	CompletedWeekBG:setupNineSliceShader(64, 64)
	self:addElement(CompletedWeekBG)
	self.CompletedWeekBG = CompletedWeekBG
	local WeekDecoration = LUI.UIImage.new(0, 0, 0, 112, 0, 0, 0.5, 112.5)
	WeekDecoration:setAlpha(0.5)
	WeekDecoration:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_number_deco"))
	self:addElement(WeekDecoration)
	self.WeekDecoration = WeekDecoration
	local DayList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	DayList:setLeftRight(0.5, 0.5, -172, 168)
	DayList:setTopBottom(0.5, 0.5, -52, 60)
	DayList:setWidgetType(CoD.PC_Korea_Event_Day_Progression)
	DayList:setHorizontalCount(3)
	DayList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DayList:linkToElementModel(self, "dayList", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DayList:setDataSource(f2_local0)
		end
	end)
	self:addElement(DayList)
	self.DayList = DayList
	local WeekText = LUI.UIText.new(0.5, 0.5, -271.5, -178.5, 0.5, 0.5, -19.5, 19.5)
	WeekText:setTTF("ttmussels_demibold")
	WeekText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WeekText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	WeekText:linkToElementModel(self, "weekNumber", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			WeekText:setText(f3_local0)
		end
	end)
	self:addElement(WeekText)
	self.WeekText = WeekText
	local TimeRemainingBG = LUI.UIImage.new(0, 0, 0, 448, 1, 1, -19, 0)
	TimeRemainingBG:setAlpha(0)
	TimeRemainingBG:setImage(RegisterImage(@"hash_644E36BB9FF6587A"))
	TimeRemainingBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	TimeRemainingBG:setShaderVector(0, 0, 0, 0, 0)
	TimeRemainingBG:setupNineSliceShader(6, 6)
	self:addElement(TimeRemainingBG)
	self.TimeRemainingBG = TimeRemainingBG
	local WeekEndingText = LUI.UIText.new(0, 0, 0, 448, 1, 1, -15, -2)
	WeekEndingText:setRGB(0, 0, 0)
	WeekEndingText:setAlpha(0)
	WeekEndingText:setTTF("dinnext_regular")
	WeekEndingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WeekEndingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	WeekEndingText:linkToElementModel(self, "weekTimeRemaining", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			WeekEndingText:setText(f4_local0)
		end
	end)
	self:addElement(WeekEndingText)
	self.WeekEndingText = WeekEndingText
	local CurrentWeekRewardBG = CoD.PC_Korea_Event_Week_Reward.new(f1_arg0, f1_arg1, 0, 0, 449, 560, 0, 0, 0, 111)
	CurrentWeekRewardBG:mergeStateConditions({
		{
			stateName = "CurrentWeekRewardIntroUnlock",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "showCompletedAnimation")
				if f5_local0 then
					f5_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isActive")
					if f5_local0 then
						f5_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventProgression.isCurrentWeekCompleted")
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "CurrentWeekRewardUnlocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isActive") and CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isCompleted")
			end,
		},
		{
			stateName = "CurrentWeek",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isActive")
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isCompleted")
			end,
		},
		{
			stateName = "Failed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isFailed")
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	CurrentWeekRewardBG:linkToElementModel(CurrentWeekRewardBG, "showCompletedAnimation", true, function(model)
		f1_arg0:updateElementState(CurrentWeekRewardBG, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showCompletedAnimation",
		})
	end)
	CurrentWeekRewardBG:linkToElementModel(CurrentWeekRewardBG, "isActive", true, function(model)
		f1_arg0:updateElementState(CurrentWeekRewardBG, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isActive",
		})
	end)
	local f1_local10 = CurrentWeekRewardBG
	local CompletedBar = CurrentWeekRewardBG.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	CompletedBar(f1_local10, f1_local12["PCKoreaEventProgression.isCurrentWeekCompleted"], function(f13_arg0)
		f1_arg0:updateElementState(CurrentWeekRewardBG, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "PCKoreaEventProgression.isCurrentWeekCompleted",
		})
	end, false)
	CurrentWeekRewardBG:linkToElementModel(CurrentWeekRewardBG, "isCompleted", true, function(model)
		f1_arg0:updateElementState(CurrentWeekRewardBG, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isCompleted",
		})
	end)
	CurrentWeekRewardBG:linkToElementModel(CurrentWeekRewardBG, "isFailed", true, function(model)
		f1_arg0:updateElementState(CurrentWeekRewardBG, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isFailed",
		})
	end)
	CurrentWeekRewardBG:linkToElementModel(self, "rewardImage", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			CurrentWeekRewardBG.RewardImage:setImage(RegisterImage(f16_local0))
		end
	end)
	self:addElement(CurrentWeekRewardBG)
	self.CurrentWeekRewardBG = CurrentWeekRewardBG
	CompletedBar = LUI.UIImage.new(0, 0, -16, 0, -0, 1, 0, 0)
	CompletedBar:setAlpha(0)
	CompletedBar:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_weekcompleted"))
	self:addElement(CompletedBar)
	self.CompletedBar = CompletedBar
	self:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isCompleted")
			end,
		},
		{
			stateName = "CurrentWeek",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isActive")
			end,
		},
		{
			stateName = "Failed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isFailed")
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "isCompleted", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isCompleted",
		})
	end)
	self:linkToElementModel(self, "isActive", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isActive",
		})
	end)
	self:linkToElementModel(self, "isFailed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isFailed",
		})
	end)
	DayList.id = "DayList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Korea_Event_Week_Progression.__resetProperties = function(f24_arg0)
	f24_arg0.WeekText:completeAnimation()
	f24_arg0.CompletedWeekBG:completeAnimation()
	f24_arg0.CompletedBar:completeAnimation()
	f24_arg0.CurrentWeekBG:completeAnimation()
	f24_arg0.TimeRemainingBG:completeAnimation()
	f24_arg0.WeekEndingText:completeAnimation()
	f24_arg0.DayList:completeAnimation()
	f24_arg0.WeekDecoration:completeAnimation()
	f24_arg0.StarsBG:completeAnimation()
	f24_arg0.WeekText:setTopBottom(0.5, 0.5, -19.5, 19.5)
	f24_arg0.WeekText:setRGB(1, 1, 1)
	f24_arg0.CompletedWeekBG:setAlpha(0)
	f24_arg0.CompletedBar:setTopBottom(-0, 1, 0, 0)
	f24_arg0.CompletedBar:setAlpha(0)
	f24_arg0.CurrentWeekBG:setAlpha(0)
	f24_arg0.TimeRemainingBG:setAlpha(0)
	f24_arg0.WeekEndingText:setAlpha(0)
	f24_arg0.DayList:setTopBottom(0.5, 0.5, -52, 60)
	f24_arg0.DayList:setAlpha(1)
	f24_arg0.WeekDecoration:setAlpha(0.5)
	f24_arg0.StarsBG:setRGB(1, 1, 1)
end
CoD.PC_Korea_Event_Week_Progression.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.WeekText:completeAnimation()
			f25_arg0.WeekText:setRGB(0.49, 0.49, 0.49)
			f25_arg0.clipFinished(f25_arg0.WeekText)
		end,
	},
	Completed = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.CompletedWeekBG:completeAnimation()
			f26_arg0.CompletedWeekBG:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.CompletedWeekBG)
			f26_arg0.WeekText:completeAnimation()
			f26_arg0.WeekText:setRGB(0.77, 0.77, 0.77)
			f26_arg0.clipFinished(f26_arg0.WeekText)
			f26_arg0.CompletedBar:completeAnimation()
			f26_arg0.CompletedBar:setTopBottom(-0, 1, 0, 0)
			f26_arg0.CompletedBar:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.CompletedBar)
		end,
	},
	CurrentWeek = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(6)
			f27_arg0.CurrentWeekBG:completeAnimation()
			f27_arg0.CurrentWeekBG:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.CurrentWeekBG)
			f27_arg0.WeekDecoration:beginAnimation(80)
			f27_arg0.WeekDecoration:setAlpha(0.7)
			f27_arg0.WeekDecoration:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
			f27_arg0.WeekDecoration:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			f27_arg0.DayList:completeAnimation()
			f27_arg0.DayList:setTopBottom(0.5, 0.5, -60, 52)
			f27_arg0.clipFinished(f27_arg0.DayList)
			f27_arg0.WeekText:completeAnimation()
			f27_arg0.WeekText:setTopBottom(0.5, 0.5, -23.5, 15.5)
			f27_arg0.WeekText:setRGB(1, 1, 1)
			f27_arg0.clipFinished(f27_arg0.WeekText)
			f27_arg0.TimeRemainingBG:completeAnimation()
			f27_arg0.TimeRemainingBG:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.TimeRemainingBG)
			f27_arg0.WeekEndingText:completeAnimation()
			f27_arg0.WeekEndingText:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.WeekEndingText)
		end,
	},
	Failed = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.WeekText:completeAnimation()
			f28_arg0.WeekText:setRGB(0.41, 0.41, 0.41)
			f28_arg0.clipFinished(f28_arg0.WeekText)
		end,
	},
	Unavailable = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.StarsBG:completeAnimation()
			f29_arg0.StarsBG:setRGB(0.39, 0.39, 0.39)
			f29_arg0.clipFinished(f29_arg0.StarsBG)
			f29_arg0.DayList:completeAnimation()
			f29_arg0.DayList:setAlpha(0.5)
			f29_arg0.clipFinished(f29_arg0.DayList)
			f29_arg0.WeekText:completeAnimation()
			f29_arg0.WeekText:setRGB(0.27, 0.27, 0.27)
			f29_arg0.clipFinished(f29_arg0.WeekText)
		end,
	},
}
CoD.PC_Korea_Event_Week_Progression.__onClose = function(f30_arg0)
	f30_arg0.DayList:close()
	f30_arg0.WeekText:close()
	f30_arg0.WeekEndingText:close()
	f30_arg0.CurrentWeekRewardBG:close()
end
