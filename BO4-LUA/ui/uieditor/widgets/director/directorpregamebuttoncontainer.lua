require("x64:67940364f14a232")
CoD.DirectorPreGameButtonContainer = InheritFrom(LUI.UIElement)
CoD.DirectorPreGameButtonContainer.__defaultWidth = 983
CoD.DirectorPreGameButtonContainer.__defaultHeight = 70
CoD.DirectorPreGameButtonContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPreGameButtonContainer)
	self.id = "DirectorPreGameButtonContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local LobbyButtons = LUI.UIList.new(f1_arg0, f1_arg1, 21, 0, nil, false, false, false, false)
	LobbyButtons:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsDirectorButtonOptionLocked(menu, element, f1_arg1)
			end,
		},
	})
	LobbyButtons:linkToElementModel(LobbyButtons, "locked", true, function(model)
		f1_arg0:updateElementState(LobbyButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	LobbyButtons:linkToElementModel(LobbyButtons, "featureItemIndex", true, function(model)
		f1_arg0:updateElementState(LobbyButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featureItemIndex",
		})
	end)
	local f1_local2 = LobbyButtons
	local f1_local3 = LobbyButtons.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(LobbyButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LobbyButtons:setLeftRight(0, 0, 0, 983)
	LobbyButtons:setTopBottom(1, 1, -70, 0)
	LobbyButtons:setWidgetType(CoD.DirectorPreGameButton)
	LobbyButtons:setHorizontalCount(4)
	LobbyButtons:setSpacing(21)
	LobbyButtons:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LobbyButtons:setDataSource("DirectorPregameButtons")
	LobbyButtons:linkToElementModel(LobbyButtons, "locked", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	LobbyButtons:linkToElementModel(LobbyButtons, "featureItemIndex", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local2 = LobbyButtons
	f1_local3 = LobbyButtons.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LobbyButtons:linkToElementModel(LobbyButtons, "trialLocked", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	LobbyButtons:registerEventHandler("gain_list_focus", function(element, event)
		local f10_local0 = nil
		UpdateElementState(self, "HintText", f1_arg1)
		return f10_local0
	end)
	LobbyButtons:registerEventHandler("lose_list_focus", function(element, event)
		local f11_local0 = nil
		UpdateElementState(self, "HintText", f1_arg1)
		return f11_local0
	end)
	LobbyButtons:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LobbyButtons, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.DirectorUtility.IsDirectorButtonOptionLocked(menu, element, controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			PlaySoundAlias("uin_press_generic")
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.DirectorUtility.IsDirectorButtonOptionLocked(menu, element, controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(LobbyButtons)
	self.LobbyButtons = LobbyButtons
	self.__on_menuOpened_self = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = self
		SetLoseFocusToElement(self, "CustomGames", f15_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "lobbyRoot.playlistId", function(model)
		local f16_local0 = self
		UpdateDataSource(self, self.LobbyButtons, f1_arg1)
	end)
	LobbyButtons.id = "LobbyButtons"
	self.__defaultFocus = LobbyButtons
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPreGameButtonContainer.__onClose = function(f18_arg0)
	f18_arg0.__on_close_removeOverrides()
	f18_arg0.LobbyButtons:close()
end
