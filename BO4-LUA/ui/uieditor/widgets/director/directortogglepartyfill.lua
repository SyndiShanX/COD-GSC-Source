require("x64:669e5bae82c0f3e")
require("x64:f1eadda0b2ffd89")
CoD.DirectorTogglePartyFill = InheritFrom(LUI.UIElement)
CoD.DirectorTogglePartyFill.__defaultWidth = 396
CoD.DirectorTogglePartyFill.__defaultHeight = 70
CoD.DirectorTogglePartyFill.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("lobbyRoot.fillParty")
	self:setClass(CoD.DirectorTogglePartyFill)
	self.id = "DirectorTogglePartyFill"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorTogglePartyFillInternal = CoD.DirectorTogglePartyFillInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorTogglePartyFillInternal.Tint:setRGB(0.16, 0.16, 0.17)
	DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/off"))
	DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/off"))
	DirectorTogglePartyFillInternal.MiddleText:setText(LocalizeToUpperString(@"menu/fill_squad"))
	DirectorTogglePartyFillInternal.MiddleText:setTTF("ttmussels_regular")
	DirectorTogglePartyFillInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/fill_squad"))
	DirectorTogglePartyFillInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	self:addElement(DirectorTogglePartyFillInternal)
	self.DirectorTogglePartyFillInternal = DirectorTogglePartyFillInternal
	local DirectorTogglePartyFillClientInternal = CoD.DirectorTogglePartyFillClientInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorTogglePartyFillClientInternal:setAlpha(0)
	DirectorTogglePartyFillClientInternal.Tint:setAlpha(1)
	DirectorTogglePartyFillClientInternal.DotTiledBacking:setAlpha(0.5)
	DirectorTogglePartyFillClientInternal.Status:setText(LocalizeToUpperString(@"menu/off"))
	DirectorTogglePartyFillClientInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/off"))
	DirectorTogglePartyFillClientInternal.MiddleText:setText(LocalizeToUpperString(@"menu/fill_squad"))
	DirectorTogglePartyFillClientInternal.MiddleText:setTTF("ttmussels_regular")
	DirectorTogglePartyFillClientInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"menu/fill_squad"))
	DirectorTogglePartyFillClientInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	self:addElement(DirectorTogglePartyFillClientInternal)
	self.DirectorTogglePartyFillClientInternal = DirectorTogglePartyFillClientInternal
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "HostOff",
			condition = function(menu, element, event)
				return IsLobbyPrivateHost() and not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.fillParty")
			end,
		},
		{
			stateName = "HostOn",
			condition = function(menu, element, event)
				return IsLobbyPrivateHost() and CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.fillParty")
			end,
		},
		{
			stateName = "ClientOff",
			condition = function(menu, element, event)
				local f5_local0
				if not IsLobbyPrivateHost() then
					f5_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.fillParty")
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "ClientOn",
			condition = function(menu, element, event)
				local f6_local0
				if not IsLobbyPrivateHost() then
					f6_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.fillParty")
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.privateClient.update"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.fillParty"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.fillParty",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsSelfInState(self, "HostOff") and not IsGameLobbyActive() then
			SetFillParty(self, element, controller, true)
			PlaySoundAlias("uin_paint_select")
			return true
		elseif IsSelfInState(self, "HostOn") and not IsGameLobbyActive() then
			SetFillParty(self, element, controller, false)
			PlaySoundAlias("uin_paint_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsSelfInState(self, "HostOff") and not IsGameLobbyActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsSelfInState(self, "HostOn") and not IsGameLobbyActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	DirectorTogglePartyFillInternal.id = "DirectorTogglePartyFillInternal"
	DirectorTogglePartyFillClientInternal.id = "DirectorTogglePartyFillClientInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTogglePartyFill.__resetProperties = function(f12_arg0)
	f12_arg0.DirectorTogglePartyFillInternal:completeAnimation()
	f12_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
	f12_arg0.DirectorTogglePartyFillInternal:setAlpha(1)
	f12_arg0.DirectorTogglePartyFillInternal:setScale(1, 1)
	f12_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/off"))
	f12_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/off"))
	f12_arg0.DirectorTogglePartyFillClientInternal:setAlpha(0)
	f12_arg0.DirectorTogglePartyFillClientInternal:setScale(1, 1)
	f12_arg0.DirectorTogglePartyFillClientInternal.Status:setText(LocalizeToUpperString(@"menu/off"))
	f12_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/off"))
end
CoD.DirectorTogglePartyFill.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	HostOff = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f15_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f15_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f15_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/off"))
			f15_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/off"))
			f15_arg0.clipFinished(f15_arg0.DirectorTogglePartyFillInternal)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f16_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f16_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f16_arg0.DirectorTogglePartyFillInternal:setScale(1.05, 1.05)
			f16_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/off"))
			f16_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/off"))
			f16_arg0.clipFinished(f16_arg0.DirectorTogglePartyFillInternal)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.DirectorTogglePartyFillInternal:beginAnimation(200)
				f17_arg0.DirectorTogglePartyFillInternal:setScale(1.05, 1.05)
				f17_arg0.DirectorTogglePartyFillInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DirectorTogglePartyFillInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f17_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f17_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f17_arg0.DirectorTogglePartyFillInternal:setScale(1, 1)
			f17_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/off"))
			f17_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/off"))
			f17_local0(f17_arg0.DirectorTogglePartyFillInternal)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.DirectorTogglePartyFillInternal:beginAnimation(200)
				f19_arg0.DirectorTogglePartyFillInternal:setScale(1, 1)
				f19_arg0.DirectorTogglePartyFillInternal:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.DirectorTogglePartyFillInternal:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f19_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f19_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f19_arg0.DirectorTogglePartyFillInternal:setScale(1.05, 1.05)
			f19_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/off"))
			f19_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/off"))
			f19_local0(f19_arg0.DirectorTogglePartyFillInternal)
		end,
	},
	HostOn = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f21_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f21_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f21_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f21_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f21_arg0.clipFinished(f21_arg0.DirectorTogglePartyFillInternal)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f22_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f22_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f22_arg0.DirectorTogglePartyFillInternal:setScale(1.05, 1.05)
			f22_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f22_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f22_arg0.clipFinished(f22_arg0.DirectorTogglePartyFillInternal)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.DirectorTogglePartyFillInternal:beginAnimation(200)
				f23_arg0.DirectorTogglePartyFillInternal:setScale(1.05, 1.05)
				f23_arg0.DirectorTogglePartyFillInternal:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.DirectorTogglePartyFillInternal:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f23_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f23_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f23_arg0.DirectorTogglePartyFillInternal:setScale(1, 1)
			f23_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f23_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f23_local0(f23_arg0.DirectorTogglePartyFillInternal)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.DirectorTogglePartyFillInternal:beginAnimation(200)
				f25_arg0.DirectorTogglePartyFillInternal:setScale(1, 1)
				f25_arg0.DirectorTogglePartyFillInternal:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.DirectorTogglePartyFillInternal:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f25_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f25_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f25_arg0.DirectorTogglePartyFillInternal:setScale(1.05, 1.05)
			f25_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f25_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f25_local0(f25_arg0.DirectorTogglePartyFillInternal)
		end,
	},
	ClientOff = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f27_arg0.DirectorTogglePartyFillInternal:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DirectorTogglePartyFillInternal)
			f27_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
			f27_arg0.DirectorTogglePartyFillClientInternal:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.DirectorTogglePartyFillClientInternal)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f28_arg0.DirectorTogglePartyFillInternal:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.DirectorTogglePartyFillInternal)
			f28_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
			f28_arg0.DirectorTogglePartyFillClientInternal:setAlpha(1)
			f28_arg0.DirectorTogglePartyFillClientInternal:setScale(1.05, 1.05)
			f28_arg0.clipFinished(f28_arg0.DirectorTogglePartyFillClientInternal)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f29_arg0.DirectorTogglePartyFillInternal:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.DirectorTogglePartyFillInternal)
			local f29_local0 = function(f30_arg0)
				f29_arg0.DirectorTogglePartyFillClientInternal:beginAnimation(200)
				f29_arg0.DirectorTogglePartyFillClientInternal:setScale(1.05, 1.05)
				f29_arg0.DirectorTogglePartyFillClientInternal:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DirectorTogglePartyFillClientInternal:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
			f29_arg0.DirectorTogglePartyFillClientInternal:setAlpha(1)
			f29_arg0.DirectorTogglePartyFillClientInternal:setScale(1, 1)
			f29_local0(f29_arg0.DirectorTogglePartyFillClientInternal)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f31_arg0.DirectorTogglePartyFillInternal:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.DirectorTogglePartyFillInternal)
			local f31_local0 = function(f32_arg0)
				f31_arg0.DirectorTogglePartyFillClientInternal:beginAnimation(200)
				f31_arg0.DirectorTogglePartyFillClientInternal:setScale(1, 1)
				f31_arg0.DirectorTogglePartyFillClientInternal:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.DirectorTogglePartyFillClientInternal:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
			f31_arg0.DirectorTogglePartyFillClientInternal:setAlpha(1)
			f31_arg0.DirectorTogglePartyFillClientInternal:setScale(1.05, 1.05)
			f31_local0(f31_arg0.DirectorTogglePartyFillClientInternal)
		end,
	},
	ClientOn = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f33_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f33_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f33_arg0.DirectorTogglePartyFillInternal:setAlpha(0)
			f33_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f33_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f33_arg0.clipFinished(f33_arg0.DirectorTogglePartyFillInternal)
			f33_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
			f33_arg0.DirectorTogglePartyFillClientInternal.Status:completeAnimation()
			f33_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:completeAnimation()
			f33_arg0.DirectorTogglePartyFillClientInternal:setAlpha(1)
			f33_arg0.DirectorTogglePartyFillClientInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f33_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f33_arg0.clipFinished(f33_arg0.DirectorTogglePartyFillClientInternal)
		end,
		ChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f34_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f34_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f34_arg0.DirectorTogglePartyFillInternal:setAlpha(0)
			f34_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f34_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f34_arg0.clipFinished(f34_arg0.DirectorTogglePartyFillInternal)
			f34_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
			f34_arg0.DirectorTogglePartyFillClientInternal.Status:completeAnimation()
			f34_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:completeAnimation()
			f34_arg0.DirectorTogglePartyFillClientInternal:setAlpha(1)
			f34_arg0.DirectorTogglePartyFillClientInternal:setScale(1.05, 1.05)
			f34_arg0.DirectorTogglePartyFillClientInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f34_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f34_arg0.clipFinished(f34_arg0.DirectorTogglePartyFillClientInternal)
		end,
		GainChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f35_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f35_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f35_arg0.DirectorTogglePartyFillInternal:setAlpha(0)
			f35_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f35_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f35_arg0.clipFinished(f35_arg0.DirectorTogglePartyFillInternal)
			local f35_local0 = function(f36_arg0)
				f35_arg0.DirectorTogglePartyFillClientInternal:beginAnimation(200)
				f35_arg0.DirectorTogglePartyFillClientInternal:setScale(1.05, 1.05)
				f35_arg0.DirectorTogglePartyFillClientInternal:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.DirectorTogglePartyFillClientInternal:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
			f35_arg0.DirectorTogglePartyFillClientInternal.Status:completeAnimation()
			f35_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:completeAnimation()
			f35_arg0.DirectorTogglePartyFillClientInternal:setAlpha(1)
			f35_arg0.DirectorTogglePartyFillClientInternal:setScale(1, 1)
			f35_arg0.DirectorTogglePartyFillClientInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f35_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f35_local0(f35_arg0.DirectorTogglePartyFillClientInternal)
		end,
		LoseChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			f37_arg0.DirectorTogglePartyFillInternal:completeAnimation()
			f37_arg0.DirectorTogglePartyFillInternal.Status:completeAnimation()
			f37_arg0.DirectorTogglePartyFillInternal.StatusFocus:completeAnimation()
			f37_arg0.DirectorTogglePartyFillInternal:setAlpha(0)
			f37_arg0.DirectorTogglePartyFillInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f37_arg0.DirectorTogglePartyFillInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f37_arg0.clipFinished(f37_arg0.DirectorTogglePartyFillInternal)
			local f37_local0 = function(f38_arg0)
				f37_arg0.DirectorTogglePartyFillClientInternal:beginAnimation(200)
				f37_arg0.DirectorTogglePartyFillClientInternal:setScale(1, 1)
				f37_arg0.DirectorTogglePartyFillClientInternal:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.DirectorTogglePartyFillClientInternal:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.DirectorTogglePartyFillClientInternal:completeAnimation()
			f37_arg0.DirectorTogglePartyFillClientInternal.Status:completeAnimation()
			f37_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:completeAnimation()
			f37_arg0.DirectorTogglePartyFillClientInternal:setAlpha(1)
			f37_arg0.DirectorTogglePartyFillClientInternal:setScale(1.05, 1.05)
			f37_arg0.DirectorTogglePartyFillClientInternal.Status:setText(LocalizeToUpperString(@"menu/on"))
			f37_arg0.DirectorTogglePartyFillClientInternal.StatusFocus:setText(LocalizeToUpperString(@"menu/on"))
			f37_local0(f37_arg0.DirectorTogglePartyFillClientInternal)
		end,
	},
}
CoD.DirectorTogglePartyFill.__onClose = function(f39_arg0)
	f39_arg0.DirectorTogglePartyFillInternal:close()
	f39_arg0.DirectorTogglePartyFillClientInternal:close()
end
