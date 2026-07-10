CoD.VehicleGround_CenterInnerRingElement = InheritFrom(LUI.UIElement)
CoD.VehicleGround_CenterInnerRingElement.__defaultWidth = 85
CoD.VehicleGround_CenterInnerRingElement.__defaultHeight = 103
CoD.VehicleGround_CenterInnerRingElement.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_CenterInnerRingElement)
	self.id = "VehicleGround_CenterInnerRingElement"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InnerRingElement = LUI.UIImage.new(1, 1, -48, 0, 0, 0, 0, 48)
	InnerRingElement:setAlpha(0.5)
	InnerRingElement:setImage(RegisterImage(0xCE6420999415091))
	InnerRingElement:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(InnerRingElement)
	self.InnerRingElement = InnerRingElement
	local Image0 = LUI.UIImage.new(0, 0, 0, 12, 1, 1, -12, 0)
	Image0:setAlpha(0.5)
	Image0:setImage(RegisterImage(0xE727EABAB9FC602))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_CenterInnerRingElement.__resetProperties = function(f2_arg0)
	f2_arg0.Image0:completeAnimation()
	f2_arg0.Image0:setAlpha(0.5)
end
CoD.VehicleGround_CenterInnerRingElement.__clipsPerState = {
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
											f11_arg0:beginAnimation(740)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f10_arg0:beginAnimation(9)
										f10_arg0:setAlpha(1)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(110)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(9)
								f8_arg0:setAlpha(0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(120)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(240)
						f6_arg0:setAlpha(0.5)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(80)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Image0:beginAnimation(290)
				f3_arg0.Image0:setAlpha(0)
				f3_arg0.Image0:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Image0:completeAnimation()
			f3_arg0.Image0:setAlpha(1)
			f3_local0(f3_arg0.Image0)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
