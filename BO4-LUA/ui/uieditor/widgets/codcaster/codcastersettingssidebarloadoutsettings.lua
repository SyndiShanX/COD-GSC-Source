require("x64:1391e29b3804784")
require("x64:64bbc2f21267b33")
CoD.CodCasterSettingsSideBarLoadoutSettings = InheritFrom(LUI.UIElement)
CoD.CodCasterSettingsSideBarLoadoutSettings.__defaultWidth = 960
CoD.CodCasterSettingsSideBarLoadoutSettings.__defaultHeight = 1080
CoD.CodCasterSettingsSideBarLoadoutSettings.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterSettingsSideBarLoadoutSettings)
	self.id = "CodCasterSettingsSideBarLoadoutSettings"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OptionsListPC = nil
	OptionsListPC = CoD.CodCasterSettingsSideBarLoadoutSettingsContainer.new(f1_arg0, f1_arg1, 0, 0, 260, 960, 0, 0, 11, 800)
	OptionsListPC:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionsListPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		CoD.CodCasterUtility.SetFocusToFirstSelectableItemInButtonList(self, self.OptionsListPC)
		SetControllerModelValue(controller, "customGamesEdit", false)
		SetFocusToElement(self, "OptionCategoryListPC", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
		return true
	end, false)
	self:addElement(OptionsListPC)
	self.OptionsListPC = OptionsListPC
	local f1_local2 = nil
	local OptionCategoryListPC = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	OptionCategoryListPC:setLeftRight(0, 0, 0, 250)
	OptionCategoryListPC:setTopBottom(0, 0, 11, 475)
	OptionCategoryListPC:setWidgetType(CoD.CustomGames_OptionCategoryButton)
	OptionCategoryListPC:setVerticalCount(4)
	OptionCategoryListPC:setSpacing(8)
	OptionCategoryListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionCategoryListPC:setDataSource("CodCasterLoadoutSettingsCategories")
	OptionCategoryListPC:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local4 = OptionCategoryListPC
	local f1_local5 = OptionCategoryListPC.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	OptionCategoryListPC:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionCategoryListPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsMouse(controller) then
			SetControllerModelValue(controller, "customGamesEdit", true)
			SetElementState(self, element, controller, "Selected")
			SetFocusToElement(self, "OptionsListPC", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsMouse(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(OptionCategoryListPC)
	self.OptionCategoryListPC = OptionCategoryListPC
	f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.OptionsList = f1_local5
	f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.OptionCategoryList = f1_local4
	OptionsListPC:linkToElementModel(OptionCategoryListPC, "optionsListDatasource", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			OptionsListPC.ButtonList:setDataSource(f10_local0)
		end
	end)
	f1_local5:linkToElementModel(f1_local4, "optionsListDatasource", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			f1_local5.ButtonList:setDataSource(f11_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "EditSettings",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "customGamesEdit") and not IsPC()
			end,
		},
		{
			stateName = "DefaultPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	local f1_local7 = self
	f1_local6 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local7, f1_local8.customGamesEdit, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "customGamesEdit",
		})
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "Y", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			ToggleControllerModelValueNumber(controller, "CodCaster.showSettingsSideBar")
			CoD.CodCasterUtility.SetFocusToFirstSelectableItemInButtonList(self, self.OptionsList)
			SetFocusToElement(self, "OptionCategoryList", controller)
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.OptionCategoryList)
			MakeElementNotFocusable(self, "OptionsList", controller)
			SaveShoutcasterSettings(self, element, controller)
			GoBack(self, controller)
			SetLuiKeyCatcher(false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"menu/back", nil, "Y")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "customGamesEdit", false)
	end)
	self.__on_menuOpened_self = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
		local f18_local0 = self
		if not IsPC() then
			DelaySetFocusToElement(self, "OptionCategoryList", f18_arg1, 5)
		elseif IsPC() then
			DelaySetFocusToElement(self, "OptionCategoryListPC", f18_arg1, 5)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	if CoD.isPC then
		OptionsListPC.id = "OptionsListPC"
	end
	OptionCategoryListPC.id = "OptionCategoryListPC"
	f1_local5.id = "OptionsList"
	f1_local4.id = "OptionCategoryList"
	self.__defaultFocus = f1_local4
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	SetElementCanBeNavigatedTo(OptionCategoryListPC, false)
	SetElementCanBeNavigatedTo(f1_local4, false)
	return self
end
CoD.CodCasterSettingsSideBarLoadoutSettings.__resetProperties = function(f20_arg0)
	f20_arg0.OptionsList:completeAnimation()
	f20_arg0.OptionCategoryList:completeAnimation()
	f20_arg0.OptionsList:setAlpha(1)
	f20_arg0.OptionsList.OptionDesc.OptionTitle:setAlpha(1)
	f20_arg0.OptionsList.OptionDesc.OptionDesc:setAlpha(1)
	f20_arg0.OptionCategoryList:setAlpha(1)
end
CoD.CodCasterSettingsSideBarLoadoutSettings.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
			f21_arg0.OptionsList:completeAnimation()
			f21_arg0.OptionsList.OptionDesc.OptionTitle:completeAnimation()
			f21_arg0.OptionsList.OptionDesc.OptionDesc:completeAnimation()
			f21_arg0.OptionsList:setAlpha(0.12)
			f21_arg0.OptionsList.OptionDesc.OptionTitle:setAlpha(0)
			f21_arg0.OptionsList.OptionDesc.OptionDesc:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.OptionsList)
		end,
	},
	EditSettings = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
			f22_arg0.OptionCategoryList:completeAnimation()
			f22_arg0.OptionCategoryList:setAlpha(0.12)
			f22_arg0.clipFinished(f22_arg0.OptionCategoryList)
		end,
	},
	DefaultPC = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CodCasterSettingsSideBarLoadoutSettings.__onClose = function(f24_arg0)
	f24_arg0.__on_close_removeOverrides()
	f24_arg0.OptionsListPC:close()
	f24_arg0.OptionsList:close()
	f24_arg0.OptionCategoryListPC:close()
	f24_arg0.OptionCategoryList:close()
end
