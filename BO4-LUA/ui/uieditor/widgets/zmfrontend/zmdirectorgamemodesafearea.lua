require("x64:d6ecdf7755aeddc")
require("x64:81a24c5340caa1e")
require("x64:e41af73729601d6")
require("x64:614b957d206f438")
CoD.ZMDirectorGamemodeSafeArea = InheritFrom(LUI.UIElement)
CoD.ZMDirectorGamemodeSafeArea.__defaultWidth = 1920
CoD.ZMDirectorGamemodeSafeArea.__defaultHeight = 1080
CoD.ZMDirectorGamemodeSafeArea.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMDirectorGamemodeSafeArea)
	self.id = "ZMDirectorGamemodeSafeArea"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/zombies_modes"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local ZMGameModeTabs = CoD.ZMGameModeTabs.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 35.5, 95.5)
	ZMGameModeTabs.customClasssList:setDataSource("DirectorPlaylistGameTypeList")
	self:addElement(ZMGameModeTabs)
	self.ZMGameModeTabs = ZMGameModeTabs
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, -25)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	ZMGameModeTabs.id = "ZMGameModeTabs"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMDirectorGamemodeSafeArea.__onClose = function(f3_arg0)
	f3_arg0.CommonHeader:close()
	f3_arg0.TabBacking:close()
	f3_arg0.ZMGameModeTabs:close()
	f3_arg0.BackingGrayMediumLeft:close()
end
