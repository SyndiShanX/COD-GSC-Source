CoD.EmblemEditorColorMixerPointer = InheritFrom(LUI.UIElement)
CoD.EmblemEditorColorMixerPointer.__defaultWidth = 2
CoD.EmblemEditorColorMixerPointer.__defaultHeight = 20
CoD.EmblemEditorColorMixerPointer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorColorMixerPointer)
	self.id = "EmblemEditorColorMixerPointer"
	self.soundSet = "default"
	local line = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(line)
	self.line = line
	local Linker = LUI.UIImage.new(0, 0, -1, 3, 0, 0, -10, 20)
	Linker:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local arrowLarge = LUI.UIImage.new(0, 0, -5.5, 6.5, 0, 0, -23, 1)
	arrowLarge:setAlpha(0)
	arrowLarge:setZRot(-90)
	arrowLarge:setImage(RegisterImage(@"uie_ui_hud_common_triangle"))
	self:addElement(arrowLarge)
	self.arrowLarge = arrowLarge
	local Arrow = LUI.UIImage.new(0, 0, -5, 7, 0, 0, -18.5, -6.5)
	Arrow:setZRot(-45)
	Arrow:setImage(RegisterImage(@"uie_ui_menu_social_emblem_corner"))
	Arrow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Arrow:setShaderVector(0, 3.2, 0, 0, 0)
	self:addElement(Arrow)
	self.Arrow = Arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
