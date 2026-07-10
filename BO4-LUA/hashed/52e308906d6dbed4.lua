CoD.BM_ContractDifficultyIndicator = InheritFrom(LUI.UIElement)
CoD.BM_ContractDifficultyIndicator.__defaultWidth = 400
CoD.BM_ContractDifficultyIndicator.__defaultHeight = 400
CoD.BM_ContractDifficultyIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ContractDifficultyIndicator)
	self.id = "BM_ContractDifficultyIndicator"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Hard = LUI.UIText.new(0.5, 0.5, -188, 203, 1, 1, -354, -330)
	Hard:setRGB(0, 0, 0)
	Hard:setAlpha(0)
	Hard:setText(LocalizeToUpperString(0x16E8ABBB4FC27A))
	Hard:setTTF("ttmussels_demibold")
	Hard:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Hard:setBackingType(3)
	Hard:setBackingXPadding(12)
	Hard:setBackingYPadding(6)
	Hard:setBackingImage(RegisterImage(0xA170139EA8497A))
	Hard:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Hard:setBackingShaderVector(0, 0, 0, 0, 0)
	Hard:setupBackingNineSliceShader(16, 16)
	self:addElement(Hard)
	self.Hard = Hard
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ContractDifficultyIndicator.__resetProperties = function(f2_arg0)
	f2_arg0.Hard:completeAnimation()
	f2_arg0.Hard:setAlpha(0)
end
CoD.BM_ContractDifficultyIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hard = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Hard:completeAnimation()
			f4_arg0.Hard:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Hard)
		end,
	},
}
