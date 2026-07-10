require("x64:d6ecdf7755aeddc")
require("x64:71d2a0ed724628e")
require("x64:e9cfc3cb5356fa5")
require("x64:81a24c5340caa1e")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
CoD.MPSpecialistHUBTags_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.MPSpecialistHUBTags_SafeAreaContainer.__defaultWidth = 1920
CoD.MPSpecialistHUBTags_SafeAreaContainer.__defaultHeight = 1080
CoD.MPSpecialistHUBTags_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MPSpecialistHUBTags_SafeAreaContainer)
	self.id = "MPSpecialistHUBTags_SafeAreaContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -0.25, 1.25, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -48, 0)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xBB7AA7A26F39DFA))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local CommonTabBarLeftAlign = CoD.CommonTabBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 35, 96)
	CommonTabBarLeftAlign.Tabs.grid:setDataSource("TagCategories")
	self:addElement(CommonTabBarLeftAlign)
	self.CommonTabBarLeftAlign = CommonTabBarLeftAlign
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	local HeaderStripe = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	FooterContainerFrontendRight:appendEventHandler("menu_loaded", function()
		FooterContainerFrontendRight:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	CommonTabBarLeftAlign.id = "CommonTabBarLeftAlign"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MPSpecialistHUBTags_SafeAreaContainer.__onClose = function(f4_arg0)
	f4_arg0.TabBacking:close()
	f4_arg0.FooterContainerFrontendRight:close()
	f4_arg0.CommonHeader:close()
	f4_arg0.CommonTabBarLeftAlign:close()
	f4_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
	f4_arg0.HeaderStripe:close()
end
