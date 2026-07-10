require("x64:777a2e5e764dbc9")
require("x64:d70dffca5f57ab0")
require("x64:2bcbbd6658178b6")
CoD.AARTierRewardShowcaseInternalContraband = InheritFrom(LUI.UIElement)
CoD.AARTierRewardShowcaseInternalContraband.__defaultWidth = 310
CoD.AARTierRewardShowcaseInternalContraband.__defaultHeight = 632
CoD.AARTierRewardShowcaseInternalContraband.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardShowcaseInternalContraband)
	self.id = "AARTierRewardShowcaseInternalContraband"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGWidgetCommon = CoD.AARTierRewardShowcaseInternalCoreContraband.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0.5, 0.5, -316, 316)
	BGWidgetCommon:linkToElementModel(self, nil, false, function(model)
		BGWidgetCommon:setModel(model, f1_arg1)
	end)
	self:addElement(BGWidgetCommon)
	self.BGWidgetCommon = BGWidgetCommon
	local CoreWidgetUniversal = CoD.AARTierRewardShowcaseInternalCore.new(f1_arg0, f1_arg1, 0.5, 0.5, -155, 155, 0.5, 0.5, -316, 316)
	CoreWidgetUniversal:linkToElementModel(self, nil, false, function(model)
		CoreWidgetUniversal:setModel(model, f1_arg1)
	end)
	CoreWidgetUniversal:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CoreWidgetUniversal.Contract:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f4_local0))
		end
	end)
	self:addElement(CoreWidgetUniversal)
	self.CoreWidgetUniversal = CoreWidgetUniversal
	local Sound = LUI.UIElement.new(0, 0, -70, -38, 0, 0, 598, 630)
	self:addElement(Sound)
	self.Sound = Sound
	local GlowAnim = CoD.AARTierRewardItemGlowAnimation.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	GlowAnim:setRGB(ColorSet.BlackMarketCommonBright.r, ColorSet.BlackMarketCommonBright.g, ColorSet.BlackMarketCommonBright.b)
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
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardShowcaseInternalContraband.__resetProperties = function(f9_arg0)
	f9_arg0.BGWidgetCommon:completeAnimation()
	f9_arg0.GlowAnim:completeAnimation()
	f9_arg0.CoreWidgetUniversal:completeAnimation()
	f9_arg0.Sound:completeAnimation()
	f9_arg0.BGWidgetCommon:setAlpha(1)
	f9_arg0.BGWidgetCommon:setScale(1, 1)
	f9_arg0.GlowAnim:setAlpha(1)
	f9_arg0.CoreWidgetUniversal:setAlpha(1)
	f9_arg0.CoreWidgetUniversal:setScale(1, 1)
	f9_arg0.Sound:setPlaySoundDirect(false)
