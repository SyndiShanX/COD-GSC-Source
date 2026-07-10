require("x64:308a9caa8800c7d")
require("x64:d840bf6099875c0")
require("x64:b544efba293ba09")
require("x64:d70dffca5f57ab0")
require("x64:ab8c219daf49e8a")
CoD.AARTierRewardShowcaseInternalUltra = InheritFrom(LUI.UIElement)
CoD.AARTierRewardShowcaseInternalUltra.__defaultWidth = 310
CoD.AARTierRewardShowcaseInternalUltra.__defaultHeight = 632
CoD.AARTierRewardShowcaseInternalUltra.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardShowcaseInternalUltra)
	self.id = "AARTierRewardShowcaseInternalUltra"
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
	local BGWidgetUltra = CoD.AARTierRewardShowcaseInternalCoreUltra.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0.5, 0.5, -316, 316)
	BGWidgetUltra:linkToElementModel(self, nil, false, function(model)
		BGWidgetUltra:setModel(model, f1_arg1)
	end)
	self:addElement(BGWidgetUltra)
	self.BGWidgetUltra = BGWidgetUltra
	local CoreWidgetUniversal = CoD.AARTierRewardShowcaseInternalCore.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0.5, 0.5, -316, 316)
	CoreWidgetUniversal:linkToElementModel(self, nil, false, function(model)
		CoreWidgetUniversal:setModel(model, f1_arg1)
	end)
	CoreWidgetUniversal:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CoreWidgetUniversal.Contract:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f6_local0))
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
	local GlowAnim = CoD.AARTierRewardItemGlowAnimationUltra.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	GlowAnim:linkToElementModel(self, nil, false, function(model)
		GlowAnim:setModel(model, f1_arg1)
	end)
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
				local f12_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked") then
					f12_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x3006FE890A202D9])
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
		{
			stateName = "Dupe",
			condition = function(menu, element, event)
				local f13_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dupe")
				if f13_local0 then
					f13_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x3006FE890A202D9])
					if f13_local0 then
						f13_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "Reroll",
			condition = function(menu, element, event)
				local f14_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "reroll")
				if f14_local0 then
					f14_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x3006FE890A202D9])
					if f14_local0 then
						f14_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
					end
				end
				return f14_local0
			end,
		},
		{
			stateName = "Contraband",
			condition = function(menu, element, event)
				local f15_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
				if f15_local0 then
					f15_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x3006FE890A202D9])
					if f15_local0 then
						f15_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRABAND)
					end
				end
				return f15_local0
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
CoD.AARTierRewardShowcaseInternalUltra.__resetProperties = function(f22_arg0)
	f22_arg0.BGWidgetUltra:completeAnimation()
	f22_arg0.Rerolled:completeAnimation()
	f22_arg0.GlowAnim:completeAnimation()
	f22_arg0.CoreWidgetUniversal:completeAnimation()
	f22_arg0.Sound:completeAnimation()
	f22_arg0.AARTierRewardDupeIndicator:completeAnimation()
	f22_arg0.ContrabandFull:completeAnimation()
	f22_arg0.BGWidgetUltra:setAlpha(1)
	f22_arg0.BGWidgetUltra:setScale(1, 1)
	f22_arg0.Rerolled:setAlpha(0)
	f22_arg0.GlowAnim:setAlpha(1)
	f22_arg0.CoreWidgetUniversal:setAlpha(1)
	f22_arg0.CoreWidgetUniversal:setScale(1, 1)
	f22_arg0.Sound:setPlaySoundDirect(false)
	f22_arg0.AARTierRewardDupeIndicator:setAlpha(0)
	f22_arg0.ContrabandFull:setAlpha(0)
	f22_arg0.ContrabandFull:setScale(1, 1)
