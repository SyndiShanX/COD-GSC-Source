CoD.VodButtonPrompt = InheritFrom(LUI.UIElement)
CoD.VodButtonPrompt.__defaultWidth = 200
CoD.VodButtonPrompt.__defaultHeight = 33
CoD.VodButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VodButtonPrompt)
	self.id = "VodButtonPrompt"
	self.soundSet = "default"
	local Play = LUI.UIText.new(0, 0, 33, 200, 0, 0, 4.5, 28.5)
	Play:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Play:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_D31D493AE40DA0F"))
	Play:setTTF("ttmussels_regular")
	Play:setLetterSpacing(6)
	Play:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Play)
	self.Play = Play
	local buttonPromptImage = LUI.UIImage.new(0, 0, 1.5, 31.5, 0, 0, 1.5, 31.5)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
