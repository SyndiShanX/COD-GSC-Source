require("x64:189db42984e831b")
require("x64:7cfaa6a68d4fa26")
require("x64:38c11a77e96e48c")
CoD.DirectorChooseGameTypeFrame = InheritFrom(LUI.UIElement)
CoD.DirectorChooseGameTypeFrame.__defaultWidth = 1920
CoD.DirectorChooseGameTypeFrame.__defaultHeight = 804
CoD.DirectorChooseGameTypeFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorChooseGameTypeFrame)
	self.id = "DirectorChooseGameTypeFrame"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	local GameTypeCategoryGridPC = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 8, 0, nil, nil, false, false, false, false)
	GameTypeCategoryGridPC:setLeftRight(0, 0, 100, 500)
	GameTypeCategoryGridPC:setTopBottom(0, 0, 0, 804)
	GameTypeCategoryGridPC:setWidgetType(CoD.CustomGames_MapModeSlider)
	GameTypeCategoryGridPC:setVerticalCount(14)
	GameTypeCategoryGridPC:setSpacing(8)
	GameTypeCategoryGridPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameTypeCategoryGridPC:setDataSource("GameTypeCategories")
	GameTypeCategoryGridPC:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GameTypeCategoryGridPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		SetCurrentElementAsActive(self, element, controller)
		SetControllerModelValue(controller, "mapModeSelection", true)
		SetFocusToElement(self, "GameTypeListPC", controller)
		PlaySoundAlias("cac_open_wpn_cust")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(GameTypeCategoryGridPC)
	self.GameTypeCategoryGridPC = GameTypeCategoryGridPC
	local f1_local3 = nil
	local GameTypeListPC = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	GameTypeListPC:setLeftRight(0, 0, 525, 925)
	GameTypeListPC:setTopBottom(0, 0, 0, 804)
	GameTypeListPC:setWidgetType(CoD.CustomGames_MapModeSlider)
	GameTypeListPC:setVerticalCount(14)
	GameTypeListPC:setSpacing(8)
	GameTypeListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameTypeListPC:setVerticalCounter(CoD.verticalCounter)
	GameTypeListPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.GameTypeUtility.SetGameTypePreviewToElementGameType(element, f1_arg1)
		return f5_local0
	end)
	GameTypeListPC:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GameTypeListPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		GameModeSelected(element, controller)
		PlaySoundAlias("cac_open_wpn_cust")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(GameTypeListPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.OptionsUtility.SetFocusToGrid(self.GameTypeCategoryGridPC)
		SetControllerModelValue(controller, "mapModeSelection", false)
		DataSourceHelperRecreate(controller, "MapModePreview")
		PlaySoundAlias("cac_wpn_cust_exit")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self:addElement(GameTypeListPC)
	self.GameTypeListPC = GameTypeListPC
	local f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.GameTypeCategoryList = f1_local5
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.GameTypeList = f1_local6
	local MapModeInfo = CoD.CustomGames_MapModeInfo.new(f1_arg0, f1_arg1, 0, 0, 1019, 1819, 0, 0, 0, 804)
	MapModeInfo:subscribeToGlobalModel(f1_arg1, "MapModePreview", "modeName", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			MapModeInfo.PreviewInfoName:setText(ToUpper(GameTypeToLocalizedGameType(f11_local0)))
		end
	end)
	MapModeInfo:subscribeToGlobalModel(f1_arg1, "MapModePreview", "modeName", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			MapModeInfo.PreviewInfoDesc:setText(GameTypeToLocalizedGameTypeDescription(f12_local0))
		end
	end)
	self:addElement(MapModeInfo)
	self.MapModeInfo = MapModeInfo
	GameTypeListPC:linkToElementModel(GameTypeCategoryGridPC, "gametypeListDatasource", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			GameTypeListPC:setDataSource(f13_local0)
		end
	end)
	f1_local6:linkToElementModel(f1_local5, "gametypeListDatasource", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			f1_local6:setDataSource(f14_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "ChooseGametypePCKeyboardGamepad",
			condition = function(menu, element, event)
				local f15_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "mapModeSelection")
				if f15_local0 then
					f15_local0 = IsGamepadOrKeyboardNavigation(f1_arg1)
					if f15_local0 then
						f15_local0 = IsPC()
					end
				end
				return f15_local0
			end,
		},
		{
			stateName = "DefaultStatePCKeyboardGamepad",
			condition = function(menu, element, event)
				return IsGamepadOrKeyboardNavigation(f1_arg1) and IsPC()
			end,
		},
		{
			stateName = "ChooseGametype",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "mapModeSelection")
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.mapModeSelection, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "mapModeSelection",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f19_arg1)
	end)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "mapModeSelection", false)
	end)
	GameTypeCategoryGridPC.id = "GameTypeCategoryGridPC"
	GameTypeListPC.id = "GameTypeListPC"
	f1_local5.id = "GameTypeCategoryList"
	f1_local6.id = "GameTypeList"
	self.__defaultFocus = f1_local5
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	DataSourceHelperRecreate(f1_arg1, "MapModePreview")
	f1_local9 = GameTypeCategoryGridPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local9, false)
		CoD.OptionsUtility.SetFocusToGrid(f1_local9)
	end
	f1_local9 = GameTypeListPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local9, false)
		CoD.GridAndListUtility.DisableKeyboardNavigationOnGridCounters(f1_local9)
		SetElementProperty(f1_local9, "ignoreSavedActive", true)
	end
	SetElementCanBeNavigatedTo(f1_local5, false)
	SetElementCanBeNavigatedTo(f1_local6, false)
	return self
end
CoD.DirectorChooseGameTypeFrame.__resetProperties = function(f22_arg0)
	f22_arg0.GameTypeList:completeAnimation()
	f22_arg0.GameTypeCategoryGridPC:completeAnimation()
	f22_arg0.GameTypeListPC:completeAnimation()
	f22_arg0.GameTypeCategoryList:completeAnimation()
	f22_arg0.GameTypeList:setAlpha(1)
	f22_arg0.GameTypeCategoryGridPC:setAlpha(1)
	f22_arg0.GameTypeListPC:setAlpha(1)
	f22_arg0.GameTypeCategoryList:setAlpha(1)
end
CoD.DirectorChooseGameTypeFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
			f23_arg0.GameTypeList:completeAnimation()
			f23_arg0.GameTypeList:setAlpha(0.12)
			f23_arg0.clipFinished(f23_arg0.GameTypeList)
		end,
	},
	ChooseGametypePCKeyboardGamepad = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.GameTypeCategoryGridPC:completeAnimation()
			f24_arg0.GameTypeCategoryGridPC:setAlpha(0.12)
			f24_arg0.clipFinished(f24_arg0.GameTypeCategoryGridPC)
		end,
	},
	DefaultStatePCKeyboardGamepad = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.GameTypeListPC:completeAnimation()
			f25_arg0.GameTypeListPC:setAlpha(0.12)
			f25_arg0.clipFinished(f25_arg0.GameTypeListPC)
		end,
	},
	ChooseGametype = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
			f26_arg0.GameTypeCategoryList:completeAnimation()
			f26_arg0.GameTypeCategoryList:setAlpha(0.12)
			f26_arg0.clipFinished(f26_arg0.GameTypeCategoryList)
		end,
	},
}
CoD.DirectorChooseGameTypeFrame.__onClose = function(f27_arg0)
	f27_arg0.GameTypeListPC:close()
	f27_arg0.GameTypeList:close()
	f27_arg0.GameTypeCategoryGridPC:close()
	f27_arg0.GameTypeCategoryList:close()
	f27_arg0.MapModeInfo:close()
end
