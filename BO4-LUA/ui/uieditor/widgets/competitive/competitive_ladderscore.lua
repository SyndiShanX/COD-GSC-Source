CoD.Competitive_ladderScore = InheritFrom(LUI.UIElement)
CoD.Competitive_ladderScore.__defaultWidth = 300
CoD.Competitive_ladderScore.__defaultHeight = 105
CoD.Competitive_ladderScore.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Competitive_ladderScore)
	self.id = "Competitive_ladderScore"
	self.soundSet = "default"
	local PLUS2 = LUI.UIText.new(0.5, 0.5, -46, 187, 0.5, 0.5, -48.5, 56.5)
	PLUS2:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	PLUS2:setScale(1.25, 1.25)
	PLUS2:setText(200)
	PLUS2:setTTF("0arame_mono_stencil")
	PLUS2:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	PLUS2:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(PLUS2)
	self.PLUS2 = PLUS2
	local PLUS = LUI.UIText.new(0, 0, 3, 63, 0.5, 0.5, -52.5, 52.5)
	PLUS:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	PLUS:setScale(1.25, 1.25)
	PLUS:setText(Engine[0xF9F1239CFD921FE](0x79FAB66208B3145))
	PLUS:setTTF("0arame_mono_stencil")
	PLUS:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	PLUS:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041]))
	PLUS:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(PLUS)
	self.PLUS = PLUS
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
