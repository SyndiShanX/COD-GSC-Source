require("x64:78d9663be3f826")
require("x64:d6ecdf7755aeddc")
require("x64:81a24c5340caa1e")
require("x64:9dc2d0c43534ce4")
require("x64:e41af73729601d6")
CoD.ZMTalismanSafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.ZMTalismanSafeAreaContainer.__defaultWidth = 1920
CoD.ZMTalismanSafeAreaContainer.__defaultHeight = 1080
CoD.ZMTalismanSafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMTalismanSafeAreaContainer)
	self.id = "ZMTalismanSafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, 0, 0, -190, 2110, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local CACHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_4813595698C26EB"))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0.5, 1.5, -960, -960, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local CategoryTabs = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 35, 95)
	CategoryTabs.Tabs.grid:setWidgetType(CoD.CommonTabButton)
	CategoryTabs.Tabs.grid:setDataSource("TalismanCategories")
	self:addElement(CategoryTabs)
	self.CategoryTabs = CategoryTabs
	CategoryTabs.id = "CategoryTabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTalismanSafeAreaContainer.__onClose = function(f3_arg0)
	f3_arg0.TabBacking:close()
	f3_arg0.CACHeader:close()
	f3_arg0.BackingGrayMediumLeft:close()
	f3_arg0.CategoryTabs:close()
end
