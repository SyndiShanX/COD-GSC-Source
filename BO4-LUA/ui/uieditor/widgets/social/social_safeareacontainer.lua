require("ui/uieditor/widgets/common/commontabbar")
require("ui/uieditor/widgets/common/commontabbarbacking")
CoD.Social_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.Social_SafeAreaContainer.__defaultWidth = 1920
CoD.Social_SafeAreaContainer.__defaultHeight = 1080
CoD.Social_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_SafeAreaContainer)
	self.id = "Social_SafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local tabs = CoD.CommonTabBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 35.5, 97.5)
	tabs.Tabs.grid:setDataSource("SocialTabs")
	tabs:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		SetSocialTab(self, element, f1_arg1)
		FetchOnlineFriendsData(self, element, f1_arg1)
		return f2_local0
	end)
	self:addElement(tabs)
	self.tabs = tabs
	tabs.id = "tabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	DisableKeyboardNavigationByElement(tabs)
	return self
end
CoD.Social_SafeAreaContainer.__onClose = function(f3_arg0)
	f3_arg0.TabBacking:close()
	f3_arg0.tabs:close()
end
