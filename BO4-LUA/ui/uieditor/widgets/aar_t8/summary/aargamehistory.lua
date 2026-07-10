require("x64:44bfdac7bcde7fa")
require("x64:92778f6892c4333")
require("x64:8303be9406fbc0d")
require("x64:ba8314cd1d6cfc3")
require("x64:8d9203449623ab5")
require("x64:68f610303e34085")
require("x64:194a3c2b978e81")
CoD.AARGameHistory = InheritFrom(LUI.UIElement)
CoD.AARGameHistory.__defaultWidth = 1160
CoD.AARGameHistory.__defaultHeight = 300
CoD.AARGameHistory.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARGameHistory)
	self.id = "AARGameHistory"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local GameHistoryBG = LUI.UIImage.new(0, 0, 0, 1160, 0, 0, 42, 276)
	GameHistoryBG:setImage(RegisterImage(@"uie_ui_menu_aar_info_grid_bg"))
	GameHistoryBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6E9593DF28749F2"))
	GameHistoryBG:setShaderVector(0, 4, 1, 0, 0)
	GameHistoryBG:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(GameHistoryBG)
	self.GameHistoryBG = GameHistoryBG
	local GameHistoryGridVline = LUI.UIImage.new(0, 0, 0, 1160, 0, 0, 45, 272)
	GameHistoryGridVline:setAlpha(0.2)
	GameHistoryGridVline:setImage(RegisterImage(@"uie_ui_menu_aar_info_grid_vline"))
	GameHistoryGridVline:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	GameHistoryGridVline:setShaderVector(0, 20, 1, 0, 0)
	GameHistoryGridVline:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(GameHistoryGridVline)
	self.GameHistoryGridVline = GameHistoryGridVline
	local GameHistoryGridHline2 = LUI.UIImage.new(0, 0, -1.5, 1162.5, 0, 0, 98, 102)
	GameHistoryGridHline2:setAlpha(0.2)
	GameHistoryGridHline2:setImage(RegisterImage(@"uie_ui_menu_aar_info_grid_hline"))
	GameHistoryGridHline2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GameHistoryGridHline2)
	self.GameHistoryGridHline2 = GameHistoryGridHline2
	local GameHistoryGridHline1 = LUI.UIImage.new(0, 0, -1.5, 1162.5, 0, 0, 214.5, 218.5)
	GameHistoryGridHline1:setAlpha(0.2)
	GameHistoryGridHline1:setImage(RegisterImage(@"uie_ui_menu_aar_info_grid_hline"))
	GameHistoryGridHline1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GameHistoryGridHline1)
	self.GameHistoryGridHline1 = GameHistoryGridHline1
	local GameHistoryGridSub = LUI.UIImage.new(0, 0, 0, 1160, 0, 0, 43, 277)
	GameHistoryGridSub:setAlpha(0.03)
	GameHistoryGridSub:setImage(RegisterImage(@"uie_ui_menu_aar_info_grid_sub"))
	GameHistoryGridSub:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	GameHistoryGridSub:setShaderVector(0, 4, 1, 0, 0)
	GameHistoryGridSub:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(GameHistoryGridSub)
	self.GameHistoryGridSub = GameHistoryGridSub
	local GameHistoryGridBracket2 = LUI.UIImage.new(0, 0, -2, 1162, 0, 0, 266, 278)
	GameHistoryGridBracket2:setZRot(180)
	GameHistoryGridBracket2:setImage(RegisterImage(@"uie_ui_menu_aar_info_grid_bracket"))
	GameHistoryGridBracket2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GameHistoryGridBracket2)
	self.GameHistoryGridBracket2 = GameHistoryGridBracket2
	local GameHistoryGridBracket1 = LUI.UIImage.new(0, 0, -2, 1162, 0, 0, 40, 52)
	GameHistoryGridBracket1:setImage(RegisterImage(@"uie_ui_menu_aar_info_grid_bracket"))
	GameHistoryGridBracket1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GameHistoryGridBracket1)
	self.GameHistoryGridBracket1 = GameHistoryGridBracket1
	local AverageMessage = CoD.AARAverageWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 1500, 0, 0, 275, 313)
	AverageMessage:setAlpha(0)
	AverageMessage:linkToElementModel(self, nil, false, function(model)
		AverageMessage:setModel(model, f1_arg1)
	end)
	self:addElement(AverageMessage)
	self.AverageMessage = AverageMessage
	local WinLoseMessage = CoD.AARWinLoseMessage.new(f1_arg0, f1_arg1, 0, 0, 0, 1500, 0, 0, 275, 313)
	WinLoseMessage:setAlpha(0)
	WinLoseMessage:linkToElementModel(self, nil, false, function(model)
		WinLoseMessage:setModel(model, f1_arg1)
	end)
	self:addElement(WinLoseMessage)
	self.WinLoseMessage = WinLoseMessage
	local StatTypeBar = LUI.UIImage.new(0, 0, -2.5, 1161.5, 0, 0, -3, 1)
	StatTypeBar:setAlpha(0.4)
	StatTypeBar:setImage(RegisterImage(@"uie_ui_menu_aar_stat_rt_navbar"))
	StatTypeBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(StatTypeBar)
	self.StatTypeBar = StatTypeBar
	local CommonSecondaryTabBar = CoD.CommonSecondaryTabBar.new(f1_arg0, f1_arg1, 0, 0, 63, 1148, 0, 0, -13, 48)
	CommonSecondaryTabBar.Tabs.grid:setWidgetType(CoD.AARStatTypeTabHeader)
	CommonSecondaryTabBar.Tabs.grid:setHorizontalCount(8)
	CommonSecondaryTabBar.Tabs.grid:setDataSource("AARStatTypeTabHeader")
	CommonSecondaryTabBar:registerEventHandler("list_active_changed", function(element, event)
		local f4_local0 = nil
		CoD.AARUtility.AARStatTypeSwitch(f1_arg1, self, element, event)
		return f4_local0
	end)
	self:addElement(CommonSecondaryTabBar)
	self.CommonSecondaryTabBar = CommonSecondaryTabBar
	local StatAvgBar = CoD.AARGameHistoryAvg.new(f1_arg0, f1_arg1, 0, 0, -76, 1235, 0, 0, 146.5, 169.5)
	self:addElement(StatAvgBar)
	self.StatAvgBar = StatAvgBar
	local GameHistoryGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -8, 0, nil, nil, false, false, false, false)
	GameHistoryGrid:setLeftRight(0, 0, -4, 1164)
	GameHistoryGrid:setTopBottom(0, 0, 41.5, 277.5)
	GameHistoryGrid:setWidgetType(CoD.AARNumericalStatHistory)
	GameHistoryGrid:setHorizontalCount(10)
	GameHistoryGrid:setSpacing(-8)
	GameHistoryGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameHistoryGrid:setDataSource("AARGameHistory")
	GameHistoryGrid:subscribeToGlobalModel(f1_arg1, "PerController", "AAR.activeStat", function(model)
		CoD.GridAndListUtility.UpdateDataSource(GameHistoryGrid, true, true, true)
	end)
	self:addElement(GameHistoryGrid)
	self.GameHistoryGrid = GameHistoryGrid
	local Last10Games = LUI.UIText.new(0, 0, 0, 855, 0, 0, -38, 0)
	Last10Games:setRGB(0.9, 0.89, 0.78)
	Last10Games:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_134099EC43595F0"))
	Last10Games:setTTF("dinnext_regular")
	Last10Games:setLetterSpacing(10)
	Last10Games:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Last10Games:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Last10Games)
	self.Last10Games = Last10Games
	local AARCompactHistoryMessage = CoD.AARCompactHistoryMessage.new(f1_arg0, f1_arg1, 0, 0, 756, 1336, 0, 0, -39, -1)
	AARCompactHistoryMessage:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsWinLoseStat(f1_arg1)
			end,
		},
	})
	local f1_local16 = AARCompactHistoryMessage
	local f1_local17 = AARCompactHistoryMessage.subscribeToModel
	local f1_local18 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local17(f1_local16, f1_local18["AAR.activeStat"], function(f7_arg0)
		f1_arg0:updateElementState(AARCompactHistoryMessage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "AAR.activeStat",
		})
	end, false)
	AARCompactHistoryMessage:linkToElementModel(self, nil, false, function(model)
		AARCompactHistoryMessage:setModel(model, f1_arg1)
	end)
	self:addElement(AARCompactHistoryMessage)
	self.AARCompactHistoryMessage = AARCompactHistoryMessage
	CommonSecondaryTabBar.id = "CommonSecondaryTabBar"
	GameHistoryGrid.id = "GameHistoryGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local17 = self
	CoD.AARUtility.RegisterForTriggerNavigation(f1_arg0, CommonSecondaryTabBar, f1_arg1, "Tabs.grid", CoD.AARUtility.AARTabs.AAR_SUMMARY)
	return self
end
CoD.AARGameHistory.__onClose = function(f9_arg0)
	f9_arg0.AverageMessage:close()
	f9_arg0.WinLoseMessage:close()
	f9_arg0.CommonSecondaryTabBar:close()
	f9_arg0.StatAvgBar:close()
	f9_arg0.GameHistoryGrid:close()
	f9_arg0.AARCompactHistoryMessage:close()
end
