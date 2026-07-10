CoD.CommonBgLayoutElement01 = InheritFrom(LUI.UIElement)
CoD.CommonBgLayoutElement01.__defaultWidth = 144
CoD.CommonBgLayoutElement01.__defaultHeight = 36
CoD.CommonBgLayoutElement01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonBgLayoutElement01)
	self.id = "CommonBgLayoutElement01"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DotGridBg = LUI.UIImage.new(0, 0, 0, 144, 0, 0, 0, 36)
	DotGridBg:setImage(RegisterImage(0xC529D202F311DB5))
	DotGridBg:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotGridBg)
	self.DotGridBg = DotGridBg
	local DotGridPattern01 = LUI.UIImage.new(0, 0, 10.5, 134.5, 0, 0, 10, 26)
	DotGridPattern01:setAlpha(0)
	DotGridPattern01:setImage(RegisterImage(0x386097A4B65DDFE))
	DotGridPattern01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotGridPattern01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(DotGridPattern01)
	self.DotGridPattern01 = DotGridPattern01
	local DotGridPattern02 = LUI.UIImage.new(0, 0, 10.5, 134.5, 0, 0, 10, 26)
	DotGridPattern02:setAlpha(0)
	DotGridPattern02:setImage(RegisterImage(0x386087A4B65DC4B))
	DotGridPattern02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotGridPattern02:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(DotGridPattern02)
	self.DotGridPattern02 = DotGridPattern02
	local DotGridPattern03 = LUI.UIImage.new(0, 0, 10.5, 134.5, 0, 0, 10, 26)
	DotGridPattern03:setAlpha(0)
	DotGridPattern03:setImage(RegisterImage(0x3860A7A4B65DFB1))
	DotGridPattern03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotGridPattern03:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(DotGridPattern03)
	self.DotGridPattern03 = DotGridPattern03
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonBgLayoutElement01.__resetProperties = function(f2_arg0)
	f2_arg0.DotGridBg:completeAnimation()
	f2_arg0.DotGridPattern01:completeAnimation()
	f2_arg0.DotGridPattern02:completeAnimation()
	f2_arg0.DotGridPattern03:completeAnimation()
	f2_arg0.DotGridBg:setAlpha(1)
	f2_arg0.DotGridPattern01:setAlpha(0)
	f2_arg0.DotGridPattern01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.DotGridPattern01:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.DotGridPattern02:setAlpha(0)
	f2_arg0.DotGridPattern02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.DotGridPattern02:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.DotGridPattern03:setAlpha(0)
	f2_arg0.DotGridPattern03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.DotGridPattern03:setShaderVector(0, 1, 0, 0, 0)
