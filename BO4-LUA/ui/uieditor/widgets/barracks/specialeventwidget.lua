require("x64:aac73e3cb2db880")
require("x64:15cf4f01e6aec35")
require("x64:38e03e34ad8f0b5")
require("x64:a5c094515c7c87e")
CoD.SpecialEventWidget = InheritFrom(LUI.UIElement)
CoD.SpecialEventWidget.__defaultWidth = 477
CoD.SpecialEventWidget.__defaultHeight = 382
CoD.SpecialEventWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("AutoEvents.zm_halloween_2018_timer")
	self:setClass(CoD.SpecialEventWidget)
	self.id = "SpecialEventWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeaderText = LUI.UIText.new(0, 0, 9, 252, 0, 0, 6, 32)
	HeaderText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderText:setTTF("ttmussels_regular")
	HeaderText:setLetterSpacing(4)
	HeaderText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HeaderText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	HeaderText:linkToElementModel(self, "eventName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HeaderText:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(HeaderText)
	self.HeaderText = HeaderText
	local SpecialSubtitleText = LUI.UIText.new(0, 0, 9, 215, 0, 0, 35, 53)
	SpecialSubtitleText:setRGB(ColorSet.T8_PC_CHAT_PARTY.r, ColorSet.T8_PC_CHAT_PARTY.g, ColorSet.T8_PC_CHAT_PARTY.b)
	SpecialSubtitleText:setText(LocalizeToUpperString(0x9D2993B90351AC9))
	SpecialSubtitleText:setTTF("ttmussels_regular")
	SpecialSubtitleText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SpecialSubtitleText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(SpecialSubtitleText)
	self.SpecialSubtitleText = SpecialSubtitleText
	local TimerText = LUI.UIText.new(0, 0, 215, 465, 0, 0, 35, 50)
	TimerText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	TimerText:setTTF("ttmussels_demibold")
	TimerText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	TimerText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TimerText:subscribeToGlobalModel(f1_arg1, "AutoEvents", "zm_halloween_2018_timer", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TimerText:setText(LocalizeIntoStringIfNotEmpty(0xC0CE2452CF87DB1, f3_local0))
		end
	end)
	self:addElement(TimerText)
	self.TimerText = TimerText
	local NextDailyTimerText = LUI.UIText.new(0.5, 0.5, -194, 194, 0.5, 0.5, 12.5, 27.5)
	NextDailyTimerText:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	NextDailyTimerText:setAlpha(0)
	NextDailyTimerText:setTTF("ttmussels_demibold")
	NextDailyTimerText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NextDailyTimerText:subscribeToGlobalModel(f1_arg1, "AutoEvents", "zm_daily_callings_timer", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NextDailyTimerText:setText(LocalizeIntoStringIfNotEmpty(0xF79DED252995605, f4_local0))
		end
	end)
	self:addElement(NextDailyTimerText)
	self.NextDailyTimerText = NextDailyTimerText
	local StepText = LUI.UIText.new(0, 0, 12, 228, 0, 0, 79, 95)
	StepText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	StepText:setTTF("ttmussels_regular")
	StepText:setLetterSpacing(1)
	StepText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StepText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	StepText:linkToElementModel(self, "stepProgress", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			StepText:setText(ToUpper(f5_local0))
		end
	end)
	self:addElement(StepText)
	self.StepText = StepText
	local TaskInfo = CoD.SpecialEventTaskWidget.new(f1_arg0, f1_arg1, 0, 0, 12, 465, 0, 0, 99, 199)
	TaskInfo:linkToElementModel(self, nil, false, function(model)
		TaskInfo:setModel(model, f1_arg1)
	end)
	self:addElement(TaskInfo)
	self.TaskInfo = TaskInfo
	local RewardsHeader = LUI.UIText.new(0, 0, 12, 228, 0, 0, 224.5, 240.5)
	RewardsHeader:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	RewardsHeader:setText(LocalizeToUpperString(0x2ACBA21D0C15241))
	RewardsHeader:setTTF("ttmussels_regular")
	RewardsHeader:setLetterSpacing(1)
	RewardsHeader:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RewardsHeader:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(RewardsHeader)
	self.RewardsHeader = RewardsHeader
	local RewardQuantityText = CoD.SpecialEventRewardsWidget.new(f1_arg0, f1_arg1, 0, 0, 12, 465, 0, 0, 244.5, 344.5)
	RewardQuantityText.RewardGrid:setDataSource("SpecialEventRewards")
	RewardQuantityText:linkToElementModel(self, nil, false, function(model)
		RewardQuantityText:setModel(model, f1_arg1)
	end)
	self:addElement(RewardQuantityText)
	self.RewardQuantityText = RewardQuantityText
	local CompleteText = LUI.UIText.new(0.5, 0.5, -194, 194, 0.5, 0.5, -12, 12)
	CompleteText:setAlpha(0)
	CompleteText:setTTF("ttmussels_demibold")
	CompleteText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CompleteText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	CompleteText:linkToElementModel(self, "allTasksCompleteText", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CompleteText:setText(LocalizeToUpperString(f8_local0))
		end
	end)
	self:addElement(CompleteText)
	self.CompleteText = CompleteText
	local SpecialEventPips = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 4, 0, nil, nil, false, false, false, false)
	SpecialEventPips:setLeftRight(0, 0, 376, 464)
	SpecialEventPips:setTopBottom(0, 0, 73, 91)
	SpecialEventPips:setAutoScaleContent(true)
	SpecialEventPips:setWidgetType(CoD.SpecialEventProgressPip)
	SpecialEventPips:setHorizontalCount(4)
	SpecialEventPips:setSpacing(4)
	SpecialEventPips:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	SpecialEventPips:setDataSource("SpecialEventSteps")
	self:addElement(SpecialEventPips)
	self.SpecialEventPips = SpecialEventPips
	local BarracksTimeDisplayText = CoD.Barracks_TimeDisplayText.new(f1_arg0, f1_arg1, 0, 0, 215, 465, 0, 0, 35, 50)
	BarracksTimeDisplayText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	BarracksTimeDisplayText:subscribeToGlobalModel(f1_arg1, "DailyCallingInfo", nil, function(model)
		BarracksTimeDisplayText:setModel(model, f1_arg1)
	end)
	BarracksTimeDisplayText:subscribeToGlobalModel(f1_arg1, "AutoEvents", "zm_daily_callings_timer", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			BarracksTimeDisplayText.DailyTimerText:setText(LocalizeIntoStringIfNotEmpty(0xC0CE2452CF87DB1, f10_local0))
		end
	end)
	self:addElement(BarracksTimeDisplayText)
	self.BarracksTimeDisplayText = BarracksTimeDisplayText
	self:mergeStateConditions({
		{
			stateName = "DailyCompleteLayoutSmall",
			condition = function(menu, element, event)
				local f11_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showDailyLayout")
				if f11_local0 then
					f11_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allTasksComplete")
					if f11_local0 then
						f11_local0 = AlwaysFalse()
					end
				end
				return f11_local0
			end,
		},
		{
			stateName = "DailyCompleteLayout",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showDailyLayout") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allTasksComplete")
			end,
		},
		{
			stateName = "DailyLayoutSmall",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showDailyLayout") and AlwaysFalse()
			end,
		},
		{
			stateName = "DailyLayout",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showDailyLayout")
			end,
		},
		{
			stateName = "CompleteLayout",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allTasksComplete")
			end,
		},
	})
	self:linkToElementModel(self, "showDailyLayout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showDailyLayout",
		})
	end)
	self:linkToElementModel(self, "allTasksComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allTasksComplete",
		})
	end)
	RewardQuantityText.id = "RewardQuantityText"
	SpecialEventPips.id = "SpecialEventPips"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local12 = self
	CoD.BlackMarketUtility.EnableLiveCountDownTimer(self)
	CoD.ZombiesCallingsUtility.SubscribeToAutoEvents(self, f1_arg1)
	CoD.ZombiesCallingsUtility.EnableLiveDailyCallingsCountDownTimer(self)
	return self
