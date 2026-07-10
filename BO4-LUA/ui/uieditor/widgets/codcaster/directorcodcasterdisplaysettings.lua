require("x64:64bbc2f21267b33")
require("x64:38c11a77e96e48c")
require("x64:48be5c6feaceeb4")
require("x64:d5504359f8c0fcd")
CoD.DirectorCodCasterDisplaySettings = InheritFrom(LUI.UIElement)
CoD.DirectorCodCasterDisplaySettings.__defaultWidth = 1920
CoD.DirectorCodCasterDisplaySettings.__defaultHeight = 1080
CoD.DirectorCodCasterDisplaySettings.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCodCasterDisplaySettings)
	self.id = "DirectorCodCasterDisplaySettings"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	local ButtonListPC = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	ButtonListPC:setLeftRight(0, 0, 366, 1066)
	ButtonListPC:setTopBottom(0, 0, 52, 722)
	ButtonListPC:setWidgetType(CoD.StartMenu_Options_SettingSlider)
	ButtonListPC:setVerticalCount(13)
	ButtonListPC:setSpacing(6)
	ButtonListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonListPC:setVerticalCounter(CoD.verticalCounter)
	ButtonListPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		GameSettingsButtonGainFocus(self, element, f1_arg1)
		SetCurrentElementAsActive(self, element, f1_arg1)
		return f2_local0
	end)
	ButtonListPC:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryListPC, false)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f3_local0
	end)
	ButtonListPC:registerEventHandler("lose_focus", function(element, event)
		local f4_local0 = nil
		if element.loseFocus then
			f4_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f4_local0 = element.super:loseFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryListPC, true)
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonListPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.ButtonListPC)
		SetControllerModelValue(controller, "customGamesEdit", false)
		SetFocusToElement(self, "OptionCategoryListPC", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self:addElement(ButtonListPC)
	self.ButtonListPC = ButtonListPC
	local f1_local3 = nil
	local OptionCategoryListPC = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	OptionCategoryListPC:setLeftRight(0, 0, 100, 350)
	OptionCategoryListPC:setTopBottom(0, 0, 52, 634)
	OptionCategoryListPC:setWidgetType(CoD.CustomGames_OptionCategoryButton)
	OptionCategoryListPC:setVerticalCount(5)
	OptionCategoryListPC:setSpacing(8)
	OptionCategoryListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionCategoryListPC:setDataSource("CodCasterDisplaySettingsCategories")
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
	f1_arg0:AddButtonCallbackFunction(OptionCategoryListPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		ShowWidget(self.ButtonListPC)
		SetCurrentElementAsActive(self, element, controller)
		SetFocusToElement(self, "ButtonListPC", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(OptionCategoryListPC)
	self.OptionCategoryListPC = OptionCategoryListPC
	local f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.ButtonList = f1_local5
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.OptionCategoryList = f1_local6
	local OptionInfo = CoD.StartMenu_Options_SettingInfo.new(f1_arg0, f1_arg1, 0, 0, 1088, 1788, 0, 0, 52, 156)
	self:addElement(OptionInfo)
	self.OptionInfo = OptionInfo
	ButtonListPC:linkToElementModel(OptionCategoryListPC, "optionsListDatasource", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ButtonListPC:setDataSource(f10_local0)
		end
	end)
	f1_local5:linkToElementModel(f1_local6, "optionsListDatasource", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			f1_local5:setDataSource(f11_local0)
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
			stateName = "DefaultStatePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.customGamesEdit, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "customGamesEdit",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "customGamesEdit", false)
	end)
	ButtonListPC.id = "ButtonListPC"
	OptionCategoryListPC.id = "OptionCategoryListPC"
	f1_local5.id = "ButtonList"
	f1_local6.id = "OptionCategoryList"
	self.__defaultFocus = f1_local6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.OptionCategoryListPC)
		ForceCheckDefaultPCFocus(self.OptionCategoryListPC, f1_arg0, f1_arg1)
	end
	f1_local9 = ButtonListPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local9, false)
		SetElementProperty(f1_local9, "ignoreSavedActive", true)
	end
	SetElementCanBeNavigatedTo(f1_local5, false)
	SetElementCanBeNavigatedTo(f1_local6, false)
	return self
end
CoD.DirectorCodCasterDisplaySettings.__resetProperties = function(f16_arg0)
	f16_arg0.ButtonList:completeAnimation()
	f16_arg0.OptionInfo:completeAnimation()
	f16_arg0.OptionCategoryList:completeAnimation()
	f16_arg0.ButtonList:setAlpha(1)
	f16_arg0.OptionInfo:setAlpha(1)
	f16_arg0.OptionCategoryList:setAlpha(1)
end
CoD.DirectorCodCasterDisplaySettings.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.ButtonList:completeAnimation()
			f17_arg0.ButtonList:setAlpha(0.12)
			f17_arg0.clipFinished(f17_arg0.ButtonList)
			f17_arg0.OptionInfo:completeAnimation()
			f17_arg0.OptionInfo:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.OptionInfo)
		end,
	},
	EditSettings = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
			f18_arg0.OptionCategoryList:completeAnimation()
			f18_arg0.OptionCategoryList:setAlpha(0.12)
			f18_arg0.clipFinished(f18_arg0.OptionCategoryList)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorCodCasterDisplaySettings.__onClose = function(f20_arg0)
	f20_arg0.ButtonListPC:close()
	f20_arg0.ButtonList:close()
	f20_arg0.OptionCategoryListPC:close()
	f20_arg0.OptionCategoryList:close()
	f20_arg0.OptionInfo:close()
end
