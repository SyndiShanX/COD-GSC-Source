require("x64:1394ae5e9cdcb54")
require("x64:eeb1847d838c6b1")
CoD.CodCaster_Settings_CategoryTabs = InheritFrom(LUI.UIElement)
CoD.CodCaster_Settings_CategoryTabs.__defaultWidth = 1050
CoD.CodCaster_Settings_CategoryTabs.__defaultHeight = 37
CoD.CodCaster_Settings_CategoryTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.CodCaster_Settings_CategoryTabs)
	self.id = "CodCaster_Settings_CategoryTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 597.5, 797.5, 0, 0, 0, 34)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local f1_local2 = nil
	local categoryTabsListPC = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	categoryTabsListPC:setLeftRight(0, 0, -557.5, 592.5)
	categoryTabsListPC:setTopBottom(0, 0, 0, 35)
	categoryTabsListPC:setWidgetType(CoD.CACTabButtonInternal)
	categoryTabsListPC:setHorizontalCount(5)
	categoryTabsListPC:setSpacing(0)
	categoryTabsListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	categoryTabsListPC:setStaggeredIntroTime(50)
	categoryTabsListPC:setDataSource("CodCasterSettingsTabs")
	categoryTabsListPC:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		CoD.OptionsUtility.GameSettingsTabChanged(self, element, f1_arg1)
		return f2_local0
	end)
	self:addElement(categoryTabsListPC)
	self.categoryTabsListPC = categoryTabsListPC
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.categoryTabsList = f1_local4
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 1, 1, 357.5, 557.5, 0, 0, 0, 34)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	categoryTabsListPC.id = "categoryTabsListPC"
	f1_local4.id = "categoryTabsList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	f1_local6 = categoryTabsListPC
	if IsPC() then
		CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local6, f1_arg1)
	end
	f1_local6 = f1_local4
	if not IsPC() then
		CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local6, f1_arg1)
	end
	return self
end
CoD.CodCaster_Settings_CategoryTabs.__onClose = function(f3_arg0)
	f3_arg0.LB:close()
	f3_arg0.categoryTabsListPC:close()
	f3_arg0.categoryTabsList:close()
	f3_arg0.RB:close()
end
