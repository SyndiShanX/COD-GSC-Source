CoD.PaintshopChooseSide = InheritFrom(LUI.UIElement)
CoD.PaintshopChooseSide.__defaultWidth = 320
CoD.PaintshopChooseSide.__defaultHeight = 37
CoD.PaintshopChooseSide.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintshopChooseSide)
	self.id = "PaintshopChooseSide"
	self.soundSet = "default"
	local text = LUI.UIText.new(0, 0, 0, 320, 0, 0, 1, 16)
	text:setRGB(0.92, 0.89, 0.72)
	text:setText(Engine[0xF9F1239CFD921FE](0x63E51BFF17859F1))
	text:setTTF("ttmussels_demibold")
	text:setLetterSpacing(6)
	text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(text)
	self.text = text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
