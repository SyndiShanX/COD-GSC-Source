CoD.AARTierRewardTitle = InheritFrom(LUI.UIElement)
CoD.AARTierRewardTitle.__defaultWidth = 800
CoD.AARTierRewardTitle.__defaultHeight = 60
CoD.AARTierRewardTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 20, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.AARTierRewardTitle)
	self.id = "AARTierRewardTitle"
	self.soundSet = "none"
	local Rewards = LUI.UIText.new(0, 0, 0, 800, 0, 1, 0, 0)
	Rewards:setRGB(0.86, 0.74, 0.25)
	Rewards:setText(Engine[0xF9F1239CFD921FE](0x897061E92EE5BFC))
	Rewards:setTTF("ttmussels_regular")
	Rewards:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Rewards:setShaderVector(0, 0.77, 0, 0, 0)
	Rewards:setShaderVector(1, 0, 0, 0, 0)
	Rewards:setShaderVector(2, 1, 0.31, 0, 0.3)
	Rewards:setLetterSpacing(14)
	Rewards:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Rewards:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Rewards)
	self.Rewards = Rewards
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
