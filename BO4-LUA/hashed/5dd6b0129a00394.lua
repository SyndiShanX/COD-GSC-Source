require("x64:d58642f40ad6e08")
CoD.BM_ActiveContractItemRewardsContainer = InheritFrom(LUI.UIElement)
CoD.BM_ActiveContractItemRewardsContainer.__defaultWidth = 500
CoD.BM_ActiveContractItemRewardsContainer.__defaultHeight = 128
CoD.BM_ActiveContractItemRewardsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ActiveContractItemRewardsContainer)
	self.id = "BM_ActiveContractItemRewardsContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Rewards = LUI.UIText.new(0.5, 0.5, -248, 248, 0, 0, 11, 37)
	Rewards:setText(LocalizeToUpperString(0x2ACBA21D0C15241))
	Rewards:setTTF("ttmussels_regular")
	Rewards:setLetterSpacing(2)
	Rewards:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Rewards:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Rewards)
	self.Rewards = Rewards
	local BMActiveContractXpReward = CoD.BM_ActiveContractRewards.new(f1_arg0, f1_arg1, 0.5, 0.5, -220, 220, 0, 0, 71, 121)
	BMActiveContractXpReward:linkToElementModel(self, nil, false, function(model)
		BMActiveContractXpReward:setModel(model, f1_arg1)
	end)
	self:addElement(BMActiveContractXpReward)
	self.BMActiveContractXpReward = BMActiveContractXpReward
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ActiveContractItemRewardsContainer.__onClose = function(f3_arg0)
	f3_arg0.BMActiveContractXpReward:close()
end
