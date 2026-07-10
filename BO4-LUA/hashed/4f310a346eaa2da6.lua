CoD.VHUDHawkWeakSignalWarningText = InheritFrom(LUI.UIElement)
CoD.VHUDHawkWeakSignalWarningText.__defaultWidth = 180
CoD.VHUDHawkWeakSignalWarningText.__defaultHeight = 45
CoD.VHUDHawkWeakSignalWarningText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VHUDHawkWeakSignalWarningText)
	self.id = "VHUDHawkWeakSignalWarningText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WEAK = LUI.UIText.new(-0.08, 1.08, 0, 0, 0, 0, 10, 34)
	WEAK:setRGB(1, 0, 0)
	WEAK:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F33AED3A709B334"))
	WEAK:setTTF("default")
	WEAK:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	WEAK:setShaderVector(0, 0, 1, 0, 0)
	WEAK:setShaderVector(1, 0, 0, 0, 0)
	WEAK:setShaderVector(2, 0, 0, 0, 0)
	WEAK:setShaderVector(3, 0, 0, 0, 0)
	WEAK:setShaderVector(4, 0, 0, 0, 0)
	WEAK:setLetterSpacing(6)
	WEAK:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WEAK:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WEAK)
	self.WEAK = WEAK
	local WEAK0 = LUI.UIText.new(-0.08, 1.08, 0, 0, 0, 0, 10, 34)
	WEAK0:setRGB(1, 0, 0)
	WEAK0:setAlpha(0)
	WEAK0:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F33AED3A709B334"))
	WEAK0:setTTF("default")
	WEAK0:setLetterSpacing(6)
	WEAK0:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WEAK0:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WEAK0)
	self.WEAK0 = WEAK0
	local WEAK00 = LUI.UIText.new(-0.08, 1.08, 0, 0, 0, 0, 10, 34)
	WEAK00:setRGB(1, 0, 0)
	WEAK00:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F33AED3A709B334"))
	WEAK00:setTTF("default")
	WEAK00:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	WEAK00:setLetterSpacing(6)
	WEAK00:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WEAK00:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WEAK00)
	self.WEAK00 = WEAK00
	local WEAK000 = LUI.UIText.new(-0.07, 1.08, 0, 0, 0, 0, 10, 34)
	WEAK000:setRGB(1, 0, 0)
	WEAK000:setAlpha(0)
	WEAK000:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F33AED3A709B334"))
	WEAK000:setTTF("default")
	WEAK000:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	WEAK000:setLetterSpacing(6)
	WEAK000:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WEAK000:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WEAK000)
	self.WEAK000 = WEAK000
	local GlowOrangeOver = LUI.UIImage.new(0.5, 0.5, -21, 18, 0, 0, -30, 76)
	GlowOrangeOver:setRGB(1, 0, 0.03)
	GlowOrangeOver:setAlpha(0.5)
	GlowOrangeOver:setZRot(-90)
	GlowOrangeOver:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	GlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowOrangeOver)
	self.GlowOrangeOver = GlowOrangeOver
	self:mergeStateConditions({
		{
			stateName = "OutOfRange",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "outOfRange")
			end,
		},
	})
	self:linkToElementModel(self, "outOfRange", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "outOfRange",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VHUDHawkWeakSignalWarningText.__resetProperties = function(f4_arg0)
	f4_arg0.GlowOrangeOver:completeAnimation()
	f4_arg0.WEAK000:completeAnimation()
	f4_arg0.WEAK00:completeAnimation()
	f4_arg0.WEAK:completeAnimation()
	f4_arg0.GlowOrangeOver:setAlpha(0.5)
	f4_arg0.WEAK000:setAlpha(0)
	f4_arg0.WEAK00:setAlpha(1)
	f4_arg0.WEAK:setAlpha(1)
end
CoD.VHUDHawkWeakSignalWarningText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(199)
						f8_arg0:setAlpha(0.6)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(100)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.WEAK:beginAnimation(210)
				f5_arg0.WEAK:setAlpha(1)
				f5_arg0.WEAK:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.WEAK:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.WEAK:completeAnimation()
			f5_arg0.WEAK:setAlpha(0.6)
			f5_local0(f5_arg0.WEAK)
			local f5_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(199)
						f11_arg0:setAlpha(0)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(100)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f5_arg0.WEAK00:beginAnimation(210)
				f5_arg0.WEAK00:setAlpha(1)
				f5_arg0.WEAK00:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.WEAK00:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f5_arg0.WEAK00:completeAnimation()
			f5_arg0.WEAK00:setAlpha(0)
			f5_local1(f5_arg0.WEAK00)
			local f5_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(199)
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(100)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f5_arg0.WEAK000:beginAnimation(210)
				f5_arg0.WEAK000:setAlpha(1)
				f5_arg0.WEAK000:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.WEAK000:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f5_arg0.WEAK000:completeAnimation()
			f5_arg0.WEAK000:setAlpha(0)
			f5_local2(f5_arg0.WEAK000)
			local f5_local3 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(199)
						f17_arg0:setAlpha(0.1)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(100)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f5_arg0.GlowOrangeOver:beginAnimation(210)
				f5_arg0.GlowOrangeOver:setAlpha(0.5)
				f5_arg0.GlowOrangeOver:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.GlowOrangeOver:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f5_arg0.GlowOrangeOver:completeAnimation()
			f5_arg0.GlowOrangeOver:setAlpha(0.1)
			f5_local3(f5_arg0.GlowOrangeOver)
			f5_arg0.nextClip = "DefaultClip"
		end,
		StartUp = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.WEAK:completeAnimation()
			f18_arg0.WEAK:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.WEAK)
			f18_arg0.WEAK00:completeAnimation()
			f18_arg0.WEAK00:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.WEAK00)
			f18_arg0.GlowOrangeOver:completeAnimation()
			f18_arg0.GlowOrangeOver:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.GlowOrangeOver)
		end,
	},
	OutOfRange = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						f22_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_in"])
						f22_arg0:setAlpha(0.6)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f21_arg0:beginAnimation(100)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f19_arg0.WEAK:beginAnimation(210, Enum[@"luitween"][@"luitween_ease_out"])
				f19_arg0.WEAK:setAlpha(1)
				f19_arg0.WEAK:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.WEAK:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.WEAK:completeAnimation()
			f19_arg0.WEAK:setAlpha(0.6)
			f19_local0(f19_arg0.WEAK)
			local f19_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						f25_arg0:beginAnimation(199)
						f25_arg0:setAlpha(0)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f24_arg0:beginAnimation(100)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f19_arg0.WEAK00:beginAnimation(210)
				f19_arg0.WEAK00:setAlpha(1)
				f19_arg0.WEAK00:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.WEAK00:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f19_arg0.WEAK00:completeAnimation()
			f19_arg0.WEAK00:setAlpha(0)
			f19_local1(f19_arg0.WEAK00)
			local f19_local2 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						f28_arg0:beginAnimation(199)
						f28_arg0:setAlpha(0)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f27_arg0:beginAnimation(100)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f19_arg0.WEAK000:beginAnimation(210)
				f19_arg0.WEAK000:setAlpha(1)
				f19_arg0.WEAK000:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.WEAK000:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f19_arg0.WEAK000:completeAnimation()
			f19_arg0.WEAK000:setAlpha(0)
			f19_local2(f19_arg0.WEAK000)
			local f19_local3 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						f31_arg0:beginAnimation(199)
						f31_arg0:setAlpha(0.1)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f30_arg0:beginAnimation(100)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f19_arg0.GlowOrangeOver:beginAnimation(210)
				f19_arg0.GlowOrangeOver:setAlpha(0.5)
				f19_arg0.GlowOrangeOver:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.GlowOrangeOver:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f19_arg0.GlowOrangeOver:completeAnimation()
			f19_arg0.GlowOrangeOver:setAlpha(0.1)
			f19_local3(f19_arg0.GlowOrangeOver)
			f19_arg0.nextClip = "DefaultClip"
		end,
	},
}
