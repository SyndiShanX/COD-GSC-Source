require("x64:eda152e1d10147a")
require("x64:7889ce1e3e2e8a")
require("x64:c6100ada0135336")
CoD.DirectorPersonalizeCharacterMP = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorPersonalizeCharacterMP = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorPersonalizeCharacterMP", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.DirectorPersonalizeCharacterMP)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setAlpha(0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local StartMenuPersonalizationMP = CoD.StartMenu_Personalization_MP.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -390, 390)
	self:addElement(StartMenuPersonalizationMP)
	self.StartMenuPersonalizationMP = StartMenuPersonalizationMP
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x2993608F0D6EF9E))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.CharacterBreadcrumbs.getModel(f1_arg0)
	f1_local7(f1_local6, f1_local8.breadcrumbCount, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and IsPC() then
			CoD.BreadcrumbUtility.ClearAllPersonalizationBreadcrumbs(menu, controller)
			return true
		elseif not IsPC() then
			CoD.BaseUtility.UINoAction()
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], 0x5619D8212EDA599, nil, "ui_contextual_2")
			return true
		elseif not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], 0x0, nil, "ui_contextual_2")
			return false
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		local f8_local0 = self
		SendClientScriptMenuChangeNotify(f8_arg1, f8_arg2, true)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		ClearMenuSavedState(f1_local1)
		CoD.PlayerRoleUtility.SaveCharacterCustomizations(f1_arg0)
	end)
	StartMenuPersonalizationMP.id = "StartMenuPersonalizationMP"
	GenericMenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = StartMenuPersonalizationMP
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local7 = self
	SizeToSafeArea(StartMenuPersonalizationMP, f1_arg0)
	return self
end
CoD.DirectorPersonalizeCharacterMP.__onClose = function(f11_arg0)
	f11_arg0.__on_close_removeOverrides()
	f11_arg0.Background:close()
	f11_arg0.StartMenuPersonalizationMP:close()
	f11_arg0.GenericMenuFrame:close()
end
