require("x64:64bbc2f21267b33")
require("x64:fb61775b944bf26")
require("x64:8c6423d3c47fd33")
require("x64:9583ae1e21ae4")
require("x64:38c11a77e96e48c")
CoD.GameSettings_Restriction = InheritFrom(LUI.UIElement)
CoD.GameSettings_Restriction.__defaultWidth = 1920
CoD.GameSettings_Restriction.__defaultHeight = 877
CoD.GameSettings_Restriction.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.OptionsUtility.InitCurrentActiveRestrictionCategoryIndex()
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.CACRestrictionTabIndex", nil)
	SetProperty(self, "CACCategoryIndex", 1)
	self:setClass(CoD.GameSettings_Restriction)
	self.id = "GameSettings_Restriction"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	local CACRestrictionCategoriesPC = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	CACRestrictionCategoriesPC:setLeftRight(0, 0, 335, 1101)
	CACRestrictionCategoriesPC:setTopBottom(0, 0, 19, 523)
	CACRestrictionCategoriesPC:setScale(0.91, 1)
	CACRestrictionCategoriesPC:setWidgetType(CoD.CustomGames_Restrictions_CategoryButton)
	CACRestrictionCategoriesPC:setHorizontalCount(3)
	CACRestrictionCategoriesPC:setVerticalCount(2)
	CACRestrictionCategoriesPC:setSpacing(20)
	CACRestrictionCategoriesPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CACRestrictionCategoriesPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		GameSettingsButtonGainFocus(self, element, f1_arg1)
		SetCurrentElementAsActive(self, element, f1_arg1)
		return f2_local0
	end)
	CACRestrictionCategoriesPC:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, false)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f3_local0
	end)
	CACRestrictionCategoriesPC:registerEventHandler("lose_focus", function(element, event)
		local f4_local0 = nil
		if element.loseFocus then
			f4_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f4_local0 = element.super:loseFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, true)
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CACRestrictionCategoriesPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(CACRestrictionCategoriesPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		SetFocusToElement(self, "OptionCategoryGrid", controller)
		CoD.OptionsUtility.SetFocusToGrid(self.OptionCategoryGrid)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(CACRestrictionCategoriesPC)
	self.CACRestrictionCategoriesPC = CACRestrictionCategoriesPC
	local f1_local3 = nil
	local SlidersPC = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	SlidersPC:setLeftRight(0, 0, 367, 1067)
	SlidersPC:setTopBottom(0, 0, 10, 818)
	SlidersPC:setWidgetType(CoD.CustomGames_SettingSlider)
	SlidersPC:setVerticalCount(12)
	SlidersPC:setSpacing(8)
	SlidersPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SlidersPC:setVerticalCounter(CoD.verticalCounter)
	SlidersPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		GameSettingsButtonGainFocus(self, element, f1_arg1)
		SetCurrentElementAsActive(self, element, f1_arg1)
		return f9_local0
	end)
	SlidersPC:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, false)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f10_local0
	end)
	SlidersPC:registerEventHandler("lose_focus", function(element, event)
		local f11_local0 = nil
		if element.loseFocus then
			f11_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f11_local0 = element.super:loseFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, true)
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SlidersPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		SetFocusToElement(self, "OptionCategoryGrid", controller)
		CoD.OptionsUtility.SetFocusToGrid(self.OptionCategoryGrid)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(SlidersPC)
	self.SlidersPC = SlidersPC
	local f1_local5 = nil
	local OptionCategoryGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 8, 0, nil, nil, false, false, false, false)
	OptionCategoryGrid:setLeftRight(0, 0, 100, 350)
	OptionCategoryGrid:setTopBottom(0, 0, 10, 710)
	OptionCategoryGrid:setWidgetType(CoD.CustomGames_OptionCategoryButton)
	OptionCategoryGrid:setVerticalCount(6)
	OptionCategoryGrid:setSpacing(8)
	OptionCategoryGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionCategoryGrid:setDataSource("RestrictionOptionCategories")
	OptionCategoryGrid:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionCategoryGrid, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		SetCurrentElementAsActive(self, element, controller)
		CoD.OptionsUtility.SetCurrentActiveRestrictionCategoryIndex(element)
		CoD.OptionsUtility.SetFocusToRestrictionOptionsList(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(OptionCategoryGrid)
	self.OptionCategoryGrid = OptionCategoryGrid
	local f1_local7 = nil
	f1_local7 = LUI.UIElement.createFake()
	self.CACRestrictionCategories = f1_local7
	local f1_local8 = nil
	f1_local8 = LUI.UIElement.createFake()
	self.Sliders = f1_local8
	local f1_local9 = nil
	f1_local9 = LUI.UIElement.createFake()
	self.OptionCategoryList = f1_local9
	local GameSettingsSelectedItemInfo = CoD.GameSettings_SelectedItemInfo.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.5, 0.5, 234, 436)
	GameSettingsSelectedItemInfo.GameModeName:setAlpha(0)
	self:addElement(GameSettingsSelectedItemInfo)
	self.GameSettingsSelectedItemInfo = GameSettingsSelectedItemInfo
	CACRestrictionCategoriesPC:linkToElementModel(OptionCategoryGrid, "optionsListDatasource", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			CACRestrictionCategoriesPC:setDataSource(f17_local0)
		end
	end)
	SlidersPC:linkToElementModel(OptionCategoryGrid, "optionsListDatasource", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			SlidersPC:setDataSource(f18_local0)
		end
	end)
	f1_local7:linkToElementModel(f1_local9, "optionsListDatasource", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			f1_local7:setDataSource(f19_local0)
		end
	end)
	f1_local8:linkToElementModel(f1_local9, "optionsListDatasource", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			f1_local8:setDataSource(f20_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "CACCategoryActive",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsCACCategoryActive(self)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getglobalmodel"]()
	f1_local12(f1_local11, f1_local13.ActiveRestrictionCategoryIndex, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "ActiveRestrictionCategoryIndex",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "customGamesEdit", false)
	end)
	CACRestrictionCategoriesPC.id = "CACRestrictionCategoriesPC"
	SlidersPC.id = "SlidersPC"
	OptionCategoryGrid.id = "OptionCategoryGrid"
	f1_local7.id = "CACRestrictionCategories"
	f1_local8.id = "Sliders"
	f1_local9.id = "OptionCategoryList"
	self.__defaultFocus = f1_local9
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.OptionCategoryGrid)
		ForceCheckDefaultPCFocus(self.OptionCategoryGrid, f1_arg0, f1_arg1)
	end
	f1_local12 = CACRestrictionCategoriesPC
	if IsPC() then
		SetElementProperty(self.CACRestrictionCategoriesPC, "openRestriction", true)
	end
	f1_local12 = SlidersPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local12, false)
		SetElementProperty(f1_local12, "ignoreSavedActive", true)
		SetElementProperty(self.SlidersPC, "openRestriction", false)
	end
	f1_local12 = f1_local7
	SetElementProperty(self.CACRestrictionCategories, "openRestriction", true)
	SetElementCanBeNavigatedTo(f1_local12, false)
	SetElementCanBeNavigatedTo(f1_local8, false)
	SetElementCanBeNavigatedTo(f1_local9, false)
	return self
