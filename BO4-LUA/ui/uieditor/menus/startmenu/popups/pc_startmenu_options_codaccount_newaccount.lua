require("ui/uieditor/menus/startmenu/popups/legaltextviewermenu")
require("ui/uieditor/widgets/backgroundframes/menuframeingame")
require("ui/uieditor/widgets/common/commonheader")
require("ui/uieditor/widgets/director/directorselectbuttonminiinternal")
require("ui/uieditor/widgets/header/header_container_frontend")
require("ui/uieditor/widgets/startmenu/options/pc_startmenu_options_registrationform")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground")
CoD.PC_StartMenu_Options_CoDAccount_NewAccount = InheritFrom(CoD.Menu)
LUI.createMenu.PC_StartMenu_Options_CoDAccount_NewAccount = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_StartMenu_Options_CoDAccount_NewAccount", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PC_StartMenu_Options_CoDAccount_NewAccount)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(background)
	self.background = background
	local MenuFrameIngame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -1080, 0)
	self:addElement(MenuFrameIngame)
	self.MenuFrameIngame = MenuFrameIngame
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_213ADAB54C482D0"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local PCStartMenuOptionsRegistrationForm = CoD.PC_StartMenu_Options_RegistrationForm.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	PCStartMenuOptionsRegistrationForm:subscribeToGlobalModel(f1_arg0, "CODAccountRegistrationForm", nil, function(model)
		PCStartMenuOptionsRegistrationForm:setModel(model, f1_arg0)
	end)
	self:addElement(PCStartMenuOptionsRegistrationForm)
	self.PCStartMenuOptionsRegistrationForm = PCStartMenuOptionsRegistrationForm
	local DirectorSelectButtonMiniInternal2 = CoD.DirectorSelectButtonMiniInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -813, -512, 0.5, 0.5, 172, 241)
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
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(DirectorSelectButtonMiniInternal2, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		CoD.CoDAccountUtility.SetupCurrentLegalInfo(f8_arg1, f8_arg2, "TermsOfUsePages")
		OpenOverlay(self, "LegalTextViewerMenu", f8_arg2)
		return true
	end, function(f9_arg0, f9_arg1, f9_arg2)
		CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(DirectorSelectButtonMiniInternal2)
	self.DirectorSelectButtonMiniInternal2 = DirectorSelectButtonMiniInternal2
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -813, -512, 0.5, 0.5, 249, 318)
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
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(DirectorSelectButtonMiniInternal, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		CoD.CoDAccountUtility.SetupCurrentLegalInfo(f13_arg1, f13_arg2, "PrivacyPolicyPages")
		OpenOverlay(self, "LegalTextViewerMenu", f13_arg2)
		return true
	end, function(f14_arg0, f14_arg1, f14_arg2)
		CoD.Menu.SetButtonLabel(f14_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	self:registerEventHandler("ui_keyboard_input", function(element, event)
		local f15_local0 = nil
		CoD.CoDAccountUtility.CodAccountHandleKeyboardComplete(self, f1_arg0, event, self.PCStartMenuOptionsRegistrationForm)
		if not f15_local0 then
			f15_local0 = element:dispatchEventToChildren(event)
		end
		return f15_local0
	end)
	self:registerEventHandler("list_active_changed", function(element, event)
		local f16_local0 = nil
		CoD.CoDAccountUtility.OnNewAccountItemFocusChange(f1_local1, f1_arg0, element)
		return f16_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
		GoBack(self, f17_arg2)
		CoD.CoDAccountUtility.ClearRegistrationEmailAndPasswordModels(f17_arg2)
		return true
	end, function(f18_arg0, f18_arg1, f18_arg2)
		CoD.Menu.SetButtonLabel(f18_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
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
	PCStartMenuOptionsRegistrationForm.id = "PCStartMenuOptionsRegistrationForm"
	DirectorSelectButtonMiniInternal2.id = "DirectorSelectButtonMiniInternal2"
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
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
CoD.PC_StartMenu_Options_CoDAccount_NewAccount.__onClose = function(f20_arg0)
	f20_arg0.background:close()
	f20_arg0.MenuFrameIngame:close()
	f20_arg0.CommonHeader:close()
	f20_arg0.BackingGrayMediumLeft:close()
	f20_arg0.PCStartMenuOptionsRegistrationForm:close()
	f20_arg0.DirectorSelectButtonMiniInternal2:close()
	f20_arg0.DirectorSelectButtonMiniInternal:close()
end
