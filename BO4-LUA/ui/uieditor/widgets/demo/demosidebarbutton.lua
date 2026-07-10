require("x64:359389ec0f594f6")
CoD.DemoSideBarButton = InheritFrom(LUI.UIElement)
CoD.DemoSideBarButton.__defaultWidth = 350
CoD.DemoSideBarButton.__defaultHeight = 70
CoD.DemoSideBarButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoSideBarButton)
	self.id = "DemoSideBarButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DemoSideBarButtonInternal = CoD.DemoSideBarButtonInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0, 0, 0, 70)
	DemoSideBarButtonInternal:linkToElementModel(self, nil, false, function(model)
		DemoSideBarButtonInternal:setModel(model, f1_arg1)
	end)
	self:addElement(DemoSideBarButtonInternal)
	self.DemoSideBarButtonInternal = DemoSideBarButtonInternal
	DemoSideBarButtonInternal.id = "DemoSideBarButtonInternal"
	self.__defaultFocus = DemoSideBarButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DemoSideBarButton.__resetProperties = function(f3_arg0)
	f3_arg0.DemoSideBarButtonInternal:completeAnimation()
	f3_arg0.DemoSideBarButtonInternal:setScale(1, 1)
end
CoD.DemoSideBarButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.DemoSideBarButtonInternal:completeAnimation()
			f5_arg0.DemoSideBarButtonInternal:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.DemoSideBarButtonInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.DemoSideBarButtonInternal:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f6_arg0.DemoSideBarButtonInternal:setScale(1.05, 1.05)
				f6_arg0.DemoSideBarButtonInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.DemoSideBarButtonInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.DemoSideBarButtonInternal:completeAnimation()
			f6_arg0.DemoSideBarButtonInternal:setScale(1, 1)
			f6_local0(f6_arg0.DemoSideBarButtonInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.DemoSideBarButtonInternal:beginAnimation(150, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f8_arg0.DemoSideBarButtonInternal:setScale(1, 1)
				f8_arg0.DemoSideBarButtonInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.DemoSideBarButtonInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.DemoSideBarButtonInternal:completeAnimation()
			f8_arg0.DemoSideBarButtonInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.DemoSideBarButtonInternal)
		end,
	},
}
CoD.DemoSideBarButton.__onClose = function(f10_arg0)
	f10_arg0.DemoSideBarButtonInternal:close()
end
