require("x64:6735e84e8dd1117")
CoD.LootTierBoostPercentContraband = InheritFrom(LUI.UIElement)
CoD.LootTierBoostPercentContraband.__defaultWidth = 135
CoD.LootTierBoostPercentContraband.__defaultHeight = 16
CoD.LootTierBoostPercentContraband.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LootTierBoostPercentContraband)
	self.id = "LootTierBoostPercentContraband"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TierBoost = LUI.UIText.new(0, 0.96, 0, 0, 0, 1, 0, 0)
	TierBoost:setRGB(0, 0, 0)
	TierBoost:setTTF("ttmussels_demibold")
	TierBoost:setLetterSpacing(2)
	TierBoost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TierBoost:setBackingType(1)
	TierBoost:setBackingWidget(CoD.ContractSeasonalPromoBacker, f1_arg0, f1_arg1)
	TierBoost:setBackingXPadding(7)
	TierBoost:setBackingYPadding(1)
	TierBoost:subscribeToGlobalModel(f1_arg1, "TierBoostPercent", "boost_amount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TierBoost:setText(ToUpper(CoD.BlackMarketUtility.GetTierBoostPercentString(f1_arg1, f2_local0)))
		end
	end)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LootTierBoostPercentContraband.__resetProperties = function(f3_arg0)
	f3_arg0.TierBoost:completeAnimation()
	f3_arg0.TierBoost:setAlpha(1)
end
CoD.LootTierBoostPercentContraband.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.TierBoost:completeAnimation()
			f5_arg0.TierBoost:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TierBoost)
		end,
	},
}
CoD.LootTierBoostPercentContraband.__onClose = function(f6_arg0)
	f6_arg0.TierBoost:close()
end
