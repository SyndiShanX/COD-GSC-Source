require("x64:74bc0ee537888fc")
CoD.InspectCallingCardWidget = InheritFrom(LUI.UIElement)
CoD.InspectCallingCardWidget.__defaultWidth = 348
CoD.InspectCallingCardWidget.__defaultHeight = 87
CoD.InspectCallingCardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectCallingCardWidget)
	self.id = "InspectCallingCardWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonButtonOutline = CoD.InspectCallingCardWidgetInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 348, 0, 0, 0, 87)
	CommonButtonOutline:linkToElementModel(self, nil, false, function(model)
		CommonButtonOutline:setModel(model, f1_arg1)
	end)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectCallingCardWidget.__resetProperties = function(f3_arg0)
	f3_arg0.CommonButtonOutline:completeAnimation()
	f3_arg0.CommonButtonOutline:setScale(1, 1)
end
CoD.InspectCallingCardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.CommonButtonOutline:completeAnimation()
			f4_arg0.CommonButtonOutline:setScale(0.98, 0.97)
			f4_arg0.clipFinished(f4_arg0.CommonButtonOutline)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CommonButtonOutline:completeAnimation()
			f5_arg0.CommonButtonOutline:setScale(1.01, 1.02)
			f5_arg0.clipFinished(f5_arg0.CommonButtonOutline)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.CommonButtonOutline:beginAnimation(150)
				f6_arg0.CommonButtonOutline:setScale(1.01, 1.02)
				f6_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.CommonButtonOutline:completeAnimation()
			f6_arg0.CommonButtonOutline:setScale(0.98, 0.97)
			f6_local0(f6_arg0.CommonButtonOutline)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CommonButtonOutline:beginAnimation(100)
				f8_arg0.CommonButtonOutline:setScale(0.98, 0.97)
				f8_arg0.CommonButtonOutline:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CommonButtonOutline:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CommonButtonOutline:completeAnimation()
			f8_arg0.CommonButtonOutline:setScale(1.01, 1.02)
			f8_local0(f8_arg0.CommonButtonOutline)
		end,
	},
}
CoD.InspectCallingCardWidget.__onClose = function(f10_arg0)
	f10_arg0.CommonButtonOutline:close()
end
