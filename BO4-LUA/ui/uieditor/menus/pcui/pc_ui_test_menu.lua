require("x64:eda152e1d10147a")
require("x64:78d9663be3f826")
CoD.PC_UI_Test_Menu = InheritFrom(CoD.Menu)
LUI.createMenu.PC_UI_Test_Menu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_UI_Test_Menu", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PC_UI_Test_Menu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setImage(RegisterImage(0x4BF88A437F4C579))
	self:addElement(Background)
	self.Background = Background
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xBB7AA7A26F39DFA))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local TabBar = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0.5, 0.5, -1689, 1611, 0, 0, 11, 72)
	self:addElement(TabBar)
	self.TabBar = TabBar
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0, 1, 0, 0)
	TabFrame:setTopBottom(0, 0.74, 187.5, 187.5)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		SendMenuResponse(self, "PC_UI_Test_Menu", "closing", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x6C253CF816B40B5, nil, "ESCAPE")
		return true
	end, false)
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	TabBar.id = "TabBar"
	TabFrame.id = "TabFrame"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = TabFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local6 = self
	CoD.FreeCursorUtility.SetAllowFreeCursor(true)
	return self
end
CoD.PC_UI_Test_Menu.__onClose = function(f5_arg0)
	f5_arg0.MenuFrame:close()
	f5_arg0.TabBar:close()
	f5_arg0.TabFrame:close()
end
