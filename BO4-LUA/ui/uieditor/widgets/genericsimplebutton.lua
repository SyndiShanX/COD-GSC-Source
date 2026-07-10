require("x64:c4c5fd562617659")
CoD.GenericSimpleButton = InheritFrom(LUI.UIElement)
CoD.GenericSimpleButton.__defaultWidth = 194
CoD.GenericSimpleButton.__defaultHeight = 103
CoD.GenericSimpleButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GenericSimpleButton)
	self.id = "GenericSimpleButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonContainer = CoD.GenericSimpleButton_Container.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonContainer)
	self.ButtonContainer = ButtonContainer
	ButtonContainer.id = "ButtonContainer"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GenericSimpleButton.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonContainer:completeAnimation()
	f2_arg0.ButtonContainer:setLeftRight(0, 1, 0, 0)
	f2_arg0.ButtonContainer:setTopBottom(0, 1, 0, 0)
	f2_arg0.ButtonContainer:setScale(1, 1)
end
CoD.GenericSimpleButton.__clipsPerState = {
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
CoD.GenericSimpleButton.__onClose = function(f9_arg0)
	f9_arg0.ButtonContainer:close()
end
