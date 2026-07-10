require("x64:9f30ccf57885c6a")
require("x64:a4f0aa4e3a1e010")
CoD.AmmoWidgetMP_ClipContainerNew = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_ClipContainerNew.__defaultWidth = 64
CoD.AmmoWidgetMP_ClipContainerNew.__defaultHeight = 26
CoD.AmmoWidgetMP_ClipContainerNew.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_ClipContainerNew)
	self.id = "AmmoWidgetMP_ClipContainerNew"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Clip = CoD.AmmoWidget_ClipContainerValue.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Clip:setRGB(1, 0.54, 0.54)
	Clip.Clip:setText(CoD.BaseUtility.NonStringWorkaround(33))
	self:addElement(Clip)
	self.Clip = Clip
	local ClipContainerPress = CoD.AmmoWidget_ClipContainerPress.new(f1_arg0, f1_arg1, 0, 1, -52, -52, 0, 1, -8, -8)
	ClipContainerPress:mergeStateConditions({
		{
			stateName = "NoAmmoPress",
			condition = function(menu, element, event)
				return PulseNoAmmo(f1_arg1)
			end,
		},
	})
	local f1_local3 = ClipContainerPress
	local Bounce = ClipContainerPress.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	Bounce(f1_local3, f1_local5["hudItems.pulseNoAmmo"], function(f3_arg0)
		f1_arg0:updateElementState(ClipContainerPress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.pulseNoAmmo",
		})
	end, false)
	ClipContainerPress.Clip:setText(CoD.BaseUtility.NonStringWorkaround(33))
	self:addElement(ClipContainerPress)
	self.ClipContainerPress = ClipContainerPress
	Bounce = LUI.UIImage.new(0, 0, -9.5, 64.5, 0, 0, -19, 9)
	Bounce:setAlpha(0)
	Bounce:setImage(RegisterImage(@"hash_711B3A87BB555593"))
	Bounce:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Bounce)
	self.Bounce = Bounce
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetMP_ClipContainerNew.__resetProperties = function(f4_arg0)
	f4_arg0.Clip:completeAnimation()
	f4_arg0.ClipContainerPress:completeAnimation()
	f4_arg0.Bounce:completeAnimation()
	f4_arg0.Clip:setLeftRight(0, 1, 0, 0)
	f4_arg0.Clip:setTopBottom(0, 1, 0, 0)
	f4_arg0.Clip:setRGB(1, 0.54, 0.54)
	f4_arg0.Clip:setAlpha(1)
	f4_arg0.Clip:setScale(1, 1)
	f4_arg0.Clip.Clip:setShaderVector(0, 0.8, 0, 0, 0)
	f4_arg0.Clip.Clip:setShaderVector(2, 1, 1, 1, 0.25)
	f4_arg0.ClipContainerPress:setRGB(1, 1, 1)
	f4_arg0.ClipContainerPress:setAlpha(1)
	f4_arg0.Bounce:setRGB(1, 1, 1)
	f4_arg0.Bounce:setAlpha(0)
