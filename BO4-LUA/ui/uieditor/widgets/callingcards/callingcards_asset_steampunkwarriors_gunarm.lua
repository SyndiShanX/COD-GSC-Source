require("x64:37a0b77f84c105b")
CoD.CallingCards_Asset_steampunkwarriors_gunarm = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_steampunkwarriors_gunarm.__defaultWidth = 10
CoD.CallingCards_Asset_steampunkwarriors_gunarm.__defaultHeight = 10
CoD.CallingCards_Asset_steampunkwarriors_gunarm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_steampunkwarriors_gunarm)
	self.id = "CallingCards_Asset_steampunkwarriors_gunarm"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arm = LUI.UIImage.new(0, 0, -204, 28, 0, 0, -12.5, 67.5)
	arm:setImage(RegisterImage(0x3C51811F0DDA462))
	self:addElement(arm)
	self.arm = arm
	local gun = CoD.CallingCards_Asset_steampunkwarriors_gun.new(f1_arg0, f1_arg1, 0, 0, -199.5, -189.5, 0, 0, 39.5, 49.5)
	self:addElement(gun)
	self.gun = gun
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_steampunkwarriors_gunarm.__resetProperties = function(f2_arg0)
	f2_arg0.gun:completeAnimation()
	f2_arg0.gun:setZRot(0)
end
CoD.CallingCards_Asset_steampunkwarriors_gunarm.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(1510)
							f7_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
								element:playClip("DefaultClip")
								f3_arg0.clipFinished(element, event)
							end)
						end
						f6_arg0:beginAnimation(390, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f6_arg0:setZRot(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f5_arg0:setZRot(-18)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.gun:playClip("DefaultClip")
				f3_arg0.gun:beginAnimation(1000)
				f3_arg0.gun:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gun:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.gun:completeAnimation()
			f3_arg0.gun:setZRot(0)
			f3_local0(f3_arg0.gun)
		end,
	},
}
CoD.CallingCards_Asset_steampunkwarriors_gunarm.__onClose = function(f9_arg0)
	f9_arg0.gun:close()
end