end
CoD.AARTierRewardShowcaseInternalContraband.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.BGWidgetCommon:completeAnimation()
			f11_arg0.BGWidgetCommon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BGWidgetCommon)
			f11_arg0.CoreWidgetUniversal:completeAnimation()
			f11_arg0.CoreWidgetUniversal:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CoreWidgetUniversal)
			f11_arg0.GlowAnim:completeAnimation()
			f11_arg0.GlowAnim:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.GlowAnim)
		end,
	},
	Locked = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.BGWidgetCommon:completeAnimation()
			f12_arg0.BGWidgetCommon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BGWidgetCommon)
			f12_arg0.CoreWidgetUniversal:completeAnimation()
			f12_arg0.CoreWidgetUniversal:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CoreWidgetUniversal)
		end,
		DefaultState = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(100)
					f15_arg0:setAlpha(1)
					f15_arg0:setScale(1, 1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.BGWidgetCommon:beginAnimation(200)
				f13_arg0.BGWidgetCommon:setAlpha(0.67)
				f13_arg0.BGWidgetCommon:setScale(0.8, 0.8)
				f13_arg0.BGWidgetCommon:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.BGWidgetCommon:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.BGWidgetCommon:completeAnimation()
			f13_arg0.BGWidgetCommon:setAlpha(0)
			f13_arg0.BGWidgetCommon:setScale(4, 4)
			f13_local0(f13_arg0.BGWidgetCommon)
			local f13_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(100)
					f17_arg0:setAlpha(1)
					f17_arg0:setScale(1, 1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.CoreWidgetUniversal:beginAnimation(200)
				f13_arg0.CoreWidgetUniversal:setAlpha(0.67)
				f13_arg0.CoreWidgetUniversal:setScale(0.8, 0.8)
				f13_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f13_arg0.CoreWidgetUniversal:completeAnimation()
			f13_arg0.CoreWidgetUniversal:setAlpha(0)
			f13_arg0.CoreWidgetUniversal:setScale(4, 4)
			f13_local1(f13_arg0.CoreWidgetUniversal)
			f13_arg0.Sound:completeAnimation()
			f13_arg0.Sound:setPlaySoundDirect(true)
			f13_arg0.Sound:playSound("uin_mtx_item_get_common", f13_arg1)
			f13_arg0.clipFinished(f13_arg0.Sound)
			f13_arg0.GlowAnim:beginAnimation(300)
			f13_arg0.GlowAnim:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
			f13_arg0.GlowAnim:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playClip("Trigger")
				f13_arg0.clipFinished(element, event)
			end)
		end,
		Contraband = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(9)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.BGWidgetCommon:beginAnimation(790)
				f19_arg0.BGWidgetCommon:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.BGWidgetCommon:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.BGWidgetCommon:completeAnimation()
			f19_arg0.BGWidgetCommon:setAlpha(0)
			f19_local0(f19_arg0.BGWidgetCommon)
			local f19_local1 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(9)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.CoreWidgetUniversal:beginAnimation(790)
				f19_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f19_arg0.CoreWidgetUniversal:completeAnimation()
			f19_arg0.CoreWidgetUniversal:setAlpha(0)
			f19_local1(f19_arg0.CoreWidgetUniversal)
			f19_arg0.Sound:completeAnimation()
			f19_arg0.Sound:setPlaySoundDirect(true)
			f19_arg0.Sound:playSound("uin_mtx_item_get_common", f19_arg1)
			f19_arg0.clipFinished(f19_arg0.Sound)
			f19_arg0.GlowAnim:beginAnimation(700)
			f19_arg0.GlowAnim:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
			f19_arg0.GlowAnim:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playClip("Trigger")
				f19_arg0.clipFinished(element, event)
			end)
		end,
		Reroll = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(10)
					f27_arg0:setAlpha(1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.BGWidgetCommon:beginAnimation(130)
				f25_arg0.BGWidgetCommon:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.BGWidgetCommon:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.BGWidgetCommon:completeAnimation()
			f25_arg0.BGWidgetCommon:setAlpha(0)
			f25_local0(f25_arg0.BGWidgetCommon)
			local f25_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(10)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.CoreWidgetUniversal:beginAnimation(130)
				f25_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f25_arg0.CoreWidgetUniversal:completeAnimation()
			f25_arg0.CoreWidgetUniversal:setAlpha(0)
			f25_local1(f25_arg0.CoreWidgetUniversal)
			f25_arg0.Sound:completeAnimation()
			f25_arg0.Sound:setPlaySoundDirect(true)
			f25_arg0.Sound:playSound("uin_mtx_item_reroll", f25_arg1)
			f25_arg0.clipFinished(f25_arg0.Sound)
			f25_arg0.GlowAnim:completeAnimation()
			f25_arg0.GlowAnim:playClip("Trigger")
			f25_arg0.clipFinished(f25_arg0.GlowAnim)
		end,
		Dupe = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(10)
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.BGWidgetCommon:beginAnimation(130)
				f30_arg0.BGWidgetCommon:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.BGWidgetCommon:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.BGWidgetCommon:completeAnimation()
			f30_arg0.BGWidgetCommon:setAlpha(0)
			f30_local0(f30_arg0.BGWidgetCommon)
			local f30_local1 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(10)
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.CoreWidgetUniversal:beginAnimation(130)
				f30_arg0.CoreWidgetUniversal:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.CoreWidgetUniversal:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f30_arg0.CoreWidgetUniversal:completeAnimation()
			f30_arg0.CoreWidgetUniversal:setAlpha(0)
			f30_local1(f30_arg0.CoreWidgetUniversal)
			f30_arg0.GlowAnim:completeAnimation()
			f30_arg0.GlowAnim:playClip("Trigger")
			f30_arg0.clipFinished(f30_arg0.GlowAnim)
		end,
	},
}
CoD.AARTierRewardShowcaseInternalContraband.__onClose = function(f35_arg0)
	f35_arg0.BGWidgetCommon:close()
	f35_arg0.CoreWidgetUniversal:close()
	f35_arg0.GlowAnim:close()
end
