require("x64:eda152e1d10147a")
require("x64:cbca9d1404b1f94")
CoD.SpecialistDossier = InheritFrom(CoD.Menu)
LUI.createMenu.SpecialistDossier = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SpecialistDossier", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.SpecialistDossier)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local SpecialistDossierInternal = CoD.SpecialistDossierInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	self.__on_menuOpened_SpecialistDossierInternal = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		SizeToSafeArea(SpecialistDossierInternal, f2_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_SpecialistDossierInternal)
	self:addElement(SpecialistDossierInternal)
	self.SpecialistDossierInternal = SpecialistDossierInternal
	local SocialFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SocialFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	SocialFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_74B6BF4D7A660E84"))
	SocialFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SocialFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(SocialFrame)
	self.SocialFrame = SocialFrame
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_778D439E1B360368", nil, "ESCAPE")
		return true
	end, false)
	SpecialistDossierInternal.id = "SpecialistDossierInternal"
	SocialFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		SocialFrame.id = "SocialFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = SpecialistDossierInternal
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_SpecialistDossierInternal)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.SpecialistDossier.__onClose = function(f7_arg0)
	f7_arg0.__on_close_removeOverrides()
	f7_arg0.SpecialistDossierInternal:close()
	f7_arg0.SocialFrame:close()
end
