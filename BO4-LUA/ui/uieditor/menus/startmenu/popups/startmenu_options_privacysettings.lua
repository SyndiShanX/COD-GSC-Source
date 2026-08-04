require("ui/uieditor/widgets/backgroundframes/menuframeingame")
require("ui/uieditor/widgets/common/commonheader")
require("ui/uieditor/widgets/header/header_container_frontend")
require("ui/uieditor/widgets/startmenu/options/startmenu_options_privacysettingsmanagementform")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground")
CoD.StartMenu_Options_PrivacySettings = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_PrivacySettings = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_PrivacySettings", f1_arg0)
	local f1_local1 = self
	CoD.ModelUtility.SetGlobalDatasourceModelValueToEnum(f1_arg0, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"])
	self:setClass(CoD.StartMenu_Options_PrivacySettings)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local StartMenuOptionsBackground = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuOptionsBackground)
	self.StartMenuOptionsBackground = StartMenuOptionsBackground
	local MenuFrameIngame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(MenuFrameIngame)
	self.MenuFrameIngame = MenuFrameIngame
	local PrivacySettingsManagementForm = CoD.StartMenu_Options_PrivacySettingsManagementForm.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PrivacySettingsManagementForm)
	self.PrivacySettingsManagementForm = PrivacySettingsManagementForm
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString("menu/privacy_settings"))
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
	local headercontainerfrontend = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	headercontainerfrontend:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(headercontainerfrontend)
	self.headercontainerfrontend = headercontainerfrontend
	local f1_local7 = nil
	self.StateWidget = LUI.UIElement.createFake()
	self:mergeStateConditions({
		{
			stateName = "Updating",
			condition = function(menu, element, event)
				local f5_local0
				if not IsPC() then
					f5_local0 = not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg0, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"])
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = DataSources.PrivacySettingManagementForm.getModel(f1_arg0)
	f1_local9(f1_local8, f1_local10.updateProgressState, function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "updateProgressState",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.PrivacySettingManagementForm.getModel(f1_arg0)
	f1_local9(f1_local8, f1_local10.updateProgressState, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_lb"])
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.PrivacySettingManagementForm.getModel(f1_arg0)
	f1_local9(f1_local8, f1_local10.currentPage, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_rb"])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_lb"])
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.PrivacySettingManagementForm.getModel(f1_arg0)
	f1_local9(f1_local8, f1_local10.lastPage, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_rb"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f10_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) then
			ClearRecordedFocus(f10_arg1, f10_arg2)
			GoBack(self, f10_arg2)
			return true
		else
		end
	end, function(f11_arg0, f11_arg1, f11_arg2)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f11_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) then
			CoD.Menu.SetButtonLabel(f11_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f12_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_4F100F564F11A910"]) and CoD.BaseUtility.IsButtonHoldFinished(f12_arg3) then
			ClearRecordedFocus(f12_arg1, f12_arg2)
			GoBack(self, f12_arg2)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f12_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_1DE287BA1764B6AE"]) and not CoD.BaseUtility.IsButtonHoldFinished(f12_arg3) then
			ClearRecordedFocus(f12_arg1, f12_arg2)
			GoBack(self, f12_arg2)
			return true
		else
		end
	end, function(f13_arg0, f13_arg1, f13_arg2)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f13_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_4F100F564F11A910"]) then
			CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/continue", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f13_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_1DE287BA1764B6AE"]) then
			CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/continue", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_rb"], nil, function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f14_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) and not CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(f14_arg2) then
			CoD.OptionsUtility.ChangePrivacySettingDescPage(f14_arg2, f14_arg1, "1")
			return true
		else
		end
	end, function(f15_arg0, f15_arg1, f15_arg2)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f15_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) and not CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(f15_arg2) then
			CoD.Menu.SetButtonLabel(f15_arg1, Enum.LUIButton[@"lui_key_rb"], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_lb"], nil, function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f16_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f16_arg2, "PrivacySettingManagementForm", "currentPage", 1) then
			CoD.OptionsUtility.ChangePrivacySettingDescPage(f16_arg2, f16_arg1, "-1")
			return true
		else
		end
	end, function(f17_arg0, f17_arg1, f17_arg2)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f17_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f17_arg2, "PrivacySettingManagementForm", "currentPage", 1) then
			CoD.Menu.SetButtonLabel(f17_arg1, Enum.LUIButton[@"lui_key_lb"], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	MenuFrameIngame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrameIngame.id = "MenuFrameIngame"
	end
	PrivacySettingsManagementForm.id = "PrivacySettingsManagementForm"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = PrivacySettingsManagementForm
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local9 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.StartMenu_Options_PrivacySettings.__resetProperties = function(f18_arg0)
	f18_arg0.PrivacySettingsManagementForm:completeAnimation()
	f18_arg0.StateWidget:completeAnimation()
	f18_arg0.PrivacySettingsManagementForm:setAlpha(1)
	f18_arg0.StateWidget:setAlpha(0)
end
CoD.StartMenu_Options_PrivacySettings.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	Updating = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.PrivacySettingsManagementForm:completeAnimation()
			f20_arg0.PrivacySettingsManagementForm:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PrivacySettingsManagementForm)
			f20_arg0.StateWidget:completeAnimation()
			f20_arg0.StateWidget:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.StateWidget)
		end,
	},
}
CoD.StartMenu_Options_PrivacySettings.__onClose = function(f21_arg0)
	f21_arg0.StartMenuOptionsBackground:close()
	f21_arg0.MenuFrameIngame:close()
	f21_arg0.PrivacySettingsManagementForm:close()
	f21_arg0.CommonHeader:close()
	f21_arg0.headercontainerfrontend:close()
	f21_arg0.StateWidget:close()
end
