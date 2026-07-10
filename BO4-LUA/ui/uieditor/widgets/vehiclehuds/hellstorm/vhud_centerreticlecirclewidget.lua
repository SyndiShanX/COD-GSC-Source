CoD.vhud_CenterReticleCircleWidget = InheritFrom(LUI.UIElement)
CoD.vhud_CenterReticleCircleWidget.__defaultWidth = 102
CoD.vhud_CenterReticleCircleWidget.__defaultHeight = 102
CoD.vhud_CenterReticleCircleWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_CenterReticleCircleWidget)
	self.id = "vhud_CenterReticleCircleWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CenterReticle = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	CenterReticle:setRGB(1, 0, 0)
	CenterReticle:setImage(RegisterImage(0x5C3FF395F0A052A))
	CenterReticle:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	CenterReticle:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(CenterReticle)
	self.CenterReticle = CenterReticle
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_CenterReticleCircleWidget.__resetProperties = function(f2_arg0)
	f2_arg0.CenterReticle:completeAnimation()
	f2_arg0.CenterReticle:setLeftRight(0.5, 0.5, -50, 50)
	f2_arg0.CenterReticle:setTopBottom(0.5, 0.5, -50, 50)
	f2_arg0.CenterReticle:setAlpha(1)
	f2_arg0.CenterReticle:setShaderVector(0, 2, 0, 0, 0)
end
CoD.vhud_CenterReticleCircleWidget.__clipsPerState = {
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
													f13_arg0:beginAnimation(19)
													f13_arg0:setAlpha(1)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
												end
												f12_arg0:beginAnimation(20)
												f12_arg0:setAlpha(0)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(19)
											f11_arg0:setAlpha(0.9)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(20)
										f10_arg0:setAlpha(0)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(19)
									f9_arg0:setAlpha(1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(20)
								f8_arg0:setAlpha(0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(20)
							f7_arg0:setAlpha(1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(20)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(20)
					f5_arg0:setAlpha(0.9)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.CenterReticle:beginAnimation(20)
				f3_arg0.CenterReticle:setAlpha(0)
				f3_arg0.CenterReticle:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.CenterReticle:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.CenterReticle:completeAnimation()
			f3_arg0.CenterReticle:setAlpha(1)
			f3_arg0.CenterReticle:setShaderVector(0, 2, 0, 0, 0)
			f3_local0(f3_arg0.CenterReticle)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
	LowAltitude = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	LowAltitude_Slow = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.CenterReticle:completeAnimation()
			f15_arg0.CenterReticle:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.CenterReticle)
		end,
	},
	LowAltitude_Boost = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.CenterReticle:completeAnimation()
			f16_arg0.CenterReticle:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.CenterReticle)
		end,
	},
	MediumAltitude = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.CenterReticle:completeAnimation()
			f17_arg0.CenterReticle:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CenterReticle)
		end,
		LowAltitude = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.CenterReticle:completeAnimation()
			f18_arg0.CenterReticle:setLeftRight(0.5, 0.5, -53, 49)
			f18_arg0.CenterReticle:setTopBottom(0.5, 0.5, -52, 50)
			f18_arg0.clipFinished(f18_arg0.CenterReticle)
		end,
	},
	MediumAltitude_Slow = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.CenterReticle:completeAnimation()
			f19_arg0.CenterReticle:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.CenterReticle)
		end,
	},
	MediumAltitude_Boost = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.CenterReticle:completeAnimation()
			f20_arg0.CenterReticle:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.CenterReticle)
		end,
	},
	HighAltitude = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.CenterReticle:completeAnimation()
			f21_arg0.CenterReticle:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.CenterReticle)
		end,
		MediumAltitude = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.CenterReticle:completeAnimation()
			f22_arg0.CenterReticle:setLeftRight(0.5, 0.5, -53, 49)
			f22_arg0.CenterReticle:setTopBottom(0.5, 0.5, -52, 50)
			f22_arg0.clipFinished(f22_arg0.CenterReticle)
		end,
	},
	HighAltitude_Slow = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.CenterReticle:completeAnimation()
			f23_arg0.CenterReticle:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.CenterReticle)
		end,
	},
	HighAltitude_Boost = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.CenterReticle:completeAnimation()
			f24_arg0.CenterReticle:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.CenterReticle)
		end,
	},
}
