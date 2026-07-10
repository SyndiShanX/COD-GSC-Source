require("x64:41fdb2506284dda")
require("x64:37583579a3dcbe")
CoD.arenaLeaguePlayRubiesList = InheritFrom(LUI.UIElement)
CoD.arenaLeaguePlayRubiesList.__defaultWidth = 140
CoD.arenaLeaguePlayRubiesList.__defaultHeight = 40
CoD.arenaLeaguePlayRubiesList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.arenaLeaguePlayRubiesList)
	self.id = "arenaLeaguePlayRubiesList"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local rubiesListSlot = LUI.UIList.new(f1_arg0, f1_arg1, 5, 0, nil, false, false, false, false)
	rubiesListSlot:setLeftRight(0, 0, 5, 135)
	rubiesListSlot:setTopBottom(0, 0, 0, 40)
	rubiesListSlot:setWidgetType(CoD.arenaLeaguePlayRubySlot)
	rubiesListSlot:setHorizontalCount(3)
	rubiesListSlot:setSpacing(5)
	rubiesListSlot:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(rubiesListSlot)
	self.rubiesListSlot = rubiesListSlot
	local rubiesList = LUI.UIList.new(f1_arg0, f1_arg1, 5, 0, nil, false, false, false, false)
	rubiesList:setLeftRight(0, 0, 5, 135)
	rubiesList:setTopBottom(0, 0, 0, 40)
	rubiesList:setWidgetType(CoD.arenaLeaguePlayRuby)
	rubiesList:setHorizontalCount(3)
	rubiesList:setSpacing(5)
	rubiesList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(rubiesList)
	self.rubiesList = rubiesList
	rubiesListSlot.id = "rubiesListSlot"
	rubiesList.id = "rubiesList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.arenaLeaguePlayRubiesList.__onClose = function(f2_arg0)
	f2_arg0.rubiesListSlot:close()
	f2_arg0.rubiesList:close()
end