end
CoD.GameSettings_Restriction.__resetProperties = function(f24_arg0)
	f24_arg0.CACRestrictionCategoriesPC:completeAnimation()
	f24_arg0.CACRestrictionCategories:completeAnimation()
	f24_arg0.Sliders:completeAnimation()
	f24_arg0.SlidersPC:completeAnimation()
	f24_arg0.CACRestrictionCategoriesPC:setAlpha(1)
	f24_arg0.CACRestrictionCategories:setAlpha(1)
	f24_arg0.Sliders:setAlpha(1)
	f24_arg0.SlidersPC:setAlpha(1)
end
CoD.GameSettings_Restriction.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.CACRestrictionCategoriesPC:completeAnimation()
			f25_arg0.CACRestrictionCategoriesPC:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CACRestrictionCategoriesPC)
			f25_arg0.CACRestrictionCategories:completeAnimation()
			f25_arg0.CACRestrictionCategories:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CACRestrictionCategories)
		end,
	},
	CACCategoryActive = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.CACRestrictionCategoriesPC:completeAnimation()
			f26_arg0.CACRestrictionCategoriesPC:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.CACRestrictionCategoriesPC)
			f26_arg0.SlidersPC:completeAnimation()
			f26_arg0.SlidersPC:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.SlidersPC)
			f26_arg0.Sliders:completeAnimation()
			f26_arg0.Sliders:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Sliders)
		end,
	},
}
CoD.GameSettings_Restriction.__onClose = function(f27_arg0)
	f27_arg0.CACRestrictionCategoriesPC:close()
	f27_arg0.SlidersPC:close()
	f27_arg0.CACRestrictionCategories:close()
	f27_arg0.Sliders:close()
	f27_arg0.OptionCategoryGrid:close()
	f27_arg0.OptionCategoryList:close()
	f27_arg0.GameSettingsSelectedItemInfo:close()
end
