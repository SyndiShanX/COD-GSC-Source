CoD[0xA90B69ECEBAE127] = InheritFrom(LUI.UIElement)
CoD[0xA90B69ECEBAE127].__defaultWidth = 960
CoD[0xA90B69ECEBAE127].__defaultHeight = 240
CoD[0xA90B69ECEBAE127].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0xA90B69ECEBAE127])
	self.id = "CallingCards_wz_Heroics_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0xC91C36E9A8B312A))
	self:addElement(bg)
	self.bg = bg
	local ParticlesBack = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	ParticlesBack:setImage(RegisterImage(0xB68E3112EFC739D))
	ParticlesBack:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	ParticlesBack:setShaderVector(0, 1, 1, 0, 0)
	ParticlesBack:setShaderVector(1, 0, -0.1, 0, 0)
	self:addElement(ParticlesBack)
	self.ParticlesBack = ParticlesBack
	local ParticlesFront = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	ParticlesFront:setImage(RegisterImage(0xE8D4F3F1117DE49))
	ParticlesFront:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	ParticlesFront:setShaderVector(0, 1, 1, 0, 0)
	ParticlesFront:setShaderVector(1, 0, -0.25, 0, 0)
	self:addElement(ParticlesFront)
	self.ParticlesFront = ParticlesFront
	local BlackSmoke = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BlackSmoke:setImage(RegisterImage(0x470B2630EA26787))
	BlackSmoke:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	BlackSmoke:setShaderVector(0, 0, 5, 0, 0)
	BlackSmoke:setShaderVector(1, 5, 0, 0, 0)
	self:addElement(BlackSmoke)
	self.BlackSmoke = BlackSmoke
	local BlackSmoke2 = LUI.UIImage.new(0, 0, -265, 695, 0, 0, 33, 273)
	BlackSmoke2:setScale(1.38, 0.8)
	BlackSmoke2:setImage(RegisterImage(0x470B2630EA26787))
	BlackSmoke2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	BlackSmoke2:setShaderVector(0, 0, 5, 0, 0)
	BlackSmoke2:setShaderVector(1, 5, 0, 0, 0)
	self:addElement(BlackSmoke2)
	self.BlackSmoke2 = BlackSmoke2
	local soldier1 = LUI.UIImage.new(0, 0, 480, 856, 0, 0, 0, 240)
	soldier1:setImage(RegisterImage(0x9ED06E1713767EF))
	self:addElement(soldier1)
	self.soldier1 = soldier1
	local soldier2 = LUI.UIImage.new(0, 0, 480, 856, 0, 0, 0, 240)
	soldier2:setImage(RegisterImage(0x9ED07E1713769A2))
	self:addElement(soldier2)
	self.soldier2 = soldier2
	local glows = LUI.UIImage.new(0, 0, -17, 943, 0, 0, 0, 240)
	glows:setAlpha(0.4)
	glows:setImage(RegisterImage(0xF5CCACC23C817D7))
	glows:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	glows:setShaderVector(0, 0, 3, 0, 0)
	glows:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(glows)
	self.glows = glows
	local bullets = LUI.UIImage.new(0, 0, 330, 562, 0, 0, 91, 165)
	bullets:setZRot(7)
	bullets:setScale(0.8, 1)
	bullets:setImage(RegisterImage(0x9395081C1C3E0B1))
	bullets:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	bullets:setShaderVector(0, 0, 6, 0, 0)
	bullets:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(bullets)
	self.bullets = bullets
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0xA90B69ECEBAE127].__resetProperties = function(f2_arg0)
	f2_arg0.soldier1:completeAnimation()
	f2_arg0.soldier2:completeAnimation()
	f2_arg0.glows:completeAnimation()
	f2_arg0.bullets:completeAnimation()
	f2_arg0.soldier1:setAlpha(1)
	f2_arg0.soldier2:setAlpha(1)
	f2_arg0.glows:setAlpha(0.4)
	f2_arg0.bullets:setAlpha(1)
