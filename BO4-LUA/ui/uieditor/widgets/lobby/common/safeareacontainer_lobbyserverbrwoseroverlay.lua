require("x64:d6ecdf7755aeddc")
require("x64:81a24c5340caa1e")
require("x64:4b054a81ee0245c")
require("x64:e41af73729601d6")
CoD.SafeAreaContainer_LobbyServerBrwoserOverlay = InheritFrom(LUI.UIElement)
CoD.SafeAreaContainer_LobbyServerBrwoserOverlay.__defaultWidth = 1920
CoD.SafeAreaContainer_LobbyServerBrwoserOverlay.__defaultHeight = 1080
CoD.SafeAreaContainer_LobbyServerBrwoserOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SafeAreaContainer_LobbyServerBrwoserOverlay)
	self.id = "SafeAreaContainer_LobbyServerBrwoserOverlay"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -0.1, 1.1, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_797DF1A82E7BB536"))
	CommonHeader.subtitle.subtitle:setText("")
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local FETabBar = CoD.DirectorSelect_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -100.5, 100.5, 0, 0, 52.5, 113.5)
	FETabBar:mergeStateConditions({
		{
			stateName = "DimBumperIcons",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
	})
	local f1_local4 = FETabBar
	local HeaderStripe = FETabBar.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	HeaderStripe(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(FETabBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	FETabBar.Tabs.grid:setHorizontalCount(5)
	FETabBar.Tabs.grid:setDataSource("ServerBrowserFilters")
	FETabBar:registerEventHandler("list_active_changed", function(element, event)
		local f4_local0 = nil
		CoD.LobbyUtility.LobbyLANServerBrowserSetMainModeFilter(self, element, f1_arg1)
		RefreshServerList(self, f1_arg1)
		return f4_local0
	end)
	self:addElement(FETabBar)
	self.FETabBar = FETabBar
	HeaderStripe = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	FETabBar.id = "FETabBar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SafeAreaContainer_LobbyServerBrwoserOverlay.__onClose = function(f5_arg0)
	f5_arg0.TabBacking:close()
	f5_arg0.CommonHeader:close()
	f5_arg0.FETabBar:close()
	f5_arg0.HeaderStripe:close()
end
