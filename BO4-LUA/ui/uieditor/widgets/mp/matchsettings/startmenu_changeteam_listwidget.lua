require("x64:8ea9fbf3bb18e48")
CoD.StartMenu_ChangeTeam_ListWidget = InheritFrom(LUI.UIElement)
CoD.StartMenu_ChangeTeam_ListWidget.__defaultWidth = 200
CoD.StartMenu_ChangeTeam_ListWidget.__defaultHeight = 200
CoD.StartMenu_ChangeTeam_ListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_ChangeTeam_ListWidget)
	self.id = "StartMenu_ChangeTeam_ListWidget"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonInternal = CoD.StartMenu_ChangeTeam_ButtonInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0.5, 0.5, -100, 100)
	ButtonInternal:linkToElementModel(self, nil, false, function(model)
		ButtonInternal:setModel(model, f1_arg1)
	end)
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
CoD.StartMenu_ChangeTeam_ListWidget.__resetProperties = function(f3_arg0)
	f3_arg0.ButtonInternal:completeAnimation()
	f3_arg0.ButtonInternal:setScale(1, 1)
end
CoD.StartMenu_ChangeTeam_ListWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ButtonInternal:completeAnimation()
			f5_arg0.ButtonInternal:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.ButtonInternal:beginAnimation(200)
				f6_arg0.ButtonInternal:setScale(1.05, 1.05)
				f6_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.ButtonInternal:completeAnimation()
			f6_arg0.ButtonInternal:setScale(1, 1)
			f6_local0(f6_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ButtonInternal:beginAnimation(200)
				f8_arg0.ButtonInternal:setScale(1, 1)
				f8_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ButtonInternal:completeAnimation()
			f8_arg0.ButtonInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.ButtonInternal)
		end,
	},
}
CoD.StartMenu_ChangeTeam_ListWidget.__onClose = function(f10_arg0)
	f10_arg0.ButtonInternal:close()
end
