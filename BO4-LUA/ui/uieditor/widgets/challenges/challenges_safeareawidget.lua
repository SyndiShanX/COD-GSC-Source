require("x64:78d9663be3f826")
require("x64:81a24c5340caa1e")
CoD.Challenges_SafeAreaWidget = InheritFrom(LUI.UIElement)
CoD.Challenges_SafeAreaWidget.__defaultWidth = 1920
CoD.Challenges_SafeAreaWidget.__defaultHeight = 1080
CoD.Challenges_SafeAreaWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_SafeAreaWidget)
	self.id = "Challenges_SafeAreaWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, 0, 1, -193, 193, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local FETabBar = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -964, 964, 0, 0, 36, 98)
	FETabBar.Tabs.grid:setHorizontalCount(8)
	FETabBar.Tabs.grid:setDataSource("ChallengesTabs")
	self:addElement(FETabBar)
	self.FETabBar = FETabBar
	FETabBar.id = "FETabBar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_SafeAreaWidget.__onClose = function(f2_arg0)
	f2_arg0.TabBacking:close()
	f2_arg0.FETabBar:close()
end
