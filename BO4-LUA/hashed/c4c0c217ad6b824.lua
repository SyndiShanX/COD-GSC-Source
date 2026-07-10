require("x64:7220f0194baed57")
CoD.ui_icon_callingcards_fairytales_armgroup = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_fairytales_armgroup.__defaultWidth = 10
CoD.ui_icon_callingcards_fairytales_armgroup.__defaultHeight = 10
CoD.ui_icon_callingcards_fairytales_armgroup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_fairytales_armgroup)
	self.id = "ui_icon_callingcards_fairytales_armgroup"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arm = LUI.UIImage.new(0, 0, -312, 16, 0, 0, -31, 41)
	arm:setImage(RegisterImage(0xEBCA1C38C8654B0))
	self:addElement(arm)
	self.arm = arm
	local wrist = CoD.ui_icon_callingcards_fairytales_wristgroup.new(f1_arg0, f1_arg1, 0, 0, -295, -285, 0, 0, 14, 24)
	self:addElement(wrist)
	self.wrist = wrist
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_fairytales_armgroup.__resetProperties = function(f2_arg0)
	f2_arg0.wrist:completeAnimation()
	f2_arg0.wrist:setZRot(0)
end
CoD.ui_icon_callingcards_fairytales_armgroup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f5_arg0:setZRot(-10)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.wrist:playClip("DefaultClip")
				f3_arg0.wrist:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.wrist:setZRot(50)
				f3_arg0.wrist:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.wrist:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.wrist:completeAnimation()
			f3_arg0.wrist:setZRot(-10)
			f3_local0(f3_arg0.wrist)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_fairytales_armgroup.__onClose = function(f7_arg0)
	f7_arg0.wrist:close()
end
