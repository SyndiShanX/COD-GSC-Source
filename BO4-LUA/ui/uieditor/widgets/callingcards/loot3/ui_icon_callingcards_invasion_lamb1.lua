CoD.ui_icon_callingcards_invasion_lamb1 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_invasion_lamb1.__defaultWidth = 112
CoD.ui_icon_callingcards_invasion_lamb1.__defaultHeight = 112
CoD.ui_icon_callingcards_invasion_lamb1.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_invasion_lamb1)
	self.id = "ui_icon_callingcards_invasion_lamb1"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lamb1 = LUI.UIImage.new(0, 0, 0, 112, 0, 0, 0, 112)
	lamb1:setImage(RegisterImage(0x9184A772BCA8511))
	self:addElement(lamb1)
	self.lamb1 = lamb1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_invasion_lamb1.__resetProperties = function(f2_arg0)
	f2_arg0.lamb1:completeAnimation()
	f2_arg0.lamb1:setZRot(0)
end
CoD.ui_icon_callingcards_invasion_lamb1.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.lamb1:beginAnimation(3000)
				f3_arg0.lamb1:setZRot(-360)
				f3_arg0.lamb1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lamb1:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.lamb1:completeAnimation()
			f3_arg0.lamb1:setZRot(0)
			f3_local0(f3_arg0.lamb1)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
