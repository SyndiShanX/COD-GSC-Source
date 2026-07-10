CoD[0xA99D05EEE776A3] = InheritFrom(LUI.UIElement)
CoD[0xA99D05EEE776A3].__defaultWidth = 720
CoD[0xA99D05EEE776A3].__defaultHeight = 180
CoD[0xA99D05EEE776A3].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0xA99D05EEE776A3])
	self.id = "CallingCards_Specialized_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CardIcon:setImage(RegisterImage(@"uie_t7_icon_callingcard_temp2_lrg"))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local background = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	background:setImage(RegisterImage(@"uie_background_01"))
	background:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	background:setShaderVector(0, 1, 1, 0, 0)
	background:setShaderVector(1, 0.03, 0, 0, 0)
	self:addElement(background)
	self.background = background
	local bear = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	bear:setImage(RegisterImage(@"uie_bear"))
	self:addElement(bear)
	self.bear = bear
	local colorOverlay = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	colorOverlay:setAlpha(0.7)
	colorOverlay:setImage(RegisterImage(@"uie_color_overlay"))
	colorOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(colorOverlay)
	self.colorOverlay = colorOverlay
	local bearBlack = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	bearBlack:setAlpha(0.5)
	bearBlack:setImage(RegisterImage(@"uie_black_bear"))
	self:addElement(bearBlack)
	self.bearBlack = bearBlack
	local bearDetails = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	bearDetails:setImage(RegisterImage(@"uie_bear_features"))
	self:addElement(bearDetails)
	self.bearDetails = bearDetails
	local eyeGlow = LUI.UIImage.new(0, 0, 398.5, 493.5, 0, 0, 16, 68)
	eyeGlow:setZRot(-35)
	eyeGlow:setImage(RegisterImage(@"uie_fire_glow"))
	eyeGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(eyeGlow)
	self.eyeGlow = eyeGlow
	local eyeGlow2 = LUI.UIImage.new(0, 0, 481.5, 576.5, 0, 0, 59, 111)
	eyeGlow2:setZRot(-24)
	eyeGlow2:setImage(RegisterImage(@"uie_fire_glow"))
	eyeGlow2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(eyeGlow2)
	self.eyeGlow2 = eyeGlow2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0xA99D05EEE776A3].__resetProperties = function(f2_arg0)
	f2_arg0.bear:completeAnimation()
	f2_arg0.bearBlack:completeAnimation()
	f2_arg0.bearDetails:completeAnimation()
	f2_arg0.eyeGlow:completeAnimation()
	f2_arg0.eyeGlow2:completeAnimation()
	f2_arg0.bear:setAlpha(1)
	f2_arg0.bearBlack:setAlpha(0.5)
	f2_arg0.bearBlack:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f2_arg0.bearDetails:setAlpha(1)
	f2_arg0.eyeGlow:setAlpha(1)
	f2_arg0.eyeGlow2:setAlpha(1)
end
CoD[0xA99D05EEE776A3].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1500)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(2000)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.bear:beginAnimation(500)
				f3_arg0.bear:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bear:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.bear:completeAnimation()
			f3_arg0.bear:setAlpha(1)
			f3_local0(f3_arg0.bear)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							local f10_local0 = function(f11_arg0)
								local f11_local0 = function(f12_arg0)
									f12_arg0:beginAnimation(1500)
									f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f11_arg0:beginAnimation(500)
								f11_arg0:setAlpha(0)
								f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
							end
							f10_arg0:beginAnimation(780)
							f10_arg0:setAlpha(0.75)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
						end
						f9_arg0:beginAnimation(220)
						f9_arg0:setAlpha(0.56)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(500)
					f8_arg0:setAlpha(0.5)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.bearBlack:beginAnimation(500)
				f3_arg0.bearBlack:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bearBlack:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.bearBlack:completeAnimation()
			f3_arg0.bearBlack:setAlpha(0)
			f3_arg0.bearBlack:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f3_local1(f3_arg0.bearBlack)
			local f3_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								f17_arg0:beginAnimation(1500)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f16_arg0:beginAnimation(500)
							f16_arg0:setAlpha(0)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(940)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(519)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f3_arg0.bearDetails:beginAnimation(540)
				f3_arg0.bearDetails:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bearDetails:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.bearDetails:completeAnimation()
			f3_arg0.bearDetails:setAlpha(0)
			f3_local2(f3_arg0.bearDetails)
			local f3_local3 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(490)
						f20_arg0:setAlpha(0)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(320)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f18_arg0:beginAnimation(370)
				f18_arg0:setAlpha(1)
				f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f3_arg0.eyeGlow:beginAnimation(1060)
			f3_arg0.eyeGlow:setAlpha(0)
			f3_arg0.eyeGlow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.eyeGlow:registerEventHandler("transition_complete_keyframe", f3_local3)
			local f3_local4 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						f23_arg0:beginAnimation(490)
						f23_arg0:setAlpha(0)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f22_arg0:beginAnimation(320)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f21_arg0:beginAnimation(370)
				f21_arg0:setAlpha(1)
				f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f3_arg0.eyeGlow2:beginAnimation(1060)
			f3_arg0.eyeGlow2:setAlpha(0)
			f3_arg0.eyeGlow2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.eyeGlow2:registerEventHandler("transition_complete_keyframe", f3_local4)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
