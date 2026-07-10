CoD.ZM_ReviveBleedoutRedEyeGlow = InheritFrom(LUI.UIElement)
CoD.ZM_ReviveBleedoutRedEyeGlow.__defaultWidth = 25
CoD.ZM_ReviveBleedoutRedEyeGlow.__defaultHeight = 27
CoD.ZM_ReviveBleedoutRedEyeGlow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZM_ReviveBleedoutRedEyeGlow)
	self.id = "ZM_ReviveBleedoutRedEyeGlow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowOrangeOver0 = LUI.UIImage.new(0, 0, 0, 26, 0, 0, 0, 27)
	GlowOrangeOver0:setRGB(1, 0, 0.03)
	GlowOrangeOver0:setAlpha(0.46)
	GlowOrangeOver0:setZRot(90)
	GlowOrangeOver0:setImage(RegisterImage(0x5BE416E17DAB33B))
	GlowOrangeOver0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowOrangeOver0)
	self.GlowOrangeOver0 = GlowOrangeOver0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZM_ReviveBleedoutRedEyeGlow.__resetProperties = function(f2_arg0)
	f2_arg0.GlowOrangeOver0:completeAnimation()
	f2_arg0.GlowOrangeOver0:setAlpha(0.46)
end
CoD.ZM_ReviveBleedoutRedEyeGlow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											local f11_local0 = function(f12_arg0)
												local f12_local0 = function(f13_arg0)
													f13_arg0:beginAnimation(200)
													f13_arg0:setAlpha(0)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
												end
												f12_arg0:beginAnimation(209)
												f12_arg0:setAlpha(0.17)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(300)
											f11_arg0:setAlpha(0)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(299)
										f10_arg0:setAlpha(0.3)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(300)
									f9_arg0:setAlpha(0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(199)
								f8_arg0:setAlpha(0.29)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(229)
							f7_arg0:setAlpha(0.2)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(90)
						f6_arg0:setAlpha(0.54)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(70)
					f5_arg0:setAlpha(0.11)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.GlowOrangeOver0:beginAnimation(110)
				f3_arg0.GlowOrangeOver0:setAlpha(0.19)
				f3_arg0.GlowOrangeOver0:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowOrangeOver0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GlowOrangeOver0:completeAnimation()
			f3_arg0.GlowOrangeOver0:setAlpha(0)
			f3_local0(f3_arg0.GlowOrangeOver0)
			f3_arg0.nextClip = "DefaultClip"
		end,
		BleedingOut = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
}
