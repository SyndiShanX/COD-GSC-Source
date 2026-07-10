CoD.BM_ActiveContractItemReward = InheritFrom(LUI.UIElement)
CoD.BM_ActiveContractItemReward.__defaultWidth = 150
CoD.BM_ActiveContractItemReward.__defaultHeight = 50
CoD.BM_ActiveContractItemReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ActiveContractItemReward)
	self.id = "BM_ActiveContractItemReward"
	self.soundSet = "none"
	local RewardIcon = LUI.UIImage.new(0, 0, 0, 60, 0.5, 0.5, -23, 37)
	RewardIcon:setImage(RegisterImage(0xD0C0C9F62783A5C))
	self:addElement(RewardIcon)
	self.RewardIcon = RewardIcon
	local RewardsAmount = LUI.UIText.new(0, 0, 63, 143, 0, 0, 13, 37)
	RewardsAmount:setText("")
	RewardsAmount:setTTF("ttmussels_demibold")
	RewardsAmount:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RewardsAmount:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(RewardsAmount)
	self.RewardsAmount = RewardsAmount
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
