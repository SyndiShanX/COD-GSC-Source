require("x64:228a7baa572b047")
require("x64:14f5cb7dede32ce")
CoD.systemOverlay_PrestigeRewards = InheritFrom(LUI.UIElement)
CoD.systemOverlay_PrestigeRewards.__defaultWidth = 517
CoD.systemOverlay_PrestigeRewards.__defaultHeight = 304
CoD.systemOverlay_PrestigeRewards.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_PrestigeRewards)
	self.id = "systemOverlay_PrestigeRewards"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RewardsTitle = LUI.UIText.new(0, 0, 2, 515, 0, 0, 0, 24)
	RewardsTitle:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	RewardsTitle:setText(LocalizeToUpperString(0x2ACBA21D0C15241))
	RewardsTitle:setTTF("ttmussels_demibold")
	RewardsTitle:setLetterSpacing(6)
	RewardsTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(RewardsTitle)
	self.RewardsTitle = RewardsTitle
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 2, 217, 0, 0, 233, 287)
	CallingCardsFrameWidget:subscribeToGlobalModel(f1_arg1, "PrestigeCallingCard", nil, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local CallingCardLabel = LUI.UIText.new(0, 0, 5, 275, 0, 0, 291, 309)
	CallingCardLabel:setText(LocalizeToUpperString(0x5D0D4D46178F2C8))
	CallingCardLabel:setTTF("ttmussels_regular")
	CallingCardLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CallingCardLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CallingCardLabel)
	self.CallingCardLabel = CallingCardLabel
	local RewardList = LUI.UIList.new(f1_arg0, f1_arg1, 5, 0, nil, false, false, false, false)
	RewardList:setLeftRight(0, 0, 0, 490)
	RewardList:setTopBottom(0, 0, 29, 204)
	RewardList:setWidgetType(CoD.systemOverlay_PrestigeRewardItem)
	RewardList:setHorizontalCount(3)
	RewardList:setSpacing(5)
	RewardList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RewardList:setDataSource("PrestigeRewards")
	self:addElement(RewardList)
	self.RewardList = RewardList
	self:mergeStateConditions({
		{
			stateName = "LargeCallingCardState",
			condition = function(menu, element, event)
				return CoD.GridAndListUtility.ListElementHasAtLeastNumElements(self.RewardList, 3)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	RewardList.id = "RewardList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_PrestigeRewards.__resetProperties = function(f5_arg0)
	f5_arg0.CallingCardsFrameWidget:completeAnimation()
	f5_arg0.CallingCardLabel:completeAnimation()
	f5_arg0.CallingCardsFrameWidget:setLeftRight(0, 0, 2, 217)
	f5_arg0.CallingCardsFrameWidget:setTopBottom(0, 0, 233, 287)
	f5_arg0.CallingCardLabel:setLeftRight(0, 0, 5, 275)
	f5_arg0.CallingCardLabel:setTopBottom(0, 0, 291, 309)
end
CoD.systemOverlay_PrestigeRewards.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.CallingCardsFrameWidget:completeAnimation()
			f6_arg0.CallingCardsFrameWidget:setLeftRight(0, 0, 2, 217)
			f6_arg0.CallingCardsFrameWidget:setTopBottom(0, 0, 233, 287)
			f6_arg0.clipFinished(f6_arg0.CallingCardsFrameWidget)
		end,
	},
	LargeCallingCardState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.CallingCardsFrameWidget:completeAnimation()
			f7_arg0.CallingCardsFrameWidget:setLeftRight(0, 0, 2, 490)
			f7_arg0.CallingCardsFrameWidget:setTopBottom(0, 0, 233, 355)
			f7_arg0.clipFinished(f7_arg0.CallingCardsFrameWidget)
			f7_arg0.CallingCardLabel:completeAnimation()
			f7_arg0.CallingCardLabel:setLeftRight(0, 0, 8, 278)
			f7_arg0.CallingCardLabel:setTopBottom(0, 0, 359, 377)
			f7_arg0.clipFinished(f7_arg0.CallingCardLabel)
		end,
	},
}
CoD.systemOverlay_PrestigeRewards.__onClose = function(f8_arg0)
	f8_arg0.CallingCardsFrameWidget:close()
	f8_arg0.RewardList:close()
end
