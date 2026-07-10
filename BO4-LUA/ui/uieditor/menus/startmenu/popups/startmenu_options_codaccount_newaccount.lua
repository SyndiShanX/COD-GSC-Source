require("x64:f59c6c673920a4a")
require("x64:71d4e66447f837e")
require("x64:d6ecdf7755aeddc")
require("x64:1f846296f1a1b81")
require("x64:e41af73729601d6")
require("x64:2b684c0293c27f9")
require("x64:7889ce1e3e2e8a")
CoD.StartMenu_Options_CoDAccount_NewAccount = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_CoDAccount_NewAccount = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_CoDAccount_NewAccount", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.StartMenu_Options_CoDAccount_NewAccount)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(background)
	self.background = background
	local MenuFrameIngame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(MenuFrameIngame)
	self.MenuFrameIngame = MenuFrameIngame
	local StartMenuOptionsRegistrationForm = CoD.StartMenu_Options_RegistrationForm.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -545, 535)
	StartMenuOptionsRegistrationForm:subscribeToGlobalModel(f1_arg0, "CODAccountRegistrationForm", nil, function(model)
		StartMenuOptionsRegistrationForm:setModel(model, f1_arg0)
	end)
	self:addElement(StartMenuOptionsRegistrationForm)
	self.StartMenuOptionsRegistrationForm = StartMenuOptionsRegistrationForm
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_213ADAB54C482D0"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_local1, f1_arg0, 0, 0, 147, 448, 0, 0, 789, 858)
	DirectorSelectButtonMiniInternal:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"hash_5A2EE3185C07E292"))
	DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_5A2EE3185C07E292"))
	DirectorSelectButtonMiniInternal:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(DirectorSelectButtonMiniInternal, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.CoDAccountUtility.SetupCurrentLegalInfo(menu, controller, "PrivacyPolicyPages")
		OpenOverlay(self, "LegalTextViewerMenu", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	local DirectorSelectButtonMiniInternal2 = CoD.DirectorSelectButtonMiniInternal.new(f1_local1, f1_arg0, 0, 0, 147, 448, 0, 0, 710, 779)
	DirectorSelectButtonMiniInternal2:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	DirectorSelectButtonMiniInternal2.MiddleText:setText(LocalizeToUpperString(@"hash_3752EF7539CCF2F5"))
	DirectorSelectButtonMiniInternal2.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_3752EF7539CCF2F5"))
	DirectorSelectButtonMiniInternal2:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(DirectorSelectButtonMiniInternal2, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.CoDAccountUtility.SetupCurrentLegalInfo(menu, controller, "TermsOfUsePages")
		OpenOverlay(self, "LegalTextViewerMenu", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(DirectorSelectButtonMiniInternal2)
	self.DirectorSelectButtonMiniInternal2 = DirectorSelectButtonMiniInternal2
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f15_local0 = nil
		CoD.CoDAccountUtility.CodAccountHandleKeyboardComplete(self, f1_arg0, event, self.StartMenuOptionsRegistrationForm)
		if not f15_local0 then
			f15_local0 = self:dispatchEventToChildren(event)
		end
		return f15_local0
	end)
	self:registerEventHandler("list_item_gain_focus", function(self, event)
		local f16_local0 = nil
		CoD.CoDAccountUtility.OnNewAccountItemFocusChange(f1_local1, f1_arg0, self)
		return f16_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "UNOAccountInfo", "iTransactionResult", function(model)
		local f19_local0 = self
		CoD.CoDAccountUtility.CodAccountOnTransactionResultUpdated(self, f1_arg0, model)
	end)
	MenuFrameIngame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrameIngame.id = "MenuFrameIngame"
	end
	StartMenuOptionsRegistrationForm.id = "StartMenuOptionsRegistrationForm"
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
	DirectorSelectButtonMiniInternal2.id = "DirectorSelectButtonMiniInternal2"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local9 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	return self
end
CoD.StartMenu_Options_CoDAccount_NewAccount.__onClose = function(f20_arg0)
	f20_arg0.background:close()
	f20_arg0.MenuFrameIngame:close()
	f20_arg0.StartMenuOptionsRegistrationForm:close()
	f20_arg0.CommonHeader:close()
	f20_arg0.BackingGrayMediumLeft:close()
	f20_arg0.DirectorSelectButtonMiniInternal:close()
	f20_arg0.DirectorSelectButtonMiniInternal2:close()
end