end
CoD.CommonBgLayoutElement01.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								f8_arg0:beginAnimation(2000)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f7_arg0:beginAnimation(2000)
							f7_arg0:setAlpha(1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(2000)
						f6_arg0:setAlpha(0.85)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(2000)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.DotGridBg:beginAnimation(2000)
				f3_arg0.DotGridBg:setAlpha(0.8)
				f3_arg0.DotGridBg:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.DotGridBg:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.DotGridBg:completeAnimation()
			f3_arg0.DotGridBg:setAlpha(1)
			f3_local0(f3_arg0.DotGridBg)
			local f3_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							local f12_local0 = function(f13_arg0)
								local f13_local0 = function(f14_arg0)
									f14_arg0:beginAnimation(200)
									f14_arg0:setAlpha(0)
									f14_arg0:setShaderVector(0, 1, 0, 0, 0)
									f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f13_arg0:beginAnimation(199)
								f13_arg0:setAlpha(0.03)
								f13_arg0:setShaderVector(0, 2, 0, 0, 0)
								f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
							end
							f12_arg0:beginAnimation(5900)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
						end
						f11_arg0:beginAnimation(250, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f11_arg0:setAlpha(0)
						f11_arg0:setShaderVector(0, 1, 0, 0, 0)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(250, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f10_arg0:setAlpha(0.03)
					f10_arg0:setShaderVector(0, 2, 0, 0, 0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f3_arg0.DotGridPattern01:beginAnimation(1000)
				f3_arg0.DotGridPattern01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.DotGridPattern01:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.DotGridPattern01:completeAnimation()
			f3_arg0.DotGridPattern01:setAlpha(0)
			f3_arg0.DotGridPattern01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.DotGridPattern01:setShaderVector(0, 1, 0, 0, 0)
			f3_local1(f3_arg0.DotGridPattern01)
			local f3_local2 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						local f17_local0 = function(f18_arg0)
							local f18_local0 = function(f19_arg0)
								local f19_local0 = function(f20_arg0)
									local f20_local0 = function(f21_arg0)
										local f21_local0 = function(f22_arg0)
											f22_arg0:beginAnimation(199)
											f22_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f21_arg0:beginAnimation(199)
										f21_arg0:setAlpha(0)
										f21_arg0:setShaderVector(0, 1, 0, 0, 0)
										f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
									end
									f20_arg0:beginAnimation(200)
									f20_arg0:setAlpha(0.04)
									f20_arg0:setShaderVector(0, 2, 0, 0, 0)
									f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
								end
								f19_arg0:beginAnimation(5399)
								f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
							end
							f18_arg0:beginAnimation(250, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
							f18_arg0:setAlpha(0)
							f18_arg0:setShaderVector(0, 1, 0, 0, 0)
							f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
						end
						f17_arg0:beginAnimation(250, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f17_arg0:setAlpha(0.04)
						f17_arg0:setShaderVector(0, 2, 0, 0, 0)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
					end
					f16_arg0:beginAnimation(1500)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f3_arg0.DotGridPattern02:beginAnimation(1000)
				f3_arg0.DotGridPattern02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.DotGridPattern02:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f3_arg0.DotGridPattern02:completeAnimation()
			f3_arg0.DotGridPattern02:setAlpha(0)
			f3_arg0.DotGridPattern02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.DotGridPattern02:setShaderVector(0, 1, 0, 0, 0)
			f3_local2(f3_arg0.DotGridPattern02)
			local f3_local3 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						local f25_local0 = function(f26_arg0)
							local f26_local0 = function(f27_arg0)
								local f27_local0 = function(f28_arg0)
									local f28_local0 = function(f29_arg0)
										local f29_local0 = function(f30_arg0)
											f30_arg0:beginAnimation(200)
											f30_arg0:setAlpha(0)
											f30_arg0:setShaderVector(0, 1, 0, 0, 0)
											f30_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f29_arg0:beginAnimation(199)
										f29_arg0:setAlpha(0.05)
										f29_arg0:setShaderVector(0, 2, 0, 0, 0)
										f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
									end
									f28_arg0:beginAnimation(2600)
									f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
								end
								f27_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
								f27_arg0:setAlpha(0)
								f27_arg0:setShaderVector(0, 1, 0, 0, 0)
								f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
							end
							f26_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
							f26_arg0:setAlpha(0.05)
							f26_arg0:setShaderVector(0, 2, 0, 0, 0)
							f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
						end
						f25_arg0:beginAnimation(1500)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
					end
					f24_arg0:beginAnimation(1500)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f3_arg0.DotGridPattern03:beginAnimation(1000)
				f3_arg0.DotGridPattern03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.DotGridPattern03:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f3_arg0.DotGridPattern03:completeAnimation()
			f3_arg0.DotGridPattern03:setAlpha(0)
			f3_arg0.DotGridPattern03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.DotGridPattern03:setShaderVector(0, 1, 0, 0, 0)
			f3_local3(f3_arg0.DotGridPattern03)
			f3_arg0.nextClip = "DefaultClip"
		end,
		Intro = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.DotGridBg:beginAnimation(2000)
				f31_arg0.DotGridBg:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.DotGridBg:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.DotGridBg:completeAnimation()
			f31_arg0.DotGridBg:setAlpha(0)
			f31_local0(f31_arg0.DotGridBg)
		end,
	},
}
