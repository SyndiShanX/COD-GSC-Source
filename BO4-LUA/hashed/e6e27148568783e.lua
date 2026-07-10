require("x64:a64a3cc00bddbfa")
require("x64:e78e80d32559e2a")
require("x64:6f694d60ec64699")
require("x64:fd6432d26a0a682")
require("x64:dc874d6188ab7d0")
require("x64:d46b57f9867ec93")
require("x64:f106f8df9c638b3")
require("x64:2d361ac3553c22a")
CoD.AARTierRewardShowcase = InheritFrom(LUI.UIElement)
CoD.AARTierRewardShowcase.__defaultWidth = 310
CoD.AARTierRewardShowcase.__defaultHeight = 631
CoD.AARTierRewardShowcase.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardShowcase)
	self.id = "AARTierRewardShowcase"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RewardCommon = CoD.AARTierRewardShowcaseInternalCommon.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	RewardCommon:linkToElementModel(self, nil, false, function(model)
		RewardCommon:setModel(model, f1_arg1)
	end)
	self:addElement(RewardCommon)
	self.RewardCommon = RewardCommon
	local RewardRare = CoD.AARTierRewardShowcaseInternalRare.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	RewardRare:setAlpha(0)
	RewardRare:linkToElementModel(self, nil, false, function(model)
		RewardRare:setModel(model, f1_arg1)
	end)
	self:addElement(RewardRare)
	self.RewardRare = RewardRare
	local RewardLegendary = CoD.AARTierRewardShowcaseInternalLegendary.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	RewardLegendary:setAlpha(0)
	RewardLegendary:linkToElementModel(self, nil, false, function(model)
		RewardLegendary:setModel(model, f1_arg1)
	end)
	self:addElement(RewardLegendary)
	self.RewardLegendary = RewardLegendary
	local RewardEpic = CoD.AARTierRewardShowcaseInternalEpic.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	RewardEpic:setAlpha(0)
	RewardEpic:linkToElementModel(self, nil, false, function(model)
		RewardEpic:setModel(model, f1_arg1)
	end)
	self:addElement(RewardEpic)
	self.RewardEpic = RewardEpic
	local RewardUltra = CoD.AARTierRewardShowcaseInternalUltra.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	RewardUltra:setAlpha(0)
	RewardUltra:linkToElementModel(self, nil, false, function(model)
		RewardUltra:setModel(model, f1_arg1)
	end)
	self:addElement(RewardUltra)
	self.RewardUltra = RewardUltra
	local RewardContraband = CoD.AARTierRewardShowcaseInternalContraband.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	RewardContraband:setAlpha(0)
	RewardContraband:linkToElementModel(self, nil, false, function(model)
		RewardContraband:setModel(model, f1_arg1)
	end)
	self:addElement(RewardContraband)
	self.RewardContraband = RewardContraband
	local AARTierRewardFocusIndicator = CoD.AARTierRewardFocusIndicator.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0, 0, -8, -3)
	AARTierRewardFocusIndicator:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "AARTierReward", "allAnimationsFinished")
			end,
		},
	})
	local f1_local8 = AARTierRewardFocusIndicator
	local TrialWidget = AARTierRewardFocusIndicator.subscribeToModel
	local f1_local10 = DataSources.AARTierReward.getModel(f1_arg1)
	TrialWidget(f1_local8, f1_local10.allAnimationsFinished, function(f9_arg0)
		f1_arg0:updateElementState(AARTierRewardFocusIndicator, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "allAnimationsFinished",
		})
	end, false)
	AARTierRewardFocusIndicator:setAlpha(0)
	self:addElement(AARTierRewardFocusIndicator)
	self.AARTierRewardFocusIndicator = AARTierRewardFocusIndicator
	TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 9, 34, 0, 0, 8, 33)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
			end,
		},
	})
	TrialWidget:linkToElementModel(TrialWidget, "unlocked", true, function(model)
		f1_arg0:updateElementState(TrialWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	TrialWidget:linkToElementModel(self, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg1)
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "Contraband",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContrabandCrate")
			end,
		},
		{
			stateName = "Ultra",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[@"lootraritytype"][@"hash_63006FE890A202D9"])
			end,
		},
		{
			stateName = "Epic",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[@"lootraritytype"][@"loot_rarity_type_epic"])
			end,
		},
		{
			stateName = "Legendary",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[@"lootraritytype"][@"loot_rarity_type_legendary"])
			end,
		},
		{
			stateName = "Rare",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[@"lootraritytype"][@"loot_rarity_type_rare"])
			end,
		},
		{
			stateName = "Common",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[@"lootraritytype"][@"loot_rarity_type_common"])
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "isContrabandCrate", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isContrabandCrate",
		})
	end)
	self:linkToElementModel(self, "rarity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardShowcase.__resetProperties = function(f22_arg0)
	f22_arg0.RewardCommon:completeAnimation()
	f22_arg0.RewardUltra:completeAnimation()
	f22_arg0.RewardEpic:completeAnimation()
	f22_arg0.RewardLegendary:completeAnimation()
	f22_arg0.RewardRare:completeAnimation()
	f22_arg0.TrialWidget:completeAnimation()
	f22_arg0.RewardContraband:completeAnimation()
	f22_arg0.AARTierRewardFocusIndicator:completeAnimation()
	f22_arg0.RewardCommon:setAlpha(1)
	f22_arg0.RewardCommon:setScale(1, 1)
	f22_arg0.RewardUltra:setAlpha(0)
	f22_arg0.RewardUltra:setScale(1, 1)
	f22_arg0.RewardEpic:setAlpha(0)
	f22_arg0.RewardEpic:setScale(1, 1)
	f22_arg0.RewardLegendary:setAlpha(0)
	f22_arg0.RewardLegendary:setScale(1, 1)
	f22_arg0.RewardRare:setAlpha(0)
	f22_arg0.RewardRare:setScale(1, 1)
	f22_arg0.TrialWidget:setAlpha(1)
	f22_arg0.RewardContraband:setAlpha(0)
	f22_arg0.AARTierRewardFocusIndicator:setAlpha(0)
end
CoD.AARTierRewardShowcase.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(6)
			f23_arg0.RewardCommon:completeAnimation()
			f23_arg0.RewardCommon:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RewardCommon)
			f23_arg0.RewardRare:completeAnimation()
			f23_arg0.RewardRare:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RewardRare)
			f23_arg0.RewardLegendary:completeAnimation()
			f23_arg0.RewardLegendary:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RewardLegendary)
			f23_arg0.RewardEpic:completeAnimation()
			f23_arg0.RewardEpic:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RewardEpic)
			f23_arg0.RewardUltra:completeAnimation()
			f23_arg0.RewardUltra:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RewardUltra)
			f23_arg0.TrialWidget:completeAnimation()
			f23_arg0.TrialWidget:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.TrialWidget)
		end,
	},
	Contraband = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.RewardCommon:completeAnimation()
			f24_arg0.RewardCommon:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.RewardCommon)
			f24_arg0.RewardContraband:completeAnimation()
			f24_arg0.RewardContraband:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.RewardContraband)
		end,
		Focus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.RewardCommon:completeAnimation()
			f25_arg0.RewardCommon:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RewardCommon)
			f25_arg0.RewardContraband:completeAnimation()
			f25_arg0.RewardContraband:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.RewardContraband)
			f25_arg0.AARTierRewardFocusIndicator:completeAnimation()
			f25_arg0.AARTierRewardFocusIndicator:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.AARTierRewardFocusIndicator)
		end,
	},
	Ultra = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.RewardCommon:completeAnimation()
			f26_arg0.RewardCommon:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.RewardCommon)
			f26_arg0.RewardUltra:completeAnimation()
			f26_arg0.RewardUltra:setAlpha(1)
			f26_arg0.RewardUltra:setScale(1, 1)
			f26_arg0.clipFinished(f26_arg0.RewardUltra)
		end,
		Focus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.RewardCommon:completeAnimation()
			f27_arg0.RewardCommon:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RewardCommon)
			f27_arg0.RewardUltra:completeAnimation()
			f27_arg0.RewardUltra:setAlpha(1)
			f27_arg0.RewardUltra:setScale(1, 1)
			f27_arg0.clipFinished(f27_arg0.RewardUltra)
			f27_arg0.AARTierRewardFocusIndicator:completeAnimation()
			f27_arg0.AARTierRewardFocusIndicator:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.AARTierRewardFocusIndicator)
		end,
	},
	Epic = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.RewardCommon:completeAnimation()
			f28_arg0.RewardCommon:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.RewardCommon)
			f28_arg0.RewardEpic:completeAnimation()
			f28_arg0.RewardEpic:setAlpha(1)
			f28_arg0.RewardEpic:setScale(1, 1)
			f28_arg0.clipFinished(f28_arg0.RewardEpic)
		end,
		Focus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.RewardCommon:completeAnimation()
			f29_arg0.RewardCommon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.RewardCommon)
			f29_arg0.RewardEpic:completeAnimation()
			f29_arg0.RewardEpic:setAlpha(1)
			f29_arg0.RewardEpic:setScale(1, 1)
			f29_arg0.clipFinished(f29_arg0.RewardEpic)
			f29_arg0.AARTierRewardFocusIndicator:completeAnimation()
			f29_arg0.AARTierRewardFocusIndicator:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.AARTierRewardFocusIndicator)
		end,
	},
	Legendary = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.RewardCommon:completeAnimation()
			f30_arg0.RewardCommon:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.RewardCommon)
			f30_arg0.RewardLegendary:completeAnimation()
			f30_arg0.RewardLegendary:setAlpha(1)
			f30_arg0.RewardLegendary:setScale(1, 1)
			f30_arg0.clipFinished(f30_arg0.RewardLegendary)
		end,
		Focus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.RewardCommon:completeAnimation()
			f31_arg0.RewardCommon:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.RewardCommon)
			f31_arg0.RewardLegendary:completeAnimation()
			f31_arg0.RewardLegendary:setAlpha(1)
			f31_arg0.RewardLegendary:setScale(1, 1)
			f31_arg0.clipFinished(f31_arg0.RewardLegendary)
			f31_arg0.AARTierRewardFocusIndicator:completeAnimation()
			f31_arg0.AARTierRewardFocusIndicator:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.AARTierRewardFocusIndicator)
		end,
	},
	Rare = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.RewardCommon:completeAnimation()
			f32_arg0.RewardCommon:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.RewardCommon)
			f32_arg0.RewardRare:completeAnimation()
			f32_arg0.RewardRare:setAlpha(1)
			f32_arg0.RewardRare:setScale(1, 1)
			f32_arg0.clipFinished(f32_arg0.RewardRare)
		end,
		Focus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
			f33_arg0.RewardCommon:completeAnimation()
			f33_arg0.RewardCommon:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.RewardCommon)
			f33_arg0.RewardRare:completeAnimation()
			f33_arg0.RewardRare:setAlpha(1)
			f33_arg0.RewardRare:setScale(1, 1)
			f33_arg0.clipFinished(f33_arg0.RewardRare)
			f33_arg0.AARTierRewardFocusIndicator:completeAnimation()
			f33_arg0.AARTierRewardFocusIndicator:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.AARTierRewardFocusIndicator)
		end,
	},
	Common = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.RewardCommon:completeAnimation()
			f34_arg0.RewardCommon:setAlpha(1)
			f34_arg0.RewardCommon:setScale(1, 1)
			f34_arg0.clipFinished(f34_arg0.RewardCommon)
		end,
		Focus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.RewardCommon:completeAnimation()
			f35_arg0.RewardCommon:setAlpha(1)
			f35_arg0.RewardCommon:setScale(1, 1)
			f35_arg0.clipFinished(f35_arg0.RewardCommon)
			f35_arg0.AARTierRewardFocusIndicator:completeAnimation()
			f35_arg0.AARTierRewardFocusIndicator:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.AARTierRewardFocusIndicator)
		end,
	},
	Empty = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(6)
			f36_arg0.RewardCommon:completeAnimation()
			f36_arg0.RewardCommon:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.RewardCommon)
			f36_arg0.RewardRare:completeAnimation()
			f36_arg0.RewardRare:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.RewardRare)
			f36_arg0.RewardLegendary:completeAnimation()
			f36_arg0.RewardLegendary:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.RewardLegendary)
			f36_arg0.RewardEpic:completeAnimation()
			f36_arg0.RewardEpic:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.RewardEpic)
			f36_arg0.RewardUltra:completeAnimation()
			f36_arg0.RewardUltra:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.RewardUltra)
			f36_arg0.TrialWidget:completeAnimation()
			f36_arg0.TrialWidget:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.TrialWidget)
		end,
	},
}
CoD.AARTierRewardShowcase.__onClose = function(f37_arg0)
	f37_arg0.RewardCommon:close()
	f37_arg0.RewardRare:close()
	f37_arg0.RewardLegendary:close()
	f37_arg0.RewardEpic:close()
	f37_arg0.RewardUltra:close()
	f37_arg0.RewardContraband:close()
	f37_arg0.AARTierRewardFocusIndicator:close()
	f37_arg0.TrialWidget:close()
end
