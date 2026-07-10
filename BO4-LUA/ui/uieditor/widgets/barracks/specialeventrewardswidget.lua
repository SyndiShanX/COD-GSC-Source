require("x64:686355579696a18")
require("x64:94fbc5cbde7d92d")
require("x64:192a347560f0f5d")
CoD.SpecialEventRewardsWidget = InheritFrom(LUI.UIElement)
CoD.SpecialEventRewardsWidget.__defaultWidth = 453
CoD.SpecialEventRewardsWidget.__defaultHeight = 100
CoD.SpecialEventRewardsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialEventRewardsWidget)
	self.id = "SpecialEventRewardsWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.23, 0.23, 0.23)
	BG:setAlpha(0.25)
	self:addElement(BG)
	self.BG = BG
	local MainRewardText = LUI.UIText.new(0, 0, 107, 447, 0, 0, 5, 25)
	MainRewardText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MainRewardText:setTTF("ttmussels_demibold")
	MainRewardText:setLetterSpacing(2)
	MainRewardText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MainRewardText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MainRewardText:linkToElementModel(self, "taskLargeRewardName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MainRewardText:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(MainRewardText)
	self.MainRewardText = MainRewardText
	local MainReward = CoD.SpecialEventSmallRewardWidget.new(f1_arg0, f1_arg1, 0, 0, 5, 95, 0, 0, 5, 95)
	MainReward:linkToElementModel(self, "taskLargeRewardIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MainReward.FixedAspectRatioImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(MainReward)
	self.MainReward = MainReward
	local RewardGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -8, 0, nil, nil, false, false, false, false)
	RewardGrid:setLeftRight(0, 0, 107, 399)
	RewardGrid:setTopBottom(0, 0, 41, 97)
	RewardGrid:setWidgetType(CoD.SpecialEventRewardWidget)
	RewardGrid:setHorizontalCount(2)
	RewardGrid:setSpacing(-8)
	RewardGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RewardGrid:setDataSource("SpecialEventRewards")
	self:addElement(RewardGrid)
	self.RewardGrid = RewardGrid
	local ZMDailyCallingsTierSkipNotification = CoD.ZMDailyCallingsTierSkipNotification.new(f1_arg0, f1_arg1, 0, 0, 0, 190, 0.5, 0.5, -20, 36)
	ZMDailyCallingsTierSkipNotification:mergeStateConditions({
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	ZMDailyCallingsTierSkipNotification:setAlpha(0)
	self:addElement(ZMDailyCallingsTierSkipNotification)
	self.ZMDailyCallingsTierSkipNotification = ZMDailyCallingsTierSkipNotification
	self:mergeStateConditions({
		{
			stateName = "DailyLayout",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showDailyLayout")
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
	RewardGrid.id = "RewardGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialEventRewardsWidget.__resetProperties = function(f7_arg0)
	f7_arg0.MainRewardText:completeAnimation()
	f7_arg0.MainReward:completeAnimation()
	f7_arg0.ZMDailyCallingsTierSkipNotification:completeAnimation()
	f7_arg0.RewardGrid:completeAnimation()
	f7_arg0.MainRewardText:setAlpha(1)
	f7_arg0.MainReward:setAlpha(1)
	f7_arg0.ZMDailyCallingsTierSkipNotification:setLeftRight(0, 0, 0, 190)
	f7_arg0.ZMDailyCallingsTierSkipNotification:setTopBottom(0.5, 0.5, -20, 36)
	f7_arg0.ZMDailyCallingsTierSkipNotification:setAlpha(0)
	f7_arg0.RewardGrid:setLeftRight(0, 0, 107, 399)
	f7_arg0.RewardGrid:setTopBottom(0, 0, 41, 97)
end
CoD.SpecialEventRewardsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	DailyLayout = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.MainRewardText:completeAnimation()
			f9_arg0.MainRewardText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.MainRewardText)
			f9_arg0.MainReward:completeAnimation()
			f9_arg0.MainReward:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.MainReward)
			f9_arg0.RewardGrid:completeAnimation()
			f9_arg0.RewardGrid:setLeftRight(0, 0, 213, 493)
			f9_arg0.RewardGrid:setTopBottom(0, 0, 23, 79)
			f9_arg0.clipFinished(f9_arg0.RewardGrid)
			f9_arg0.ZMDailyCallingsTierSkipNotification:completeAnimation()
			f9_arg0.ZMDailyCallingsTierSkipNotification:setLeftRight(0, 0, 15, 205)
			f9_arg0.ZMDailyCallingsTierSkipNotification:setTopBottom(0.5, 0.5, -27, 29)
			f9_arg0.ZMDailyCallingsTierSkipNotification:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ZMDailyCallingsTierSkipNotification)
		end,
	},
}
CoD.SpecialEventRewardsWidget.__onClose = function(f10_arg0)
	f10_arg0.MainRewardText:close()
	f10_arg0.MainReward:close()
	f10_arg0.RewardGrid:close()
	f10_arg0.ZMDailyCallingsTierSkipNotification:close()
end
