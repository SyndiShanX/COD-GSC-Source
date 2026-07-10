require("x64:b1f16370250a381")
CoD.WarzoneGameStatusIndicatorDisplay = InheritFrom(LUI.UIElement)
CoD.WarzoneGameStatusIndicatorDisplay.__defaultWidth = 345
CoD.WarzoneGameStatusIndicatorDisplay.__defaultHeight = 44
CoD.WarzoneGameStatusIndicatorDisplay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneGameStatusIndicatorDisplay)
	self.id = "WarzoneGameStatusIndicatorDisplay"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GameStatusIndicatorsRightSolo = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	GameStatusIndicatorsRightSolo:setLeftRight(1, 1, -160, 0)
	GameStatusIndicatorsRightSolo:setTopBottom(0, 0, 0, 44)
	GameStatusIndicatorsRightSolo:setWidgetType(CoD.WarzoneGameStatusIndicatorListItem)
	GameStatusIndicatorsRightSolo:setHorizontalCount(2)
	GameStatusIndicatorsRightSolo:setSpacing(4)
	GameStatusIndicatorsRightSolo:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(GameStatusIndicatorsRightSolo)
	self.GameStatusIndicatorsRightSolo = GameStatusIndicatorsRightSolo
	local GameStatusIndicatorsLeftSolo = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	GameStatusIndicatorsLeftSolo:setLeftRight(0, 0, 81, 159)
	GameStatusIndicatorsLeftSolo:setTopBottom(0, 0, 0, 44)
	GameStatusIndicatorsLeftSolo:setWidgetType(CoD.WarzoneGameStatusIndicatorListItem)
	GameStatusIndicatorsLeftSolo:setSpacing(4)
	GameStatusIndicatorsLeftSolo:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(GameStatusIndicatorsLeftSolo)
	self.GameStatusIndicatorsLeftSolo = GameStatusIndicatorsLeftSolo
	local GameStatusIndicators = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	GameStatusIndicators:setLeftRight(0, 0, 1, 399)
	GameStatusIndicators:setTopBottom(0, 0, 0, 44)
	GameStatusIndicators:setWidgetType(CoD.WarzoneGameStatusIndicatorListItem)
	GameStatusIndicators:setHorizontalCount(5)
	GameStatusIndicators:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(GameStatusIndicators)
	self.GameStatusIndicators = GameStatusIndicators
	self:mergeStateConditions({
		{
			stateName = "Solo",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.IsSoloTeamGame()
			end,
		},
		{
			stateName = "Right",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	GameStatusIndicatorsRightSolo.id = "GameStatusIndicatorsRightSolo"
	GameStatusIndicatorsLeftSolo.id = "GameStatusIndicatorsLeftSolo"
	GameStatusIndicators.id = "GameStatusIndicators"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneGameStatusIndicatorDisplay.__resetProperties = function(f5_arg0)
	f5_arg0.GameStatusIndicators:completeAnimation()
	f5_arg0.GameStatusIndicatorsRightSolo:completeAnimation()
	f5_arg0.GameStatusIndicatorsLeftSolo:completeAnimation()
	f5_arg0.GameStatusIndicators:setLeftRight(0, 0, 1, 399)
	f5_arg0.GameStatusIndicators:setAlpha(1)
	f5_arg0.GameStatusIndicators:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	f5_arg0.GameStatusIndicatorsRightSolo:setAlpha(1)
	f5_arg0.GameStatusIndicatorsLeftSolo:setLeftRight(0, 0, 81, 159)
	f5_arg0.GameStatusIndicatorsLeftSolo:setAlpha(1)
end
CoD.WarzoneGameStatusIndicatorDisplay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.GameStatusIndicatorsRightSolo:completeAnimation()
			f6_arg0.GameStatusIndicatorsRightSolo:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GameStatusIndicatorsRightSolo)
			f6_arg0.GameStatusIndicatorsLeftSolo:completeAnimation()
			f6_arg0.GameStatusIndicatorsLeftSolo:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GameStatusIndicatorsLeftSolo)
			f6_arg0.GameStatusIndicators:completeAnimation()
			f6_arg0.GameStatusIndicators:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GameStatusIndicators)
		end,
	},
	Solo = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.GameStatusIndicatorsLeftSolo:completeAnimation()
			f7_arg0.GameStatusIndicatorsLeftSolo:setLeftRight(0, 0, 93, 171)
			f7_arg0.clipFinished(f7_arg0.GameStatusIndicatorsLeftSolo)
			f7_arg0.GameStatusIndicators:completeAnimation()
			f7_arg0.GameStatusIndicators:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.GameStatusIndicators)
		end,
	},
	Right = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.GameStatusIndicatorsRightSolo:completeAnimation()
			f8_arg0.GameStatusIndicatorsRightSolo:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GameStatusIndicatorsRightSolo)
			f8_arg0.GameStatusIndicatorsLeftSolo:completeAnimation()
			f8_arg0.GameStatusIndicatorsLeftSolo:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GameStatusIndicatorsLeftSolo)
			f8_arg0.GameStatusIndicators:completeAnimation()
			f8_arg0.GameStatusIndicators:setLeftRight(1, 1, -398, 0)
			f8_arg0.GameStatusIndicators:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
			f8_arg0.clipFinished(f8_arg0.GameStatusIndicators)
		end,
	},
	Left = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.GameStatusIndicatorsRightSolo:completeAnimation()
			f9_arg0.GameStatusIndicatorsRightSolo:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.GameStatusIndicatorsRightSolo)
			f9_arg0.GameStatusIndicatorsLeftSolo:completeAnimation()
			f9_arg0.GameStatusIndicatorsLeftSolo:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.GameStatusIndicatorsLeftSolo)
		end,
	},
}
CoD.WarzoneGameStatusIndicatorDisplay.__onClose = function(f10_arg0)
	f10_arg0.GameStatusIndicatorsRightSolo:close()
	f10_arg0.GameStatusIndicatorsLeftSolo:close()
	f10_arg0.GameStatusIndicators:close()
end