end
CoD.SpecialEventWidget.__resetProperties = function(f18_arg0)
	f18_arg0.SpecialSubtitleText:completeAnimation()
	f18_arg0.StepText:completeAnimation()
	f18_arg0.TaskInfo:completeAnimation()
	f18_arg0.TimerText:completeAnimation()
	f18_arg0.CompleteText:completeAnimation()
	f18_arg0.HeaderText:completeAnimation()
	f18_arg0.RewardQuantityText:completeAnimation()
	f18_arg0.RewardsHeader:completeAnimation()
	f18_arg0.NextDailyTimerText:completeAnimation()
	f18_arg0.BarracksTimeDisplayText:completeAnimation()
	f18_arg0.SpecialSubtitleText:setAlpha(1)
	f18_arg0.StepText:setAlpha(1)
	f18_arg0.TaskInfo:setTopBottom(0, 0, 99, 199)
	f18_arg0.TaskInfo:setAlpha(1)
	f18_arg0.TimerText:setAlpha(1)
	f18_arg0.CompleteText:setTopBottom(0.5, 0.5, -12, 12)
	f18_arg0.CompleteText:setAlpha(0)
	f18_arg0.HeaderText:setAlpha(1)
	f18_arg0.RewardQuantityText:setTopBottom(0, 0, 244.5, 344.5)
	f18_arg0.RewardQuantityText:setAlpha(1)
	f18_arg0.RewardsHeader:setTopBottom(0, 0, 224.5, 240.5)
	f18_arg0.RewardsHeader:setAlpha(1)
	f18_arg0.NextDailyTimerText:setTopBottom(0.5, 0.5, 12.5, 27.5)
	f18_arg0.NextDailyTimerText:setAlpha(0)
	f18_arg0.BarracksTimeDisplayText:setTopBottom(0, 0, 35, 50)
	f18_arg0.BarracksTimeDisplayText:setAlpha(1)
