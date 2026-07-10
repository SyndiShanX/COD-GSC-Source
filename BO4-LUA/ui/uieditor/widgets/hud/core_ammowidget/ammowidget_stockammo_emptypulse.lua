CoD.AmmoWidget_StockAmmo_EmptyPulse = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_StockAmmo_EmptyPulse.__defaultWidth = 100
CoD.AmmoWidget_StockAmmo_EmptyPulse.__defaultHeight = 24
CoD.AmmoWidget_StockAmmo_EmptyPulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_StockAmmo_EmptyPulse)
	self.id = "AmmoWidget_StockAmmo_EmptyPulse"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glow = LUI.UIImage.new(0, 0, -36.5, 135.5, 0, 0, -17, 37)
	Glow:setRGB(1, 0, 0)
	Glow:setImage(RegisterImage(@"uie_ui_hud_core_no_ammo_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local pulseImage = LUI.UIImage.new(0, 0, -13, 111, 0, 0, -12, 28)
	pulseImage:setRGB(1, 0, 0)
	pulseImage:setImage(RegisterImage(@"hash_679EFF63C895F04B"))
	self:addElement(pulseImage)
	self.pulseImage = pulseImage
	local Empty = LUI.UIText.new(0, 0, -4, 103, 0, 0, 5, 19)
	Empty:setRGB(1, 0, 0)
	Empty:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_14D7BD9466B67FE1"))
	Empty:setTTF("ttmussels_regular")
	Empty:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	Empty:setShaderVector(0, 0.5, 0, 0, 0)
	Empty:setShaderVector(1, 0, 0, 0, 1)
	Empty:setLetterSpacing(2)
	Empty:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Empty:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Empty)
	self.Empty = Empty
	self:subscribeToGlobalModel(f1_arg1, "HUDItems", "pulseNoAmmoForReload", function(model)
		local f2_local0 = self
		PlayClip(self, "Pulse", f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_StockAmmo_EmptyPulse.__resetProperties = function(f3_arg0)
	f3_arg0.pulseImage:completeAnimation()
	f3_arg0.Glow:completeAnimation()
	f3_arg0.Empty:completeAnimation()
	f3_arg0.pulseImage:setAlpha(1)
	f3_arg0.Glow:setAlpha(1)
	f3_arg0.Empty:setAlpha(1)
end
CoD.AmmoWidget_StockAmmo_EmptyPulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Glow:completeAnimation()
			f4_arg0.Glow:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Glow)
			f4_arg0.pulseImage:completeAnimation()
			f4_arg0.pulseImage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.pulseImage)
			f4_arg0.Empty:completeAnimation()
			f4_arg0.Empty:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Empty)
		end,
		Pulse = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							f9_arg0:beginAnimation(60)
							f9_arg0:setAlpha(0)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
						end
						f8_arg0:beginAnimation(59)
						f8_arg0:setAlpha(0.04)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(60)
					f7_arg0:setAlpha(0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.Glow:beginAnimation(140)
				f5_arg0.Glow:setAlpha(0.02)
				f5_arg0.Glow:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Glow:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.Glow:completeAnimation()
			f5_arg0.Glow:setAlpha(0)
			f5_local0(f5_arg0.Glow)
			local f5_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							f13_arg0:beginAnimation(60)
							f13_arg0:setAlpha(0)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
						end
						f12_arg0:beginAnimation(59)
						f12_arg0:setAlpha(0.1)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(60, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
					f11_arg0:setAlpha(0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f5_arg0.pulseImage:beginAnimation(140, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
				f5_arg0.pulseImage:setAlpha(0.03)
				f5_arg0.pulseImage:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.pulseImage:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f5_arg0.pulseImage:completeAnimation()
			f5_arg0.pulseImage:setAlpha(0)
			f5_local1(f5_arg0.pulseImage)
			local f5_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							f17_arg0:beginAnimation(60)
							f17_arg0:setAlpha(0)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
						end
						f16_arg0:beginAnimation(59)
						f16_arg0:setAlpha(1)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(60)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f5_arg0.Empty:beginAnimation(140)
				f5_arg0.Empty:setAlpha(1)
				f5_arg0.Empty:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Empty:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f5_arg0.Empty:completeAnimation()
			f5_arg0.Empty:setAlpha(0)
			f5_local2(f5_arg0.Empty)
		end,
	},
}
