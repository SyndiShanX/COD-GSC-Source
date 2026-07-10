CoD.lmgInfiniteReticle_light = InheritFrom(LUI.UIElement)
CoD.lmgInfiniteReticle_light.__defaultWidth = 94
CoD.lmgInfiniteReticle_light.__defaultHeight = 129
CoD.lmgInfiniteReticle_light.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.lmgInfiniteReticle_light)
	self.id = "lmgInfiniteReticle_light"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lights100 = LUI.UIImage.new(0, 0, 0, 94, 0, 0, 0, 129)
	lights100:setImage(RegisterImage(@"uie_t7_weapon_lmg_lights_02"))
	lights100:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	lights100:setShaderVector(0, 0.85, 1, 0, 0)
	lights100:setShaderVector(1, 0.13, 0.05, 0, 0)
	lights100:setShaderVector(2, 0, 1, 0, 0)
	lights100:setShaderVector(3, 0, 0, 0, 0)
	lights100:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(lights100)
	self.lights100 = lights100
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.lmgInfiniteReticle_light.__resetProperties = function(f2_arg0)
	f2_arg0.lights100:completeAnimation()
	f2_arg0.lights100:setAlpha(1)
	f2_arg0.lights100:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	f2_arg0.lights100:setShaderVector(0, 0.85, 1, 0, 0)
	f2_arg0.lights100:setShaderVector(1, 0.13, 0.05, 0, 0)
	f2_arg0.lights100:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.lights100:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.lights100:setShaderVector(4, 0, 0, 0, 0)
end
CoD.lmgInfiniteReticle_light.__clipsPerState = {
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
											f11_arg0:beginAnimation(250)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f10_arg0:beginAnimation(149)
										f10_arg0:setShaderVector(0, 0.85, 1, 0, 0)
										f10_arg0:setShaderVector(1, 0.13, 0.05, 0, 0)
										f10_arg0:setShaderVector(2, 0, 1, 0, 0)
										f10_arg0:setShaderVector(3, 0, 0, 0, 0)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(110)
									f9_arg0:setShaderVector(0, 0.7, 0.85, 0, 0)
									f9_arg0:setShaderVector(1, 0.12, 0.07, 0, 0)
									f9_arg0:setShaderVector(2, 0.19, 0.81, 0, 0)
									f9_arg0:setShaderVector(3, 0.1, 0.1, 0, 0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(10)
								f8_arg0:setShaderVector(0, 0.51, 0.67, 0, 0)
								f8_arg0:setShaderVector(1, 0.1, 0.1, 0, 0)
								f8_arg0:setShaderVector(2, 0.19, 0.81, 0, 0)
								f8_arg0:setShaderVector(3, 0.4, 0.4, 0, 0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(240)
							f7_arg0:setAlpha(1)
							f7_arg0:setShaderVector(0, 0.5, 0.65, 0, 0)
							f7_arg0:setShaderVector(1, 0.1, 0.1, 0, 0)
							f7_arg0:setShaderVector(2, 0.06, 0.94, 0, 0)
							f7_arg0:setShaderVector(3, 0.09, 0.17, 0, 0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(49)
						f6_arg0:setAlpha(0.5)
						f6_arg0:setShaderVector(0, 0.3, 0.48, 0, 0)
						f6_arg0:setShaderVector(1, 0.1, 0.1, 0, 0)
						f6_arg0:setShaderVector(2, 0.19, 0.81, 0, 0)
						f6_arg0:setShaderVector(3, 0.13, 0.25, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(39)
					f5_arg0:setAlpha(0.4)
					f5_arg0:setShaderVector(0, 0.19, 0.39, 0, 0)
					f5_arg0:setShaderVector(1, 0.1, 0.1, 0, 0)
					f5_arg0:setShaderVector(2, 0.11, 0.89, 0, 0)
					f5_arg0:setShaderVector(3, 0.16, 0.29, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.lights100:beginAnimation(150)
				f3_arg0.lights100:setAlpha(0.31)
				f3_arg0.lights100:setShaderVector(0, 0.11, 0.31, 0, 0)
				f3_arg0.lights100:setShaderVector(1, 0.1, 0.1, 0, 0)
				f3_arg0.lights100:setShaderVector(2, 0.19, 0.81, 0, 0)
				f3_arg0.lights100:setShaderVector(3, 0.18, 0.33, 0, 0)
				f3_arg0.lights100:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lights100:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.lights100:completeAnimation()
			f3_arg0.lights100:setAlpha(0)
			f3_arg0.lights100:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
			f3_arg0.lights100:setShaderVector(0, 0, 0.22, 0, 0)
			f3_arg0.lights100:setShaderVector(1, 0.1, 0.1, 0, 0)
			f3_arg0.lights100:setShaderVector(2, 0.14, 0.86, 0, 0)
			f3_arg0.lights100:setShaderVector(3, 0.2, 0.37, 0, 0)
			f3_arg0.lights100:setShaderVector(4, 0, 0, 0, 0)
			f3_local0(f3_arg0.lights100)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
