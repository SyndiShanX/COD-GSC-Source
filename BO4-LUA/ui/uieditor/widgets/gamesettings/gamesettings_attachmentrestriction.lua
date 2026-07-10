require("x64:64bbc2f21267b33")
require("x64:7863833f9bab54e")
require("x64:8c6423d3c47fd33")
require("x64:9583ae1e21ae4")
require("x64:38c11a77e96e48c")
CoD.GameSettings_AttachmentRestriction = InheritFrom(LUI.UIElement)
CoD.GameSettings_AttachmentRestriction.__defaultWidth = 1920
CoD.GameSettings_AttachmentRestriction.__defaultHeight = 877
CoD.GameSettings_AttachmentRestriction.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "operatorModCategoryIndex", 3)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.ActiveAttachmentCategoryIndex", nil)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.ActiveScopeCategoryIndex", nil)
	CoD.OptionsUtility.InitCurrentAttachmentCategoryIndex()
	self:setClass(CoD.GameSettings_AttachmentRestriction)
	self.id = "GameSettings_AttachmentRestriction"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	local AttachRestrictionCategoriesPC = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	AttachRestrictionCategoriesPC:setLeftRight(0, 0, 334, 1100)
	AttachRestrictionCategoriesPC:setTopBottom(0, 0, 20, 816)
	AttachRestrictionCategoriesPC:setScale(0.91, 1)
	AttachRestrictionCategoriesPC:setWidgetType(CoD.CustomGames_Restrictions_Button)
	AttachRestrictionCategoriesPC:setHorizontalCount(3)
	AttachRestrictionCategoriesPC:setVerticalCount(6)
	AttachRestrictionCategoriesPC:setSpacing(20)
	AttachRestrictionCategoriesPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AttachRestrictionCategoriesPC:setVerticalCounter(CoD.verticalCounter)
	AttachRestrictionCategoriesPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		GameSettingsButtonGainFocus(self, element, f1_arg1)
		SetCurrentElementAsActive(self, element, f1_arg1)
		return f2_local0
	end)
	AttachRestrictionCategoriesPC:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, false)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		return f3_local0
	end)
	AttachRestrictionCategoriesPC:registerEventHandler("lose_focus", function(element, event)
		local f4_local0 = nil
		if element.loseFocus then
			f4_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f4_local0 = element.super:loseFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, true)
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AttachRestrictionCategoriesPC, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(AttachRestrictionCategoriesPC, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		SetFocusToElement(self, "OptionCategoryGrid", controller)
		CoD.OptionsUtility.SetFocusToGrid(self.OptionCategoryGrid)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(AttachRestrictionCategoriesPC)
	self.AttachRestrictionCategoriesPC = AttachRestrictionCategoriesPC
	local f1_local3 = nil
	local SlidersPC = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	SlidersPC:setLeftRight(0, 0, 367, 1067)
	SlidersPC:setTopBottom(0, 0, 10, 818)
	SlidersPC:setWidgetType(CoD.CustomGames_SettingSlider)
	SlidersPC:setVerticalCount(12)
	SlidersPC:setSpacing(8)
	SlidersPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
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
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
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
	f1_arg0:AddButtonCallbackFunction(SlidersPC, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		SetFocusToElement(self, "OptionCategoryGrid", controller)
		CoD.OptionsUtility.SetFocusToGrid(self.OptionCategoryGrid)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x0, nil, nil)
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
	OptionCategoryGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionCategoryGrid:setDataSource("AttachmentRestrictionOptionCategories")
	OptionCategoryGrid:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionCategoryGrid, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		SetCurrentElementAsActive(self, element, controller)
		CoD.OptionsUtility.SetCurrentAttachmentCategoryIndex(element)
		CoD.OptionsUtility.SetFocusToAttachmentOptionsList(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(OptionCategoryGrid)
	self.OptionCategoryGrid = OptionCategoryGrid
	local f1_local7 = nil
	f1_local7 = LUI.UIElement.createFake()
	self.AttachRestrictionCategories = f1_local7
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
	AttachRestrictionCategoriesPC:linkToElementModel(OptionCategoryGrid, "optionsListDatasource", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			AttachRestrictionCategoriesPC:setDataSource(f17_local0)
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
			stateName = "OperatorModCategoryActive",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsOperatorModCategoryActive(self)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local12(f1_local11, f1_local13.CurrentAttachmentCategoryIndex, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "CurrentAttachmentCategoryIndex",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "customGamesEdit", false)
	end)
	AttachRestrictionCategoriesPC.id = "AttachRestrictionCategoriesPC"
	SlidersPC.id = "SlidersPC"
	OptionCategoryGrid.id = "OptionCategoryGrid"
	f1_local7.id = "AttachRestrictionCategories"
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
	f1_local12 = AttachRestrictionCategoriesPC
	if IsPC() then
		SetElementProperty(self.AttachRestrictionCategoriesPC, "openWeaponAttachment", true)
	end
	f1_local12 = SlidersPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local12, false)
		SetElementProperty(f1_local12, "ignoreSavedActive", true)
	end
	f1_local12 = f1_local7
	SetElementProperty(self.AttachRestrictionCategories, "openWeaponAttachment", true)
	SetElementCanBeNavigatedTo(f1_local12, false)
	SetElementCanBeNavigatedTo(f1_local8, false)
	SetElementCanBeNavigatedTo(f1_local9, false)
	return self
end
CoD.GameSettings_AttachmentRestriction.__resetProperties = function(f24_arg0)
	f24_arg0.OptionCategoryGrid:completeAnimation()
	f24_arg0.OptionCategoryList:completeAnimation()
	f24_arg0.SlidersPC:completeAnimation()
	f24_arg0.Sliders:completeAnimation()
	f24_arg0.AttachRestrictionCategories:completeAnimation()
	f24_arg0.AttachRestrictionCategoriesPC:completeAnimation()
	f24_arg0.OptionCategoryGrid:setAlpha(1)
	f24_arg0.OptionCategoryList:setAlpha(1)
	f24_arg0.SlidersPC:setAlpha(1)
	f24_arg0.Sliders:setAlpha(1)
	f24_arg0.AttachRestrictionCategories:setAlpha(1)
	f24_arg0.AttachRestrictionCategoriesPC:setAlpha(1)
end
CoD.GameSettings_AttachmentRestriction.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.SlidersPC:completeAnimation()
			f25_arg0.SlidersPC:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.SlidersPC)
			f25_arg0.OptionCategoryGrid:completeAnimation()
			f25_arg0.OptionCategoryGrid:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.OptionCategoryGrid)
			f25_arg0.Sliders:completeAnimation()
			f25_arg0.Sliders:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Sliders)
			f25_arg0.OptionCategoryList:completeAnimation()
			f25_arg0.OptionCategoryList:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.OptionCategoryList)
		end,
	},
	OperatorModCategoryActive = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.AttachRestrictionCategoriesPC:completeAnimation()
			f26_arg0.AttachRestrictionCategoriesPC:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.AttachRestrictionCategoriesPC)
			f26_arg0.SlidersPC:completeAnimation()
			f26_arg0.SlidersPC:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.SlidersPC)
			f26_arg0.AttachRestrictionCategories:completeAnimation()
			f26_arg0.AttachRestrictionCategories:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.AttachRestrictionCategories)
			f26_arg0.Sliders:completeAnimation()
			f26_arg0.Sliders:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.Sliders)
		end,
	},
}
CoD.GameSettings_AttachmentRestriction.__onClose = function(f27_arg0)
	f27_arg0.AttachRestrictionCategoriesPC:close()
	f27_arg0.SlidersPC:close()
	f27_arg0.AttachRestrictionCategories:close()
	f27_arg0.Sliders:close()
	f27_arg0.OptionCategoryGrid:close()
	f27_arg0.OptionCategoryList:close()
	f27_arg0.GameSettingsSelectedItemInfo:close()
end
