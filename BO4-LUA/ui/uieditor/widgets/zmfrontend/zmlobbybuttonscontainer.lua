require("x64:c89d021ac8b3747")
CoD.ZMLobbyButtonsContainer = InheritFrom(LUI.UIElement)
CoD.ZMLobbyButtonsContainer.__defaultWidth = 425
CoD.ZMLobbyButtonsContainer.__defaultHeight = 92
CoD.ZMLobbyButtonsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLobbyButtonsContainer)
	self.id = "ZMLobbyButtonsContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PrivateMatchButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0, 0.48, 0, 0, 0, 1, 0, 0)
	PrivateMatchButton:linkToElementModel(self, "PrivateMatchName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PrivateMatchButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(CoD.DirectorUtility.GetPrivateMatchName(f2_local0)))
		end
	end)
	PrivateMatchButton:linkToElementModel(self, "PrivateMatchName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PrivateMatchButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(CoD.DirectorUtility.GetPrivateMatchName(f3_local0)))
		end
	end)
	local f1_local2 = PrivateMatchButton
	local PublicMatchButton = PrivateMatchButton.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	PublicMatchButton(f1_local2, f1_local4["lobbyRoot.playlistId"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local2 = PrivateMatchButton
	PublicMatchButton = PrivateMatchButton.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	PublicMatchButton(f1_local2, f1_local4["lobbyRoot.lobbyList.playerCount"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PrivateMatchButton:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PrivateMatchButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.DirectorUtility.NavigateToPrivateLobbyForCurrentMode(menu, controller)
			return true
		elseif CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, controller)
			return true
		elseif not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.DirectorUtility.OpenMapsNotEnabledPopup(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(PrivateMatchButton)
	self.PrivateMatchButton = PrivateMatchButton
	PublicMatchButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.52, 1, 0, 0, 0, 1, 0, 0)
	PublicMatchButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x21227B49B2CBED8))
	PublicMatchButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x21227B49B2CBED8))
	f1_local4 = PublicMatchButton
	f1_local2 = PublicMatchButton.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.playlistId"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local4 = PublicMatchButton
	f1_local2 = PublicMatchButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyList.playerCount"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PublicMatchButton:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PublicMatchButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.DirectorUtility.NavigateToPublicLobbyForCurrentMenuMode(menu, controller)
			return true
		elseif CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, controller)
			return true
		elseif not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.DirectorUtility.OpenMapsNotEnabledPopup(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.DirectorUtility.IsNumClientsExceeded(controller) and CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif not CoD.DirectorUtility.AllClientsOwnDLCForPlaylist(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(PublicMatchButton)
	self.PublicMatchButton = PublicMatchButton
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "BothExcluded",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "ZMLobbyExclusions", "PublicMatchExcluded") and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "ZMLobbyExclusions", "PrivateMatchExcluded")
			end,
		},
		{
			stateName = "PublicMatchExcluded",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "ZMLobbyExclusions", "PublicMatchExcluded")
			end,
		},
		{
			stateName = "PrivateMatchExcluded",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "ZMLobbyExclusions", "PrivateMatchExcluded")
			end,
		},
	})
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = DataSources.ZMLobbyExclusions.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.PublicMatchExcluded, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "PublicMatchExcluded",
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = DataSources.ZMLobbyExclusions.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.PrivateMatchExcluded, function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "PrivateMatchExcluded",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f20_arg2, f20_arg3, f20_arg4)
		if IsSelfInState(self, "PublicMatchExcluded") then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.PrivateMatchButton)
		elseif IsSelfInState(self, "PrivateMatchExcluded") then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.PublicMatchButton)
		end
	end)
	PrivateMatchButton.id = "PrivateMatchButton"
	PublicMatchButton.id = "PublicMatchButton"
	self.__defaultFocus = PublicMatchButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMLobbyButtonsContainer.__resetProperties = function(f21_arg0)
	f21_arg0.PrivateMatchButton:completeAnimation()
	f21_arg0.PublicMatchButton:completeAnimation()
	f21_arg0.PrivateMatchButton:setLeftRight(0, 0.48, 0, 0)
	f21_arg0.PrivateMatchButton:setAlpha(1)
	f21_arg0.PublicMatchButton:setLeftRight(0.52, 1, 0, 0)
	f21_arg0.PublicMatchButton:setAlpha(1)
end
CoD.ZMLobbyButtonsContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.PrivateMatchButton:completeAnimation()
			f23_arg0.PrivateMatchButton:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PrivateMatchButton)
			f23_arg0.PublicMatchButton:completeAnimation()
			f23_arg0.PublicMatchButton:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PublicMatchButton)
		end,
	},
	BothExcluded = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.PrivateMatchButton:completeAnimation()
			f24_arg0.PrivateMatchButton:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PrivateMatchButton)
			f24_arg0.PublicMatchButton:completeAnimation()
			f24_arg0.PublicMatchButton:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PublicMatchButton)
		end,
	},
	PublicMatchExcluded = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.PrivateMatchButton:completeAnimation()
			f25_arg0.PrivateMatchButton:setLeftRight(0, 1, 0, 0)
			f25_arg0.clipFinished(f25_arg0.PrivateMatchButton)
			f25_arg0.PublicMatchButton:completeAnimation()
			f25_arg0.PublicMatchButton:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.PublicMatchButton)
		end,
	},
	PrivateMatchExcluded = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.PrivateMatchButton:completeAnimation()
			f26_arg0.PrivateMatchButton:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PrivateMatchButton)
			f26_arg0.PublicMatchButton:completeAnimation()
			f26_arg0.PublicMatchButton:setLeftRight(0, 1, 0, 0)
			f26_arg0.clipFinished(f26_arg0.PublicMatchButton)
		end,
	},
}
CoD.ZMLobbyButtonsContainer.__onClose = function(f27_arg0)
	f27_arg0.PrivateMatchButton:close()
	f27_arg0.PublicMatchButton:close()
end
