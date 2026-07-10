CoD.SystemOverlaySpinner = InheritFrom(LUI.UIElement)
CoD.SystemOverlaySpinner.__defaultWidth = 448
CoD.SystemOverlaySpinner.__defaultHeight = 21
CoD.SystemOverlaySpinner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SystemOverlaySpinner)
	self.id = "SystemOverlaySpinner"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image1 = LUI.UIImage.new(0, 0.32, 0, 0, 0, 1, 0, 0)
	Image1:setRGB(1, 0.68, 0)
	self:addElement(Image1)
	self.Image1 = Image1
	local Image10 = LUI.UIImage.new(0.34, 0.66, 0, 0, 0, 1, 0, 0)
	Image10:setRGB(1, 0.68, 0)
	Image10:setAlpha(0.5)
	self:addElement(Image10)
	self.Image10 = Image10
	local Image100 = LUI.UIImage.new(0.68, 1, 0, 0, 0, 1, 0, 0)
	Image100:setRGB(1, 0.68, 0)
	Image100:setAlpha(0.25)
	self:addElement(Image100)
	self.Image100 = Image100
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SystemOverlaySpinner.__resetProperties = function(f2_arg0)
	f2_arg0.Image1:completeAnimation()
	f2_arg0.Image10:completeAnimation()
	f2_arg0.Image100:completeAnimation()
	f2_arg0.Image1:setAlpha(1)
	f2_arg0.Image10:setAlpha(0.5)
	f2_arg0.Image100:setAlpha(0.25)
end
CoD.SystemOverlaySpinner.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(229)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(370)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f5_arg0:setAlpha(0.7)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Image1:beginAnimation(80, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.Image1:setAlpha(0.07)
				f3_arg0.Image1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Image1:completeAnimation()
			f3_arg0.Image1:setAlpha(0)
			f3_local0(f3_arg0.Image1)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(219)
							f11_arg0:setAlpha(0)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(220)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(110, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f9_arg0:setAlpha(0.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.Image10:beginAnimation(220)
				f3_arg0.Image10:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image10:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.Image10:completeAnimation()
			f3_arg0.Image10:setAlpha(0)
			f3_local1(f3_arg0.Image10)
			local f3_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							f15_arg0:beginAnimation(139)
							f15_arg0:setAlpha(0)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f14_arg0:beginAnimation(130)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(89, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f13_arg0:setAlpha(0.25)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.Image100:beginAnimation(330)
				f3_arg0.Image100:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image100:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.Image100:completeAnimation()
			f3_arg0.Image100:setAlpha(0)
			f3_local2(f3_arg0.Image100)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