end
CoD.SpecialEventWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	DailyCompleteLayoutSmall = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(10)
			f20_arg0.HeaderText:completeAnimation()
			f20_arg0.HeaderText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.HeaderText)
			f20_arg0.SpecialSubtitleText:completeAnimation()
			f20_arg0.SpecialSubtitleText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SpecialSubtitleText)
			f20_arg0.TimerText:completeAnimation()
			f20_arg0.TimerText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.TimerText)
			f20_arg0.NextDailyTimerText:completeAnimation()
			f20_arg0.NextDailyTimerText:setTopBottom(0.5, 0.5, -44, -29)
			f20_arg0.NextDailyTimerText:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.NextDailyTimerText)
			f20_arg0.StepText:completeAnimation()
			f20_arg0.StepText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.StepText)
			f20_arg0.TaskInfo:completeAnimation()
			f20_arg0.TaskInfo:setTopBottom(0, 0, 79, 179)
			f20_arg0.TaskInfo:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.TaskInfo)
			f20_arg0.RewardsHeader:completeAnimation()
			f20_arg0.RewardsHeader:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.RewardsHeader)
			f20_arg0.RewardQuantityText:completeAnimation()
			f20_arg0.RewardQuantityText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.RewardQuantityText)
			f20_arg0.CompleteText:completeAnimation()
			f20_arg0.CompleteText:setTopBottom(0.5, 0.5, -68.5, -44.5)
			f20_arg0.CompleteText:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.CompleteText)
			f20_arg0.BarracksTimeDisplayText:completeAnimation()
			f20_arg0.BarracksTimeDisplayText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.BarracksTimeDisplayText)
		end,
	},
	DailyCompleteLayout = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(10)
			f21_arg0.HeaderText:completeAnimation()
			f21_arg0.HeaderText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.HeaderText)
			f21_arg0.SpecialSubtitleText:completeAnimation()
			f21_arg0.SpecialSubtitleText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.SpecialSubtitleText)
			f21_arg0.TimerText:completeAnimation()
			f21_arg0.TimerText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TimerText)
			f21_arg0.NextDailyTimerText:completeAnimation()
			f21_arg0.NextDailyTimerText:setTopBottom(0.5, 0.5, 17.5, 32.5)
			f21_arg0.NextDailyTimerText:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.NextDailyTimerText)
			f21_arg0.StepText:completeAnimation()
			f21_arg0.StepText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.StepText)
			f21_arg0.TaskInfo:completeAnimation()
			f21_arg0.TaskInfo:setTopBottom(0, 0, 79, 179)
			f21_arg0.TaskInfo:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TaskInfo)
			f21_arg0.RewardsHeader:completeAnimation()
			f21_arg0.RewardsHeader:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.RewardsHeader)
			f21_arg0.RewardQuantityText:completeAnimation()
			f21_arg0.RewardQuantityText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.RewardQuantityText)
			f21_arg0.CompleteText:completeAnimation()
			f21_arg0.CompleteText:setTopBottom(0.5, 0.5, -17, 7)
			f21_arg0.CompleteText:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.CompleteText)
			f21_arg0.BarracksTimeDisplayText:completeAnimation()
			f21_arg0.BarracksTimeDisplayText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.BarracksTimeDisplayText)
		end,
	},
	DailyLayoutSmall = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(7)
			f22_arg0.SpecialSubtitleText:completeAnimation()
			f22_arg0.SpecialSubtitleText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.SpecialSubtitleText)
			f22_arg0.TimerText:completeAnimation()
			f22_arg0.TimerText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.TimerText)
			f22_arg0.StepText:completeAnimation()
			f22_arg0.StepText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.StepText)
			f22_arg0.TaskInfo:completeAnimation()
			f22_arg0.TaskInfo:setTopBottom(0, 0, 37, 137)
			f22_arg0.clipFinished(f22_arg0.TaskInfo)
			f22_arg0.RewardsHeader:completeAnimation()
			f22_arg0.RewardsHeader:setTopBottom(0, 0, 141.5, 157.5)
			f22_arg0.clipFinished(f22_arg0.RewardsHeader)
			f22_arg0.RewardQuantityText:completeAnimation()
			f22_arg0.RewardQuantityText:setTopBottom(0, 0, 161.5, 261.5)
			f22_arg0.clipFinished(f22_arg0.RewardQuantityText)
			f22_arg0.BarracksTimeDisplayText:completeAnimation()
			f22_arg0.BarracksTimeDisplayText:setTopBottom(0, 0, 17, 32)
			f22_arg0.clipFinished(f22_arg0.BarracksTimeDisplayText)
		end,
	},
	DailyLayout = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.SpecialSubtitleText:completeAnimation()
			f23_arg0.SpecialSubtitleText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SpecialSubtitleText)
			f23_arg0.TimerText:completeAnimation()
			f23_arg0.TimerText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.TimerText)
			f23_arg0.StepText:completeAnimation()
			f23_arg0.StepText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.StepText)
			f23_arg0.TaskInfo:completeAnimation()
			f23_arg0.TaskInfo:setTopBottom(0, 0, 79, 179)
			f23_arg0.clipFinished(f23_arg0.TaskInfo)
		end,
	},
	CompleteLayout = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(9)
			f24_arg0.HeaderText:completeAnimation()
			f24_arg0.HeaderText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.HeaderText)
			f24_arg0.SpecialSubtitleText:completeAnimation()
			f24_arg0.SpecialSubtitleText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.SpecialSubtitleText)
			f24_arg0.TimerText:completeAnimation()
			f24_arg0.TimerText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.TimerText)
			f24_arg0.StepText:completeAnimation()
			f24_arg0.StepText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.StepText)
			f24_arg0.TaskInfo:completeAnimation()
			f24_arg0.TaskInfo:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.TaskInfo)
			f24_arg0.RewardsHeader:completeAnimation()
			f24_arg0.RewardsHeader:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.RewardsHeader)
			f24_arg0.RewardQuantityText:completeAnimation()
			f24_arg0.RewardQuantityText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.RewardQuantityText)
			f24_arg0.CompleteText:completeAnimation()
			f24_arg0.CompleteText:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.CompleteText)
			f24_arg0.BarracksTimeDisplayText:completeAnimation()
			f24_arg0.BarracksTimeDisplayText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.BarracksTimeDisplayText)
		end,
	},
}
CoD.SpecialEventWidget.__onClose = function(f25_arg0)
	f25_arg0.HeaderText:close()
	f25_arg0.TimerText:close()
	f25_arg0.NextDailyTimerText:close()
	f25_arg0.StepText:close()
	f25_arg0.TaskInfo:close()
	f25_arg0.RewardQuantityText:close()
	f25_arg0.CompleteText:close()
	f25_arg0.SpecialEventPips:close()
	f25_arg0.BarracksTimeDisplayText:close()
end
