require("ui/uieditor/widgets/startmenu/options/startmenu_options_privacysettingsscrollprompt")
require("ui/uieditor/widgets/startmenu/startmenu_options_simplecheckoption")
CoD.StartMenu_Options_PrivacySettingsManagementForm = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PrivacySettingsManagementForm.__defaultWidth = 1920
CoD.StartMenu_Options_PrivacySettingsManagementForm.__defaultHeight = 1080
CoD.StartMenu_Options_PrivacySettingsManagementForm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PrivacySettingsManagementForm)
	self.id = "StartMenu_Options_PrivacySettingsManagementForm"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PrivacySettingsOptions = LUI.UIList.new(f1_arg0, f1_arg1, 5, 0, nil, false, false, false, false)
	PrivacySettingsOptions:setLeftRight(0.5, 0.5, -813, -53)
	PrivacySettingsOptions:setTopBottom(0, 0, 408, 858)
	PrivacySettingsOptions:setWidgetType(CoD.StartMenu_Options_SimpleCheckOption)
	PrivacySettingsOptions:setVerticalCount(7)
	PrivacySettingsOptions:setSpacing(5)
	PrivacySettingsOptions:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	PrivacySettingsOptions:setDataSource("PrivacySettingOptionList")
	local Body = PrivacySettingsOptions
	local Title = PrivacySettingsOptions.subscribeToModel
	local DescriptionText = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	Title(Body, DescriptionText.updateProgressState, function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	PrivacySettingsOptions:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) then
			CoD.OptionsUtility.OnPrivacySettingItemFocusChange(f1_arg1, element, f1_arg0)
		end
		return f3_local0
	end)
	PrivacySettingsOptions:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PrivacySettingsOptions, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f5_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) then
			ProcessListAction(self, f5_arg0, f5_arg2, f5_arg1)
			return true
		else
		end
	end, function(f6_arg0, f6_arg1, f6_arg2)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f6_arg2, "PrivacySettingManagementForm", "updateProgressState", Enum[@"hash_65887EAAB38F9F8"][@"hash_464A086C0CC2A87"]) then
			CoD.Menu.SetButtonLabel(f6_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(PrivacySettingsOptions)
	self.PrivacySettingsOptions = PrivacySettingsOptions
	Title = LUI.UIText.new(0.5, 0.5, -795.5, -70.5, 0, 0, 206.5, 260.5)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(LocalizeToUpperString("menu/privacy_settings"))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	Body = LUI.UIText.new(0.5, 0.5, -795.5, -70.5, 0, 0, 292.5, 316.5)
	Body:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Body:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/privacy_settings_desc"))
	Body:setTTF("dinnext_regular")
	Body:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Body:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(Body)
	self.Body = Body
	DescriptionText = LUI.UIText.new(0.5, 0.5, 9, 809, 0, 0, 206.5, 230.5)
	DescriptionText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DescriptionText:setTTF("dinnext_regular")
	DescriptionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	DescriptionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	DescriptionText:subscribeToGlobalModel(f1_arg1, "PrivacySettingManagementForm", "descText", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			DescriptionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(DescriptionText)
	self.DescriptionText = DescriptionText
	local StartMenuOptionsPrivacySettingsScrollPrompt = CoD.StartMenu_Options_PrivacySettingsScrollPrompt.new(f1_arg0, f1_arg1, 0, 0, 1219, 1519, 0, 0, 858, 895)
	StartMenuOptionsPrivacySettingsScrollPrompt:subscribeToGlobalModel(f1_arg1, "PrivacySettingManagementForm", nil, function(model)
		StartMenuOptionsPrivacySettingsScrollPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(StartMenuOptionsPrivacySettingsScrollPrompt)
	self.StartMenuOptionsPrivacySettingsScrollPrompt = StartMenuOptionsPrivacySettingsScrollPrompt
	PrivacySettingsOptions.id = "PrivacySettingsOptions"
	if CoD.isPC then
		StartMenuOptionsPrivacySettingsScrollPrompt.id = "StartMenuOptionsPrivacySettingsScrollPrompt"
	end
	self.__defaultFocus = PrivacySettingsOptions
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PrivacySettingsManagementForm.__onClose = function(f9_arg0)
	f9_arg0.PrivacySettingsOptions:close()
	f9_arg0.DescriptionText:close()
	f9_arg0.StartMenuOptionsPrivacySettingsScrollPrompt:close()
end
