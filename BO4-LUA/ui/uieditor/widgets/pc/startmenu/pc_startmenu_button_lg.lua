require("x64:7a644b38ce54692")
CoD.PC_StartMenu_Button_LG = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Button_LG.__defaultWidth = 420
CoD.PC_StartMenu_Button_LG.__defaultHeight = 113
CoD.PC_StartMenu_Button_LG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Button_LG)
	self.id = "PC_StartMenu_Button_LG"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonInternal = CoD.PC_StartMenu_Button_LG_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonInternal)
	self.ButtonInternal = ButtonInternal
	ButtonInternal.id = "ButtonInternal"
	self.__defaultFocus = ButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Button_LG.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonInternal:completeAnimation()
	f2_arg0.ButtonInternal:setAlpha(1)
	f2_arg0.ButtonInternal:setScale(1, 1)
end
CoD.PC_StartMenu_Button_LG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ButtonInternal:completeAnimation()
			f4_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f4_arg0.ButtonInternal:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.ButtonInternal:beginAnimation(200)
				f5_arg0.ButtonInternal:setScale(1.05, 1.05)
				f5_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f5_arg0.clipFinished(element, event)
				end)
			end
			f5_arg0.ButtonInternal:completeAnimation()
			f5_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f5_arg0.ButtonInternal:setScale(1, 1)
			f5_local0(f5_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ButtonInternal:beginAnimation(200)
				f8_arg0.ButtonInternal:setScale(1, 1)
				f8_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f8_arg0.clipFinished(element, event)
				end)
			end
			f8_arg0.ButtonInternal:completeAnimation()
			f8_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f8_arg0.ButtonInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.ButtonInternal)
		end,
		InputFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ButtonInternal:completeAnimation()
			f11_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f11_arg0.ButtonInternal:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.ButtonInternal)
		end,
	},
}
CoD.PC_StartMenu_Button_LG.__onClose = function(f12_arg0)
	f12_arg0.ButtonInternal:close()
end
