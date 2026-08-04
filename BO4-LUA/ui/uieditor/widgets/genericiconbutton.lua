require("ui/uieditor/widgets/genericiconbutton_container")
CoD.GenericIconButton = InheritFrom(LUI.UIElement)
CoD.GenericIconButton.__defaultWidth = 194
CoD.GenericIconButton.__defaultHeight = 103
CoD.GenericIconButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GenericIconButton)
	self.id = "GenericIconButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonContainer = CoD.GenericIconButton_Container.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonContainer)
	self.ButtonContainer = ButtonContainer
	ButtonContainer.id = "ButtonContainer"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GenericIconButton.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonContainer:completeAnimation()
	f2_arg0.ButtonContainer:setLeftRight(0, 1, 0, 0)
	f2_arg0.ButtonContainer:setTopBottom(0, 1, 0, 0)
	f2_arg0.ButtonContainer:setScale(1, 1)
end
CoD.GenericIconButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(80)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.ButtonContainer:beginAnimation(100)
				f4_arg0.ButtonContainer:setScale(1.05, 1.05)
				f4_arg0.ButtonContainer:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ButtonContainer:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.ButtonContainer:completeAnimation()
			f4_arg0.ButtonContainer:setLeftRight(0, 1, 0, 0)
			f4_arg0.ButtonContainer:setTopBottom(0, 1, 0, 0)
			f4_arg0.ButtonContainer:setScale(1, 1)
			f4_local0(f4_arg0.ButtonContainer)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ButtonContainer:beginAnimation(80)
				f7_arg0.ButtonContainer:setScale(1, 1)
				f7_arg0.ButtonContainer:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ButtonContainer:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ButtonContainer:completeAnimation()
			f7_arg0.ButtonContainer:setLeftRight(0, 1, 0, 0)
			f7_arg0.ButtonContainer:setTopBottom(0, 1, 0, 0)
			f7_arg0.ButtonContainer:setScale(1.05, 1.05)
			f7_local0(f7_arg0.ButtonContainer)
		end,
	},
}
CoD.GenericIconButton.__onClose = function(f9_arg0)
	f9_arg0.ButtonContainer:close()
end
