require("x64:9532492bc6fcfca")
CoD.BM_ActiveContractRewards_ZMTierSkip = InheritFrom(LUI.UIElement)
CoD.BM_ActiveContractRewards_ZMTierSkip.__defaultWidth = 150
CoD.BM_ActiveContractRewards_ZMTierSkip.__defaultHeight = 50
CoD.BM_ActiveContractRewards_ZMTierSkip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ActiveContractRewards_ZMTierSkip)
	self.id = "BM_ActiveContractRewards_ZMTierSkip"
	self.soundSet = "none"
	local RewardsAmount = LUI.UIText.new(0, 0, 44, 156, 0, 0, 13, 37)
	RewardsAmount:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_659AB2B00A337CBE"))
	RewardsAmount:setTTF("dinnext_regular")
	RewardsAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RewardsAmount:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(RewardsAmount)
	self.RewardsAmount = RewardsAmount
	local RewardIcon = LUI.UIImage.new(0, 0, 1, 42, 0.5, 0.5, -20.5, 20.5)
	RewardIcon:setImage(RegisterImage(@"uie_ui_icon_blackmarket_tier_token"))
	self:addElement(RewardIcon)
	self.RewardIcon = RewardIcon
	local Promo = LUI.UIText.new(0, 0, 44.5, 244.5, 0, 0, -9, 7)
	Promo:setRGB(0, 0, 0)
	Promo:setText(LocalizeToUpperString(@"menu/zombies_bonus"))
	Promo:setTTF("ttmussels_demibold")
	Promo:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Promo:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Promo:setBackingType(1)
	Promo:setBackingWidget(CoD.ZM_Promo_Banner, f1_arg0, f1_arg1)
	Promo:setBackingColor(1, 0.87, 0)
	Promo:setBackingXPadding(3)
	Promo:setBackingYPadding(3)
	self:addElement(Promo)
	self.Promo = Promo
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
