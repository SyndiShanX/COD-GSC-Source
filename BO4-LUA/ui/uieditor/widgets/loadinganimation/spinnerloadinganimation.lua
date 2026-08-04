CoD.SpinnerLoadingAnimation = InheritFrom(LUI.UIElement)
CoD.SpinnerLoadingAnimation.__defaultWidth = 60
CoD.SpinnerLoadingAnimation.__defaultHeight = 60
CoD.SpinnerLoadingAnimation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpinnerLoadingAnimation)
	self.id = "SpinnerLoadingAnimation"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Spinner = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Spinner:setAlpha(0.02)
	Spinner:setZRot(-359)
	Spinner:setImage(RegisterImage(@"hash_7C96F6285B1D996C"))
	Spinner:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Spinner:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Spinner)
	self.Spinner = Spinner
	local TierSlot = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TierSlot:setAlpha(0)
	TierSlot:setImage(RegisterImage("uie_ui_icon_blackmarket_tier_empty"))
	self:addElement(TierSlot)
	self.TierSlot = TierSlot
	local Tier = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Tier:setAlpha(0)
	Tier:setImage(RegisterImage("ui_icon_blackmarket_tier_medium"))
	self:addElement(Tier)
	self.Tier = Tier
	local TierGlow = LUI.UIImage.new(-0.08, 1.08, 0, 0, -0.57, 1.57, 0, 0)
	TierGlow:setRGB(0.87, 0.75, 0.36)
	TierGlow:setAlpha(0)
	TierGlow:setImage(RegisterImage("uie_ui_hud_notifications_glow"))
	TierGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	TierGlow:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(TierGlow)
	self.TierGlow = TierGlow
	local NPEmpty = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NPEmpty:setAlpha(0)
	NPEmpty:setImage(RegisterImage("uie_ui_icon_nebulium_medium_empty"))
	self:addElement(NPEmpty)
	self.NPEmpty = NPEmpty
	local NP = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NP:setAlpha(0)
	NP:setImage(RegisterImage("ui_icon_nebulium_medium"))
	self:addElement(NP)
	self.NP = NP
	local NPGlow = LUI.UIImage.new(-0.08, 1.08, -4, -4, -0.37, 1.77, 1, 1)
	NPGlow:setRGB(0.46, 0.03, 0.81)
	NPGlow:setAlpha(0)
	NPGlow:setImage(RegisterImage("uie_ui_hud_notifications_glow"))
	NPGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	NPGlow:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(NPGlow)
	self.NPGlow = NPGlow
	self:mergeStateConditions({
		{
			stateName = "Blackmarket",
			condition = function(menu, element, event)
				return IsPerControllerTablePropertyValue(f1_arg1, "inBlackMarket", true)
			end,
		},
		{
			stateName = "Laboratory",
			condition = function(menu, element, event)
				return IsPerControllerTablePropertyValue(f1_arg1, "inLaboratory", true)
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpinnerLoadingAnimation.__resetProperties = function(f4_arg0)
	f4_arg0.Spinner:completeAnimation()
	f4_arg0.TierSlot:completeAnimation()
	f4_arg0.Tier:completeAnimation()
	f4_arg0.TierGlow:completeAnimation()
	f4_arg0.NPEmpty:completeAnimation()
	f4_arg0.NP:completeAnimation()
	f4_arg0.NPGlow:completeAnimation()
	f4_arg0.Spinner:setAlpha(0.02)
	f4_arg0.Spinner:setZRot(-359)
	f4_arg0.TierSlot:setAlpha(0)
	f4_arg0.Tier:setAlpha(0)
	f4_arg0.Tier:setScale(1, 1)
	f4_arg0.TierGlow:setAlpha(0)
	f4_arg0.TierGlow:setScale(1, 1)
	f4_arg0.NPEmpty:setAlpha(0)
	f4_arg0.NP:setAlpha(0)
	f4_arg0.NP:setScale(1, 1)
	f4_arg0.NPGlow:setAlpha(0)
	f4_arg0.NPGlow:setScale(1, 1)
end
CoD.SpinnerLoadingAnimation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Spinner:beginAnimation(1400)
				f5_arg0.Spinner:setZRot(-359)
				f5_arg0.Spinner:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Spinner:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Spinner:completeAnimation()
			f5_arg0.Spinner:setZRot(0)
			f5_local0(f5_arg0.Spinner)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	Blackmarket = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			f7_arg0.Spinner:completeAnimation()
			f7_arg0.Spinner:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Spinner)
			f7_arg0.TierSlot:completeAnimation()
			f7_arg0.TierSlot:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.TierSlot)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(799, Enum[@"luitween"][@"luitween_ease_out"])
							f11_arg0:setAlpha(0)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_out"])
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(49, Enum[@"luitween"][@"luitween_ease_out"])
					f9_arg0:setAlpha(1)
					f9_arg0:setScale(0.9, 0.9)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f8_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f8_arg0:setAlpha(0.9)
				f8_arg0:setScale(0.8, 0.8)
				f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.Tier:beginAnimation(100)
			f7_arg0.Tier:setAlpha(0)
			f7_arg0.Tier:setScale(5, 5)
			f7_arg0.Tier:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
			f7_arg0.Tier:registerEventHandler("transition_complete_keyframe", f7_local0)
			local f7_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(350, Enum[@"luitween"][@"luitween_ease_out"])
					f13_arg0:setAlpha(0)
					f13_arg0:setScale(4, 2)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f12_arg0:beginAnimation(50, Enum[@"luitween"][@"luitween_ease_out"])
				f12_arg0:setAlpha(0.5)
				f12_arg0:setScale(1.38, 1.12)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f7_arg0.TierGlow:beginAnimation(350)
			f7_arg0.TierGlow:setAlpha(0)
			f7_arg0.TierGlow:setScale(1, 1)
			f7_arg0.TierGlow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
			f7_arg0.TierGlow:registerEventHandler("transition_complete_keyframe", f7_local1)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
	Laboratory = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.Spinner:completeAnimation()
			f14_arg0.Spinner:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Spinner)
			f14_arg0.NPEmpty:completeAnimation()
			f14_arg0.NPEmpty:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.NPEmpty)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						local f17_local0 = function(f18_arg0)
							f18_arg0:beginAnimation(799)
							f18_arg0:setAlpha(0)
							f18_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
						end
						f17_arg0:beginAnimation(250)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
					end
					f16_arg0:beginAnimation(49)
					f16_arg0:setAlpha(1)
					f16_arg0:setScale(1, 1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f15_arg0:beginAnimation(200)
				f15_arg0:setAlpha(0.8)
				f15_arg0:setScale(0.8, 0.8)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.NP:beginAnimation(100)
			f14_arg0.NP:setAlpha(0)
			f14_arg0.NP:setScale(5, 5)
			f14_arg0.NP:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
			f14_arg0.NP:registerEventHandler("transition_complete_keyframe", f14_local0)
			local f14_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(350)
					f20_arg0:setAlpha(0)
					f20_arg0:setScale(4, 2)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f19_arg0:beginAnimation(50)
				f19_arg0:setAlpha(0.5)
				f19_arg0:setScale(1.38, 1.12)
				f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f14_arg0.NPGlow:beginAnimation(350)
			f14_arg0.NPGlow:setAlpha(0)
			f14_arg0.NPGlow:setScale(1, 1)
			f14_arg0.NPGlow:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
			f14_arg0.NPGlow:registerEventHandler("transition_complete_keyframe", f14_local1)
			f14_arg0.nextClip = "DefaultClip"
		end,
	},
}
