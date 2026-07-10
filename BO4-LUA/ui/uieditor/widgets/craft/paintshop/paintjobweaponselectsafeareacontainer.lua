require("x64:d6ecdf7755aeddc")
require("x64:81a24c5340caa1e")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
CoD.PaintjobWeaponSelectSafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.PaintjobWeaponSelectSafeAreaContainer.__defaultWidth = 1920
CoD.PaintjobWeaponSelectSafeAreaContainer.__defaultHeight = 1080
CoD.PaintjobWeaponSelectSafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintjobWeaponSelectSafeAreaContainer)
	self.id = "PaintjobWeaponSelectSafeAreaContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -48, 0)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(Engine[0xF9F1239CFD921FE](0x93CE015442D7E04))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyMainMode", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f2_local0)))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -1, 3, -960, -960, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local TopBar = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(TopBar)
	self.TopBar = TopBar
	FooterContainerFrontendRight:appendEventHandler("menu_loaded", function()
		FooterContainerFrontendRight:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintjobWeaponSelectSafeAreaContainer.__onClose = function(f4_arg0)
	f4_arg0.FooterContainerFrontendRight:close()
	f4_arg0.CommonHeader:close()
	f4_arg0.TabBacking:close()
	f4_arg0.TopBar:close()
end
