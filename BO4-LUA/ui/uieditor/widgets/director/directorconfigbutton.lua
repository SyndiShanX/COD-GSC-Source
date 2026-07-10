require("x64:5829deb6251c128")
CoD.DirectorConfigButton = InheritFrom(LUI.UIElement)
CoD.DirectorConfigButton.__defaultWidth = 106
CoD.DirectorConfigButton.__defaultHeight = 40
CoD.DirectorConfigButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorConfigButton)
	self.id = "DirectorConfigButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ConfigInternal = CoD.DirectorSelectButtonInternalSecondary.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -32, 20)
	ConfigInternal:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	ConfigInternal:appendEventHandler("on_session_start", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ConfigInternal, f3_arg1)
	end)
	ConfigInternal:appendEventHandler("on_session_end", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ConfigInternal, f4_arg1)
	end)
	local f1_local2 = ConfigInternal
	local ButtonName = ConfigInternal.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	ButtonName(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(ConfigInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = ConfigInternal
	ButtonName = ConfigInternal.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	ButtonName(f1_local2, f1_local4["lobbyRoot.gameClient.update"], function(f6_arg0)
		f1_arg0:updateElementState(ConfigInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local2 = ConfigInternal
	ButtonName = ConfigInternal.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	ButtonName(f1_local2, f1_local4["lobbyRoot.privateClient.update"], function(f7_arg0)
		f1_arg0:updateElementState(ConfigInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	ConfigInternal.LeaderActivityText:setAlpha(0)
	ConfigInternal.LeaderActivityText:setText("")
	ConfigInternal.Header:setAlpha(0)
	ConfigInternal.Header:setText(LocalizeToUpperString(0x0))
	ConfigInternal.MiddleText:setText("")
	ConfigInternal:linkToElementModel(self, "iconBackground", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ConfigInternal.ImageNotFocus:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(ConfigInternal)
	self.ConfigInternal = ConfigInternal
	ButtonName = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -9, 9)
	ButtonName:setText(LocalizeToUpperString(@"menu/bots"))
	ButtonName:setTTF("ttmussels_regular")
	ButtonName:setLetterSpacing(2)
	ButtonName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ButtonName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ButtonName)
	self.ButtonName = ButtonName
	ConfigInternal.id = "ConfigInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorConfigButton.__resetProperties = function(f9_arg0)
	f9_arg0.ConfigInternal:completeAnimation()
	f9_arg0.ButtonName:completeAnimation()
	f9_arg0.ConfigInternal:setAlpha(1)
	f9_arg0.ConfigInternal:setScale(1, 1)
	f9_arg0.ButtonName:setRGB(1, 1, 1)
	f9_arg0.ButtonName:setAlpha(1)
	f9_arg0.ButtonName:setScale(1, 1)
end
CoD.DirectorConfigButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.ConfigInternal:completeAnimation()
			f11_arg0.ConfigInternal:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.ConfigInternal)
			f11_arg0.ButtonName:completeAnimation()
			f11_arg0.ButtonName:setRGB(0.92, 0.89, 0.72)
			f11_arg0.ButtonName:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.ButtonName)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ConfigInternal:beginAnimation(200)
				f12_arg0.ConfigInternal:setScale(1.05, 1.05)
				f12_arg0.ConfigInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ConfigInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ConfigInternal:completeAnimation()
			f12_arg0.ConfigInternal:setScale(1, 1)
			f12_local0(f12_arg0.ConfigInternal)
			local f12_local1 = function(f14_arg0)
				f12_arg0.ButtonName:beginAnimation(200)
				f12_arg0.ButtonName:setScale(1.05, 1.05)
				f12_arg0.ButtonName:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ButtonName:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ButtonName:completeAnimation()
			f12_arg0.ButtonName:setRGB(0.92, 0.89, 0.72)
			f12_arg0.ButtonName:setScale(1, 1)
			f12_local1(f12_arg0.ButtonName)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.ConfigInternal:beginAnimation(200)
				f15_arg0.ConfigInternal:setScale(1, 1)
				f15_arg0.ConfigInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.ConfigInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.ConfigInternal:completeAnimation()
			f15_arg0.ConfigInternal:setScale(1.05, 1.05)
			f15_local0(f15_arg0.ConfigInternal)
			local f15_local1 = function(f17_arg0)
				f15_arg0.ButtonName:beginAnimation(200)
				f15_arg0.ButtonName:setScale(1, 1)
				f15_arg0.ButtonName:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.ButtonName:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.ButtonName:completeAnimation()
			f15_arg0.ButtonName:setRGB(0.92, 0.89, 0.72)
			f15_arg0.ButtonName:setScale(1.05, 1.05)
			f15_local1(f15_arg0.ButtonName)
		end,
	},
	invisible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.ConfigInternal:completeAnimation()
			f18_arg0.ConfigInternal:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ConfigInternal)
			f18_arg0.ButtonName:completeAnimation()
			f18_arg0.ButtonName:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ButtonName)
		end,
	},
}
CoD.DirectorConfigButton.__onClose = function(f19_arg0)
	f19_arg0.ConfigInternal:close()
end
