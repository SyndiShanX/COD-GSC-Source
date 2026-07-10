CoD.CallingCards_Asset_future_car = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_future_car.__defaultWidth = 720
CoD.CallingCards_Asset_future_car.__defaultHeight = 180
CoD.CallingCards_Asset_future_car.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_future_car)
	self.id = "CallingCards_Asset_future_car"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local car = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	car:setImage(RegisterImage(0xCDAF062AD7C6AB1))
	self:addElement(car)
	self.car = car
	local carWhite2 = LUI.UIImage.new(0, 0, 0, 720, 0, 0, 0, 180)
	carWhite2:setAlpha(0.8)
	carWhite2:setImage(RegisterImage(0x1C2F9314BCAAD47))
	carWhite2:setMaterial(LUI.UIImage.GetCachedMaterial(0xB760921EE6B05E1))
	carWhite2:setShaderVector(0, 1.02, 0.67, 0, 0)
	carWhite2:setShaderVector(1, 1.6, 0, 0, 0)
	carWhite2:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(carWhite2)
	self.carWhite2 = carWhite2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_future_car.__resetProperties = function(f2_arg0)
	f2_arg0.carWhite2:completeAnimation()
	f2_arg0.car:completeAnimation()
	f2_arg0.carWhite2:setRGB(1, 1, 1)
	f2_arg0.carWhite2:setAlpha(0.8)
	f2_arg0.carWhite2:setShaderVector(0, 1.02, 0.67, 0, 0)
	f2_arg0.carWhite2:setShaderVector(1, 1.6, 0, 0, 0)
	f2_arg0.carWhite2:setShaderVector(2, 1, 0, 0, 0)
	f2_arg0.car:setAlpha(1)
	f2_arg0.car:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
end
CoD.CallingCards_Asset_future_car.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.car:completeAnimation()
			f3_arg0.car:setAlpha(1)
			f3_arg0.car:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
			f3_arg0.clipFinished(f3_arg0.car)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											f11_arg0:beginAnimation(470)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f10_arg0:beginAnimation(520)
										f10_arg0:setShaderVector(0, -0.51, 0.15, 0, 0)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(530)
									f9_arg0:setShaderVector(0, 0.13, 0.24, 0, 0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(510)
								f8_arg0:setShaderVector(0, 0.29, 0.24, 0, 0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(450)
							f7_arg0:setShaderVector(0, 0.44, 0.25, 0, 0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(729)
						f6_arg0:setShaderVector(0, 0.61, 0.34, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(400)
					f5_arg0:setShaderVector(0, 0.85, 0.57, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.carWhite2:beginAnimation(400)
				f3_arg0.carWhite2:setShaderVector(0, 1.02, 0.67, 0, 0)
				f3_arg0.carWhite2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.carWhite2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.carWhite2:completeAnimation()
			f3_arg0.carWhite2:setRGB(1, 1, 1)
			f3_arg0.carWhite2:setAlpha(0.35)
			f3_arg0.carWhite2:setShaderVector(0, 1.67, 0.82, 0, 0)
			f3_arg0.carWhite2:setShaderVector(1, 1.6, 0, 0, 0)
			f3_arg0.carWhite2:setShaderVector(2, 1, 0, 0, 0)
			f3_local0(f3_arg0.carWhite2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
