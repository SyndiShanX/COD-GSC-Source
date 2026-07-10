require("x64:e921acb1415f1b2")
CoD.AAR_RankUpStarsList = InheritFrom(LUI.UIElement)
CoD.AAR_RankUpStarsList.__defaultWidth = 605
CoD.AAR_RankUpStarsList.__defaultHeight = 335
CoD.AAR_RankUpStarsList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AAR_RankUpStarsList)
	self.id = "AAR_RankUpStarsList"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local AARRankedStarsList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	AARRankedStarsList:setLeftRight(0, 0, 0, 601)
	AARRankedStarsList:setTopBottom(0, 0, 0, 333)
	AARRankedStarsList:setWidgetType(CoD.AAR_RankUpStar)
	AARRankedStarsList:setHorizontalCount(9)
	AARRankedStarsList:setVerticalCount(5)
	AARRankedStarsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AARRankedStarsList:setDataSource("RankedPlayStar")
	self:addElement(AARRankedStarsList)
	self.AARRankedStarsList = AARRankedStarsList
	AARRankedStarsList.id = "AARRankedStarsList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	f1_local2 = AARRankedStarsList
	CoD.ArenaRankedPlayUtility.PopulateRankedPlayAARWidget(f1_arg1, self)
	return self
end
CoD.AAR_RankUpStarsList.__onClose = function(f2_arg0)
	f2_arg0.AARRankedStarsList:close()
end
