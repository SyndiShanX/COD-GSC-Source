require("x64:b1b45f210299d24")
require("x64:75b68cdde53ec78")
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
	PrivacySettingsOptions:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PrivacySettingsOptions:setDataSource("PrivacySettingOptionList")
	local Body = PrivacySettingsOptions
	local Title = PrivacySettingsOptions.subscribeToModel
	local DescriptionText = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	Title(Body, DescriptionText.updateProgressState, function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
	end, false)
	Body = PrivacySettingsOptions
	Title = PrivacySettingsOptions.subscribeToModel
	DescriptionText = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	Title(Body, DescriptionText.currentPage, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
	end, false)
	Body = PrivacySettingsOptions
	Title = PrivacySettingsOptions.subscribeToModel
	DescriptionText = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	Title(Body, DescriptionText.lastPage, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
	end, false)
	PrivacySettingsOptions:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87]) then
			CoD.OptionsUtility.OnPrivacySettingItemFocusChange(f1_arg1, element)
		end
		return f5_local0
	end)
	PrivacySettingsOptions:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PrivacySettingsOptions, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87]) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(PrivacySettingsOptions, f1_arg1, Enum[0x3DD78803F918E9D][0x49A252B20B48936], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87]) and not CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(controller) then
			CoD.OptionsUtility.ChangePrivacySettingDescPage(controller, element, "1")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87]) and not CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x49A252B20B48936], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(PrivacySettingsOptions, f1_arg1, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87]) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "PrivacySettingManagementForm", "currentPage", 1) then
			CoD.OptionsUtility.ChangePrivacySettingDescPage(controller, element, "-1")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(controller, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0x464A086C0CC2A87]) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "PrivacySettingManagementForm", "currentPage", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(PrivacySettingsOptions)
	self.PrivacySettingsOptions = PrivacySettingsOptions
	Title = LUI.UIText.new(0.5, 0.5, -795.5, -70.5, 0, 0, 206.5, 260.5)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(LocalizeToUpperString(0x5EB6FED86163697))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	Body = LUI.UIText.new(0.5, 0.5, -795.5, -70.5, 0, 0, 292.5, 316.5)
	Body:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Body:setText(Engine[0xF9F1239CFD921FE](0xF42DFDF48767889))
	Body:setTTF("dinnext_regular")
	Body:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Body:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Body)
	self.Body = Body
	DescriptionText = LUI.UIText.new(0.5, 0.5, 9, 809, 0, 0, 206.5, 230.5)
	DescriptionText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DescriptionText:setTTF("dinnext_regular")
	DescriptionText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DescriptionText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	DescriptionText:subscribeToGlobalModel(f1_arg1, "PrivacySettingManagementForm", "descText", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			DescriptionText:setText(Engine[0xF9F1239CFD921FE](f13_local0))
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
CoD.StartMenu_Options_PrivacySettingsManagementForm.__onClose = function(f15_arg0)
	f15_arg0.PrivacySettingsOptions:close()
	f15_arg0.DescriptionText:close()
	f15_arg0.StartMenuOptionsPrivacySettingsScrollPrompt:close()
end
