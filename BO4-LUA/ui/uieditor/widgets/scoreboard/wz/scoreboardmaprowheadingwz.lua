CoD.ScoreboardMapRowHeadingWZ = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapRowHeadingWZ.__defaultWidth = 40
CoD.ScoreboardMapRowHeadingWZ.__defaultHeight = 112
CoD.ScoreboardMapRowHeadingWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapRowHeadingWZ)
	self.id = "ScoreboardMapRowHeadingWZ"
	self.soundSet = "default"
	local TextBox = LUI.UIText.new(0.5, 0.5, -20, 20, 0.5, 0.5, -13.5, 13.5)
	TextBox:setRGB(0.92, 0.92, 0.92)
	TextBox:setAlpha(0.7)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x908BB4202CBC31))
	TextBox:setTTF("ttmussels_demibold")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local DividerBot = LUI.UIImage.new(0, 0, 0, 40, 1, 1, 0, 1)
	DividerBot:setRGB(0, 0, 0)
	self:addElement(DividerBot)
	self.DividerBot = DividerBot
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
