CoD.ReservesRerollItemDetails = InheritFrom(LUI.UIElement)
CoD.ReservesRerollItemDetails.__defaultWidth = 250
CoD.ReservesRerollItemDetails.__defaultHeight = 180
CoD.ReservesRerollItemDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesRerollItemDetails)
	self.id = "ReservesRerollItemDetails"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CaseIcon = LUI.UIImage.new(0.5, 0.5, -75, 75, 0, 0, 0, 150)
	CaseIcon:setImage(RegisterImage(@"ui_icon_blackmarket_reserves_case_small"))
	self:addElement(CaseIcon)
	self.CaseIcon = CaseIcon
	local CrateIcon = LUI.UIImage.new(0.5, 0.5, -75, 75, 0, 0, 0, 150)
	CrateIcon:setAlpha(0)
	CrateIcon:setImage(RegisterImage(@"ui_icon_blackmarket_reserves_crate_small"))
	self:addElement(CrateIcon)
	self.CrateIcon = CrateIcon
	local BribeIcon = LUI.UIImage.new(0.5, 0.5, -142, 142, 0, 0, -22, 130)
	BribeIcon:setAlpha(0)
	BribeIcon:setImage(RegisterImage(@"uie_t7_blackmarket_crate_bribe_chip"))
	self:addElement(BribeIcon)
	self.BribeIcon = BribeIcon
	local BundleCrateIcon = LUI.UIImage.new(0.5, 0.5, -142, 142, 0, 0, -22, 130)
	BundleCrateIcon:setAlpha(0)
	BundleCrateIcon:setImage(RegisterImage(@"hash_620F12DAD4B05C97"))
	self:addElement(BundleCrateIcon)
	self.BundleCrateIcon = BundleCrateIcon
	local CaseCount = LUI.UIText.new(0.5, 0.5, -75, 75, 0, 0, 101, 141)
	CaseCount:setTTF("ttmussels_demibold")
	CaseCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	CaseCount:setShaderVector(0, 0.1, 0, 0, 0)
	CaseCount:setShaderVector(1, 0, 0, 0, 1)
	CaseCount:setLetterSpacing(2)
	CaseCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CaseCount:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	CaseCount:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootCaseCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CaseCount:setText(f2_local0)
		end
	end)
	self:addElement(CaseCount)
	self.CaseCount = CaseCount
	local BundleCrateCount = LUI.UIText.new(0.5, 0.5, -75, 75, 0, 0, 101, 141)
	BundleCrateCount:setAlpha(0)
	BundleCrateCount:setTTF("ttmussels_demibold")
	BundleCrateCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	BundleCrateCount:setShaderVector(0, 0.1, 0, 0, 0)
	BundleCrateCount:setShaderVector(1, 0, 0, 0, 1)
	BundleCrateCount:setLetterSpacing(2)
	BundleCrateCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	BundleCrateCount:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	BundleCrateCount:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootBundleCrateCount", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BundleCrateCount:setText(f3_local0)
		end
	end)
	self:addElement(BundleCrateCount)
	self.BundleCrateCount = BundleCrateCount
	local BribeCount = LUI.UIText.new(0.5, 0.5, -75, 75, 0, 0, 101, 141)
	BribeCount:setAlpha(0)
	BribeCount:setTTF("ttmussels_demibold")
	BribeCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	BribeCount:setShaderVector(0, 0.1, 0, 0, 0)
	BribeCount:setShaderVector(1, 0, 0, 0, 1)
	BribeCount:setLetterSpacing(2)
	BribeCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	BribeCount:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	BribeCount:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootBribeCount", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BribeCount:setText(f4_local0)
		end
	end)
	self:addElement(BribeCount)
	self.BribeCount = BribeCount
	local CaseTitle = LUI.UIText.new(0, 0, 0, 250, 0, 0, 155, 178)
	CaseTitle:setText(LocalizeToUpperString(@"hash_D004F2913090A"))
	CaseTitle:setTTF("ttmussels_regular")
	CaseTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CaseTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(CaseTitle)
	self.CaseTitle = CaseTitle
	local CrateTitle = LUI.UIText.new(0, 0, 0, 250, 0, 0, 155, 178)
	CrateTitle:setAlpha(0)
	CrateTitle:setText(LocalizeToUpperString(@"hash_683A7EF42505FCE5"))
	CrateTitle:setTTF("ttmussels_regular")
	CrateTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CrateTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(CrateTitle)
	self.CrateTitle = CrateTitle
	local WeaponBribeTitle = LUI.UIText.new(0, 0, 0, 250, 0, 0, 155, 178)
	WeaponBribeTitle:setAlpha(0)
	WeaponBribeTitle:setText(LocalizeToUpperString(@"menu/bribes"))
	WeaponBribeTitle:setTTF("ttmussels_regular")
	WeaponBribeTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WeaponBribeTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WeaponBribeTitle)
	self.WeaponBribeTitle = WeaponBribeTitle
	local NoDupeBribeTitle = LUI.UIText.new(0.5, 0.5, -105, 109, 0, 0, 155, 178)
	NoDupeBribeTitle:setAlpha(0)
	NoDupeBribeTitle:setText(LocalizeToUpperString(@"hash_1717FF140F30014C"))
	NoDupeBribeTitle:setTTF("ttmussels_regular")
	NoDupeBribeTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NoDupeBribeTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(NoDupeBribeTitle)
	self.NoDupeBribeTitle = NoDupeBribeTitle
	local BundleCrateTitle = LUI.UIText.new(0, 0, 0, 250, 0, 0, 155, 178)
	BundleCrateTitle:setAlpha(0)
	BundleCrateTitle:setText(LocalizeToUpperString(@"hash_5DAA91F7954A788A"))
	BundleCrateTitle:setTTF("ttmussels_regular")
	BundleCrateTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	BundleCrateTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(BundleCrateTitle)
	self.BundleCrateTitle = BundleCrateTitle
	local NoDupeBribeIcon = LUI.UIImage.new(0, 0, -17, 267, 0, 0, -7, 145)
	NoDupeBribeIcon:setAlpha(0)
	NoDupeBribeIcon:setImage(RegisterImage(@"hash_296460AAA869F14A"))
	self:addElement(NoDupeBribeIcon)
	self.NoDupeBribeIcon = NoDupeBribeIcon
	self:mergeStateConditions({
		{
			stateName = "Case",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "LootRNGResult.streamId", CoD.BlackMarketUtility.CrateStreams.CASE)
			end,
		},
		{
			stateName = "BundleCrate",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "LootRNGResult.streamId", CoD.BlackMarketUtility.CrateStreams.THREE_PACK)
				if f6_local0 then
					f6_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBundleCrate")
					if f6_local0 then
						f6_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "ReservesItemCounts", "lootBundleCrateCount", 0)
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "NoDupeBribe",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToHashString(f1_arg1, element, "name", @"hash_1717FF140F30014C")
			end,
		},
		{
			stateName = "Crate",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "LootRNGResult.streamId", CoD.BlackMarketUtility.CrateStreams.THREE_PACK)
			end,
		},
		{
			stateName = "BribeStack",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.IsBribeMenuOrBribeStackStream(f1_arg1)
			end,
		},
		{
			stateName = "Bribe",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.IsBribeStream(f1_arg1)
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local15(f1_local14, f1_local16["LootRNGResult.streamId"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LootRNGResult.streamId",
		})
	end, false)
	self:linkToElementModel(self, "isBundleCrate", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBundleCrate",
		})
	end)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = DataSources.ReservesItemCounts.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.lootBundleCrateCount, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lootBundleCrateCount",
		})
	end, false)
	self:linkToElementModel(self, "name", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesRerollItemDetails.__resetProperties = function(f15_arg0)
	f15_arg0.CaseTitle:completeAnimation()
	f15_arg0.CaseCount:completeAnimation()
	f15_arg0.CaseIcon:completeAnimation()
	f15_arg0.BundleCrateCount:completeAnimation()
	f15_arg0.BundleCrateTitle:completeAnimation()
	f15_arg0.BundleCrateIcon:completeAnimation()
	f15_arg0.BribeCount:completeAnimation()
	f15_arg0.BribeIcon:completeAnimation()
	f15_arg0.WeaponBribeTitle:completeAnimation()
	f15_arg0.NoDupeBribeIcon:completeAnimation()
	f15_arg0.NoDupeBribeTitle:completeAnimation()
	f15_arg0.CrateTitle:completeAnimation()
	f15_arg0.CrateIcon:completeAnimation()
	f15_arg0.CaseTitle:setAlpha(1)
	f15_arg0.CaseCount:setAlpha(1)
	f15_arg0.CaseIcon:setAlpha(1)
	f15_arg0.BundleCrateCount:setAlpha(0)
	f15_arg0.BundleCrateTitle:setLeftRight(0, 0, 0, 250)
	f15_arg0.BundleCrateTitle:setAlpha(0)
	f15_arg0.BundleCrateIcon:setAlpha(0)
	f15_arg0.BribeCount:setAlpha(0)
	f15_arg0.BribeIcon:setAlpha(0)
	f15_arg0.BribeIcon:setImage(RegisterImage(@"uie_t7_blackmarket_crate_bribe_chip"))
	f15_arg0.WeaponBribeTitle:setAlpha(0)
	f15_arg0.WeaponBribeTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	f15_arg0.NoDupeBribeIcon:setAlpha(0)
	f15_arg0.NoDupeBribeTitle:setAlpha(0)
	f15_arg0.CrateTitle:setAlpha(0)
	f15_arg0.CrateIcon:setAlpha(0)
end
CoD.ReservesRerollItemDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.CaseIcon:completeAnimation()
			f16_arg0.CaseIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CaseIcon)
			f16_arg0.CaseCount:completeAnimation()
			f16_arg0.CaseCount:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CaseCount)
			f16_arg0.CaseTitle:completeAnimation()
			f16_arg0.CaseTitle:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CaseTitle)
		end,
	},
	Case = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	BundleCrate = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(6)
			f18_arg0.CaseIcon:completeAnimation()
			f18_arg0.CaseIcon:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.CaseIcon)
			f18_arg0.BundleCrateIcon:completeAnimation()
			f18_arg0.BundleCrateIcon:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.BundleCrateIcon)
			f18_arg0.CaseCount:completeAnimation()
			f18_arg0.CaseCount:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.CaseCount)
			f18_arg0.BundleCrateCount:completeAnimation()
			f18_arg0.BundleCrateCount:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.BundleCrateCount)
			f18_arg0.CaseTitle:completeAnimation()
			f18_arg0.CaseTitle:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.CaseTitle)
			f18_arg0.BundleCrateTitle:completeAnimation()
			f18_arg0.BundleCrateTitle:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.BundleCrateTitle)
		end,
	},
	NoDupeBribe = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(9)
			f19_arg0.CaseIcon:completeAnimation()
			f19_arg0.CaseIcon:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.CaseIcon)
			f19_arg0.BribeIcon:completeAnimation()
			f19_arg0.BribeIcon:setAlpha(0)
			f19_arg0.BribeIcon:setImage(RegisterImage(@"hash_491C73044887736F"))
			f19_arg0.clipFinished(f19_arg0.BribeIcon)
			f19_arg0.CaseCount:completeAnimation()
			f19_arg0.CaseCount:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.CaseCount)
			f19_arg0.BribeCount:completeAnimation()
			f19_arg0.BribeCount:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.BribeCount)
			f19_arg0.CaseTitle:completeAnimation()
			f19_arg0.CaseTitle:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.CaseTitle)
			f19_arg0.WeaponBribeTitle:completeAnimation()
			f19_arg0.WeaponBribeTitle:setAlpha(0)
			f19_arg0.WeaponBribeTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
			f19_arg0.clipFinished(f19_arg0.WeaponBribeTitle)
			f19_arg0.NoDupeBribeTitle:completeAnimation()
			f19_arg0.NoDupeBribeTitle:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.NoDupeBribeTitle)
			f19_arg0.BundleCrateTitle:completeAnimation()
			f19_arg0.BundleCrateTitle:setLeftRight(0, 0, 10, 241)
			f19_arg0.clipFinished(f19_arg0.BundleCrateTitle)
			f19_arg0.NoDupeBribeIcon:completeAnimation()
			f19_arg0.NoDupeBribeIcon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.NoDupeBribeIcon)
		end,
	},
	Crate = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			f20_arg0.CaseIcon:completeAnimation()
			f20_arg0.CaseIcon:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CaseIcon)
			f20_arg0.CrateIcon:completeAnimation()
			f20_arg0.CrateIcon:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.CrateIcon)
			f20_arg0.CaseCount:completeAnimation()
			f20_arg0.CaseCount:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CaseCount)
			f20_arg0.CaseTitle:completeAnimation()
			f20_arg0.CaseTitle:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CaseTitle)
			f20_arg0.CrateTitle:completeAnimation()
			f20_arg0.CrateTitle:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.CrateTitle)
		end,
	},
	BribeStack = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(6)
			f21_arg0.CaseIcon:completeAnimation()
			f21_arg0.CaseIcon:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CaseIcon)
			f21_arg0.BribeIcon:completeAnimation()
			f21_arg0.BribeIcon:setAlpha(1)
			f21_arg0.BribeIcon:setImage(RegisterImage(@"hash_491C73044887736F"))
			f21_arg0.clipFinished(f21_arg0.BribeIcon)
			f21_arg0.CaseCount:completeAnimation()
			f21_arg0.CaseCount:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CaseCount)
			f21_arg0.BribeCount:completeAnimation()
			f21_arg0.BribeCount:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.BribeCount)
			f21_arg0.CaseTitle:completeAnimation()
			f21_arg0.CaseTitle:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CaseTitle)
			f21_arg0.WeaponBribeTitle:completeAnimation()
			f21_arg0.WeaponBribeTitle:setAlpha(1)
			f21_arg0.WeaponBribeTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
			f21_arg0.clipFinished(f21_arg0.WeaponBribeTitle)
		end,
	},
	Bribe = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(6)
			f22_arg0.CaseIcon:completeAnimation()
			f22_arg0.CaseIcon:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CaseIcon)
			f22_arg0.BribeIcon:completeAnimation()
			f22_arg0.BribeIcon:setAlpha(1)
			f22_arg0.BribeIcon:setImage(RegisterImage(@"hash_491C73044887736F"))
			f22_arg0.clipFinished(f22_arg0.BribeIcon)
			f22_arg0.CaseCount:completeAnimation()
			f22_arg0.CaseCount:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CaseCount)
			f22_arg0.BribeCount:completeAnimation()
			f22_arg0.BribeCount:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.BribeCount)
			f22_arg0.CaseTitle:completeAnimation()
			f22_arg0.CaseTitle:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CaseTitle)
			f22_arg0.WeaponBribeTitle:completeAnimation()
			f22_arg0.WeaponBribeTitle:setAlpha(1)
			f22_arg0.WeaponBribeTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
			f22_arg0.clipFinished(f22_arg0.WeaponBribeTitle)
		end,
	},
}
CoD.ReservesRerollItemDetails.__onClose = function(f23_arg0)
	f23_arg0.CaseCount:close()
	f23_arg0.BundleCrateCount:close()
	f23_arg0.BribeCount:close()
end
