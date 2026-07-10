require("x64:308a9caa8800c7d")
require("x64:d840bf6099875c0")
require("x64:9537433151ed484")
require("x64:d70dffca5f57ab0")
require("x64:9084ab6ba1b7a1d")
CoD.AARTierRewardShowcaseInternalEpic = InheritFrom(LUI.UIElement)
CoD.AARTierRewardShowcaseInternalEpic.__defaultWidth = 310
CoD.AARTierRewardShowcaseInternalEpic.__defaultHeight = 632
CoD.AARTierRewardShowcaseInternalEpic.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardShowcaseInternalEpic)
	self.id = "AARTierRewardShowcaseInternalEpic"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ContrabandFull = CoD.AARTierRewardContraband.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 0, 0, 0, 632)
	ContrabandFull:setAlpha(0)
	self:addElement(ContrabandFull)
	self.ContrabandFull = ContrabandFull
	local Rerolled = CoD.AARTierRewardShowcaseInternalCore.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0.5, 0.5, -316, 316)
	Rerolled:setAlpha(0)
	Rerolled:subscribeToGlobalModel(f1_arg1, "AARTierReward", "rerolledItem", function(model)
		Rerolled:setModel(model, f1_arg1)
	end)
	Rerolled:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Rerolled.Contract:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f3_local0))
		end
	end)
	self:addElement(Rerolled)
	self.Rerolled = Rerolled
	local BGWidgetEpic = CoD.AARTierRewardShowcaseInternalCoreEpic.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0.5, 0.5, -316, 316)
	BGWidgetEpic:linkToElementModel(self, nil, false, function(model)
		BGWidgetEpic:setModel(model, f1_arg1)
	end)
	self:addElement(BGWidgetEpic)
	self.BGWidgetEpic = BGWidgetEpic
	local CoreWidgetUniversal = CoD.AARTierRewardShowcaseInternalCore.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0.5, 0.5, -316, 316)
	CoreWidgetUniversal:linkToElementModel(self, nil, false, function(model)
		CoreWidgetUniversal:setModel(model, f1_arg1)
	end)
	CoreWidgetUniversal:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CoreWidgetUniversal.Contract:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f6_local0))
		end
	end)
	self:addElement(CoreWidgetUniversal)
	self.CoreWidgetUniversal = CoreWidgetUniversal
	local Sound = LUI.UIElement.new(0, 0, -70, -38, 0, 0, 598, 630)
	self:addElement(Sound)
	self.Sound = Sound
	local AARTierRewardDupeIndicator = CoD.AARTierRewardDupeIndicator.new(f1_arg0, f1_arg1, 0, 0, 5, 305, 0, 0, 372, 402)
	AARTierRewardDupeIndicator:mergeStateConditions({
		{
			stateName = "ReRolled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "reroll")
			end,
		},
	})
	AARTierRewardDupeIndicator:linkToElementModel(AARTierRewardDupeIndicator, "reroll", true, function(model)
		f1_arg0:updateElementState(AARTierRewardDupeIndicator, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reroll",
		})
	end)
	AARTierRewardDupeIndicator:setAlpha(0)
	AARTierRewardDupeIndicator:linkToElementModel(self, nil, false, function(model)
		AARTierRewardDupeIndicator:setModel(model, f1_arg1)
	end)
	self:addElement(AARTierRewardDupeIndicator)
	self.AARTierRewardDupeIndicator = AARTierRewardDupeIndicator
	local GlowAnim = CoD.AARTierRewardItemGlowAnimationEpic.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	GlowAnim:setRGB(ColorSet.BlackMarketEpicBright.r, ColorSet.BlackMarketEpicBright.g, ColorSet.BlackMarketEpicBright.b)
	self:addElement(GlowAnim)
	self.GlowAnim = GlowAnim
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				local f11_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked") then
					f11_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0xC3B1CFA5096734])
				else
					f11_local0 = false
				end
				return f11_local0
			end,
		},
		{
			stateName = "Dupe",
			condition = function(menu, element, event)
				local f12_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dupe")
				if f12_local0 then
					f12_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0xC3B1CFA5096734])
					if f12_local0 then
						f12_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
					end
				end
				return f12_local0
			end,
		},
		{
			stateName = "Reroll",
			condition = function(menu, element, event)
				local f13_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "reroll")
				if f13_local0 then
					f13_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0xC3B1CFA5096734])
					if f13_local0 then
						f13_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "Contraband",
			condition = function(menu, element, event)
				local f14_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
				if f14_local0 then
					f14_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0xC3B1CFA5096734])
					if f14_local0 then
						f14_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRABAND)
					end
				end
				return f14_local0
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
	self:linkToElementModel(self, "rarity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
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
	self:linkToElementModel(self, "lootType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lootType",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardShowcaseInternalEpic.__resetProperties = function(f21_arg0)
	f21_arg0.BGWidgetEpic:completeAnimation()
	f21_arg0.Rerolled:completeAnimation()
	f21_arg0.GlowAnim:completeAnimation()
	f21_arg0.CoreWidgetUniversal:completeAnimation()
	f21_arg0.Sound:completeAnimation()
	f21_arg0.AARTierRewardDupeIndicator:completeAnimation()
	f21_arg0.ContrabandFull:completeAnimation()
	f21_arg0.BGWidgetEpic:setAlpha(1)
	f21_arg0.BGWidgetEpic:setScale(1, 1)
	f21_arg0.Rerolled:setAlpha(0)
	f21_arg0.GlowAnim:setAlpha(1)
	f21_arg0.CoreWidgetUniversal:setAlpha(1)
	f21_arg0.CoreWidgetUniversal:setScale(1, 1)
	f21_arg0.Sound:setPlaySoundDirect(false)
	f21_arg0.AARTierRewardDupeIndicator:setAlpha(0)
	f21_arg0.ContrabandFull:setAlpha(0)
	f21_arg0.ContrabandFull:setScale(1, 1)
end
CoD.AARTierRewardShowcaseInternalEpic.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.Rerolled:completeAnimation()
			f23_arg0.Rerolled:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Rerolled)
			f23_arg0.BGWidgetEpic:completeAnimation()
			f23_arg0.BGWidgetEpic:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.BGWidgetEpic)
			f23_arg0.CoreWidgetUniversal:completeAnimation()
			f23_arg0.CoreWidgetUniversal:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CoreWidgetUniversal)
			f23_arg0.GlowAnim:completeAnimation()
			f23_arg0.GlowAnim:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.GlowAnim)
		end,
	},
	Locked = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.Rerolled:completeAnimation()
			f24_arg0.Rerolled:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Rerolled)
			f24_arg0.BGWidgetEpic:completeAnimation()
			f24_arg0.BGWidgetEpic:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.BGWidgetEpic)
			f24_arg0.CoreWidgetUniversal:completeAnimation()
			f24_arg0.CoreWidgetUniversal:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.CoreWidgetUniversal)
		end,
		DefaultState = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(6)
			f25_arg0.Rerolled:completeAnimation()
			f25_arg0.Rerolled:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Rerolled)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(100)
					f27_arg0:setAlpha(1)
					f27_arg0:setScale(1, 1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.BGWidgetEpic:beginAnimation(200)
				f25_arg0.BGWidgetEpic:setAlpha(0.67)
				f25_arg0.BGWidgetEpic:setScale(0.8, 0.8)
				f25_arg0.BGWidgetEpic:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.BGWidgetEpic:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.BGWidgetEpic:completeAnimation()
			f25_arg0.BGWidgetEpic:setAlpha(0)
			f25_arg0.BGWidgetEpic:setScale(4, 4)
			f25_local0(f25_arg0.BGWidgetEpic)
			local f25_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(100)
					f29_arg0:setAlpha(1)
					f29_arg0:setScale(1, 1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.CoreWidgetUniversal:beginAnimation(200)
				f25_arg0.CoreWidgetUniversal:setAlpha(0.67)
				f25_arg0.CoreWidgetUniversal:setScale(0.8, 0.8)
				f25_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f25_arg0.CoreWidgetUniversal:completeAnimation()
			f25_arg0.CoreWidgetUniversal:setAlpha(0)
			f25_arg0.CoreWidgetUniversal:setScale(4, 4)
			f25_local1(f25_arg0.CoreWidgetUniversal)
			f25_arg0.Sound:completeAnimation()
			f25_arg0.Sound:setPlaySoundDirect(true)
			f25_arg0.Sound:playSound("uin_mtx_item_get_epic", f25_arg1)
			f25_arg0.clipFinished(f25_arg0.Sound)
			f25_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f25_arg0.AARTierRewardDupeIndicator:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.AARTierRewardDupeIndicator)
			f25_arg0.GlowAnim:beginAnimation(300)
			f25_arg0.GlowAnim:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
			f25_arg0.GlowAnim:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playClip("Trigger")
				f25_arg0.clipFinished(element, event)
			end)
		end,
		Contraband = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(6)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							f35_arg0:beginAnimation(9)
							f35_arg0:setAlpha(0)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
						end
						f34_arg0:beginAnimation(490)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(100)
					f33_arg0:setAlpha(1)
					f33_arg0:setScale(1, 1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f31_arg0.ContrabandFull:beginAnimation(200)
				f31_arg0.ContrabandFull:setAlpha(0.67)
				f31_arg0.ContrabandFull:setScale(0.8, 0.8)
				f31_arg0.ContrabandFull:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ContrabandFull:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.ContrabandFull:completeAnimation()
			f31_arg0.ContrabandFull:setAlpha(0)
			f31_arg0.ContrabandFull:setScale(4, 4)
			f31_local0(f31_arg0.ContrabandFull)
			local f31_local1 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(9)
					f37_arg0:setAlpha(1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.BGWidgetEpic:beginAnimation(790)
				f31_arg0.BGWidgetEpic:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BGWidgetEpic:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f31_arg0.BGWidgetEpic:completeAnimation()
			f31_arg0.BGWidgetEpic:setAlpha(0)
			f31_local1(f31_arg0.BGWidgetEpic)
			local f31_local2 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(9)
					f39_arg0:setAlpha(1)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.CoreWidgetUniversal:beginAnimation(790)
				f31_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f31_arg0.CoreWidgetUniversal:completeAnimation()
			f31_arg0.CoreWidgetUniversal:setAlpha(0)
			f31_local2(f31_arg0.CoreWidgetUniversal)
			f31_arg0.Sound:completeAnimation()
			f31_arg0.Sound:setPlaySoundDirect(true)
			f31_arg0.Sound:playSound("uin_mtx_item_get_epic", f31_arg1)
			f31_arg0.clipFinished(f31_arg0.Sound)
			f31_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f31_arg0.AARTierRewardDupeIndicator:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.AARTierRewardDupeIndicator)
			f31_arg0.GlowAnim:beginAnimation(700)
			f31_arg0.GlowAnim:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.GlowAnim:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playClip("Trigger")
				f31_arg0.clipFinished(element, event)
			end)
		end,
		Reroll = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(6)
			local f41_local0 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						local f44_local0 = function(f45_arg0)
							local f45_local0 = function(f46_arg0)
								f46_arg0:beginAnimation(199)
								f46_arg0:setAlpha(0)
								f46_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
							end
							f45_arg0:beginAnimation(299)
							f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
						end
						f44_arg0:beginAnimation(200)
						f44_arg0:setAlpha(1)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
					end
					f43_arg0:beginAnimation(200)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f41_arg0.Rerolled:beginAnimation(140)
				f41_arg0.Rerolled:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.Rerolled:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f41_arg0.Rerolled:completeAnimation()
			f41_arg0.Rerolled:setAlpha(0)
			f41_local0(f41_arg0.Rerolled)
			local f41_local1 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(10)
					f48_arg0:setAlpha(1)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
				end
				f41_arg0.BGWidgetEpic:beginAnimation(130)
				f41_arg0.BGWidgetEpic:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.BGWidgetEpic:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f41_arg0.BGWidgetEpic:completeAnimation()
			f41_arg0.BGWidgetEpic:setAlpha(0)
			f41_local1(f41_arg0.BGWidgetEpic)
			local f41_local2 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(10)
					f50_arg0:setAlpha(1)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
				end
				f41_arg0.CoreWidgetUniversal:beginAnimation(130)
				f41_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f41_arg0.CoreWidgetUniversal:completeAnimation()
			f41_arg0.CoreWidgetUniversal:setAlpha(0)
			f41_local2(f41_arg0.CoreWidgetUniversal)
			f41_arg0.Sound:completeAnimation()
			f41_arg0.Sound:setPlaySoundDirect(true)
			f41_arg0.Sound:playSound("uin_mtx_item_reroll", f41_arg1)
			f41_arg0.clipFinished(f41_arg0.Sound)
			local f41_local3 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					local f52_local0 = function(f53_arg0)
						local f53_local0 = function(f54_arg0)
							local f54_local0 = function(f55_arg0)
								f55_arg0:playClip("ReRolling")
								f55_arg0:beginAnimation(300)
								f55_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
									element:playClip("ReRolled")
									f41_arg0.clipFinished(element, event)
								end)
							end
							f54_arg0:playClip("Dupe")
							f54_arg0:beginAnimation(499)
							f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
						end
						f53_arg0:beginAnimation(9)
						f53_arg0:setAlpha(1)
						f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
					end
					f52_arg0:beginAnimation(190)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
				end
				f41_arg0.AARTierRewardDupeIndicator:beginAnimation(140)
				f41_arg0.AARTierRewardDupeIndicator:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.AARTierRewardDupeIndicator:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f41_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f41_arg0.AARTierRewardDupeIndicator:setAlpha(0)
			f41_local3(f41_arg0.AARTierRewardDupeIndicator)
			f41_arg0.GlowAnim:completeAnimation()
			f41_arg0.GlowAnim:playClip("Trigger")
			f41_arg0.clipFinished(f41_arg0.GlowAnim)
		end,
		Dupe = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(5)
			f57_arg0.Rerolled:completeAnimation()
			f57_arg0.Rerolled:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.Rerolled)
			local f57_local0 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					f59_arg0:beginAnimation(10)
					f59_arg0:setAlpha(1)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
				end
				f57_arg0.BGWidgetEpic:beginAnimation(130)
				f57_arg0.BGWidgetEpic:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.BGWidgetEpic:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f57_arg0.BGWidgetEpic:completeAnimation()
			f57_arg0.BGWidgetEpic:setAlpha(0)
			f57_local0(f57_arg0.BGWidgetEpic)
			local f57_local1 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					f61_arg0:beginAnimation(10)
					f61_arg0:setAlpha(1)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
				end
				f57_arg0.CoreWidgetUniversal:beginAnimation(130)
				f57_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f57_arg0.CoreWidgetUniversal:completeAnimation()
			f57_arg0.CoreWidgetUniversal:setAlpha(0)
			f57_local1(f57_arg0.CoreWidgetUniversal)
			local f57_local2 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					f63_arg0:playClip("Dupe")
					f63_arg0:beginAnimation(10)
					f63_arg0:setAlpha(1)
					f63_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Dupe")
						f57_arg0.clipFinished(element, event)
					end)
				end
				f57_arg0.AARTierRewardDupeIndicator:playClip("Dupe")
				f57_arg0.AARTierRewardDupeIndicator:beginAnimation(130)
				f57_arg0.AARTierRewardDupeIndicator:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.AARTierRewardDupeIndicator:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f57_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f57_arg0.AARTierRewardDupeIndicator:setAlpha(0)
			f57_local2(f57_arg0.AARTierRewardDupeIndicator)
			f57_arg0.GlowAnim:completeAnimation()
			f57_arg0.GlowAnim:playClip("Trigger")
			f57_arg0.clipFinished(f57_arg0.GlowAnim)
		end,
	},
	Dupe = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(1)
			f65_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f65_arg0.AARTierRewardDupeIndicator:setAlpha(1)
			f65_arg0.AARTierRewardDupeIndicator:playClip("Dupe")
			f65_arg0.clipFinished(f65_arg0.AARTierRewardDupeIndicator)
		end,
	},
	Reroll = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(1)
			f66_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f66_arg0.AARTierRewardDupeIndicator:setAlpha(1)
			f66_arg0.AARTierRewardDupeIndicator:playClip("ReRolled")
			f66_arg0.clipFinished(f66_arg0.AARTierRewardDupeIndicator)
		end,
	},
	Contraband = {
		DefaultClip = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.AARTierRewardShowcaseInternalEpic.__onClose = function(f68_arg0)
	f68_arg0.ContrabandFull:close()
	f68_arg0.Rerolled:close()
	f68_arg0.BGWidgetEpic:close()
	f68_arg0.CoreWidgetUniversal:close()
	f68_arg0.AARTierRewardDupeIndicator:close()
	f68_arg0.GlowAnim:close()
end
