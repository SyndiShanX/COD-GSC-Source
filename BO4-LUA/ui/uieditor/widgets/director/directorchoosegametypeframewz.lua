require("x64:189db42984e831b")
require("x64:7cfaa6a68d4fa26")
require("x64:38c11a77e96e48c")
CoD.DirectorChooseGameTypeFrameWZ = InheritFrom(LUI.UIElement)
CoD.DirectorChooseGameTypeFrameWZ.__defaultWidth = 1920
CoD.DirectorChooseGameTypeFrameWZ.__defaultHeight = 804
CoD.DirectorChooseGameTypeFrameWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorChooseGameTypeFrameWZ)
	self.id = "DirectorChooseGameTypeFrameWZ"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local GameTypeList = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	GameTypeList:setLeftRight(0, 0, 100, 500)
	GameTypeList:setTopBottom(0, 0, 0, 804)
	GameTypeList:setWidgetType(CoD.CustomGames_MapModeSlider)
	GameTypeList:setVerticalCount(14)
	GameTypeList:setSpacing(8)
	GameTypeList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameTypeList:setVerticalCounter(CoD.verticalCounter)
	GameTypeList:setDataSource("GameTypeListWZ")
	local f1_local2 = GameTypeList
	local MapModeInfo = GameTypeList.subscribeToModel
	local f1_local4 = DataSources.MapVote.getModel(f1_arg1)
	MapModeInfo(f1_local2, f1_local4.mapVoteGameModeNext, function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local2 = GameTypeList
	MapModeInfo = GameTypeList.subscribeToModel
	f1_local4 = DataSources.MapVote.getModel(f1_arg1)
	MapModeInfo(f1_local2, f1_local4.mapVoteMapNext, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	GameTypeList:linkToElementModel(GameTypeList, "id", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	GameTypeList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.GameTypeUtility.SetGameTypePreviewToElementGameType(element, f1_arg1)
		return f5_local0
	end)
	GameTypeList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GameTypeList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.DirectorUtility.IsElementMapOrGameTypeSelected(element, controller) then
			GameModeSelected(element, controller)
			PlaySoundAlias("uin_main_nav")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.DirectorUtility.IsElementMapOrGameTypeSelected(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(GameTypeList)
	self.GameTypeList = GameTypeList
	MapModeInfo = CoD.CustomGames_MapModeInfo.new(f1_arg0, f1_arg1, 0, 0, 1019, 1819, 0, 0, 0, 804)
	MapModeInfo:subscribeToGlobalModel(f1_arg1, "MapModePreview", "modeName", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			MapModeInfo.PreviewInfoName:setText(ToUpper(GameTypeToLocalizedGameType(f9_local0)))
		end
	end)
	MapModeInfo:subscribeToGlobalModel(f1_arg1, "MapModePreview", "modeName", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			MapModeInfo.PreviewInfoDesc:setText(GameTypeToLocalizedGameTypeDescription(f10_local0))
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
	f1_local2 = self
	DataSourceHelperRecreate(f1_arg1, "MapModePreview")
	f1_local2 = GameTypeList
	if IsPC() then
		CoD.GridAndListUtility.DisableKeyboardNavigationOnGridCounters(f1_local2)
		SetElementProperty(f1_local2, "ignoreSavedActive", true)
	end
	return self
end
CoD.DirectorChooseGameTypeFrameWZ.__onClose = function(f12_arg0)
	f12_arg0.GameTypeList:close()
	f12_arg0.MapModeInfo:close()
end