end
CoD.AARTierRewardShowcaseInternalUltra.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.Rerolled:completeAnimation()
			f24_arg0.Rerolled:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Rerolled)
			f24_arg0.BGWidgetUltra:completeAnimation()
			f24_arg0.BGWidgetUltra:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.BGWidgetUltra)
			f24_arg0.CoreWidgetUniversal:completeAnimation()
			f24_arg0.CoreWidgetUniversal:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.CoreWidgetUniversal)
			f24_arg0.GlowAnim:completeAnimation()
			f24_arg0.GlowAnim:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.GlowAnim)
		end,
	},
	Locked = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.Rerolled:completeAnimation()
			f25_arg0.Rerolled:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Rerolled)
			f25_arg0.BGWidgetUltra:completeAnimation()
			f25_arg0.BGWidgetUltra:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.BGWidgetUltra)
			f25_arg0.CoreWidgetUniversal:completeAnimation()
			f25_arg0.CoreWidgetUniversal:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CoreWidgetUniversal)
		end,
		DefaultState = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(6)
			f26_arg0.Rerolled:completeAnimation()
			f26_arg0.Rerolled:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Rerolled)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(100)
					f28_arg0:setAlpha(1)
					f28_arg0:setScale(1, 1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.BGWidgetUltra:beginAnimation(200)
				f26_arg0.BGWidgetUltra:setAlpha(0.67)
				f26_arg0.BGWidgetUltra:setScale(0.8, 0.8)
				f26_arg0.BGWidgetUltra:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.BGWidgetUltra:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.BGWidgetUltra:completeAnimation()
			f26_arg0.BGWidgetUltra:setAlpha(0)
			f26_arg0.BGWidgetUltra:setScale(4, 4)
			f26_local0(f26_arg0.BGWidgetUltra)
			local f26_local1 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(100)
					f30_arg0:setAlpha(1)
					f30_arg0:setScale(1, 1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.CoreWidgetUniversal:beginAnimation(200)
				f26_arg0.CoreWidgetUniversal:setAlpha(0.67)
				f26_arg0.CoreWidgetUniversal:setScale(0.8, 0.8)
				f26_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f26_arg0.CoreWidgetUniversal:completeAnimation()
			f26_arg0.CoreWidgetUniversal:setAlpha(0)
			f26_arg0.CoreWidgetUniversal:setScale(4, 4)
			f26_local1(f26_arg0.CoreWidgetUniversal)
			f26_arg0.Sound:completeAnimation()
			f26_arg0.Sound:setPlaySoundDirect(true)
			f26_arg0.Sound:playSound("uin_mtx_item_get_ultra", f26_arg1)
			f26_arg0.clipFinished(f26_arg0.Sound)
			f26_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f26_arg0.AARTierRewardDupeIndicator:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.AARTierRewardDupeIndicator)
			f26_arg0.GlowAnim:beginAnimation(300)
			f26_arg0.GlowAnim:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
			f26_arg0.GlowAnim:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playClip("Trigger")
				f26_arg0.clipFinished(element, event)
			end)
		end,
		Contraband = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(6)
			local f32_local0 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					local f34_local0 = function(f35_arg0)
						local f35_local0 = function(f36_arg0)
							f36_arg0:beginAnimation(9)
							f36_arg0:setAlpha(0)
							f36_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
						end
						f35_arg0:beginAnimation(490)
						f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
					end
					f34_arg0:beginAnimation(100)
					f34_arg0:setAlpha(1)
					f34_arg0:setScale(1, 1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
				end
				f32_arg0.ContrabandFull:beginAnimation(200)
				f32_arg0.ContrabandFull:setAlpha(0.67)
				f32_arg0.ContrabandFull:setScale(0.8, 0.8)
				f32_arg0.ContrabandFull:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ContrabandFull:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f32_arg0.ContrabandFull:completeAnimation()
			f32_arg0.ContrabandFull:setAlpha(0)
			f32_arg0.ContrabandFull:setScale(4, 4)
			f32_local0(f32_arg0.ContrabandFull)
			local f32_local1 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(9)
					f38_arg0:setAlpha(1)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.BGWidgetUltra:beginAnimation(790)
				f32_arg0.BGWidgetUltra:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BGWidgetUltra:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f32_arg0.BGWidgetUltra:completeAnimation()
			f32_arg0.BGWidgetUltra:setAlpha(0)
			f32_local1(f32_arg0.BGWidgetUltra)
			local f32_local2 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(9)
					f40_arg0:setAlpha(1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.CoreWidgetUniversal:beginAnimation(790)
				f32_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f32_arg0.CoreWidgetUniversal:completeAnimation()
			f32_arg0.CoreWidgetUniversal:setAlpha(0)
			f32_local2(f32_arg0.CoreWidgetUniversal)
			f32_arg0.Sound:completeAnimation()
			f32_arg0.Sound:setPlaySoundDirect(true)
			f32_arg0.Sound:playSound("uin_mtx_item_get_ultra", f32_arg1)
			f32_arg0.clipFinished(f32_arg0.Sound)
			f32_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f32_arg0.AARTierRewardDupeIndicator:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.AARTierRewardDupeIndicator)
			f32_arg0.GlowAnim:beginAnimation(700)
			f32_arg0.GlowAnim:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
			f32_arg0.GlowAnim:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playClip("Trigger")
				f32_arg0.clipFinished(element, event)
			end)
		end,
		Reroll = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(6)
			local f42_local0 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					local f44_local0 = function(f45_arg0)
						local f45_local0 = function(f46_arg0)
							local f46_local0 = function(f47_arg0)
								f47_arg0:beginAnimation(199)
								f47_arg0:setAlpha(0)
								f47_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
							end
							f46_arg0:beginAnimation(299)
							f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
						end
						f45_arg0:beginAnimation(200)
						f45_arg0:setAlpha(1)
						f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
					end
					f44_arg0:beginAnimation(200)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
				end
				f42_arg0.Rerolled:beginAnimation(140)
				f42_arg0.Rerolled:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.Rerolled:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f42_arg0.Rerolled:completeAnimation()
			f42_arg0.Rerolled:setAlpha(0)
			f42_local0(f42_arg0.Rerolled)
			local f42_local1 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					f49_arg0:beginAnimation(10)
					f49_arg0:setAlpha(1)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.BGWidgetUltra:beginAnimation(130)
				f42_arg0.BGWidgetUltra:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.BGWidgetUltra:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f42_arg0.BGWidgetUltra:completeAnimation()
			f42_arg0.BGWidgetUltra:setAlpha(0)
			f42_local1(f42_arg0.BGWidgetUltra)
			local f42_local2 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					f51_arg0:beginAnimation(10)
					f51_arg0:setAlpha(1)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.CoreWidgetUniversal:beginAnimation(130)
				f42_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f42_arg0.CoreWidgetUniversal:completeAnimation()
			f42_arg0.CoreWidgetUniversal:setAlpha(0)
			f42_local2(f42_arg0.CoreWidgetUniversal)
			f42_arg0.Sound:completeAnimation()
			f42_arg0.Sound:setPlaySoundDirect(true)
			f42_arg0.Sound:playSound("uin_mtx_item_reroll", f42_arg1)
			f42_arg0.clipFinished(f42_arg0.Sound)
			local f42_local3 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					local f53_local0 = function(f54_arg0)
						local f54_local0 = function(f55_arg0)
							local f55_local0 = function(f56_arg0)
								f56_arg0:playClip("ReRolling")
								f56_arg0:beginAnimation(300)
								f56_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
									element:playClip("ReRolled")
									f42_arg0.clipFinished(element, event)
								end)
							end
							f55_arg0:playClip("Dupe")
							f55_arg0:beginAnimation(499)
							f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
						end
						f54_arg0:beginAnimation(9)
						f54_arg0:setAlpha(1)
						f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
					end
					f53_arg0:beginAnimation(190)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
				end
				f42_arg0.AARTierRewardDupeIndicator:beginAnimation(140)
				f42_arg0.AARTierRewardDupeIndicator:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.AARTierRewardDupeIndicator:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f42_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f42_arg0.AARTierRewardDupeIndicator:setAlpha(0)
			f42_local3(f42_arg0.AARTierRewardDupeIndicator)
			f42_arg0.GlowAnim:completeAnimation()
			f42_arg0.GlowAnim:playClip("Trigger")
			f42_arg0.clipFinished(f42_arg0.GlowAnim)
		end,
		Dupe = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(5)
			f58_arg0.Rerolled:completeAnimation()
			f58_arg0.Rerolled:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.Rerolled)
			local f58_local0 = function(f59_arg0)
				local f59_local0 = function(f60_arg0)
					f60_arg0:beginAnimation(10)
					f60_arg0:setAlpha(1)
					f60_arg0:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
				end
				f58_arg0.BGWidgetUltra:beginAnimation(130)
				f58_arg0.BGWidgetUltra:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.BGWidgetUltra:registerEventHandler("transition_complete_keyframe", f59_local0)
			end
			f58_arg0.BGWidgetUltra:completeAnimation()
			f58_arg0.BGWidgetUltra:setAlpha(0)
			f58_local0(f58_arg0.BGWidgetUltra)
			local f58_local1 = function(f61_arg0)
				local f61_local0 = function(f62_arg0)
					f62_arg0:beginAnimation(10)
					f62_arg0:setAlpha(1)
					f62_arg0:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
				end
				f58_arg0.CoreWidgetUniversal:beginAnimation(130)
				f58_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f61_local0)
			end
			f58_arg0.CoreWidgetUniversal:completeAnimation()
			f58_arg0.CoreWidgetUniversal:setAlpha(0)
			f58_local1(f58_arg0.CoreWidgetUniversal)
			local f58_local2 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					f64_arg0:playClip("Dupe")
					f64_arg0:beginAnimation(10)
					f64_arg0:setAlpha(1)
					f64_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Dupe")
						f58_arg0.clipFinished(element, event)
					end)
				end
				f58_arg0.AARTierRewardDupeIndicator:playClip("Dupe")
				f58_arg0.AARTierRewardDupeIndicator:beginAnimation(130)
				f58_arg0.AARTierRewardDupeIndicator:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.AARTierRewardDupeIndicator:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f58_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f58_arg0.AARTierRewardDupeIndicator:setAlpha(0)
			f58_local2(f58_arg0.AARTierRewardDupeIndicator)
			f58_arg0.GlowAnim:completeAnimation()
			f58_arg0.GlowAnim:playClip("Trigger")
			f58_arg0.clipFinished(f58_arg0.GlowAnim)
		end,
	},
	Dupe = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(1)
			f66_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f66_arg0.AARTierRewardDupeIndicator:setAlpha(1)
			f66_arg0.AARTierRewardDupeIndicator:playClip("Dupe")
			f66_arg0.clipFinished(f66_arg0.AARTierRewardDupeIndicator)
		end,
	},
	Reroll = {
		DefaultClip = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(1)
			f67_arg0.AARTierRewardDupeIndicator:completeAnimation()
			f67_arg0.AARTierRewardDupeIndicator:setAlpha(1)
			f67_arg0.AARTierRewardDupeIndicator:playClip("ReRolled")
			f67_arg0.clipFinished(f67_arg0.AARTierRewardDupeIndicator)
		end,
	},
	Contraband = {
		DefaultClip = function(f68_arg0, f68_arg1)
			f68_arg0:__resetProperties()
			f68_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.AARTierRewardShowcaseInternalUltra.__onClose = function(f69_arg0)
	f69_arg0.ContrabandFull:close()
	f69_arg0.Rerolled:close()
	f69_arg0.BGWidgetUltra:close()
	f69_arg0.CoreWidgetUniversal:close()
	f69_arg0.AARTierRewardDupeIndicator:close()
	f69_arg0.GlowAnim:close()
end
