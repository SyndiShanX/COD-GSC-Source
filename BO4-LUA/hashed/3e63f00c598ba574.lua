require("x64:6735e84e8dd1117")
CoD.ItemShopTierBoost = InheritFrom(LUI.UIElement)
CoD.ItemShopTierBoost.__defaultWidth = 211
CoD.ItemShopTierBoost.__defaultHeight = 26
CoD.ItemShopTierBoost.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopTierBoost)
	self.id = "ItemShopTierBoost"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Corner = LUI.UIImage.new(0, 0, 195, 211, 0, 0, 0, 16)
	Corner:setRGB(0.45, 0.41, 0.07)
	Corner:setImage(RegisterImage(@"hash_5B998225BD626F68"))
	self:addElement(Corner)
	self.Corner = Corner
	local Promo = LUI.UIText.new(0, 0, 0, 200, 0, 0, 9, 28)
	Promo:setRGB(0, 0, 0)
	Promo:setTTF("ttmussels_demibold")
	Promo:setLetterSpacing(2)
	Promo:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Promo:setBackingType(1)
	Promo:setBackingWidget(CoD.ContractSeasonalPromoBacker, f1_arg0, f1_arg1)
	Promo:setBackingXPadding(7)
	Promo:setBackingYPadding(1)
	Promo:subscribeToGlobalModel(f1_arg1, "TierBoostPercent", "specialorder_boost_amount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Promo:setText(ToUpper(CoD.BlackMarketUtility.GetTierBoostPercentString(f1_arg1, f2_local0)))
		end
	end)
	self:addElement(Promo)
	self.Promo = Promo
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopTierBoost.__resetProperties = function(f3_arg0)
	f3_arg0.Promo:completeAnimation()
	f3_arg0.Corner:completeAnimation()
	f3_arg0.Promo:setAlpha(1)
	f3_arg0.Corner:setAlpha(1)
end
CoD.ItemShopTierBoost.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Corner:completeAnimation()
			f5_arg0.Corner:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Corner)
			f5_arg0.Promo:completeAnimation()
			f5_arg0.Promo:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Promo)
		end,
	},
}
CoD.ItemShopTierBoost.__onClose = function(f6_arg0)
	f6_arg0.Promo:close()
end
