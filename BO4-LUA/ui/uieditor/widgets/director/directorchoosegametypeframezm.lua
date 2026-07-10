require("x64:189db42984e831b")
require("x64:7cfaa6a68d4fa26")
require("x64:38c11a77e96e48c")
CoD.DirectorChooseGameTypeFrameZM = InheritFrom(LUI.UIElement)
CoD.DirectorChooseGameTypeFrameZM.__defaultWidth = 1920
CoD.DirectorChooseGameTypeFrameZM.__defaultHeight = 804
CoD.DirectorChooseGameTypeFrameZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorChooseGameTypeFrameZM)
	self.id = "DirectorChooseGameTypeFrameZM"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local GameTypeList = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	GameTypeList:setLeftRight(0, 0, 100, 500)
	GameTypeList:setTopBottom(0, 0, 0, 804)
	GameTypeList:setWidgetType(CoD.CustomGames_MapModeSlider)
	GameTypeList:setVerticalCount(14)
	GameTypeList:setSpacing(8)
	GameTypeList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GameTypeList:setVerticalCounter(CoD.verticalCounter)
	GameTypeList:setDataSource("GameTypeListZM")
	GameTypeList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		CoD.GameTypeUtility.SetGameTypePreviewToElementGameType(element, f1_arg1)
		return f2_local0
	end)
	GameTypeList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GameTypeList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		GameModeSelected(element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(GameTypeList)
	self.GameTypeList = GameTypeList
	local MapModeInfo = CoD.CustomGames_MapModeInfo.new(f1_arg0, f1_arg1, 0, 0, 1019, 1819, 0, 0, 0, 804)
	MapModeInfo:subscribeToGlobalModel(f1_arg1, "MapModePreview", "modeName", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MapModeInfo.PreviewInfoName:setText(ToUpper(GameTypeToLocalizedGameType(f6_local0)))
		end
	end)
	MapModeInfo:subscribeToGlobalModel(f1_arg1, "MapModePreview", "modeName", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			MapModeInfo.PreviewInfoDesc:setText(GameTypeToLocalizedGameTypeDescription(f7_local0))
		end
	end)
	self:addElement(MapModeInfo)
	self.MapModeInfo = MapModeInfo
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "mapModeSelection", false)
	end)
	GameTypeList.id = "GameTypeList"
	self.__defaultFocus = GameTypeList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	DataSourceHelperRecreate(f1_arg1, "MapModePreview")
	f1_local3 = GameTypeList
	if IsPC() then
		CoD.GridAndListUtility.DisableKeyboardNavigationOnGridCounters(f1_local3)
		SetElementProperty(f1_local3, "ignoreSavedActive", true)
	end
	return self
end
CoD.DirectorChooseGameTypeFrameZM.__onClose = function(f9_arg0)
	f9_arg0.GameTypeList:close()
	f9_arg0.MapModeInfo:close()
end
