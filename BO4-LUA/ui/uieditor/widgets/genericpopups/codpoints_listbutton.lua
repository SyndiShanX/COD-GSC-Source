require("x64:f6916a8c3c836a1")
CoD.CoDPoints_ListButton = InheritFrom(LUI.UIElement)
CoD.CoDPoints_ListButton.__defaultWidth = 650
CoD.CoDPoints_ListButton.__defaultHeight = 80
CoD.CoDPoints_ListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CoDPoints_ListButton)
	self.id = "CoDPoints_ListButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonSocialArrow = CoD.CoDPointPurchaseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -325, 325, 0.5, 0.5, -40, 40)
	CommonSocialArrow:linkToElementModel(self, nil, false, function(model)
		CommonSocialArrow:setModel(model, f1_arg1)
	end)
	self:addElement(CommonSocialArrow)
	self.CommonSocialArrow = CommonSocialArrow
	CommonSocialArrow.id = "CommonSocialArrow"
	self.__defaultFocus = CommonSocialArrow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CoDPoints_ListButton.__resetProperties = function(f3_arg0)
	f3_arg0.CommonSocialArrow:completeAnimation()
	f3_arg0.CommonSocialArrow:setScale(1, 1)
end
CoD.CoDPoints_ListButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CommonSocialArrow:completeAnimation()
			f5_arg0.CommonSocialArrow:setScale(1.02, 1.02)
			f5_arg0.clipFinished(f5_arg0.CommonSocialArrow)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.CommonSocialArrow:beginAnimation(140)
				f6_arg0.CommonSocialArrow:setScale(1.02, 1.02)
				f6_arg0.CommonSocialArrow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.CommonSocialArrow:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.CommonSocialArrow:completeAnimation()
			f6_arg0.CommonSocialArrow:setScale(1, 1)
			f6_local0(f6_arg0.CommonSocialArrow)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CommonSocialArrow:beginAnimation(140)
				f8_arg0.CommonSocialArrow:setScale(1, 1)
				f8_arg0.CommonSocialArrow:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CommonSocialArrow:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CommonSocialArrow:completeAnimation()
			f8_arg0.CommonSocialArrow:setScale(1.02, 1.02)
			f8_local0(f8_arg0.CommonSocialArrow)
		end,
	},
}
CoD.CoDPoints_ListButton.__onClose = function(f10_arg0)
	f10_arg0.CommonSocialArrow:close()
end
