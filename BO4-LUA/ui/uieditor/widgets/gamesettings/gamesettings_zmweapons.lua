require("x64:64bbc2f21267b33")
require("x64:8c6423d3c47fd33")
require("x64:9583ae1e21ae4")
require("x64:38c11a77e96e48c")
CoD.GameSettings_ZMWeapons = InheritFrom(LUI.UIElement)
CoD.GameSettings_ZMWeapons.__defaultWidth = 1920
CoD.GameSettings_ZMWeapons.__defaultHeight = 877
CoD.GameSettings_ZMWeapons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_ZMWeapons)
	self.id = "GameSettings_ZMWeapons"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GameSettingsSelectedItemInfo = CoD.GameSettings_SelectedItemInfo.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, -202, 0)
	GameSettingsSelectedItemInfo.GameModeName:setAlpha(0)
	self:addElement(GameSettingsSelectedItemInfo)
	self.GameSettingsSelectedItemInfo = GameSettingsSelectedItemInfo
	local f1_local2 = nil
	local OptionCategoryGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	OptionCategoryGrid:setLeftRight(0, 0, 100, 350)
	OptionCategoryGrid:setTopBottom(0, 0, 0, 782)
	OptionCategoryGrid:setWidgetType(CoD.CustomGames_OptionCategoryButton)
	OptionCategoryGrid:setVerticalCount(7)
	OptionCategoryGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionCategoryGrid:setDataSource("ZMWeaponsOptionCategories")
	OptionCategoryGrid:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionCategoryGrid, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		ShowWidget(self.SlidersPC)
		SetCurrentElementAsActive(self, element, controller)
		SetFocusToElement(self, "SlidersPC", controller)
		PlaySoundAlias("uin_party_ease_slide")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(OptionCategoryGrid)
	self.OptionCategoryGrid = OptionCategoryGrid
	local f1_local4 = nil
	local SlidersPC = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	SlidersPC:setLeftRight(0, 0, 367, 1067)
	SlidersPC:setTopBottom(0, 0, 0, 742)
	SlidersPC:setWidgetType(CoD.CustomGames_SettingSlider)
	SlidersPC:setVerticalCount(12)
	SlidersPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SlidersPC:setVerticalCounter(CoD.verticalCounter)
	SlidersPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		GameSettingsButtonGainFocus(self, element, f1_arg1)
		SetCurrentElementAsActive(self, element, f1_arg1)
		return f5_local0
	end)
	SlidersPC:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, false)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f6_local0
	end)
	SlidersPC:registerEventHandler("lose_focus", function(element, event)
		local f7_local0 = nil
		if element.loseFocus then
			f7_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f7_local0 = element.super:loseFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, true)
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SlidersPC, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], "ui_contextual_1", function(element, menu, controller, model)
		if AlwaysFalse() then
			OpenGameSettingsOptionsMenu(self, element, controller, menu)
			PlaySoundAlias("cac_open_wpn_cust_sub")
			return true
		else
		end
	end, function(element, menu, controller)
		if AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"menu/options", nil, "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SlidersPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		SetFocusToElement(self, "OptionCategoryGrid", controller)
		CoD.OptionsUtility.SetFocusToGrid(self.OptionCategoryGrid)
		PlaySoundAlias("uin_party_ease_slide_back")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(SlidersPC)
	self.SlidersPC = SlidersPC
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.Sliders = f1_local6
	local f1_local7 = nil
	f1_local7 = LUI.UIElement.createFake()
	self.OptionCategoryList = f1_local7
	SlidersPC:linkToElementModel(OptionCategoryGrid, "optionsListDatasource", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			SlidersPC:setDataSource(f12_local0)
		end
	end)
	f1_local6:linkToElementModel(f1_local7, "optionsListDatasource", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			f1_local6:setDataSource(f13_local0)
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
	f1_local9(f1_local8, f1_local10.customGamesEdit, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "customGamesEdit",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "customGamesEdit", false)
	end)
	OptionCategoryGrid.id = "OptionCategoryGrid"
	SlidersPC.id = "SlidersPC"
	f1_local6.id = "Sliders"
	f1_local7.id = "OptionCategoryList"
	self.__defaultFocus = f1_local7
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.OptionCategoryGrid)
		ForceCheckDefaultPCFocus(self.OptionCategoryGrid, f1_arg0, f1_arg1)
	end
	f1_local9 = SlidersPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local9, false)
		SetElementProperty(f1_local9, "ignoreSavedActive", true)
	end
	SetElementCanBeNavigatedTo(f1_local6, false)
	SetElementCanBeNavigatedTo(f1_local7, false)
	return self
end
CoD.GameSettings_ZMWeapons.__resetProperties = function(f18_arg0)
	f18_arg0.Sliders:completeAnimation()
	f18_arg0.OptionCategoryList:completeAnimation()
	f18_arg0.GameSettingsSelectedItemInfo:completeAnimation()
	f18_arg0.Sliders:setAlpha(1)
	f18_arg0.OptionCategoryList:setAlpha(1)
	f18_arg0.GameSettingsSelectedItemInfo.ToolTip:setAlpha(1)
end
CoD.GameSettings_ZMWeapons.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
			f19_arg0.Sliders:completeAnimation()
			f19_arg0.Sliders:setAlpha(0.1)
			f19_arg0.clipFinished(f19_arg0.Sliders)
		end,
	},
	EditSettings = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
			f20_arg0.OptionCategoryList:completeAnimation()
			f20_arg0.OptionCategoryList:setAlpha(0.4)
			f20_arg0.clipFinished(f20_arg0.OptionCategoryList)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.GameSettingsSelectedItemInfo:completeAnimation()
			f21_arg0.GameSettingsSelectedItemInfo.ToolTip:completeAnimation()
			f21_arg0.GameSettingsSelectedItemInfo.ToolTip:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.GameSettingsSelectedItemInfo)
		end,
	},
}
CoD.GameSettings_ZMWeapons.__onClose = function(f22_arg0)
	f22_arg0.SlidersPC:close()
	f22_arg0.Sliders:close()
	f22_arg0.GameSettingsSelectedItemInfo:close()
	f22_arg0.OptionCategoryGrid:close()
	f22_arg0.OptionCategoryList:close()
end