end
CoD.AmmoWidgetMP_ClipContainerNew.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Clip:completeAnimation()
			f5_arg0.Clip.Clip:completeAnimation()
			f5_arg0.Clip:setRGB(0.94, 0.94, 0.94)
			f5_arg0.Clip.Clip:setShaderVector(2, 1, 1, 1, 0.25)
			f5_arg0.clipFinished(f5_arg0.Clip)
			f5_arg0.ClipContainerPress:completeAnimation()
			f5_arg0.ClipContainerPress:setRGB(0.83, 0.86, 0.9)
			f5_arg0.clipFinished(f5_arg0.ClipContainerPress)
		end,
		LowAmmo = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							local f10_local0 = function(f11_arg0)
								local f11_local0 = function(f12_arg0)
									local f12_local0 = function(f13_arg0)
										local f13_local0 = function(f14_arg0)
											f14_arg0:beginAnimation(10)
											f14_arg0:setRGB(0.94, 0.07, 0.09)
											f14_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
										end
										f13_arg0:beginAnimation(19)
										f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
									end
									f12_arg0:beginAnimation(10)
									f12_arg0:setRGB(0.83, 0.19, 0.23)
									f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
								end
								f11_arg0:beginAnimation(19)
								f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
							end
							f10_arg0:beginAnimation(10)
							f10_arg0:setRGB(0.94, 0.07, 0.09)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
						end
						f9_arg0:beginAnimation(19)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(9)
					f8_arg0:setRGB(0.69, 0.36, 0.42)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.Clip:beginAnimation(100)
				f6_arg0.Clip:setRGB(0.94, 0.07, 0.09)
				f6_arg0.Clip:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Clip:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.Clip:completeAnimation()
			f6_arg0.Clip.Clip:completeAnimation()
			f6_arg0.Clip:setRGB(0.94, 0.94, 0.94)
			f6_arg0.Clip.Clip:setShaderVector(2, 1, 0, 0, 0.25)
			f6_local0(f6_arg0.Clip)
		end,
		Hero = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						local f18_local0 = function(f19_arg0)
							local f19_local0 = function(f20_arg0)
								local f20_local0 = function(f21_arg0)
									local f21_local0 = function(f22_arg0)
										local f22_local0 = function(f23_arg0)
											f23_arg0:beginAnimation(10)
											f23_arg0:setRGB(1, 0.7, 0)
											f23_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
										end
										f22_arg0:beginAnimation(19)
										f22_arg0:setRGB(0.8, 0.62, 0.18)
										f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
									end
									f21_arg0:beginAnimation(10)
									f21_arg0:setRGB(0.81, 0.62, 0.19)
									f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
								end
								f20_arg0:beginAnimation(19)
								f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
							end
							f19_arg0:beginAnimation(10)
							f19_arg0:setRGB(1, 0.7, 0)
							f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
						end
						f18_arg0:beginAnimation(19)
						f18_arg0:setRGB(0.66, 0.55, 0.29)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
					end
					f17_arg0:beginAnimation(9)
					f17_arg0:setRGB(0.66, 0.55, 0.29)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f15_arg0.Clip:beginAnimation(100)
				f15_arg0.Clip:setRGB(1, 0.7, 0)
				f15_arg0.Clip:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Clip:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.Clip:completeAnimation()
			f15_arg0.Clip.Clip:completeAnimation()
			f15_arg0.Clip:setRGB(0.94, 0.94, 0.94)
			f15_arg0.Clip.Clip:setShaderVector(2, 1, 0.7, 0, 0.25)
			f15_local0(f15_arg0.Clip)
		end,
		NoAmmo = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						local f27_local0 = function(f28_arg0)
							local f28_local0 = function(f29_arg0)
								local f29_local0 = function(f30_arg0)
									local f30_local0 = function(f31_arg0)
										local f31_local0 = function(f32_arg0)
											f32_arg0:beginAnimation(10)
											f32_arg0:setRGB(0.94, 0.07, 0.09)
											f32_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
										end
										f31_arg0:beginAnimation(19)
										f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
									end
									f30_arg0:beginAnimation(10)
									f30_arg0:setRGB(0.83, 0.19, 0.23)
									f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
								end
								f29_arg0:beginAnimation(19)
								f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
							end
							f28_arg0:beginAnimation(10)
							f28_arg0:setRGB(0.94, 0.07, 0.09)
							f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
						end
						f27_arg0:beginAnimation(19)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
					end
					f26_arg0:beginAnimation(9)
					f26_arg0:setRGB(0.69, 0.36, 0.42)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f24_arg0.Clip:beginAnimation(100)
				f24_arg0.Clip:setRGB(0.94, 0.07, 0.09)
				f24_arg0.Clip:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Clip:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.Clip:completeAnimation()
			f24_arg0.Clip.Clip:completeAnimation()
			f24_arg0.Clip:setRGB(0.94, 0.94, 0.94)
			f24_arg0.Clip.Clip:setShaderVector(2, 1, 0, 0, 0.25)
			f24_local0(f24_arg0.Clip)
			local f24_local1 = function(f33_arg0)
				f24_arg0.ClipContainerPress:beginAnimation(120)
				f24_arg0.ClipContainerPress:setAlpha(1)
				f24_arg0.ClipContainerPress:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.ClipContainerPress:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.ClipContainerPress:completeAnimation()
			f24_arg0.ClipContainerPress:setAlpha(0)
			f24_local1(f24_arg0.ClipContainerPress)
		end,
	},
	Hidden = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.Clip:completeAnimation()
			f34_arg0.Clip:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Clip)
			f34_arg0.Bounce:completeAnimation()
			f34_arg0.Bounce:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Bounce)
		end,
	},
	LowAmmo = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			local f35_local0 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					local f37_local0 = function(f38_arg0)
						f38_arg0:beginAnimation(250)
						f38_arg0:setRGB(1, 0, 0)
						f38_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
					end
					f37_arg0:beginAnimation(250)
					f37_arg0:setRGB(0.99, 0.58, 0.58)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
				end
				f35_arg0.Clip:beginAnimation(500)
				f35_arg0.Clip:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Clip:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f35_arg0.Clip:completeAnimation()
			f35_arg0.Clip.Clip:completeAnimation()
			f35_arg0.Clip:setRGB(0.94, 0.07, 0.09)
			f35_arg0.Clip.Clip:setShaderVector(2, 1, 0, 0, 0.5)
			f35_local0(f35_arg0.Clip)
			f35_arg0.Bounce:completeAnimation()
			f35_arg0.Bounce:setRGB(1, 0, 0)
			f35_arg0.Bounce:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.Bounce)
			f35_arg0.nextClip = "DefaultClip"
		end,
		Hero = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			local f39_local0 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					local f41_local0 = function(f42_arg0)
						local f42_local0 = function(f43_arg0)
							local f43_local0 = function(f44_arg0)
								local f44_local0 = function(f45_arg0)
									local f45_local0 = function(f46_arg0)
										local f46_local0 = function(f47_arg0)
											f47_arg0:beginAnimation(10)
											f47_arg0:setRGB(1, 0.7, 0)
											f47_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
										end
										f46_arg0:beginAnimation(19)
										f46_arg0:setRGB(0.94, 0.07, 0.09)
										f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
									end
									f45_arg0:beginAnimation(10)
									f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
								end
								f44_arg0:beginAnimation(19)
								f44_arg0:setRGB(0.83, 0.19, 0.23)
								f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
							end
							f43_arg0:beginAnimation(10)
							f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
						end
						f42_arg0:beginAnimation(19)
						f42_arg0:setRGB(0.94, 0.07, 0.09)
						f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
					end
					f41_arg0:beginAnimation(9)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
				end
				f39_arg0.Clip:beginAnimation(100)
				f39_arg0.Clip:setRGB(0.69, 0.36, 0.42)
				f39_arg0.Clip:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Clip:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f39_arg0.Clip:completeAnimation()
			f39_arg0.Clip:setRGB(0.94, 0.07, 0.09)
			f39_local0(f39_arg0.Clip)
		end,
		DefaultState = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
			local f48_local0 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					local f50_local0 = function(f51_arg0)
						local f51_local0 = function(f52_arg0)
							local f52_local0 = function(f53_arg0)
								local f53_local0 = function(f54_arg0)
									local f54_local0 = function(f55_arg0)
										local f55_local0 = function(f56_arg0)
											local f56_local0 = function(f57_arg0)
												f57_arg0:beginAnimation(10)
												f57_arg0:setRGB(0.83, 0.86, 0.9)
												f57_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
											end
											f56_arg0:beginAnimation(19)
											f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
										end
										f55_arg0:beginAnimation(9)
										f55_arg0:setRGB(0.63, 0.57, 0.66)
										f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
									end
									f54_arg0:beginAnimation(30)
									f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
								end
								f53_arg0:beginAnimation(10)
								f53_arg0:setRGB(0.83, 0.86, 0.9)
								f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
							end
							f52_arg0:beginAnimation(20)
							f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
						end
						f51_arg0:beginAnimation(10)
						f51_arg0:setRGB(0.69, 0.47, 0.55)
						f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
					end
					f50_arg0:beginAnimation(20)
					f50_arg0:setRGB(0.83, 0.86, 0.9)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
				end
				f48_arg0.Clip:beginAnimation(10)
				f48_arg0.Clip:setRGB(0.59, 0.64, 0.74)
				f48_arg0.Clip:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.Clip:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f48_arg0.Clip:completeAnimation()
			f48_arg0.Clip:setRGB(0.94, 0.07, 0.09)
			f48_arg0.Clip:setAlpha(1)
			f48_local0(f48_arg0.Clip)
			local f48_local1 = function(f58_arg0)
				f48_arg0.ClipContainerPress:beginAnimation(100)
				f48_arg0.ClipContainerPress:setAlpha(0)
				f48_arg0.ClipContainerPress:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.ClipContainerPress:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.ClipContainerPress:completeAnimation()
			f48_arg0.ClipContainerPress:setAlpha(1)
			f48_local1(f48_arg0.ClipContainerPress)
		end,
	},
	NoAmmo = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(3)
			local f59_local0 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					f61_arg0:beginAnimation(250)
					f61_arg0:setAlpha(1)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
				end
				f59_arg0.Clip:beginAnimation(250)
				f59_arg0.Clip:setAlpha(0.71)
				f59_arg0.Clip:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.Clip:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f59_arg0.Clip:completeAnimation()
			f59_arg0.Clip:setRGB(0.94, 0.07, 0.09)
			f59_arg0.Clip:setAlpha(1)
			f59_local0(f59_arg0.Clip)
			f59_arg0.ClipContainerPress:completeAnimation()
			f59_arg0.ClipContainerPress:setAlpha(1)
			f59_arg0.clipFinished(f59_arg0.ClipContainerPress)
			f59_arg0.Bounce:completeAnimation()
			f59_arg0.Bounce:setRGB(1, 0, 0)
			f59_arg0.Bounce:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.Bounce)
			f59_arg0.nextClip = "DefaultClip"
		end,
		Hero = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(2)
			local f62_local0 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					local f64_local0 = function(f65_arg0)
						local f65_local0 = function(f66_arg0)
							local f66_local0 = function(f67_arg0)
								local f67_local0 = function(f68_arg0)
									local f68_local0 = function(f69_arg0)
										local f69_local0 = function(f70_arg0)
											f70_arg0:beginAnimation(10)
											f70_arg0:setRGB(1, 0.7, 0)
											f70_arg0:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
										end
										f69_arg0:beginAnimation(19)
										f69_arg0:setRGB(0.94, 0.07, 0.09)
										f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
									end
									f68_arg0:beginAnimation(10)
									f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
								end
								f67_arg0:beginAnimation(19)
								f67_arg0:setRGB(0.83, 0.19, 0.23)
								f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
							end
							f66_arg0:beginAnimation(10)
							f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
						end
						f65_arg0:beginAnimation(19)
						f65_arg0:setRGB(0.94, 0.07, 0.09)
						f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
					end
					f64_arg0:beginAnimation(9)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
				end
				f62_arg0.Clip:beginAnimation(100)
				f62_arg0.Clip:setRGB(0.69, 0.36, 0.42)
				f62_arg0.Clip:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.Clip:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f62_arg0.Clip:completeAnimation()
			f62_arg0.Clip:setRGB(0.94, 0.07, 0.09)
			f62_local0(f62_arg0.Clip)
			local f62_local1 = function(f71_arg0)
				f62_arg0.ClipContainerPress:beginAnimation(120)
				f62_arg0.ClipContainerPress:setAlpha(0)
				f62_arg0.ClipContainerPress:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.ClipContainerPress:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.ClipContainerPress:completeAnimation()
			f62_arg0.ClipContainerPress:setAlpha(1)
			f62_local1(f62_arg0.ClipContainerPress)
		end,
		DefaultState = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(2)
			local f72_local0 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					local f74_local0 = function(f75_arg0)
						local f75_local0 = function(f76_arg0)
							local f76_local0 = function(f77_arg0)
								local f77_local0 = function(f78_arg0)
									local f78_local0 = function(f79_arg0)
										local f79_local0 = function(f80_arg0)
											local f80_local0 = function(f81_arg0)
												local f81_local0 = function(f82_arg0)
													f82_arg0:beginAnimation(10)
													f82_arg0:setRGB(0.83, 0.86, 0.9)
													f82_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
												end
												f81_arg0:beginAnimation(10)
												f81_arg0:setRGB(0.59, 0.64, 0.74)
												f81_arg0:registerEventHandler("transition_complete_keyframe", f81_local0)
											end
											f80_arg0:beginAnimation(19)
											f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
										end
										f79_arg0:beginAnimation(9)
										f79_arg0:setRGB(0.63, 0.57, 0.66)
										f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
									end
									f78_arg0:beginAnimation(30)
									f78_arg0:registerEventHandler("transition_complete_keyframe", f78_local0)
								end
								f77_arg0:beginAnimation(10)
								f77_arg0:setRGB(0.83, 0.86, 0.9)
								f77_arg0:registerEventHandler("transition_complete_keyframe", f77_local0)
							end
							f76_arg0:beginAnimation(20)
							f76_arg0:registerEventHandler("transition_complete_keyframe", f76_local0)
						end
						f75_arg0:beginAnimation(10)
						f75_arg0:setRGB(0.69, 0.47, 0.55)
						f75_arg0:registerEventHandler("transition_complete_keyframe", f75_local0)
					end
					f74_arg0:beginAnimation(20)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f74_local0)
				end
				f72_arg0.Clip:beginAnimation(10)
				f72_arg0.Clip:setRGB(0.83, 0.86, 0.9)
				f72_arg0.Clip:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.Clip:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f72_arg0.Clip:completeAnimation()
			f72_arg0.Clip:setRGB(0.94, 0.07, 0.09)
			f72_arg0.Clip:setAlpha(1)
			f72_local0(f72_arg0.Clip)
			f72_arg0.ClipContainerPress:completeAnimation()
			f72_arg0.ClipContainerPress:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.ClipContainerPress)
		end,
	},
	Hero = {
		DefaultClip = function(f83_arg0, f83_arg1)
			f83_arg0:__resetProperties()
			f83_arg0:setupElementClipCounter(2)
			f83_arg0.Clip:completeAnimation()
			f83_arg0.Clip.Clip:completeAnimation()
			f83_arg0.Clip:setLeftRight(0, 0, 0.5, 64.5)
			f83_arg0.Clip:setTopBottom(0, 0, 0, 26)
			f83_arg0.Clip:setRGB(0.91, 0.78, 0.28)
			f83_arg0.Clip:setAlpha(1)
			f83_arg0.Clip:setScale(1, 1)
			f83_arg0.Clip.Clip:setShaderVector(0, 0.4, 0, 0, 0)
			f83_arg0.Clip.Clip:setShaderVector(2, 0.6, 0.4, 0.1, 0.5)
			f83_arg0.clipFinished(f83_arg0.Clip)
			f83_arg0.Bounce:completeAnimation()
			f83_arg0.Bounce:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f83_arg0.clipFinished(f83_arg0.Bounce)
		end,
		LowAmmo = function(f84_arg0, f84_arg1)
			f84_arg0:__resetProperties()
			f84_arg0:setupElementClipCounter(1)
			local f84_local0 = function(f85_arg0)
				local f85_local0 = function(f86_arg0)
					local f86_local0 = function(f87_arg0)
						local f87_local0 = function(f88_arg0)
							local f88_local0 = function(f89_arg0)
								local f89_local0 = function(f90_arg0)
									local f90_local0 = function(f91_arg0)
										local f91_local0 = function(f92_arg0)
											f92_arg0:beginAnimation(10)
											f92_arg0:setRGB(0.94, 0.07, 0.09)
											f92_arg0:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
										end
										f91_arg0:beginAnimation(19)
										f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
									end
									f90_arg0:beginAnimation(10)
									f90_arg0:setRGB(0.83, 0.19, 0.23)
									f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
								end
								f89_arg0:beginAnimation(19)
								f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
							end
							f88_arg0:beginAnimation(10)
							f88_arg0:setRGB(0.94, 0.07, 0.09)
							f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
						end
						f87_arg0:beginAnimation(19)
						f87_arg0:registerEventHandler("transition_complete_keyframe", f87_local0)
					end
					f86_arg0:beginAnimation(9)
					f86_arg0:setRGB(0.69, 0.36, 0.42)
					f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
				end
				f84_arg0.Clip:beginAnimation(100)
				f84_arg0.Clip:setLeftRight(0, 0, 0, 0)
				f84_arg0.Clip:setRGB(0.94, 0.07, 0.09)
				f84_arg0.Clip:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.Clip:registerEventHandler("transition_complete_keyframe", f85_local0)
			end
			f84_arg0.Clip:completeAnimation()
			f84_arg0.Clip:setLeftRight(0, 0, 0, 64)
			f84_arg0.Clip:setTopBottom(0, 0, 0, 26)
			f84_arg0.Clip:setRGB(1, 0.7, 0)
			f84_local0(f84_arg0.Clip)
		end,
		NoAmmo = function(f93_arg0, f93_arg1)
			f93_arg0:__resetProperties()
			f93_arg0:setupElementClipCounter(2)
			local f93_local0 = function(f94_arg0)
				local f94_local0 = function(f95_arg0)
					local f95_local0 = function(f96_arg0)
						local f96_local0 = function(f97_arg0)
							local f97_local0 = function(f98_arg0)
								local f98_local0 = function(f99_arg0)
									local f99_local0 = function(f100_arg0)
										local f100_local0 = function(f101_arg0)
											f101_arg0:beginAnimation(10)
											f101_arg0:setRGB(0.94, 0.07, 0.09)
											f101_arg0:registerEventHandler("transition_complete_keyframe", f93_arg0.clipFinished)
										end
										f100_arg0:beginAnimation(19)
										f100_arg0:registerEventHandler("transition_complete_keyframe", f100_local0)
									end
									f99_arg0:beginAnimation(10)
									f99_arg0:setRGB(0.83, 0.19, 0.23)
									f99_arg0:registerEventHandler("transition_complete_keyframe", f99_local0)
								end
								f98_arg0:beginAnimation(19)
								f98_arg0:registerEventHandler("transition_complete_keyframe", f98_local0)
							end
							f97_arg0:beginAnimation(10)
							f97_arg0:setRGB(0.94, 0.07, 0.09)
							f97_arg0:registerEventHandler("transition_complete_keyframe", f97_local0)
						end
						f96_arg0:beginAnimation(19)
						f96_arg0:registerEventHandler("transition_complete_keyframe", f96_local0)
					end
					f95_arg0:beginAnimation(9)
					f95_arg0:setRGB(0.69, 0.36, 0.42)
					f95_arg0:registerEventHandler("transition_complete_keyframe", f95_local0)
				end
				f93_arg0.Clip:beginAnimation(100)
				f93_arg0.Clip:setRGB(0.94, 0.07, 0.09)
				f93_arg0.Clip:registerEventHandler("interrupted_keyframe", f93_arg0.clipInterrupted)
				f93_arg0.Clip:registerEventHandler("transition_complete_keyframe", f94_local0)
			end
			f93_arg0.Clip:completeAnimation()
			f93_arg0.Clip:setLeftRight(0, 0, 0, 64)
			f93_arg0.Clip:setTopBottom(0, 0, 0, 26)
			f93_arg0.Clip:setRGB(1, 0.7, 0)
			f93_local0(f93_arg0.Clip)
			local f93_local1 = function(f102_arg0)
				f93_arg0.ClipContainerPress:beginAnimation(120)
				f93_arg0.ClipContainerPress:setAlpha(1)
				f93_arg0.ClipContainerPress:registerEventHandler("interrupted_keyframe", f93_arg0.clipInterrupted)
				f93_arg0.ClipContainerPress:registerEventHandler("transition_complete_keyframe", f93_arg0.clipFinished)
			end
			f93_arg0.ClipContainerPress:completeAnimation()
			f93_arg0.ClipContainerPress:setAlpha(0)
			f93_local1(f93_arg0.ClipContainerPress)
		end,
		DefaultState = function(f103_arg0, f103_arg1)
			f103_arg0:__resetProperties()
			f103_arg0:setupElementClipCounter(1)
			local f103_local0 = function(f104_arg0)
				local f104_local0 = function(f105_arg0)
					local f105_local0 = function(f106_arg0)
						local f106_local0 = function(f107_arg0)
							local f107_local0 = function(f108_arg0)
								local f108_local0 = function(f109_arg0)
									local f109_local0 = function(f110_arg0)
										local f110_local0 = function(f111_arg0)
											f111_arg0:beginAnimation(10)
											f111_arg0:setRGB(0.94, 0.94, 0.94)
											f111_arg0:registerEventHandler("transition_complete_keyframe", f103_arg0.clipFinished)
										end
										f110_arg0:beginAnimation(19)
										f110_arg0:setRGB(1, 0.7, 0)
										f110_arg0:registerEventHandler("transition_complete_keyframe", f110_local0)
									end
									f109_arg0:beginAnimation(10)
									f109_arg0:setRGB(0.8, 0.62, 0.18)
									f109_arg0:registerEventHandler("transition_complete_keyframe", f109_local0)
								end
								f108_arg0:beginAnimation(19)
								f108_arg0:setRGB(0.81, 0.62, 0.19)
								f108_arg0:registerEventHandler("transition_complete_keyframe", f108_local0)
							end
							f107_arg0:beginAnimation(10)
							f107_arg0:registerEventHandler("transition_complete_keyframe", f107_local0)
						end
						f106_arg0:beginAnimation(19)
						f106_arg0:setRGB(1, 0.7, 0)
						f106_arg0:registerEventHandler("transition_complete_keyframe", f106_local0)
					end
					f105_arg0:beginAnimation(9)
					f105_arg0:setRGB(0.66, 0.55, 0.29)
					f105_arg0:registerEventHandler("transition_complete_keyframe", f105_local0)
				end
				f103_arg0.Clip:beginAnimation(100)
				f103_arg0.Clip:setRGB(0.66, 0.55, 0.29)
				f103_arg0.Clip:registerEventHandler("interrupted_keyframe", f103_arg0.clipInterrupted)
				f103_arg0.Clip:registerEventHandler("transition_complete_keyframe", f104_local0)
			end
			f103_arg0.Clip:completeAnimation()
			f103_arg0.Clip:setLeftRight(0, 0, 0, 64)
			f103_arg0.Clip:setTopBottom(0, 0, 0, 26)
			f103_arg0.Clip:setRGB(1, 0.7, 0)
			f103_local0(f103_arg0.Clip)
		end,
	},
}
CoD.AmmoWidgetMP_ClipContainerNew.__onClose = function(f112_arg0)
	f112_arg0.Clip:close()
	f112_arg0.ClipContainerPress:close()
end
