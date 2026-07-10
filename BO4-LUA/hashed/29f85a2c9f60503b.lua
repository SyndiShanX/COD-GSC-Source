require("x64:e3e07a40c41859f")
require("x64:de018cc57b5fcfd")
require("x64:34bad1af88ea61f")
require("x64:c703989346b8301")
require("x64:799871681d39113")
CoD.zm_red_challenges_widget = InheritFrom(LUI.UIElement)
CoD.zm_red_challenges_widget.__defaultWidth = 360
CoD.zm_red_challenges_widget.__defaultHeight = 100
CoD.zm_red_challenges_widget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.zm_red_challenges_widget)
	self.id = "zm_red_challenges_widget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fxEmber = CoD.fx_EmberAdd.new(f1_arg0, f1_arg1, 0, 0, 325.5, 556.5, 0, 0, -107, 229)
	fxEmber:setAlpha(0)
	fxEmber:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2B50DA92C71B7E2"))
	self:addElement(fxEmber)
	self.fxEmber = fxEmber
	local glow01 = LUI.UIImage.new(0.5, 0.5, -344, 344, 0.5, 0.5, -98, 110)
	glow01:setRGB(1, 0.44, 0)
	glow01:setAlpha(0)
	glow01:setImage(RegisterImage(@"uie_zm_hud_challenges_glow01"))
	glow01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	glow01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(glow01)
	self.glow01 = glow01
	local glow02 = LUI.UIImage.new(0.5, 0.5, -344, 344, 0.5, 0.5, -98, 110)
	glow02:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	glow02:setAlpha(0)
	glow02:setImage(RegisterImage(@"uie_zm_hud_challenges_glow02"))
	glow02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	glow02:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(glow02)
	self.glow02 = glow02
	local zmredchallengeswidgetinternal = CoD.zm_red_challenges_widget_internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, 180, 0.5, 0.5, -37, 50)
	zmredchallengeswidgetinternal:linkToElementModel(self, nil, false, function(model)
		zmredchallengeswidgetinternal:setModel(model, f1_arg1)
	end)
	self:addElement(zmredchallengeswidgetinternal)
	self.zmredchallengeswidgetinternal = zmredchallengeswidgetinternal
	local ClaimItemText = LUI.UIText.new(0, 0, 0, 360, 0, 0, 44.5, 77.5)
	ClaimItemText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ClaimItemText:setAlpha(0)
	ClaimItemText:setText(LocalizeToUpperString(@"hash_5DEA3FF257CADC1B"))
	ClaimItemText:setTTF("dinnext_regular")
	ClaimItemText:setLetterSpacing(1)
	ClaimItemText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ClaimItemText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(ClaimItemText)
	self.ClaimItemText = ClaimItemText
	local ChallengeText = CoD.zm_red_challenge_text.new(f1_arg0, f1_arg1, 0, 0, 0, 360, 0, 0, 27, 46)
	ChallengeText.ChallengeText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	ChallengeText:linkToElementModel(self, nil, false, function(model)
		ChallengeText:setModel(model, f1_arg1)
	end)
	self:addElement(ChallengeText)
	self.ChallengeText = ChallengeText
	local LocationText = CoD.zm_red_location_text.new(f1_arg0, f1_arg1, 0, 0, 0, 360, 0, 0, 72, 91)
	LocationText:mergeStateConditions({
		{
			stateName = "NoText",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "bottomText", 0x0)
			end,
		},
		{
			stateName = "InLocation",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "bInLocation", 0)
			end,
		},
		{
			stateName = "NotInLocation",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "bInLocation", 0)
			end,
		},
	})
	LocationText:linkToElementModel(LocationText, "bottomText", true, function(model)
		f1_arg0:updateElementState(LocationText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bottomText",
		})
	end)
	LocationText:linkToElementModel(LocationText, "bInLocation", true, function(model)
		f1_arg0:updateElementState(LocationText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bInLocation",
		})
	end)
	LocationText.LocationTextDark:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	LocationText.LocationText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	LocationText:linkToElementModel(self, nil, false, function(model)
		LocationText:setModel(model, f1_arg1)
	end)
	self:addElement(LocationText)
	self.LocationText = LocationText
	local Timer = CoD.zm_red_challenge_timer.new(f1_arg0, f1_arg1, 0.5, 0.5, -124, 124, 0.5, 0.5, -145, -7)
	Timer:setScale(0.6, 0.6)
	self:addElement(Timer)
	self.Timer = Timer
	self:linkToElementModel(self, "progress", true, function(model)
		local f10_local0 = self
		PlayClip(self, "PulseTributeProgress", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.zm_red_challenges_widget.__resetProperties = function(f11_arg0)
	f11_arg0.glow01:completeAnimation()
	f11_arg0.fxEmber:completeAnimation()
	f11_arg0.glow02:completeAnimation()
	f11_arg0.ClaimItemText:completeAnimation()
	f11_arg0.LocationText:completeAnimation()
	f11_arg0.ChallengeText:completeAnimation()
	f11_arg0.glow01:setAlpha(0)
	f11_arg0.fxEmber:setAlpha(0)
	f11_arg0.glow02:setAlpha(0)
	f11_arg0.ClaimItemText:setAlpha(0)
	f11_arg0.LocationText:setAlpha(1)
	f11_arg0.ChallengeText:setAlpha(1)
end
CoD.zm_red_challenges_widget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		PulseTributeProgress = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(3200)
						f16_arg0:setAlpha(0)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(780)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.fxEmber:beginAnimation(20)
				f13_arg0.fxEmber:setAlpha(1)
				f13_arg0.fxEmber:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.fxEmber:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.fxEmber:completeAnimation()
			f13_arg0.fxEmber:setAlpha(0)
			f13_local0(f13_arg0.fxEmber)
			local f13_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							local f20_local0 = function(f21_arg0)
								local f21_local0 = function(f22_arg0)
									f22_arg0:beginAnimation(620)
									f22_arg0:setAlpha(0)
									f22_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
								end
								f21_arg0:beginAnimation(20)
								f21_arg0:setAlpha(1)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
							end
							f20_arg0:beginAnimation(59)
							f20_arg0:setAlpha(0)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(20)
						f19_arg0:setAlpha(1)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(60)
					f18_arg0:setAlpha(0)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f13_arg0.glow01:beginAnimation(20)
				f13_arg0.glow01:setAlpha(1)
				f13_arg0.glow01:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.glow01:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f13_arg0.glow01:completeAnimation()
			f13_arg0.glow01:setAlpha(0)
			f13_local1(f13_arg0.glow01)
			local f13_local2 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						local f25_local0 = function(f26_arg0)
							local f26_local0 = function(f27_arg0)
								local f27_local0 = function(f28_arg0)
									f28_arg0:beginAnimation(620)
									f28_arg0:setAlpha(0)
									f28_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
								end
								f27_arg0:beginAnimation(20)
								f27_arg0:setAlpha(1)
								f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
							end
							f26_arg0:beginAnimation(59)
							f26_arg0:setAlpha(0)
							f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
						end
						f25_arg0:beginAnimation(20)
						f25_arg0:setAlpha(1)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
					end
					f24_arg0:beginAnimation(60)
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f13_arg0.glow02:beginAnimation(20)
				f13_arg0.glow02:setAlpha(1)
				f13_arg0.glow02:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.glow02:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f13_arg0.glow02:completeAnimation()
			f13_arg0.glow02:setAlpha(0)
			f13_local2(f13_arg0.glow02)
		end,
	},
	ClaimItem = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.ClaimItemText:completeAnimation()
			f29_arg0.ClaimItemText:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.ClaimItemText)
			f29_arg0.ChallengeText:completeAnimation()
			f29_arg0.ChallengeText:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ChallengeText)
			f29_arg0.LocationText:completeAnimation()
			f29_arg0.LocationText:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.LocationText)
		end,
	},
}
CoD.zm_red_challenges_widget.__onClose = function(f30_arg0)
	f30_arg0.fxEmber:close()
	f30_arg0.zmredchallengeswidgetinternal:close()
	f30_arg0.ChallengeText:close()
	f30_arg0.LocationText:close()
	f30_arg0.Timer:close()
end
