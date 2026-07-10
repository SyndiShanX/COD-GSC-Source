require("x64:64bbc2f21267b33")
require("x64:8c6423d3c47fd33")
require("x64:9583ae1e21ae4")
require("x64:38c11a77e96e48c")
CoD.GameSettings_GearRestriction = InheritFrom(LUI.UIElement)
CoD.GameSettings_GearRestriction.__defaultWidth = 1920
CoD.GameSettings_GearRestriction.__defaultHeight = 877
CoD.GameSettings_GearRestriction.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_GearRestriction)
	self.id = "GameSettings_GearRestriction"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local f1_local1 = nil
	local OptionCategoryGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 8, 0, nil, nil, false, false, false, false)
	OptionCategoryGrid:setLeftRight(0, 0, 100, 350)
	OptionCategoryGrid:setTopBottom(0, 0, 10, 710)
	OptionCategoryGrid:setAlpha(0)
	OptionCategoryGrid:setWidgetType(CoD.CustomGames_OptionCategoryButton)
	OptionCategoryGrid:setVerticalCount(6)
	OptionCategoryGrid:setSpacing(8)
	OptionCategoryGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionCategoryGrid:setDataSource("GearRestrictionOptionCategories")
	self:addElement(OptionCategoryGrid)
	self.OptionCategoryGrid = OptionCategoryGrid
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
		local f2_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		GameSettingsButtonGainFocus(self, element, f1_arg1)
		SetCurrentElementAsActive(self, element, f1_arg1)
		return f2_local0
	end)
	SlidersPC:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, false)
		return f3_local0
	end)
	SlidersPC:registerEventHandler("lose_focus", function(element, event)
		local f4_local0 = nil
		if element.loseFocus then
			f4_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f4_local0 = element.super:loseFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, true)
		return f4_local0
	end)
	self:addElement(SlidersPC)
	self.SlidersPC = SlidersPC
	local f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.OptionCategoryList = f1_local5
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.Sliders = f1_local6
	local GameSettingsSelectedItemInfo = CoD.GameSettings_SelectedItemInfo.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.5, 0.5, 234, 436)
	GameSettingsSelectedItemInfo.GameModeName:setAlpha(0)
	self:addElement(GameSettingsSelectedItemInfo)
	self.GameSettingsSelectedItemInfo = GameSettingsSelectedItemInfo
	SlidersPC:linkToElementModel(OptionCategoryGrid, "optionsListDatasource", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SlidersPC:setDataSource(f5_local0)
		end
	end)
	f1_local6:linkToElementModel(f1_local5, "optionsListDatasource", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			f1_local6:setDataSource(f6_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "customGamesEdit", false)
	end)
	OptionCategoryGrid.id = "OptionCategoryGrid"
	SlidersPC.id = "SlidersPC"
	f1_local5.id = "OptionCategoryList"
	f1_local6.id = "Sliders"
	self.__defaultFocus = f1_local6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.SlidersPC)
		ForceCheckDefaultPCFocus(self.SlidersPC, f1_arg0, f1_arg1)
	end
	f1_local8 = SlidersPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local8, false)
		SetElementProperty(f1_local8, "ignoreSavedActive", true)
	end
	SetElementCanBeNavigatedTo(f1_local6, false)
	return self
end
CoD.GameSettings_GearRestriction.__onClose = function(f8_arg0)
	f8_arg0.SlidersPC:close()
	f8_arg0.Sliders:close()
	f8_arg0.OptionCategoryGrid:close()
	f8_arg0.OptionCategoryList:close()
	f8_arg0.GameSettingsSelectedItemInfo:close()
end
