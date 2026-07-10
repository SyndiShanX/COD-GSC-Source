require("x64:4ab72db8012133a")
CoD.AAR_LeaguePlayLadderWidget = InheritFrom(LUI.UIElement)
CoD.AAR_LeaguePlayLadderWidget.__defaultWidth = 898
CoD.AAR_LeaguePlayLadderWidget.__defaultHeight = 504
CoD.AAR_LeaguePlayLadderWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AAR_LeaguePlayLadderWidget)
	self.id = "AAR_LeaguePlayLadderWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PositionsList = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	PositionsList:setLeftRight(0, 0, 0, 898)
	PositionsList:setTopBottom(0, 0, 7.5, 503.5)
	PositionsList:setWidgetType(CoD.AAR_LeaguePlayLadderEntry)
	PositionsList:setVerticalCount(9)
	PositionsList:setSpacing(8)
	PositionsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PositionsList:setDataSource("LeaguePlayLadderMemberList")
	PositionsList:subscribeToGlobalModel(f1_arg1, "LeaguePlayLadderMemberList", "allXuidInfoLoaded", function(model)
		CoD.ArenaLeaguePlayUtility.UpdateLadderListCurrentPlayerFocus(self, PositionsList)
	end)
	self:addElement(PositionsList)
	self.PositionsList = PositionsList
	local SpecialistRight = LUI.UIText.new(0, 0, -16, 104, 0, 0, -15.5, -0.5)
	SpecialistRight:setRGB(0.7, 0.7, 0.7)
	SpecialistRight:setText(Engine[0xF9F1239CFD921FE](0x49C509B807FDA37))
	SpecialistRight:setTTF("0arame_mono_stencil")
	SpecialistRight:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SpecialistRight:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(SpecialistRight)
	self.SpecialistRight = SpecialistRight
	local SpecialistRight2 = LUI.UIText.new(0, 0, 569, 719, 0, 0, -15.5, -0.5)
	SpecialistRight2:setRGB(0.7, 0.7, 0.7)
	SpecialistRight2:setText(Engine[0xF9F1239CFD921FE](0x1275B8C997A0D5E))
	SpecialistRight2:setTTF("0arame_mono_stencil")
	SpecialistRight2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SpecialistRight2:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(SpecialistRight2)
	self.SpecialistRight2 = SpecialistRight2
	local topline05 = LUI.UIImage.new(0, 0, 718, 898, 0, 0, 4.5, 7.5)
	topline05:setRGB(0.92, 0.89, 0.72)
	topline05:setAlpha(0.05)
	self:addElement(topline05)
	self.topline05 = topline05
	local topline04 = LUI.UIImage.new(0, 0, 578, 710, 0, 0, 4.5, 7.5)
	topline04:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	topline04:setAlpha(0.05)
	self:addElement(topline04)
	self.topline04 = topline04
	local topline03 = LUI.UIImage.new(0, 0, 152, 570, 0, 0, 4.5, 7.5)
	topline03:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	topline03:setAlpha(0.05)
	self:addElement(topline03)
	self.topline03 = topline03
	local topline02 = LUI.UIImage.new(0, 0, 96, 144, 0, 0, 4.5, 7.5)
	topline02:setRGB(0.92, 0.89, 0.72)
	topline02:setAlpha(0.05)
	self:addElement(topline02)
	self.topline02 = topline02
	local topline01 = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 4.5, 7.5)
	topline01:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	topline01:setAlpha(0.05)
	self:addElement(topline01)
	self.topline01 = topline01
	local GemReward = LUI.UIText.new(0, 0, 732, 882, 0, 0, -16, -1)
	GemReward:setRGB(0.92, 0.92, 0.92)
	GemReward:setText(Engine[0xF9F1239CFD921FE](0x7A8731E3BA139AF))
	GemReward:setTTF("0arame_mono_stencil")
	GemReward:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GemReward:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(GemReward)
	self.GemReward = GemReward
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "LeaguePlayLadderMemberList.loaded", function(model)
		local f3_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueGreaterThan("LeaguePlayLadderMemberList.loaded", 0) then
			CoD.ArenaLeaguePlayUtility.ForceLadderPlayerArrows(f3_local0, f1_arg1)
		end
	end)
	PositionsList.id = "PositionsList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AAR_LeaguePlayLadderWidget.__onClose = function(f4_arg0)
	f4_arg0.PositionsList:close()
end
