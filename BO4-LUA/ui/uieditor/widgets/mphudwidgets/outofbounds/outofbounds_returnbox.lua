CoD.outofbounds_returnbox = InheritFrom(LUI.UIElement)
CoD.outofbounds_returnbox.__defaultWidth = 1148
CoD.outofbounds_returnbox.__defaultHeight = 48
CoD.outofbounds_returnbox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_returnbox)
	self.id = "outofbounds_returnbox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackBox = LUI.UIImage.new(0, 0, 0, 1148, -0.02, -0.02, 0, 50)
	BlackBox:setAlpha(0.7)
	BlackBox:setImage(RegisterImage(0x53C219542F385EB))
	self:addElement(BlackBox)
	self.BlackBox = BlackBox
	local ReturnText = LUI.UIText.new(0.5, 0.5, -422, 422, 0, 0, 7.5, 43.5)
	ReturnText:setAlpha(0.95)
	ReturnText:setText(Engine[0xF9F1239CFD921FE](0x286141CEBC1E318))
	ReturnText:setTTF("0arame_mono_stencil")
	ReturnText:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	ReturnText:setShaderVector(0, 0.05, 0, 0, 0)
	ReturnText:setShaderVector(1, 0.01, 0, 0, 0)
	ReturnText:setShaderVector(2, 1, 0, 0, 0)
	ReturnText:setLetterSpacing(3.9)
	ReturnText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ReturnText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ReturnText)
	self.ReturnText = ReturnText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
