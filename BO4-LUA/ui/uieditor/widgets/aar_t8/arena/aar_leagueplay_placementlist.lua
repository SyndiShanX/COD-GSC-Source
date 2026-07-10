require("x64:a5345e91e58dd3b")
CoD.AAR_LeaguePlay_PlacementList = InheritFrom(LUI.UIElement)
CoD.AAR_LeaguePlay_PlacementList.__defaultWidth = 500
CoD.AAR_LeaguePlay_PlacementList.__defaultHeight = 100
CoD.AAR_LeaguePlay_PlacementList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AAR_LeaguePlay_PlacementList)
	self.id = "AAR_LeaguePlay_PlacementList"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local PlacementCompletePips = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	PlacementCompletePips:setLeftRight(0, 0, 70, 438)
	PlacementCompletePips:setTopBottom(0, 0, 18, 82)
	PlacementCompletePips:setWidgetType(CoD.AAR_LeaguePlay_PlacementPip)
	PlacementCompletePips:setHorizontalCount(5)
	PlacementCompletePips:setSpacing(12)
	PlacementCompletePips:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlacementCompletePips:setDataSource("LeaguePlayPlacementPips")
	self:addElement(PlacementCompletePips)
	self.PlacementCompletePips = PlacementCompletePips
	PlacementCompletePips.id = "PlacementCompletePips"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AAR_LeaguePlay_PlacementList.__onClose = function(f2_arg0)
	f2_arg0.PlacementCompletePips:close()
end
