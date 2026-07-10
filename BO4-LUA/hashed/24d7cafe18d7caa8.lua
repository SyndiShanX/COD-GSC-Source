CoD.ContractItemEmpty = InheritFrom(LUI.UIElement)
CoD.ContractItemEmpty.__defaultWidth = 418
CoD.ContractItemEmpty.__defaultHeight = 188
CoD.ContractItemEmpty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractItemEmpty)
	self.id = "ContractItemEmpty"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.4, 0.42, 0.42)
	Background:setAlpha(0.2)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	Background:setShaderVector(0, 1, 0, 0, 0)
	Background:setShaderVector(1, 0, 0, 0, 0)
	Background:setShaderVector(2, 1, 0, 0, 0)
	Background:setShaderVector(3, 0, 0, 0, 0)
	Background:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local Noise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Noise:setAlpha(0.75)
	Noise:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	Noise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	Noise:setShaderVector(0, 0, 0, 0, 0)
	Noise:setupNineSliceShader(196, 88)
	self:addElement(Noise)
	self.Noise = Noise
	local LED = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0)
	LED:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	LED:setShaderVector(0, 0, 0, 0, 0)
	LED:setupNineSliceShader(24, 24)
	self:addElement(LED)
	self.LED = LED
	local FrameBorder = LUI.UIImage.new(0, 1, 1, -1, 0, 1, 1, -1)
	FrameBorder:setAlpha(0)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.56, 0.56, 0.56)
	Border:setAlpha(0.15)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3E7BDCB879A5176D"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setShaderVector(1, 0, 0, 0, 0)
	Border:setupNineSliceShader(1, 1)
	self:addElement(Border)
	self.Border = Border
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractItemEmpty.__resetProperties = function(f2_arg0)
	f2_arg0.Background:completeAnimation()
	f2_arg0.Background:setRGB(0.4, 0.42, 0.42)
end
CoD.ContractItemEmpty.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Background:completeAnimation()
			f3_arg0.Background:setRGB(0.25, 0.29, 0.31)
			f3_arg0.clipFinished(f3_arg0.Background)
		end,
	},
}
