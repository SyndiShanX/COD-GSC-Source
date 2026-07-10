require("x64:71d4e66447f837e")
require("x64:d6ecdf7755aeddc")
require("x64:e41af73729601d6")
require("x64:a4733827d6c5d52")
require("x64:3696ed865d69c3c")
require("x64:7889ce1e3e2e8a")
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
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_65EB6FED86163697"))
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
	local StateWidget = CoD.StartMenu_Options_PrivacySettingsStateWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -443, 443, 0.5, 0.5, -115, 35)
	StateWidget:setAlpha(0)
	self:addElement(StateWidget)
	self.StateWidget = StateWidget
	self:mergeStateConditions({
		{
			stateName = "Updating",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg0, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"])
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
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) then
			ClearRecordedFocus(menu, controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_778D439E1B360368", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_4F100F564F11A910"]) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			ClearRecordedFocus(menu, controller)
			GoBack(self, controller)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_1DE287BA1764B6AE"]) and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			ClearRecordedFocus(menu, controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_4F100F564F11A910"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_1DE287BA1764B6AE"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, nil)
			return true
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
CoD.StartMenu_Options_PrivacySettings.__resetProperties = function(f12_arg0)
	f12_arg0.PrivacySettingsManagementForm:completeAnimation()
	f12_arg0.StateWidget:completeAnimation()
	f12_arg0.PrivacySettingsManagementForm:setAlpha(1)
	f12_arg0.StateWidget:setAlpha(0)
end
CoD.StartMenu_Options_PrivacySettings.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Updating = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.PrivacySettingsManagementForm:completeAnimation()
			f14_arg0.PrivacySettingsManagementForm:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PrivacySettingsManagementForm)
			f14_arg0.StateWidget:completeAnimation()
			f14_arg0.StateWidget:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.StateWidget)
		end,
	},
}
CoD.StartMenu_Options_PrivacySettings.__onClose = function(f15_arg0)
	f15_arg0.StartMenuOptionsBackground:close()
	f15_arg0.MenuFrameIngame:close()
	f15_arg0.PrivacySettingsManagementForm:close()
	f15_arg0.CommonHeader:close()
	f15_arg0.headercontainerfrontend:close()
	f15_arg0.StateWidget:close()
end
