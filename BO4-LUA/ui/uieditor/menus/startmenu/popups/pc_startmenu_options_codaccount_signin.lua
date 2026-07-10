require("x64:71d4e66447f837e")
require("x64:d6ecdf7755aeddc")
require("x64:e41af73729601d6")
require("x64:ffc1d029868ae")
require("x64:7889ce1e3e2e8a")
CoD.PC_StartMenu_Options_CoDAccount_SignIn = InheritFrom(CoD.Menu)
LUI.createMenu.PC_StartMenu_Options_CoDAccount_SignIn = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_StartMenu_Options_CoDAccount_SignIn", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PC_StartMenu_Options_CoDAccount_SignIn)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(background)
	self.background = background
	local MenuFrameIngame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -1080, 0)
	self:addElement(MenuFrameIngame)
	self.MenuFrameIngame = MenuFrameIngame
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_734AB4709B1FA9DB"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0.5, 1.5, -960, -960, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local PCStartMenuOptionsSignInForm = CoD.PC_StartMenu_Options_SignInForm.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	PCStartMenuOptionsSignInForm:subscribeToGlobalModel(f1_arg0, "CODAccountSignInForm", nil, function(model)
		PCStartMenuOptionsSignInForm:setModel(model, f1_arg0)
	end)
	self:addElement(PCStartMenuOptionsSignInForm)
	self.PCStartMenuOptionsSignInForm = PCStartMenuOptionsSignInForm
	self:registerEventHandler("list_item_gain_focus", function(self, event)
		local f5_local0 = nil
		CoD.CoDAccountUtility.OnSignInItemFocusChange(f1_local1, f1_arg0, self)
		return f5_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		CoD.CoDAccountUtility.ClearSignInEmailAndPasswordModels(controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "UNOAccountInfo", "iTransactionResult", function(model)
		local f8_local0 = self
		CoD.CoDAccountUtility.CodAccountOnTransactionResultUpdated(self, f1_arg0, model)
	end)
	MenuFrameIngame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrameIngame.id = "MenuFrameIngame"
	end
	PCStartMenuOptionsSignInForm.id = "PCStartMenuOptionsSignInForm"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local7 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	return self
end
CoD.PC_StartMenu_Options_CoDAccount_SignIn.__onClose = function(f9_arg0)
	f9_arg0.background:close()
	f9_arg0.MenuFrameIngame:close()
	f9_arg0.CommonHeader:close()
	f9_arg0.BackingGrayMediumLeft:close()
	f9_arg0.PCStartMenuOptionsSignInForm:close()
end
