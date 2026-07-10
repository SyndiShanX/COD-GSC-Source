require("x64:dbb73fb8fe6a257")
require("x64:1394ae5e9cdcb54")
CoD.AARTabButtonInternal = InheritFrom(LUI.UIElement)
CoD.AARTabButtonInternal.__defaultWidth = 1120
CoD.AARTabButtonInternal.__defaultHeight = 35
CoD.AARTabButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.AARTabButtonInternal)
	self.id = "AARTabButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -775, -575, 0, 0, 1, 31)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	LB.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("Q"))
	self:addElement(LB)
	self.LB = LB
	local Tabs = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	Tabs:setLeftRight(0.5, 0.5, -575, 575)
	Tabs:setTopBottom(0, 0, 0, 35)
	Tabs:setWidgetType(CoD.AARTabButton)
	Tabs:setHorizontalCount(5)
	Tabs:setSpacing(0)
	Tabs:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Tabs:setDataSource("AARTabs")
	self.__on_menuOpened_Tabs = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		CoD.AARUtility.SetActiveListItemToActiveTab(f2_arg1, f2_arg2, Tabs)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_Tabs)
	Tabs:subscribeToGlobalModel(f1_arg1, "PerController", "AAR.activeTab", function(model)
		CoD.AARUtility.SetActiveListItemToActiveTab(f1_arg1, f1_arg0, Tabs)
	end)
	self:addElement(Tabs)
	self.Tabs = Tabs
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 575, 775, 0, 0, 1, 35)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	RB.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("E"))
	self:addElement(RB)
	self.RB = RB
	Tabs.id = "Tabs"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_Tabs)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, Tabs, f1_arg1)
	return self
end
CoD.AARTabButtonInternal.__onClose = function(f5_arg0)
	f5_arg0.__on_close_removeOverrides()
	f5_arg0.LB:close()
	f5_arg0.Tabs:close()
	f5_arg0.RB:close()
end
