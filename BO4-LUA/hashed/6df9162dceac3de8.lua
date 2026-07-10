CoD.BM_ActiveContractItemReward = InheritFrom(LUI.UIElement)
CoD.BM_ActiveContractItemReward.__defaultWidth = 150
CoD.BM_ActiveContractItemReward.__defaultHeight = 50
CoD.BM_ActiveContractItemReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ActiveContractItemReward)
	self.id = "BM_ActiveContractItemReward"
	self.soundSet = "none"
	local RewardIcon = LUI.UIImage.new(0, 0, 0, 60, 0.5, 0.5, -23, 37)
	RewardIcon:setImage(RegisterImage(@"ui_icon_blackmarket_reserves_case_small"))
	self:addElement(RewardIcon)
	self.RewardIcon = RewardIcon
	local RewardsAmount = LUI.UIText.new(0, 0, 63, 143, 0, 0, 13, 37)
	RewardsAmount:setText("")
	RewardsAmount:setTTF("ttmussels_demibold")
	RewardsAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RewardsAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RewardsAmount)
	self.RewardsAmount = RewardsAmount
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
