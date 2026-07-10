require("x64:1394ae5e9cdcb54")
require("x64:81a24c5340caa1e")
require("x64:eeb1847d838c6b1")
CoD.CustomGames_CatgeoryTabs = InheritFrom(LUI.UIElement)
CoD.CustomGames_CatgeoryTabs.__defaultWidth = 1920
CoD.CustomGames_CatgeoryTabs.__defaultHeight = 98
CoD.CustomGames_CatgeoryTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.CustomGames_CatgeoryTabs)
	self.id = "CustomGames_CatgeoryTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -2, 3, 0, 0, 0, 0, 52, 89)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 0, 0, 53, 87)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.categoryTabsList = f1_local3
	local f1_local4 = nil
	local categoryTabsListPC = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	categoryTabsListPC:setLeftRight(0, 0, 0, 1150)
	categoryTabsListPC:setTopBottom(0, 0, 52, 87)
	categoryTabsListPC:setWidgetType(CoD.CACTabButtonInternal)
	categoryTabsListPC:setHorizontalCount(5)
	categoryTabsListPC:setSpacing(0)
	categoryTabsListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	categoryTabsListPC:setStaggeredIntroTime(50)
	categoryTabsListPC:setDataSource("GameSettingsTabs")
	categoryTabsListPC:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		if IsPC() and IsGamepad(f1_arg1) then
			CoD.OptionsUtility.GameSettingsTabChanged(self, element, f1_arg1)
			CoD.PCOptionsUtility.GameSettingsFrameLoseFocus(f1_arg0, f1_arg1)
		else
			CoD.OptionsUtility.GameSettingsTabChanged(self, element, f1_arg1)
		end
		return f2_local0
	end)
	self:addElement(categoryTabsListPC)
	self.categoryTabsListPC = categoryTabsListPC
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 1720, 1920, 0, 0, 53, 87)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	f1_local3.id = "categoryTabsList"
	categoryTabsListPC.id = "categoryTabsListPC"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	f1_local7 = f1_local3
	if not IsPC() then
		CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local7, f1_arg1)
	end
	f1_local7 = categoryTabsListPC
	if IsPC() then
		CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local7, f1_arg1)
		DisableKeyboardNavigationByElement(f1_local7)
	end
	return self
end
CoD.CustomGames_CatgeoryTabs.__onClose = function(f3_arg0)
	f3_arg0.TabBacking:close()
	f3_arg0.LB:close()
	f3_arg0.categoryTabsList:close()
	f3_arg0.categoryTabsListPC:close()
	f3_arg0.RB:close()
end
