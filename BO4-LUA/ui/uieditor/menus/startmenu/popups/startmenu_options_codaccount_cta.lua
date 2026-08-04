require("ui/uieditor/widgets/backgroundframes/menuframeingame")
require("ui/uieditor/widgets/common/commondetailpanel")
require("ui/uieditor/widgets/common/commonheader")
require("ui/uieditor/widgets/gamesettings/gamesettings_optionsbutton")
require("ui/uieditor/widgets/header/header_container_frontend")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground")
CoD.StartMenu_Options_CoDAccount_CTA = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_CoDAccount_CTA = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_CoDAccount_CTA", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.StartMenu_Options_CoDAccount_CTA)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(background)
	self.background = background
	local CommonDetailPanel = CoD.CommonDetailPanel.new(f1_local1, f1_arg0, 0.5, 0.5, -400, 400, 0.5, 0.5, -190, 190)
	self:addElement(CommonDetailPanel)
	self.CommonDetailPanel = CommonDetailPanel
	local MenuFrameIngame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -1080, 0)
	self:addElement(MenuFrameIngame)
	self.MenuFrameIngame = MenuFrameIngame
	local accountOptionsList = LUI.UIList.new(f1_local1, f1_arg0, 12, 0, nil, false, false, false, false)
	accountOptionsList:setLeftRight(0.5, 0.5, -380, 380)
	accountOptionsList:setTopBottom(0.5, 0.5, -36, 168)
	accountOptionsList:setWidgetType(CoD.GameSettings_OptionsButton)
	accountOptionsList:setVerticalCount(3)
	accountOptionsList:setSpacing(12)
	accountOptionsList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	accountOptionsList:setDataSource("CODAccountRegisterOptions")
	accountOptionsList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(accountOptionsList, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		ProcessListAction(self, f3_arg0, f3_arg2, f3_arg1)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "MOUSE1")
		return true
	end, false)
	self:addElement(accountOptionsList)
	self.accountOptionsList = accountOptionsList
	local Desc = LUI.UIText.new(0.5, 0.5, -380, 380, 0.5, 0.5, -132, -111)
	Desc:setRGB(0.96, 0.93, 0.84)
	Desc:setAlpha(0.3)
	Desc:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6FFAD8F01669B007"))
	Desc:setTTF("ttmussels_regular")
	Desc:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum.LUIAlignment[@"lui_alignment_left"]))
	Desc:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum.LUIAlignment[@"lui_alignment_top"]))
	self:addElement(Desc)
	self.Desc = Desc
	local Title = LUI.UIText.new(0.5, 0.5, -380, 380, 0.5, 0.5, -178, -133)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_62141D0923911BB7"))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(6)
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum.LUIAlignment[@"lui_alignment_left"]))
	self:addElement(Title)
	self.Title = Title
	local Header = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	Header.BGSceneBlur:setAlpha(0)
	Header.subtitle.StageTitle:setText(LocalizeToUpperString("menu/cod_account_caps"))
	Header.subtitle.subtitle:setAlpha(0)
	Header:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Header.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	Header:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(Header)
	self.Header = Header
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local SkipButton = nil
	SkipButton = CoD.GameSettings_OptionsButton.new(f1_local1, f1_arg0, 0, 0, 1220, 1360, 0, 0, 851, 911)
	SkipButton.OptionText:setText(LocalizeToUpperString("menu/skip_caps1"))
	SkipButton:linkToElementModel(self, "image", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SkipButton.Icon:setImage(RegisterImage(f7_local0))
		end
	end)
	SkipButton:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(SkipButton, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		GoBack(self, f9_arg2)
		CoD.LobbyUtility.OpenFTUEGameIntroductionOverlay(f9_arg2)
		return true
	end, function(f10_arg0, f10_arg1, f10_arg2)
		CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(SkipButton)
	self.SkipButton = SkipButton
	self:mergeStateConditions({
		{
			stateName = "SignInRequired",
			condition = function(menu, element, event)
				return PropertyIsTrue(self, "_signInRequired")
			end,
		},
	})
	self:registerEventHandler("occlusion_change", function(element, event)
		local f12_local0 = nil
		if element.OcclusionChange then
			f12_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f12_local0 = element.super:OcclusionChange(event)
		end
		CoD.CoDAccountUtility.UpdateOnCTAOccludedChange(f1_local1, f1_arg0, event)
		if not f12_local0 then
			f12_local0 = element:dispatchEventToChildren(event)
		end
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		if not IsSelfInState(self, "SignInRequired") then
			GoBack(self, f13_arg2)
			return true
		else
		end
	end, function(f14_arg0, f14_arg1, f14_arg2)
		if not IsSelfInState(self, "SignInRequired") then
			CoD.Menu.SetButtonLabel(f14_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	MenuFrameIngame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrameIngame.id = "MenuFrameIngame"
	end
	accountOptionsList.id = "accountOptionsList"
	if CoD.isPC then
		SkipButton.id = "SkipButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = accountOptionsList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local11 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	UpdateSelfState(self, f1_arg0)
	UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
	f1_local11 = SkipButton
	if CoD.CoDAccountUtility.HideSkipButton(self) then
		ReplaceElementWithFake(self, "SkipButton")
	end
	return self
end
CoD.StartMenu_Options_CoDAccount_CTA.__onClose = function(f15_arg0)
	f15_arg0.background:close()
	f15_arg0.CommonDetailPanel:close()
	f15_arg0.MenuFrameIngame:close()
	f15_arg0.accountOptionsList:close()
	f15_arg0.Header:close()
	f15_arg0.BackingGrayMediumLeft:close()
	f15_arg0.SkipButton:close()
end
