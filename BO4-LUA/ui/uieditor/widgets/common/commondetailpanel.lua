CoD.CommonDetailPanel = InheritFrom(LUI.UIElement)
CoD.CommonDetailPanel.__defaultWidth = 474
CoD.CommonDetailPanel.__defaultHeight = 578
CoD.CommonDetailPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonDetailPanel)
	self.id = "CommonDetailPanel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local BackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingTint:setRGB(0.09, 0.09, 0.09)
	BackingTint:setAlpha(0.9)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local BackingNoise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingNoise:setAlpha(0.5)
	BackingNoise:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local HeaderStripe3 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -17, -1)
	HeaderStripe3:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	HeaderStripe3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderStripe3:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripe3:setupNineSliceShader(90, 16)
	self:addElement(HeaderStripe3)
	self.HeaderStripe3 = HeaderStripe3
	local HeaderStripe2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -17, -1)
	HeaderStripe2:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	HeaderStripe2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderStripe2:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripe2:setupNineSliceShader(90, 16)
	self:addElement(HeaderStripe2)
	self.HeaderStripe2 = HeaderStripe2
	local HeaderStripe1 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -17, -1)
	HeaderStripe1:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	HeaderStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderStripe1:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripe1:setupNineSliceShader(90, 16)
	self:addElement(HeaderStripe1)
	self.HeaderStripe1 = HeaderStripe1
	local FooterStripe3 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 0, 16)
	FooterStripe3:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	FooterStripe3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	FooterStripe3:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe3:setupNineSliceShader(90, 16)
	self:addElement(FooterStripe3)
	self.FooterStripe3 = FooterStripe3
	local FooterStripe2 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 1, 17)
	FooterStripe2:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	FooterStripe2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	FooterStripe2:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe2:setupNineSliceShader(90, 16)
	self:addElement(FooterStripe2)
	self.FooterStripe2 = FooterStripe2
	local FooterStripe1 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 0, 16)
	FooterStripe1:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	FooterStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	FooterStripe1:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe1:setupNineSliceShader(90, 16)
	self:addElement(FooterStripe1)
	self.FooterStripe1 = FooterStripe1
	local BraketBottom = LUI.UIImage.new(0, 1, -2, 2, 1, 1, -28, 1)
	BraketBottom:setZRot(180)
	BraketBottom:setImage(RegisterImage("uie_ui_menu_specialist_hub_info_bracket"))
	BraketBottom:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	BraketBottom:setShaderVector(0, 0, 0, 0, 0)
	BraketBottom:setupNineSliceShader(200, 100)
	self:addElement(BraketBottom)
	self.BraketBottom = BraketBottom
	local BraketTop = LUI.UIImage.new(0, 1, -2, 2, 0, 0, -1, 28)
	BraketTop:setImage(RegisterImage("uie_ui_menu_specialist_hub_info_bracket"))
	BraketTop:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	BraketTop:setShaderVector(0, 0, 0, 0, 0)
	BraketTop:setupNineSliceShader(200, 100)
	self:addElement(BraketTop)
	self.BraketTop = BraketTop
	self:mergeStateConditions({
		{
			stateName = "HideBottom",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonDetailPanel.__resetProperties = function(f3_arg0)
	f3_arg0.FooterStripe1:completeAnimation()
	f3_arg0.FooterStripe2:completeAnimation()
	f3_arg0.FooterStripe3:completeAnimation()
	f3_arg0.FooterStripe1:setAlpha(1)
	f3_arg0.FooterStripe2:setAlpha(1)
	f3_arg0.FooterStripe3:setAlpha(1)
end
CoD.CommonDetailPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	HideBottom = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.FooterStripe3:completeAnimation()
			f5_arg0.FooterStripe3:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.FooterStripe3)
			f5_arg0.FooterStripe2:completeAnimation()
			f5_arg0.FooterStripe2:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.FooterStripe2)
			f5_arg0.FooterStripe1:completeAnimation()
			f5_arg0.FooterStripe1:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.FooterStripe1)
		end,
	},
}
