require("x64:c05c22817826024")
CoD.BM_ActiveContractXpReward = InheritFrom(LUI.UIElement)
CoD.BM_ActiveContractXpReward.__defaultWidth = 150
CoD.BM_ActiveContractXpReward.__defaultHeight = 50
CoD.BM_ActiveContractXpReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ActiveContractXpReward)
	self.id = "BM_ActiveContractXpReward"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local RewardsAmount = LUI.UIText.new(0, 0, 47, 139, 0, 0, 13, 37)
	RewardsAmount:setText("")
	RewardsAmount:setTTF("ttmussels_demibold")
	RewardsAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RewardsAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RewardsAmount)
	self.RewardsAmount = RewardsAmount
	local CommonXpIcon = CoD.CommonXpIcon.new(f1_arg0, f1_arg1, 0, 0, 0, 44, 0, 0, 3, 47)
	self:addElement(CommonXpIcon)
	self.CommonXpIcon = CommonXpIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ActiveContractXpReward.__onClose = function(f2_arg0)
	f2_arg0.CommonXpIcon:close()
end
