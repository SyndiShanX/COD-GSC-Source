CoD.CallingCards_Asset_warwheel = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_warwheel.__defaultWidth = 1024
CoD.CallingCards_Asset_warwheel.__defaultHeight = 1024
CoD.CallingCards_Asset_warwheel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_warwheel)
	self.id = "CallingCards_Asset_warwheel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local warWheel = LUI.UIImage.new(0, 0, 0, 1024, 0, 0, 0, 1024)
	warWheel:setRGB(0.09, 0.09, 0.09)
	warWheel:setScale(0.5, 0.5)
	warWheel:setImage(RegisterImage(0x1CCB5F658ADB6CD))
	self:addElement(warWheel)
	self.warWheel = warWheel
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_warwheel.__resetProperties = function(f2_arg0)
	f2_arg0.warWheel:completeAnimation()
	f2_arg0.warWheel:setZRot(0)
end
CoD.CallingCards_Asset_warwheel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(3979)
							f7_arg0:setZRot(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(4000)
						f6_arg0:setZRot(90)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(3989)
					f5_arg0:setZRot(180)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.warWheel:beginAnimation(4010)
				f3_arg0.warWheel:setZRot(270)
				f3_arg0.warWheel:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.warWheel:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.warWheel:completeAnimation()
			f3_arg0.warWheel:setZRot(360)
			f3_local0(f3_arg0.warWheel)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
