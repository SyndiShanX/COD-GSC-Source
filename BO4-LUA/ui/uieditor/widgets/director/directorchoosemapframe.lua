require("x64:1bbde4283bb35f8")
require("x64:189db42984e831b")
require("x64:7cfaa6a68d4fa26")
require("x64:38c11a77e96e48c")
CoD.DirectorChooseMapFrame = InheritFrom(LUI.UIElement)
CoD.DirectorChooseMapFrame.__defaultWidth = 1920
CoD.DirectorChooseMapFrame.__defaultHeight = 804
CoD.DirectorChooseMapFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorChooseMapFrame)
	self.id = "DirectorChooseMapFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	local MapCategoryGridPC = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 8, 0, nil, nil, false, false, false, false)
	MapCategoryGridPC:setLeftRight(0, 0, 100, 500)
	MapCategoryGridPC:setTopBottom(0, 0, 0, 804)
	MapCategoryGridPC:setWidgetType(CoD.CustomGames_MapModeSlider)
	MapCategoryGridPC:setVerticalCount(14)
	MapCategoryGridPC:setSpacing(8)
	MapCategoryGridPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MapCategoryGridPC:setDataSource("MapCategories")
	MapCategoryGridPC:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapCategoryGridPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		SetCurrentElementAsActive(self, element, controller)
		SetControllerModelValue(controller, "mapModeSelection", true)
		SetFocusToElement(self, "MapListPC", controller)
		PlaySoundAlias("cac_open_wpn_cust")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(MapCategoryGridPC)
	self.MapCategoryGridPC = MapCategoryGridPC
	local f1_local3 = nil
	local MapListPC = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	MapListPC:setLeftRight(0, 0, 525, 925)
	MapListPC:setTopBottom(0, 0, 0, 804)
	MapListPC:setWidgetType(CoD.CustomGames_MapModeSlider)
	MapListPC:setVerticalCount(14)
	MapListPC:setSpacing(8)
	MapListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MapListPC:setVerticalCounter(CoD.verticalCounter)
	MapListPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.MapUtility.SetMapPreviewToElementMap(element, f1_arg1)
		return f5_local0
	end)
	MapListPC:registerEventHandler("gain_focus", function(element, event)
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
	f1_arg0:AddButtonCallbackFunction(MapListPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsElementPropertyValue(element, "purchasable", true) then
			OpenOverlay(self, "Store", controller)
			return true
		else
			CoD.MapUtility.SelectElementMap(element, controller)
			PlaySoundAlias("cac_open_wpn_cust")
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(MapListPC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.OptionsUtility.SetFocusToGrid(self.MapCategoryGridPC)
		SetControllerModelValue(controller, "mapModeSelection", false)
		DataSourceHelperRecreate(controller, "MapModePreview")
		PlaySoundAlias("cac_wpn_cust_exit")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self:addElement(MapListPC)
	self.MapListPC = MapListPC
	local f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.MapCategoryList = f1_local5
	local f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.MapList = f1_local6
	local MapModeInfo = CoD.CustomGames_MapModeInfo.new(f1_arg0, f1_arg1, 0, 0, 1019, 1819, 0, 0, 0, 804)
	MapModeInfo.OfficialBadge:setAlpha(0)
	MapModeInfo:subscribeToGlobalModel(f1_arg1, "MapModePreview", "mapName", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			MapModeInfo.PreviewInfoName:setText(ToUpper(MapNameToLocalizedMapName(f11_local0)))
		end
	end)
	MapModeInfo:subscribeToGlobalModel(f1_arg1, "MapModePreview", "mapName", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			MapModeInfo.PreviewInfoDesc:setText(MapNameToLocalizedMapDetailedDescription(f1_arg1, f12_local0))
		end
	end)
	self:addElement(MapModeInfo)
	self.MapModeInfo = MapModeInfo
	MapListPC:linkToElementModel(MapCategoryGridPC, "mapListDatasource", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			MapListPC:setDataSource(f13_local0)
		end
	end)
	f1_local6:linkToElementModel(f1_local5, "mapListDatasource", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			f1_local6:setDataSource(f14_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "ChooseMapPCKeyboardGamepad",
			condition = function(menu, element, event)
				local f15_local0 = IsGamepadOrKeyboardNavigation(f1_arg1)
				if f15_local0 then
					f15_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "mapModeSelection")
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
			stateName = "ChooseMap",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "mapModeSelection")
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f18_arg1)
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.mapModeSelection, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "mapModeSelection",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "mapModeSelection", false)
	end)
	MapCategoryGridPC.id = "MapCategoryGridPC"
	MapListPC.id = "MapListPC"
	f1_local5.id = "MapCategoryList"
	f1_local6.id = "MapList"
	self.__defaultFocus = f1_local5
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	DataSourceHelperRecreate(f1_arg1, "MapModePreview")
	f1_local9 = MapCategoryGridPC
	if IsPC() then
		CoD.OptionsUtility.SetFocusToGrid(f1_local9)
		SetElementCanBeNavigatedTo(f1_local9, false)
	end
	f1_local9 = MapListPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local9, false)
		CoD.GridAndListUtility.DisableKeyboardNavigationOnGridCounters(f1_local9)
		SetElementProperty(f1_local9, "ignoreSavedActive", true)
	end
	SetElementCanBeNavigatedTo(f1_local5, false)
	SetElementCanBeNavigatedTo(f1_local6, false)
	return self
end
CoD.DirectorChooseMapFrame.__resetProperties = function(f22_arg0)
	f22_arg0.MapList:completeAnimation()
	f22_arg0.MapCategoryGridPC:completeAnimation()
	f22_arg0.MapListPC:completeAnimation()
	f22_arg0.MapCategoryList:completeAnimation()
	f22_arg0.MapList:setAlpha(1)
	f22_arg0.MapCategoryGridPC:setAlpha(1)
	f22_arg0.MapListPC:setAlpha(1)
	f22_arg0.MapCategoryList:setAlpha(1)
end
CoD.DirectorChooseMapFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
			f23_arg0.MapList:completeAnimation()
			f23_arg0.MapList:setAlpha(0.12)
			f23_arg0.clipFinished(f23_arg0.MapList)
		end,
	},
	ChooseMapPCKeyboardGamepad = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.MapCategoryGridPC:completeAnimation()
			f24_arg0.MapCategoryGridPC:setAlpha(0.12)
			f24_arg0.clipFinished(f24_arg0.MapCategoryGridPC)
		end,
	},
	DefaultStatePCKeyboardGamepad = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.MapListPC:completeAnimation()
			f25_arg0.MapListPC:setAlpha(0.12)
			f25_arg0.clipFinished(f25_arg0.MapListPC)
		end,
	},
	ChooseMap = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
			f26_arg0.MapCategoryList:completeAnimation()
			f26_arg0.MapCategoryList:setAlpha(0.12)
			f26_arg0.clipFinished(f26_arg0.MapCategoryList)
		end,
	},
}
CoD.DirectorChooseMapFrame.__onClose = function(f27_arg0)
	f27_arg0.MapListPC:close()
	f27_arg0.MapList:close()
	f27_arg0.MapCategoryGridPC:close()
	f27_arg0.MapCategoryList:close()
	f27_arg0.MapModeInfo:close()
end
