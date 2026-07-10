CoD.AARTierRewardContraband = InheritFrom(LUI.UIElement)
CoD.AARTierRewardContraband.__defaultWidth = 310
CoD.AARTierRewardContraband.__defaultHeight = 632
CoD.AARTierRewardContraband.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardContraband)
	self.id = "AARTierRewardContraband"
	self.soundSet = "default"
	local ContrabandFull = LUI.UIImage.new(0, 0, 0, 310, 0, 0, 0, 632)
	ContrabandFull:setImage(RegisterImage(0x34C2E838E78D6B3))
	ContrabandFull:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	ContrabandFull:setShaderVector(0, 0, 0, 0, 0)
	ContrabandFull:setShaderVector(1, 1, 1, 0, 0)
	ContrabandFull:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(ContrabandFull)
	self.ContrabandFull = ContrabandFull
	local ContrabandFrame = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	ContrabandFrame:setRGB(0.71, 0.68, 0.44)
	ContrabandFrame:setImage(RegisterImage(0xCB07CCC28498CB2))
	ContrabandFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ContrabandFrame:setShaderVector(0, 0, 0, 0, 0)
	ContrabandFrame:setupNineSliceShader(10, 10)
	self:addElement(ContrabandFrame)
	self.ContrabandFrame = ContrabandFrame
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
