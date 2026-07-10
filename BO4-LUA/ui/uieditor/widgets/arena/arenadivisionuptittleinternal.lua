CoD.ArenaDivisionUpTittleInternal = InheritFrom(LUI.UIElement)
CoD.ArenaDivisionUpTittleInternal.__defaultWidth = 400
CoD.ArenaDivisionUpTittleInternal.__defaultHeight = 53
CoD.ArenaDivisionUpTittleInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaDivisionUpTittleInternal)
	self.id = "ArenaDivisionUpTittleInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeveledUpTextBase = LUI.UIText.new(0, 0, -700, 1100, 0, 0, 0, 51)
	LeveledUpTextBase:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
	LeveledUpTextBase:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_318BCB09BB8D1C33"))
	LeveledUpTextBase:setTTF("ttmussels_regular")
	LeveledUpTextBase:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_5B17513E9D94CE76"))
	LeveledUpTextBase:setShaderVector(0, 1, 0, 0, 0)
	LeveledUpTextBase:setShaderVector(1, 0, 0, 0, 0)
	LeveledUpTextBase:setShaderVector(2, 0, 1, 0, 0)
	LeveledUpTextBase:setShaderVector(3, 0, 0, 0, 0)
	LeveledUpTextBase:setLetterSpacing(14)
	LeveledUpTextBase:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	LeveledUpTextBase:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(LeveledUpTextBase)
	self.LeveledUpTextBase = LeveledUpTextBase
	local LeveledUpTextAdd = LUI.UIText.new(0, 0, -700, 1100, 0, 0, 0, 51)
	LeveledUpTextAdd:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
	LeveledUpTextAdd:setAlpha(0)
	LeveledUpTextAdd:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_318BCB09BB8D1C33"))
	LeveledUpTextAdd:setTTF("ttmussels_regular")
	LeveledUpTextAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3336C1AE82B1520A"))
	LeveledUpTextAdd:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_5B17513E9D94CE76"))
	LeveledUpTextAdd:setShaderVector(0, 1, 0, 0, 0)
	LeveledUpTextAdd:setShaderVector(1, 0, 0, 0, 0)
	LeveledUpTextAdd:setShaderVector(2, 0, 1, 0, 0)
	LeveledUpTextAdd:setShaderVector(3, 0, 0, 0, 0)
	LeveledUpTextAdd:setLetterSpacing(14)
	LeveledUpTextAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	LeveledUpTextAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(LeveledUpTextAdd)
	self.LeveledUpTextAdd = LeveledUpTextAdd
	local Flare = LUI.UIImage.new(0.5, 0.5, -375, 375, 0.5, 0.5, -55, 55)
	Flare:setRGB(0.92, 0.89, 0.72)
	Flare:setAlpha(0)
	Flare:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_flare"))
	Flare:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Flare:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Flare)
	self.Flare = Flare
	self:linkToElementModel(self, "rewardImage", true, function(model)
		local f2_local0 = self
		PlayClip(self, "Intro", f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaDivisionUpTittleInternal.__resetProperties = function(f3_arg0)
	f3_arg0.LeveledUpTextBase:completeAnimation()
	f3_arg0.LeveledUpTextAdd:completeAnimation()
	f3_arg0.Flare:completeAnimation()
	f3_arg0.LeveledUpTextBase:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
	f3_arg0.LeveledUpTextBase:setAlpha(1)
	f3_arg0.LeveledUpTextBase:setScale(1, 1)
	f3_arg0.LeveledUpTextAdd:setAlpha(0)
	f3_arg0.Flare:setRGB(0.92, 0.89, 0.72)
	f3_arg0.Flare:setAlpha(0)
	f3_arg0.Flare:setScale(1, 1)
end
CoD.ArenaDivisionUpTittleInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							local f8_local0 = function(f9_arg0)
								f9_arg0:beginAnimation(2090)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
							end
							f8_arg0:beginAnimation(100)
							f8_arg0:setAlpha(1)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:beginAnimation(60)
						f7_arg0:setAlpha(0.72)
						f7_arg0:setScale(1, 1)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(199)
					f6_arg0:setAlpha(0.56)
					f6_arg0:setScale(0.8, 0.8)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.LeveledUpTextBase:beginAnimation(550)
				f4_arg0.LeveledUpTextBase:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.LeveledUpTextBase:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.LeveledUpTextBase:completeAnimation()
			f4_arg0.LeveledUpTextBase:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
			f4_arg0.LeveledUpTextBase:setAlpha(0)
			f4_arg0.LeveledUpTextBase:setScale(6, 6)
			f4_local0(f4_arg0.LeveledUpTextBase)
			local f4_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(329, Enum[@"luitween"][@"luitween_ease_in"])
						f12_arg0:setAlpha(0)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f4_arg0.LeveledUpTextAdd:beginAnimation(810)
				f4_arg0.LeveledUpTextAdd:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.LeveledUpTextAdd:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f4_arg0.LeveledUpTextAdd:completeAnimation()
			f4_arg0.LeveledUpTextAdd:setAlpha(0)
			f4_local1(f4_arg0.LeveledUpTextAdd)
			local f4_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								local f17_local0 = function(f18_arg0)
									f18_arg0:beginAnimation(199)
									f18_arg0:setAlpha(0)
									f18_arg0:setScale(1.5, 1.5)
									f18_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
								end
								f17_arg0:beginAnimation(20)
								f17_arg0:setScale(1.05, 1.05)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
							end
							f16_arg0:beginAnimation(60)
							f16_arg0:setScale(1, 1)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(19)
						f15_arg0:setAlpha(1)
						f15_arg0:setScale(0.25, 0.25)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(199)
					f14_arg0:setAlpha(0.91)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f4_arg0.Flare:beginAnimation(550)
				f4_arg0.Flare:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Flare:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f4_arg0.Flare:completeAnimation()
			f4_arg0.Flare:setRGB(0.92, 0.89, 0.72)
			f4_arg0.Flare:setAlpha(0)
			f4_arg0.Flare:setScale(0, 0)
			f4_local2(f4_arg0.Flare)
		end,
	},
}
