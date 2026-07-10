require("x64:71d4e66447f837e")
require("x64:d6ecdf7755aeddc")
require("x64:e41af73729601d6")
require("x64:d5b03c451ceb6e8")
require("x64:7889ce1e3e2e8a")
CoD.StartMenu_Options_CoDAccount_ManageAccount = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_CoDAccount_ManageAccount = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_CoDAccount_ManageAccount", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.StartMenu_Options_CoDAccount_ManageAccount)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local StartMenuOptionsBackground = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuOptionsBackground)
	self.StartMenuOptionsBackground = StartMenuOptionsBackground
	local MenuFrameIngame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(MenuFrameIngame)
	self.MenuFrameIngame = MenuFrameIngame
	local StartMenuOptionsAccountManagementForm = CoD.StartMenu_Options_AccountManagementForm.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuOptionsAccountManagementForm)
	self.StartMenuOptionsAccountManagementForm = StartMenuOptionsAccountManagementForm
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x649E3D4C7444229))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local headercontainerfrontend = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(headercontainerfrontend)
	self.headercontainerfrontend = headercontainerfrontend
	self:registerEventHandler("list_item_gain_focus", function(self, event)
		local f3_local0 = nil
		CoD.CoDAccountUtility.OnAccountManagementItemFocusChange(f1_local1, f1_arg0, self)
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x78D439E1B360368, nil, nil)
		return true
	end, false)
	MenuFrameIngame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrameIngame.id = "MenuFrameIngame"
	end
	StartMenuOptionsAccountManagementForm.id = "StartMenuOptionsAccountManagementForm"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_CoDAccount_ManageAccount.__onClose = function(f6_arg0)
	f6_arg0.StartMenuOptionsBackground:close()
	f6_arg0.MenuFrameIngame:close()
	f6_arg0.StartMenuOptionsAccountManagementForm:close()
	f6_arg0.CommonHeader:close()
	f6_arg0.headercontainerfrontend:close()
end
