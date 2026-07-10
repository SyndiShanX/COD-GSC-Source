require("x64:e9ea9b16de1842b")
CoD.ui_icon_callingcards_invasion_ufo = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_invasion_ufo.__defaultWidth = 224
CoD.ui_icon_callingcards_invasion_ufo.__defaultHeight = 88
CoD.ui_icon_callingcards_invasion_ufo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_invasion_ufo)
	self.id = "ui_icon_callingcards_invasion_ufo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ufo = CoD.ui_icon_callingcards_invasion_ufowbeam.new(f1_arg0, f1_arg1, 0, 0, 0, 224, 0, 0, 0, 88)
	self:addElement(ufo)
	self.ufo = ufo
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_invasion_ufo.__resetProperties = function(f2_arg0)
	f2_arg0.ufo:completeAnimation()
	f2_arg0.ufo:setZRot(0)
end
CoD.ui_icon_callingcards_invasion_ufo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500)
					f5_arg0:setZRot(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.ufo:playClip("DefaultClip")
				f3_arg0.ufo:beginAnimation(1500)
				f3_arg0.ufo:setZRot(5)
				f3_arg0.ufo:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ufo:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ufo:completeAnimation()
			f3_arg0.ufo:setZRot(0)
			f3_local0(f3_arg0.ufo)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_invasion_ufo.__onClose = function(f7_arg0)
	f7_arg0.ufo:close()
end
