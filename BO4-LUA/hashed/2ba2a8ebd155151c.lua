require("x64:3a39d0a42a2ad4b")
CoD.AARTierRewardShowcaseInternalCore = InheritFrom(LUI.UIElement)
CoD.AARTierRewardShowcaseInternalCore.__defaultWidth = 310
CoD.AARTierRewardShowcaseInternalCore.__defaultHeight = 632
CoD.AARTierRewardShowcaseInternalCore.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardShowcaseInternalCore)
	self.id = "AARTierRewardShowcaseInternalCore"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AARTierRewardTypeImageContainer = CoD.AARTierRewardTypeImageContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0.5, 0.5, -316, 316)
	AARTierRewardTypeImageContainer:linkToElementModel(self, nil, false, function(model)
		AARTierRewardTypeImageContainer:setModel(model, f1_arg1)
	end)
	self:addElement(AARTierRewardTypeImageContainer)
	self.AARTierRewardTypeImageContainer = AARTierRewardTypeImageContainer
	local Description = LUI.UIText.new(0, 0, 9, 302, 1, 1, -168, -150)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:linkToElementModel(self, "desc", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Description:setText(f3_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local Name = LUI.UIText.new(0, 0, 9, 302, 1, 1, -194, -170)
	Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Name:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local RarityLabel = LUI.UIText.new(0, 0, 10, 114, 0, 0, 411, 428)
	RarityLabel:setTTF("ttmussels_demibold")
	RarityLabel:setLetterSpacing(4)
	RarityLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RarityLabel:setBackingType(1)
	RarityLabel:setBackingXPadding(15)
	RarityLabel:setBackingYPadding(2)
	RarityLabel:linkToElementModel(self, "rarity", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RarityLabel:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f5_local0))
		end
	end)
	RarityLabel:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RarityLabel:setText(LocalizeToUpperString(CoD.BlackMarketUtility.LootRarityToString(f6_local0)))
		end
	end)
	self:addElement(RarityLabel)
	self.RarityLabel = RarityLabel
	local Contract = LUI.UIText.new(0.5, 0.5, -45.5, 45.5, 0, 0, 5, 24)
	Contract:setAlpha(0.94)
	Contract:setTTF("ttmussels_regular")
	Contract:setLetterSpacing(4)
	Contract:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Contract:linkToElementModel(self, "rarity", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Contract:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f7_local0))
		end
	end)
	Contract:linkToElementModel(self, "category", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Contract:setText(LocalizeToUpperString(f8_local0))
		end
	end)
	self:addElement(Contract)
	self.Contract = Contract
	local MainExtraText = LUI.UIText.new(0, 0, 10, 302, 0, 0, 572.5, 592.5)
	MainExtraText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MainExtraText:setTTF("ttmussels_regular")
	MainExtraText:setLetterSpacing(2)
	MainExtraText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MainExtraText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MainExtraText:linkToElementModel(self, "mainExtraText", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			MainExtraText:setText(ToUpper(f9_local0))
		end
	end)
	self:addElement(MainExtraText)
	self.MainExtraText = MainExtraText
	local SubExtraText = LUI.UIText.new(0, 0, 10, 302, 0, 0, 594.5, 612.5)
	SubExtraText:setTTF("dinnext_regular")
	SubExtraText:setLetterSpacing(1)
	SubExtraText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SubExtraText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SubExtraText:linkToElementModel(self, "subExtraText", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			SubExtraText:setText(Engine[0xF9F1239CFD921FE](f10_local0))
		end
	end)
	self:addElement(SubExtraText)
	self.SubExtraText = SubExtraText
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				local f11_local0
				if not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name") then
					f11_local0 = AlwaysFalse()
				else
					f11_local0 = false
				end
				return f11_local0
			end,
		},
		{
			stateName = "Contraband",
			condition = function(menu, element, event)
				local f12_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
				if f12_local0 then
					f12_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRABAND)
					if f12_local0 then
						f12_local0 = AlwaysFalse()
					end
				end
				return f12_local0
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				local f13_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked") then
					f13_local0 = AlwaysFalse()
				else
					f13_local0 = false
				end
				return f13_local0
			end,
		},
		{
			stateName = "Dupe",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dupe") and AlwaysFalse()
			end,
		},
		{
			stateName = "Reroll",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "reroll") and AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "name", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	self:linkToElementModel(self, "unlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	self:linkToElementModel(self, "lootType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lootType",
		})
	end)
	self:linkToElementModel(self, "dupe", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dupe",
		})
	end)
	self:linkToElementModel(self, "reroll", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reroll",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardShowcaseInternalCore.__resetProperties = function(f21_arg0)
	f21_arg0.Name:completeAnimation()
	f21_arg0.Description:completeAnimation()
	f21_arg0.RarityLabel:completeAnimation()
	f21_arg0.Contract:completeAnimation()
	f21_arg0.AARTierRewardTypeImageContainer:completeAnimation()
	f21_arg0.Name:setAlpha(1)
	f21_arg0.Description:setAlpha(1)
	f21_arg0.RarityLabel:setAlpha(1)
	f21_arg0.Contract:setAlpha(0.94)
	f21_arg0.AARTierRewardTypeImageContainer:setAlpha(1)
end
CoD.AARTierRewardShowcaseInternalCore.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			f23_arg0.AARTierRewardTypeImageContainer:beginAnimation(400)
			f23_arg0.AARTierRewardTypeImageContainer:setAlpha(0)
			f23_arg0.AARTierRewardTypeImageContainer:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
			f23_arg0.AARTierRewardTypeImageContainer:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			f23_arg0.Description:completeAnimation()
			f23_arg0.Description:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Description)
			f23_arg0.Name:completeAnimation()
			f23_arg0.Name:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Name)
			f23_arg0.RarityLabel:completeAnimation()
			f23_arg0.RarityLabel:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RarityLabel)
			f23_arg0.Contract:completeAnimation()
			f23_arg0.Contract:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Contract)
		end,
	},
	Contraband = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	Locked = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(5)
			f25_arg0.AARTierRewardTypeImageContainer:completeAnimation()
			f25_arg0.AARTierRewardTypeImageContainer:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.AARTierRewardTypeImageContainer)
			f25_arg0.Description:completeAnimation()
			f25_arg0.Description:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Description)
			f25_arg0.Name:completeAnimation()
			f25_arg0.Name:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Name)
			f25_arg0.RarityLabel:completeAnimation()
			f25_arg0.RarityLabel:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RarityLabel)
			f25_arg0.Contract:completeAnimation()
			f25_arg0.Contract:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Contract)
		end,
		DefaultState = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(5)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(10)
					f28_arg0:setAlpha(1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.AARTierRewardTypeImageContainer:beginAnimation(130)
				f26_arg0.AARTierRewardTypeImageContainer:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.AARTierRewardTypeImageContainer:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.AARTierRewardTypeImageContainer:completeAnimation()
			f26_arg0.AARTierRewardTypeImageContainer:setAlpha(0)
			f26_local0(f26_arg0.AARTierRewardTypeImageContainer)
			local f26_local1 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(10)
					f30_arg0:setAlpha(1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.Description:beginAnimation(130)
				f26_arg0.Description:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Description:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f26_arg0.Description:completeAnimation()
			f26_arg0.Description:setAlpha(0)
			f26_local1(f26_arg0.Description)
			local f26_local2 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(10)
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.Name:beginAnimation(130)
				f26_arg0.Name:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Name:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f26_arg0.Name:completeAnimation()
			f26_arg0.Name:setAlpha(0)
			f26_local2(f26_arg0.Name)
			local f26_local3 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(10)
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.RarityLabel:beginAnimation(130)
				f26_arg0.RarityLabel:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.RarityLabel:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f26_arg0.RarityLabel:completeAnimation()
			f26_arg0.RarityLabel:setAlpha(0)
			f26_local3(f26_arg0.RarityLabel)
			local f26_local4 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(10)
					f36_arg0:setAlpha(0.94)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.Contract:beginAnimation(130)
				f26_arg0.Contract:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Contract:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f26_arg0.Contract:completeAnimation()
			f26_arg0.Contract:setAlpha(0)
			f26_local4(f26_arg0.Contract)
		end,
		Contraband = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			local f37_local0 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(200)
					f39_arg0:setAlpha(1)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
				end
				f37_arg0.AARTierRewardTypeImageContainer:beginAnimation(200)
				f37_arg0.AARTierRewardTypeImageContainer:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.AARTierRewardTypeImageContainer:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f37_arg0.AARTierRewardTypeImageContainer:completeAnimation()
			f37_arg0.AARTierRewardTypeImageContainer:setAlpha(0)
			f37_local0(f37_arg0.AARTierRewardTypeImageContainer)
			local f37_local1 = function(f40_arg0)
				f37_arg0.Description:beginAnimation(200)
				f37_arg0.Description:setAlpha(1)
				f37_arg0.Description:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Description:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.Description:completeAnimation()
			f37_arg0.Description:setAlpha(0)
			f37_local1(f37_arg0.Description)
			local f37_local2 = function(f41_arg0)
				f37_arg0.Name:beginAnimation(200)
				f37_arg0.Name:setAlpha(1)
				f37_arg0.Name:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Name:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.Name:completeAnimation()
			f37_arg0.Name:setAlpha(0)
			f37_local2(f37_arg0.Name)
		end,
	},
	Dupe = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(0)
		end,
	},
	Reroll = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.AARTierRewardShowcaseInternalCore.__onClose = function(f44_arg0)
	f44_arg0.AARTierRewardTypeImageContainer:close()
	f44_arg0.Description:close()
	f44_arg0.Name:close()
	f44_arg0.RarityLabel:close()
	f44_arg0.Contract:close()
	f44_arg0.MainExtraText:close()
	f44_arg0.SubExtraText:close()
end
