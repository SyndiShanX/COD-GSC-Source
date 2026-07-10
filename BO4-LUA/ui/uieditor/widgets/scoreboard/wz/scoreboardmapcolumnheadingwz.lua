CoD.ScoreboardMapColumnHeadingWZ = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapColumnHeadingWZ.__defaultWidth = 112
CoD.ScoreboardMapColumnHeadingWZ.__defaultHeight = 40
CoD.ScoreboardMapColumnHeadingWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapColumnHeadingWZ)
	self.id = "ScoreboardMapColumnHeadingWZ"
	self.soundSet = "default"
	local Section = LUI.UIText.new(0, 1, 0, 0, 0, 0, 8, 34)
	Section:setRGB(0.92, 0.92, 0.92)
	Section:setAlpha(0.7)
	Section:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Section:setTTF("ttmussels_demibold")
	Section:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Section:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Section)
	self.Section = Section
	local BetweenColumns = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 40)
	BetweenColumns:setRGB(0, 0, 0)
	self:addElement(BetweenColumns)
	self.BetweenColumns = BetweenColumns
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
