CoD.HUD_ZM_Arcade_Heart = InheritFrom(LUI.UIElement)
CoD.HUD_ZM_Arcade_Heart.__defaultWidth = 42
CoD.HUD_ZM_Arcade_Heart.__defaultHeight = 42
CoD.HUD_ZM_Arcade_Heart.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_ZM_Arcade_Heart)
	self.id = "HUD_ZM_Arcade_Heart"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local flare = LUI.UIImage.new(0, 0, -744, 168, 0, 0, -503.5, 57.5)
	flare:setAlpha(0)
	flare:setImage(RegisterImage(0xA35E64C8EDD2469))
	flare:setMaterial(LUI.UIImage.GetCachedMaterial(0x32309484D7128AB))
	flare:setShaderVector(0, 24, 0, 0, 0)
	flare:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(flare)
	self.flare = flare
	local HeartWidget = LUI.UIImage.new(0, 0, 0, 42, 0, 0, 0, 42)
	HeartWidget:setImage(RegisterImage(0xDE5D2D6F4375CE6))
	self:addElement(HeartWidget)
	self.HeartWidget = HeartWidget
	local Disabled = LUI.UIImage.new(-0.88, 1.88, 0, 0, -1.76, 1, 0, 0)
	Disabled:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	Disabled:setAlpha(0)
	Disabled:setImage(RegisterImage(0x69BEFB7E55FBA50))
	self:addElement(Disabled)
	self.Disabled = Disabled
	self:mergeStateConditions({
		{
			stateName = "ShowSelf",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsClientnumFromElementEqualToOurs(f1_arg1, self) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "playerScoreShown", 0)
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "playerScoreShown", 0)
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	self:linkToElementModel(self, "playerScoreShown", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "playerScoreShown",
		})
	end)
	self:linkToElementModel(self, "self_revives", true, function(model)
		local f6_local0 = self
		if CoD.ModelUtility.IsSelfModelValueGreaterThan(f6_local0, f1_arg1, "self_revives_direction", 0) then
			PlayClip(self, "Adding", f1_arg1)
		elseif CoD.ModelUtility.IsSelfModelValueLessThan(f6_local0, f1_arg1, "self_revives_direction", 0) then
			PlayClip(self, "Losing", f1_arg1)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HUD_ZM_Arcade_Heart.__resetProperties = function(f7_arg0)
	f7_arg0.HeartWidget:completeAnimation()
	f7_arg0.flare:completeAnimation()
	f7_arg0.Disabled:completeAnimation()
	f7_arg0.HeartWidget:setLeftRight(0, 0, 0, 42)
	f7_arg0.HeartWidget:setTopBottom(0, 0, 0, 42)
	f7_arg0.HeartWidget:setAlpha(1)
	f7_arg0.flare:setAlpha(0)
	f7_arg0.flare:setShaderVector(0, 24, 0, 0, 0)
	f7_arg0.flare:setShaderVector(1, 0, 0, 0, 0)
	f7_arg0.Disabled:setLeftRight(-0.88, 1.88, 0, 0)
	f7_arg0.Disabled:setTopBottom(-1.76, 1, 0, 0)
	f7_arg0.Disabled:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	f7_arg0.Disabled:setAlpha(0)
end
CoD.HUD_ZM_Arcade_Heart.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.HeartWidget:completeAnimation()
			f8_arg0.HeartWidget:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.HeartWidget)
		end,
	},
	ShowSelf = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Adding = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(190)
					f12_arg0:setAlpha(0)
					f12_arg0:setShaderVector(1, 24, 0, 0, 0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.flare:beginAnimation(530)
				f10_arg0.flare:setAlpha(0.8)
				f10_arg0.flare:setShaderVector(1, 17.67, 0, 0, 0)
				f10_arg0.flare:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.flare:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.flare:completeAnimation()
			f10_arg0.flare:setAlpha(1)
			f10_arg0.flare:setShaderVector(0, 24, 0, 0, 0)
			f10_arg0.flare:setShaderVector(1, 0, 0, 0, 0)
			f10_local0(f10_arg0.flare)
			local f10_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								f17_arg0:beginAnimation(10)
								f17_arg0:setAlpha(1)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
							end
							f16_arg0:beginAnimation(169)
							f16_arg0:setLeftRight(0, 0, 0, 42)
							f16_arg0:setTopBottom(0, 0, 0, 42)
							f16_arg0:setAlpha(0.5)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(160)
						f15_arg0:setLeftRight(0, 0, -9, 51)
						f15_arg0:setTopBottom(0, 0, -18, 42)
						f15_arg0:setAlpha(1)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(179)
					f14_arg0:setLeftRight(0, 0, 0, 42)
					f14_arg0:setTopBottom(0, 0, 0, 42)
					f14_arg0:setAlpha(0.5)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f10_arg0.HeartWidget:beginAnimation(200)
				f10_arg0.HeartWidget:setLeftRight(0, 0, -9, 51)
				f10_arg0.HeartWidget:setTopBottom(0, 0, -18, 42)
				f10_arg0.HeartWidget:setAlpha(1)
				f10_arg0.HeartWidget:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.HeartWidget:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f10_arg0.HeartWidget:completeAnimation()
			f10_arg0.HeartWidget:setLeftRight(0, 0, 0, 42)
			f10_arg0.HeartWidget:setTopBottom(0, 0, 0, 42)
			f10_arg0.HeartWidget:setAlpha(0)
			f10_local1(f10_arg0.HeartWidget)
		end,
		Losing = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					local f20_local0 = function(f21_arg0)
						local f21_local0 = function(f22_arg0)
							f22_arg0:beginAnimation(9)
							f22_arg0:setLeftRight(0, 0, 0, 42)
							f22_arg0:setTopBottom(0, 0, 0, 42)
							f22_arg0:setAlpha(1)
							f22_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
						end
						f21_arg0:beginAnimation(260)
						f21_arg0:setLeftRight(0, 0, -5, 47)
						f21_arg0:setTopBottom(0, 0, 50, 102)
						f21_arg0:setAlpha(0)
						f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
					end
					f20_arg0:beginAnimation(780)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
				end
				f18_arg0.HeartWidget:beginAnimation(210)
				f18_arg0.HeartWidget:setLeftRight(0, 0, -17, 59)
				f18_arg0.HeartWidget:setTopBottom(0, 0, -48, 28)
				f18_arg0.HeartWidget:setAlpha(1)
				f18_arg0.HeartWidget:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.HeartWidget:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.HeartWidget:completeAnimation()
			f18_arg0.HeartWidget:setLeftRight(0, 0, 0, 42)
			f18_arg0.HeartWidget:setTopBottom(0, 0, 0, 42)
			f18_arg0.HeartWidget:setAlpha(0)
			f18_local0(f18_arg0.HeartWidget)
			local f18_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						local f25_local0 = function(f26_arg0)
							local f26_local0 = function(f27_arg0)
								f27_arg0:beginAnimation(100)
								f27_arg0:setAlpha(0)
								f27_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
							end
							f26_arg0:beginAnimation(580)
							f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
						end
						f25_arg0:beginAnimation(100)
						f25_arg0:setLeftRight(-0.88, 1.88, 0, 0)
						f25_arg0:setTopBottom(-1.76, 1, 0, 0)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
					end
					f24_arg0:beginAnimation(69)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f18_arg0.Disabled:beginAnimation(140)
				f18_arg0.Disabled:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Disabled:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f18_arg0.Disabled:completeAnimation()
			f18_arg0.Disabled:setLeftRight(-2.12, 3.12, 0, 0)
			f18_arg0.Disabled:setTopBottom(-3, 2.24, 0, 0)
			f18_arg0.Disabled:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
			f18_arg0.Disabled:setAlpha(0)
			f18_local1(f18_arg0.Disabled)
		end,
	},
	Show = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
}
