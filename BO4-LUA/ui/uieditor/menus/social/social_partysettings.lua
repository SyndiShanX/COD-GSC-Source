require("x64:1b66f971ffa1f09")
require("x64:fe9df26e257edb3")
require("x64:ba72b08fda6493")
CoD.Social_PartySettings = InheritFrom(CoD.Menu)
LUI.createMenu.Social_PartySettings = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Social_PartySettings", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Social_PartySettings)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	CommomCenteredPopup.TitleText:setText(LocalizeToUpperString(@"menu/party_settings"))
	CommomCenteredPopup.HeaderBackground:setAlpha(0)
	CommomCenteredPopup.HeaderTopBar:setAlpha(0)
	CommomCenteredPopup.HeaderBottomBar:setAlpha(0)
	self:addElement(CommomCenteredPopup)
	self.CommomCenteredPopup = CommomCenteredPopup
	local PartySettingsList = LUI.UIList.new(f1_local1, f1_arg0, 8, 0, nil, false, false, false, false)
	PartySettingsList:setLeftRight(0.5, 0.5, -250, 250)
	PartySettingsList:setTopBottom(0, 0, 160, 424)
	PartySettingsList:setWidgetType(CoD.CustomGames_SettingSliderNoCustom)
	PartySettingsList:setVerticalCount(4)
	PartySettingsList:setSpacing(8)
	PartySettingsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PartySettingsList:setDataSource("PartyControlsList")
	PartySettingsList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(PartySettingsList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if HasListAction(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasListAction(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	PartySettingsList:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "privateClient.update", function(model)
		UpdateDataSource(self, PartySettingsList, f1_arg0)
	end)
	PartySettingsList:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyLockedIn", function(model)
		UpdateDataSource(self, PartySettingsList, f1_arg0)
	end)
	self:addElement(PartySettingsList)
	self.PartySettingsList = PartySettingsList
	local SettingDescription = LUI.UIText.new(0.5, 0.5, -250, 250, 0, 0, 460, 481)
	SettingDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SettingDescription:setTTF("dinnext_regular")
	SettingDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SettingDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SettingDescription)
	self.SettingDescription = SettingDescription
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_local1, f1_arg0, 0.5, 0.5, 302, 336, 0.5, 0.5, -474.5, -440.5)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(BTNQuit, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	SettingDescription:linkToElementModel(PartySettingsList, "desc", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			SettingDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](f10_local0))
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"mp/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "goBack", function(element, controller)
		ClearMenuSavedState(element)
		ForceNotifyGlobalModel(controller, "lobbyRoot.partySettingsUpdate")
	end)
	CommomCenteredPopup.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		CommomCenteredPopup.id = "CommomCenteredPopup"
	end
	PartySettingsList.id = "PartySettingsList"
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = PartySettingsList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local6 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.Social_PartySettings.__onClose = function(f14_arg0)
	f14_arg0.SettingDescription:close()
	f14_arg0.CommomCenteredPopup:close()
	f14_arg0.PartySettingsList:close()
	f14_arg0.BTNQuit:close()
end
