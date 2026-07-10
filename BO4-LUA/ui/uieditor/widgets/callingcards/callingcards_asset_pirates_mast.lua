require("x64:368f532cc98a68a")
CoD.CallingCards_Asset_Pirates_Mast = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_Pirates_Mast.__defaultWidth = 1000
CoD.CallingCards_Asset_Pirates_Mast.__defaultHeight = 280
CoD.CallingCards_Asset_Pirates_Mast.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_Pirates_Mast)
	self.id = "CallingCards_Asset_Pirates_Mast"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local mast = LUI.UIImage.new(0, 0, 0, 1000, 0, 0, 0, 280)
	mast:setImage(RegisterImage(0x3D1A4E4E0179D0A))
	self:addElement(mast)
	self.mast = mast
	local flag = CoD.CallingCards_Asset_Pirates_Flag.new(f1_arg0, f1_arg1, 0, 0, 681.5, 691.5, 0, 0, 68, 78)
	self:addElement(flag)
	self.flag = flag
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_Pirates_Mast.__resetProperties = function(f2_arg0)
	f2_arg0.flag:completeAnimation()
	f2_arg0.flag:setZRot(0)
	f2_arg0.flag:setScale(1, 1)
end
CoD.CallingCards_Asset_Pirates_Mast.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(480, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f7_arg0:setZRot(3)
							f7_arg0:setScale(0.9, 1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(520, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f6_arg0:setZRot(-3)
						f6_arg0:setScale(1, 1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f5_arg0:setZRot(3)
					f5_arg0:setScale(0.9, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.flag:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.flag:setZRot(-6)
				f3_arg0.flag:setScale(1, 1)
				f3_arg0.flag:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.flag:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.flag:completeAnimation()
			f3_arg0.flag:setZRot(3)
			f3_arg0.flag:setScale(0.9, 1)
			f3_local0(f3_arg0.flag)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.CallingCards_Asset_Pirates_Mast.__onClose = function(f8_arg0)
	f8_arg0.flag:close()
end
