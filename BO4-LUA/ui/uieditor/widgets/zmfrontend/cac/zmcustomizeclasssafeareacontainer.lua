require("x64:d6ecdf7755aeddc")
require("x64:81a24c5340caa1e")
require("x64:13057df4515f516")
require("x64:421a7ba804db0fa")
CoD.ZMCustomizeClassSafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.ZMCustomizeClassSafeAreaContainer.__defaultWidth = 1920
CoD.ZMCustomizeClassSafeAreaContainer.__defaultHeight = 1080
CoD.ZMCustomizeClassSafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMCustomizeClassSafeAreaContainer)
	self.id = "ZMCustomizeClassSafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -0.1, 1.1, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local CACHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_43E876868767ECEB"))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	CACHeader:linkToElementModel(self, nil, false, function(model)
		CACHeader:setModel(model, f1_arg1)
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local customClassList = CoD.ZMCustomClassTabs.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 35.5, 95.5)
	self:addElement(customClassList)
	self.customClassList = customClassList
	local ZMStoryTabs = CoD.ZMStoryTabs.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 2, 62)
	self:addElement(ZMStoryTabs)
	self.ZMStoryTabs = ZMStoryTabs
	customClassList.id = "customClassList"
	ZMStoryTabs.id = "ZMStoryTabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMCustomizeClassSafeAreaContainer.__onClose = function(f4_arg0)
	f4_arg0.TabBacking:close()
	f4_arg0.CACHeader:close()
	f4_arg0.customClassList:close()
	f4_arg0.ZMStoryTabs:close()
end
