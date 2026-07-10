require("x64:dbb73fb8fe6a257")
require("x64:1394ae5e9cdcb54")
CoD.ReticleCategoryTabs = InheritFrom(LUI.UIElement)
CoD.ReticleCategoryTabs.__defaultWidth = 1120
CoD.ReticleCategoryTabs.__defaultHeight = 35
CoD.ReticleCategoryTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ReticleCategoryTabs)
	self.id = "ReticleCategoryTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -660, -460, 0, 0, 61, 91)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	LB.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("Q"))
	self:addElement(LB)
	self.LB = LB
	local Tabs = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	Tabs:setLeftRight(0.5, 0.5, -460, 460)
	Tabs:setTopBottom(0, 0, 61, 96)
	Tabs:setWidgetType(CoD.AARTabButton)
	Tabs:setHorizontalCount(4)
	Tabs:setSpacing(0)
	Tabs:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Tabs:setDataSource("ReticleCategoryTabs")
	Tabs:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		CoD.WeaponOptionsUtility.SetWeaponReticleFilterFromTab(f1_arg0, f1_arg1, element)
		CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_arg0, f1_arg0, f1_arg1)
		return f2_local0
	end)
	self:addElement(Tabs)
	self.Tabs = Tabs
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 460, 660, 0, 0, 61, 95)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	RB.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("E"))
	self:addElement(RB)
	self.RB = RB
	Tabs.id = "Tabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, Tabs, f1_arg1)
	return self
end
CoD.ReticleCategoryTabs.__onClose = function(f3_arg0)
	f3_arg0.LB:close()
	f3_arg0.Tabs:close()
	f3_arg0.RB:close()
end
