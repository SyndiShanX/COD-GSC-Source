CoD.ShopReserveItemRarityBacking = InheritFrom(LUI.UIElement)
CoD.ShopReserveItemRarityBacking.__defaultWidth = 236
CoD.ShopReserveItemRarityBacking.__defaultHeight = 506
CoD.ShopReserveItemRarityBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ShopReserveItemRarityBacking)
	self.id = "ShopReserveItemRarityBacking"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonBacking = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	CommonBacking:setImage(RegisterImage(0x498F0C9C6258148))
	self:addElement(CommonBacking)
	self.CommonBacking = CommonBacking
	local RareBacking = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	RareBacking:setAlpha(0)
	RareBacking:setImage(RegisterImage(0xC33C8FB9CCFAF31))
	self:addElement(RareBacking)
	self.RareBacking = RareBacking
	local LegendaryBacking = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	LegendaryBacking:setAlpha(0)
	LegendaryBacking:setImage(RegisterImage(0x4CBF809785677FE))
	self:addElement(LegendaryBacking)
	self.LegendaryBacking = LegendaryBacking
	local EpicBacking = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	EpicBacking:setAlpha(0)
	EpicBacking:setImage(RegisterImage(0x42B6A8A46AF63DC))
	self:addElement(EpicBacking)
	self.EpicBacking = EpicBacking
	local UltraBacking = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	UltraBacking:setAlpha(0)
	UltraBacking:setImage(RegisterImage(0x8CE2C8563E7BCD1))
	self:addElement(UltraBacking)
	self.UltraBacking = UltraBacking
	self:mergeStateConditions({
		{
			stateName = "Common",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0xFA11ABBEBCE1980])
			end,
		},
		{
			stateName = "Rare",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x895F040FAFBECB9])
			end,
		},
		{
			stateName = "Legendary",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x35E4133DEF6B806])
			end,
		},
		{
			stateName = "Epic",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0xC3B1CFA5096734])
			end,
		},
		{
			stateName = "Ultra",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x3006FE890A202D9])
			end,
		},
	})
	self:linkToElementModel(self, "rarity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ShopReserveItemRarityBacking.__resetProperties = function(f8_arg0)
	f8_arg0.UltraBacking:completeAnimation()
	f8_arg0.EpicBacking:completeAnimation()
	f8_arg0.LegendaryBacking:completeAnimation()
	f8_arg0.RareBacking:completeAnimation()
	f8_arg0.CommonBacking:completeAnimation()
	f8_arg0.UltraBacking:setAlpha(0)
	f8_arg0.EpicBacking:setAlpha(0)
	f8_arg0.LegendaryBacking:setAlpha(0)
	f8_arg0.RareBacking:setAlpha(0)
	f8_arg0.CommonBacking:setAlpha(1)
end
CoD.ShopReserveItemRarityBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.CommonBacking:completeAnimation()
			f9_arg0.CommonBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CommonBacking)
			f9_arg0.RareBacking:completeAnimation()
			f9_arg0.RareBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RareBacking)
			f9_arg0.LegendaryBacking:completeAnimation()
			f9_arg0.LegendaryBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LegendaryBacking)
			f9_arg0.EpicBacking:completeAnimation()
			f9_arg0.EpicBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.EpicBacking)
			f9_arg0.UltraBacking:completeAnimation()
			f9_arg0.UltraBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.UltraBacking)
		end,
	},
	Common = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.CommonBacking:completeAnimation()
			f10_arg0.CommonBacking:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.CommonBacking)
			f10_arg0.RareBacking:completeAnimation()
			f10_arg0.RareBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RareBacking)
			f10_arg0.LegendaryBacking:completeAnimation()
			f10_arg0.LegendaryBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.LegendaryBacking)
			f10_arg0.EpicBacking:completeAnimation()
			f10_arg0.EpicBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.EpicBacking)
			f10_arg0.UltraBacking:completeAnimation()
			f10_arg0.UltraBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.UltraBacking)
		end,
	},
	Rare = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			f11_arg0.CommonBacking:completeAnimation()
			f11_arg0.CommonBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CommonBacking)
			f11_arg0.RareBacking:completeAnimation()
			f11_arg0.RareBacking:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.RareBacking)
			f11_arg0.LegendaryBacking:completeAnimation()
			f11_arg0.LegendaryBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.LegendaryBacking)
			f11_arg0.EpicBacking:completeAnimation()
			f11_arg0.EpicBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.EpicBacking)
			f11_arg0.UltraBacking:completeAnimation()
			f11_arg0.UltraBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.UltraBacking)
		end,
	},
	Legendary = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			f12_arg0.CommonBacking:completeAnimation()
			f12_arg0.CommonBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CommonBacking)
			f12_arg0.RareBacking:completeAnimation()
			f12_arg0.RareBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RareBacking)
			f12_arg0.LegendaryBacking:completeAnimation()
			f12_arg0.LegendaryBacking:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.LegendaryBacking)
			f12_arg0.EpicBacking:completeAnimation()
			f12_arg0.EpicBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.EpicBacking)
			f12_arg0.UltraBacking:completeAnimation()
			f12_arg0.UltraBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.UltraBacking)
		end,
	},
	Epic = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			f13_arg0.CommonBacking:completeAnimation()
			f13_arg0.CommonBacking:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.CommonBacking)
			f13_arg0.RareBacking:completeAnimation()
			f13_arg0.RareBacking:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RareBacking)
			f13_arg0.LegendaryBacking:completeAnimation()
			f13_arg0.LegendaryBacking:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LegendaryBacking)
			f13_arg0.EpicBacking:completeAnimation()
			f13_arg0.EpicBacking:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.EpicBacking)
			f13_arg0.UltraBacking:completeAnimation()
			f13_arg0.UltraBacking:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.UltraBacking)
		end,
	},
	Ultra = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.CommonBacking:completeAnimation()
			f14_arg0.CommonBacking:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CommonBacking)
			f14_arg0.RareBacking:completeAnimation()
			f14_arg0.RareBacking:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.RareBacking)
			f14_arg0.LegendaryBacking:completeAnimation()
			f14_arg0.LegendaryBacking:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.LegendaryBacking)
			f14_arg0.EpicBacking:completeAnimation()
			f14_arg0.EpicBacking:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.EpicBacking)
			f14_arg0.UltraBacking:completeAnimation()
			f14_arg0.UltraBacking:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.UltraBacking)
		end,
	},
}
