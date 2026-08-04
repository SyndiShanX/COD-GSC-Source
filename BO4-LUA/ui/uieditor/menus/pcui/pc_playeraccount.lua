require("ui/uieditor/widgets/backgroundframes/genericmenuframe")
require("ui/uieditor/widgets/common/common_tabbar_center")
require("ui/uieditor/widgets/common/commontabbarbacking")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground")
CoD.PC_PlayerAccount = InheritFrom(CoD.Menu)
LUI.createMenu.PC_PlayerAccount = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_PlayerAccount", f1_arg0)
	local f1_local1 = self
	CoD.StartMenuUtility.InitDataForStartMenu(self, f1_local1, f1_arg0)
	self:setClass(CoD.PC_PlayerAccount)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local TabBacking = CoD.CommonTabBarBacking.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local PlayerAccountTabs = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0.5, 0.5, -1650, 1650, 0, 0, 36, 97)
	PlayerAccountTabs.Tabs.grid:setDataSource("PCPlayerAccountTabs")
	PlayerAccountTabs:registerEventHandler("grid_item_changed", function(element, event)
		local f2_local0 = nil
		UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
		CloseContextualMenu(f1_local1, f1_arg0)
		return f2_local0
	end)
	self:addElement(PlayerAccountTabs)
	self.PlayerAccountTabs = PlayerAccountTabs
	local PlayerAccountFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	PlayerAccountFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_B828992E638B17B"))
	PlayerAccountFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerAccountFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(PlayerAccountFrame)
	self.PlayerAccountFrame = PlayerAccountFrame
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -960, 960)
	TabFrame:setTopBottom(0.5, 0.5, -390, 390)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	TabFrame:linkToElementModel(PlayerAccountTabs.Tabs.grid, "tabWidget", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TabFrame:changeFrameWidget(f4_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"], "ui_contextual_1", function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		if CoD.StartMenuUtility.CanChangeWZStatsFilter(f5_arg1, self.TabFrame, f5_arg2) then
			CoD.PlayerStatsUtility.UpdateWZStatsFilter(f5_arg2)
			return true
		else
		end
	end, function(f6_arg0, f6_arg1, f6_arg2)
		if CoD.StartMenuUtility.CanChangeWZStatsFilter(f6_arg1, self.TabFrame, f6_arg2) then
			CoD.Menu.SetButtonLabel(f6_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], 0x0, nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		GoBack(self, f7_arg2)
		return true
	end, function(f8_arg0, f8_arg1, f8_arg2)
		CoD.Menu.SetButtonLabel(f8_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	PlayerAccountTabs.id = "PlayerAccountTabs"
	PlayerAccountFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		PlayerAccountFrame.id = "PlayerAccountFrame"
	end
	TabFrame.id = "TabFrame"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = PlayerAccountFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local7 = self
	CoD.PCPlayerAccountUtility.SetupPlayerDataForBarrack(f1_local1, f1_arg0)
	return self
end
CoD.PC_PlayerAccount.__onClose = function(f9_arg0)
	f9_arg0.TabFrame:close()
	f9_arg0.Background:close()
	f9_arg0.TabBacking:close()
	f9_arg0.PlayerAccountTabs:close()
	f9_arg0.PlayerAccountFrame:close()
end
