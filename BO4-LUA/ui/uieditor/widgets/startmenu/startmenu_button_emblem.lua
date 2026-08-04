require("ui/uieditor/widgets/startmenu/startmenu_button_emblem_internal")
CoD.StartMenu_Button_Emblem = InheritFrom(LUI.UIElement)
CoD.StartMenu_Button_Emblem.__defaultWidth = 555
CoD.StartMenu_Button_Emblem.__defaultHeight = 210
CoD.StartMenu_Button_Emblem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Button_Emblem)
	self.id = "StartMenu_Button_Emblem"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonInternal = CoD.StartMenu_Button_Emblem_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonInternal)
	self.ButtonInternal = ButtonInternal
	ButtonInternal.id = "ButtonInternal"
	self.__defaultFocus = ButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SyncChildStateToSelfState(self, f1_arg1, ButtonInternal)
	return self
end
CoD.StartMenu_Button_Emblem.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonInternal:completeAnimation()
	f2_arg0.ButtonInternal:setScale(1, 1)
end
CoD.StartMenu_Button_Emblem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ButtonInternal:completeAnimation()
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
				f5_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.ButtonInternal:completeAnimation()
			f5_arg0.ButtonInternal:setScale(1, 1)
			f5_local0(f5_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ButtonInternal:beginAnimation(200)
				f7_arg0.ButtonInternal:setScale(1, 1)
				f7_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ButtonInternal:completeAnimation()
			f7_arg0.ButtonInternal:setScale(1.05, 1.05)
			f7_local0(f7_arg0.ButtonInternal)
		end,
	},
	UGCDisabled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ButtonInternal:completeAnimation()
			f10_arg0.ButtonInternal:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.ButtonInternal:beginAnimation(200)
				f11_arg0.ButtonInternal:setScale(1.05, 1.05)
				f11_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.ButtonInternal:completeAnimation()
			f11_arg0.ButtonInternal:setScale(1, 1)
			f11_local0(f11_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.ButtonInternal:beginAnimation(200)
				f13_arg0.ButtonInternal:setScale(1, 1)
				f13_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ButtonInternal:completeAnimation()
			f13_arg0.ButtonInternal:setScale(1.05, 1.05)
			f13_local0(f13_arg0.ButtonInternal)
		end,
	},
}
CoD.StartMenu_Button_Emblem.__onClose = function(f15_arg0)
	f15_arg0.ButtonInternal:close()
end
