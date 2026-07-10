CoD.CompetitiveAARDivisionRankAwardTittle = InheritFrom(LUI.UIElement)
CoD.CompetitiveAARDivisionRankAwardTittle.__defaultWidth = 600
CoD.CompetitiveAARDivisionRankAwardTittle.__defaultHeight = 42
CoD.CompetitiveAARDivisionRankAwardTittle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompetitiveAARDivisionRankAwardTittle)
	self.id = "CompetitiveAARDivisionRankAwardTittle"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setAlpha(0.05)
	self:addElement(Image)
	self.Image = Image
	local PlacementMessage = LUI.UIText.new(0.15, 0.15, -77, 523, 0, 0, 7, 37)
	PlacementMessage:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	PlacementMessage:setText(Engine[0xF9F1239CFD921FE](0x80004416A6EAFD0))
	PlacementMessage:setTTF("ttmussels_demibold")
	PlacementMessage:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	PlacementMessage:setLetterSpacing(4)
	PlacementMessage:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlacementMessage:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PlacementMessage)
	self.PlacementMessage = PlacementMessage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
