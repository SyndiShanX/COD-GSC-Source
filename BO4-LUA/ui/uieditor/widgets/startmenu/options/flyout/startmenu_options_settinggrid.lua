require("x64:447b94b1bc3bd97")
CoD.StartMenu_Options_SettingGrid = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SettingGrid.__defaultWidth = 600
CoD.StartMenu_Options_SettingGrid.__defaultHeight = 410
CoD.StartMenu_Options_SettingGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 2, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.StartMenu_Options_SettingGrid)
	self.id = "StartMenu_Options_SettingGrid"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local SettingTitle = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 21)
	SettingTitle:setAlpha(0.25)
	SettingTitle:setTTF("ttmussels_regular")
	SettingTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SettingTitle:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SettingTitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(SettingTitle)
	self.SettingTitle = SettingTitle
	local SettingsGrid = LUI.UIList.new(f1_arg0, f1_arg1, 3, 0, nil, false, false, false, false)
	SettingsGrid:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsPlayerSettingItemSelected(self, element, f1_arg1)
			end,
		},
	})
	local f1_local3 = SettingsGrid
	local f1_local4 = SettingsGrid.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.PlayerSettingsUpdate, function(f4_arg0)
		f1_arg0:updateElementState(SettingsGrid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	SettingsGrid:linkToElementModel(SettingsGrid, "currentSelection", true, function(model)
		f1_arg0:updateElementState(SettingsGrid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "currentSelection",
		})
	end)
	SettingsGrid:setLeftRight(0, 0, 0, 603)
	SettingsGrid:setTopBottom(0, 0, 23, 398)
	SettingsGrid:setWidgetType(CoD.StartMenu_Options_SettingGridItem)
	SettingsGrid:setHorizontalCount(2)
	SettingsGrid:setVerticalCount(6)
	SettingsGrid:setSpacing(3)
	SettingsGrid:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	SettingsGrid:linkToElementModel(self, "optionsDatasource", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			SettingsGrid:setDataSource(f6_local0)
		end
	end)
	SettingsGrid:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SettingsGrid, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		PlaySoundAlias("uin_paint_decal_nav")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(SettingsGrid, "setHeight", function(element, controller)
		RecalculateScaleToElementHeight(self, self)
	end)
	self:addElement(SettingsGrid)
	self.SettingsGrid = SettingsGrid
	SettingsGrid.id = "SettingsGrid"
	self.__defaultFocus = SettingsGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	CoD.OptionsUtility.InitPlayerSettingWidget(self, "SettingsGrid")
	f1_local4 = SettingsGrid
	return self
end
CoD.StartMenu_Options_SettingGrid.__onClose = function(f11_arg0)
	f11_arg0.SettingTitle:close()
	f11_arg0.SettingsGrid:close()
end
