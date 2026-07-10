require("x64:78d9663be3f826")
require("x64:81a24c5340caa1e")
CoD.StartMenu_challengesOperationTab = InheritFrom(LUI.UIElement)
CoD.StartMenu_challengesOperationTab.__defaultWidth = 1920
CoD.StartMenu_challengesOperationTab.__defaultHeight = 62
CoD.StartMenu_challengesOperationTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_challengesOperationTab)
	self.id = "StartMenu_challengesOperationTab"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -1152, 1152, 0, 0, 51, 88)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local FETabBar = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -964, 964, 0, 0, 35, 97)
	FETabBar.Tabs.grid:setHorizontalCount(8)
	FETabBar.Tabs.grid:setDataSource("OperationsWZTabs")
	self:addElement(FETabBar)
	self.FETabBar = FETabBar
	FETabBar.id = "FETabBar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_challengesOperationTab.__onClose = function(f2_arg0)
	f2_arg0.TabBacking:close()
	f2_arg0.FETabBar:close()
end