end
CoD[0xA90B69ECEBAE127].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											local f11_local0 = function(f12_arg0)
												f12_arg0:beginAnimation(89)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f11_arg0:beginAnimation(9)
											f11_arg0:setAlpha(1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(690)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(9)
									f9_arg0:setAlpha(0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(590)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(9)
							f7_arg0:setAlpha(1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(600)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(9)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.soldier1:beginAnimation(990)
				f3_arg0.soldier1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.soldier1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.soldier1:completeAnimation()
			f3_arg0.soldier1:setAlpha(1)
			f3_local0(f3_arg0.soldier1)
			local f3_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								local f17_local0 = function(f18_arg0)
									local f18_local0 = function(f19_arg0)
										local f19_local0 = function(f20_arg0)
											local f20_local0 = function(f21_arg0)
												f21_arg0:beginAnimation(89)
												f21_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f20_arg0:beginAnimation(9)
											f20_arg0:setAlpha(0)
											f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
										end
										f19_arg0:beginAnimation(690)
										f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
									end
									f18_arg0:beginAnimation(9)
									f18_arg0:setAlpha(1)
									f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
								end
								f17_arg0:beginAnimation(590)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
							end
							f16_arg0:beginAnimation(9)
							f16_arg0:setAlpha(0)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(600)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(9)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f3_arg0.soldier2:beginAnimation(990)
				f3_arg0.soldier2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.soldier2:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.soldier2:completeAnimation()
			f3_arg0.soldier2:setAlpha(0)
			f3_local1(f3_arg0.soldier2)
			local f3_local2 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							local f25_local0 = function(f26_arg0)
								local f26_local0 = function(f27_arg0)
									local f27_local0 = function(f28_arg0)
										local f28_local0 = function(f29_arg0)
											local f29_local0 = function(f30_arg0)
												f30_arg0:beginAnimation(89)
												f30_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f29_arg0:beginAnimation(9)
											f29_arg0:setAlpha(0)
											f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
										end
										f28_arg0:beginAnimation(690)
										f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
									end
									f27_arg0:beginAnimation(9)
									f27_arg0:setAlpha(0.4)
									f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
								end
								f26_arg0:beginAnimation(590)
								f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
							end
							f25_arg0:beginAnimation(9)
							f25_arg0:setAlpha(0)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
						end
						f24_arg0:beginAnimation(600)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(9)
					f23_arg0:setAlpha(0.4)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f3_arg0.glows:beginAnimation(990)
				f3_arg0.glows:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.glows:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f3_arg0.glows:completeAnimation()
			f3_arg0.glows:setAlpha(0)
			f3_local2(f3_arg0.glows)
			local f3_local3 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						local f33_local0 = function(f34_arg0)
							local f34_local0 = function(f35_arg0)
								local f35_local0 = function(f36_arg0)
									local f36_local0 = function(f37_arg0)
										local f37_local0 = function(f38_arg0)
											local f38_local0 = function(f39_arg0)
												f39_arg0:beginAnimation(89)
												f39_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f38_arg0:beginAnimation(9)
											f38_arg0:setAlpha(0)
											f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
										end
										f37_arg0:beginAnimation(690)
										f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
									end
									f36_arg0:beginAnimation(9)
									f36_arg0:setAlpha(1)
									f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
								end
								f35_arg0:beginAnimation(590)
								f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
							end
							f34_arg0:beginAnimation(9)
							f34_arg0:setAlpha(0)
							f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
						end
						f33_arg0:beginAnimation(600)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
					end
					f32_arg0:beginAnimation(9)
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f3_arg0.bullets:beginAnimation(990)
				f3_arg0.bullets:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bullets:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f3_arg0.bullets:completeAnimation()
			f3_arg0.bullets:setAlpha(0)
			f3_local3(f3_arg0.bullets)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
