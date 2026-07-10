require("x64:e9cfc3cb5356fa5")
require("x64:81a24c5340caa1e")
CoD.EmblemSelectSafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.EmblemSelectSafeAreaContainer.__defaultWidth = 1920
CoD.EmblemSelectSafeAreaContainer.__defaultHeight = 1080
CoD.EmblemSelectSafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemSelectSafeAreaContainer)
	self.id = "EmblemSelectSafeAreaContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CommonTabBar = CoD.CommonTabBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 35.5, 96.5)
	CommonTabBar.Tabs.grid:setDataSource("EmblemCategoryTabs")
	CommonTabBar:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		CoD.CraftUtility.EmblemSelect_TabChanged(self, element, f1_arg1)
		PlaySoundSetSound(self, "tab_changed")
		return f2_local0
	end)
	CommonTabBar:subscribeToGlobalModel(f1_arg1, "PerController", "Emblem.UpdateDataSource", function(model)
		UpdateTabDatasource(CommonTabBar)
	end)
	self:addElement(CommonTabBar)
	self.CommonTabBar = CommonTabBar
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	CommonTabBar.id = "CommonTabBar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemSelectSafeAreaContainer.__onClose = function(f4_arg0)
	f4_arg0.CommonTabBar:close()
	f4_arg0.TabBacking:close()
end
