require("x64:fa9b3c4076531ba")
CoD.ZM_Restart_Level_Prompt = InheritFrom(LUI.UIElement)
CoD.ZM_Restart_Level_Prompt.__defaultWidth = 700
CoD.ZM_Restart_Level_Prompt.__defaultHeight = 135
CoD.ZM_Restart_Level_Prompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZM_Restart_Level_Prompt)
	self.id = "ZM_Restart_Level_Prompt"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local YesPrompt = CoD.List1ButtonLarge_PH_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 310, 1, 1, -60, 0)
	YesPrompt:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	YesPrompt.Text:setText(LocalizeToUpperString(@"menu/yes"))
	YesPrompt:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(YesPrompt, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsSelfInState(self, "Shown") and IsPC() then
			RestartGameImmediate(menu, controller)
			LockInput(self, controller, false)
			return true
		elseif IsSelfInState(self, "Shown") then
			RestartGameImmediate(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfInState(self, "Shown") and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif IsSelfInState(self, "Shown") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(YesPrompt)
	self.YesPrompt = YesPrompt
	local NoPrompt = CoD.List1ButtonLarge_PH_Internal.new(f1_arg0, f1_arg1, 1, 1, -310, 0, 1, 1, -60, 0)
	NoPrompt:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	NoPrompt.Text:setText(LocalizeToUpperString(@"menu/no"))
	NoPrompt:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(NoPrompt, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsSelfInState(self, "Shown") then
			ResumeEndGame(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfInState(self, "Shown") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(NoPrompt)
	self.NoPrompt = NoPrompt
	local Prompt = LUI.UIText.new(0.5, 0.5, -350, 350, 0, 0, 0, 33)
	Prompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_148E5FC10A26A69D"))
	Prompt:setTTF("skorzhen")
	Prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Prompt)
	self.Prompt = Prompt
	self:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f11_local0 = self
		CoD.HUDUtility.HandleRestartPromptNotifies(f1_arg0, self, model, f1_arg1)
	end)
	YesPrompt.id = "YesPrompt"
	NoPrompt.id = "NoPrompt"
	self.__defaultFocus = NoPrompt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZM_Restart_Level_Prompt.__resetProperties = function(f12_arg0)
	f12_arg0.YesPrompt:completeAnimation()
	f12_arg0.NoPrompt:completeAnimation()
	f12_arg0.Prompt:completeAnimation()
	f12_arg0.YesPrompt:setAlpha(1)
	f12_arg0.NoPrompt:setAlpha(1)
	f12_arg0.Prompt:setAlpha(1)
end
CoD.ZM_Restart_Level_Prompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.YesPrompt:completeAnimation()
			f13_arg0.YesPrompt:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.YesPrompt)
			f13_arg0.NoPrompt:completeAnimation()
			f13_arg0.NoPrompt:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.NoPrompt)
			f13_arg0.Prompt:completeAnimation()
			f13_arg0.Prompt:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Prompt)
		end,
		Shown = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			local f14_local0 = function(f15_arg0)
				f14_arg0.YesPrompt:beginAnimation(1000)
				f14_arg0.YesPrompt:setAlpha(1)
				f14_arg0.YesPrompt:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.YesPrompt:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.YesPrompt:completeAnimation()
			f14_arg0.YesPrompt:setAlpha(0)
			f14_local0(f14_arg0.YesPrompt)
			local f14_local1 = function(f16_arg0)
				f14_arg0.NoPrompt:beginAnimation(1000)
				f14_arg0.NoPrompt:setAlpha(1)
				f14_arg0.NoPrompt:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.NoPrompt:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.NoPrompt:completeAnimation()
			f14_arg0.NoPrompt:setAlpha(0)
			f14_local1(f14_arg0.NoPrompt)
			local f14_local2 = function(f17_arg0)
				f14_arg0.Prompt:beginAnimation(1000)
				f14_arg0.Prompt:setAlpha(1)
				f14_arg0.Prompt:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Prompt:completeAnimation()
			f14_arg0.Prompt:setAlpha(0)
			f14_local2(f14_arg0.Prompt)
		end,
	},
	Shown = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.YesPrompt:completeAnimation()
			f18_arg0.YesPrompt:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.YesPrompt)
			f18_arg0.NoPrompt:completeAnimation()
			f18_arg0.NoPrompt:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.NoPrompt)
			f18_arg0.Prompt:completeAnimation()
			f18_arg0.Prompt:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Prompt)
		end,
		DefaultState = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			local f19_local0 = function(f20_arg0)
				f19_arg0.YesPrompt:beginAnimation(1000)
				f19_arg0.YesPrompt:setAlpha(0)
				f19_arg0.YesPrompt:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.YesPrompt:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.YesPrompt:completeAnimation()
			f19_arg0.YesPrompt:setAlpha(1)
			f19_local0(f19_arg0.YesPrompt)
			local f19_local1 = function(f21_arg0)
				f19_arg0.NoPrompt:beginAnimation(1000)
				f19_arg0.NoPrompt:setAlpha(0)
				f19_arg0.NoPrompt:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.NoPrompt:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.NoPrompt:completeAnimation()
			f19_arg0.NoPrompt:setAlpha(1)
			f19_local1(f19_arg0.NoPrompt)
			local f19_local2 = function(f22_arg0)
				f19_arg0.Prompt:beginAnimation(1000)
				f19_arg0.Prompt:setAlpha(0)
				f19_arg0.Prompt:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.Prompt:completeAnimation()
			f19_arg0.Prompt:setAlpha(1)
			f19_local2(f19_arg0.Prompt)
		end,
	},
}
CoD.ZM_Restart_Level_Prompt.__onClose = function(f23_arg0)
	f23_arg0.YesPrompt:close()
	f23_arg0.NoPrompt:close()
end
