require("x64:eda152e1d10147a")
require("x64:7889ce1e3e2e8a")
require("x64:c191dad9fd5ceda")
CoD.ZMPersonalizeCharacterMain = InheritFrom(CoD.Menu)
LUI.createMenu.ZMPersonalizeCharacterMain = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ZMPersonalizeCharacterMain", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.ZMPersonalizeCharacterMain)
	self.soundSet = "default"
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
	local StartMenuPersonalizationZM = CoD.StartMenu_Personalization_ZM.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -390, 390)
	self:addElement(StartMenuPersonalizationZM)
	self.StartMenuPersonalizationZM = StartMenuPersonalizationZM
	local SocialFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SocialFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	SocialFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x350A8FDD8E022EC))
	SocialFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SocialFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(SocialFrame)
	self.SocialFrame = SocialFrame
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
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], 0x5619D8212EDA599, nil, "ui_contextual_2")
			return true
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
	end)
	StartMenuPersonalizationZM.id = "StartMenuPersonalizationZM"
	SocialFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		SocialFrame.id = "SocialFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = StartMenuPersonalizationZM
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
	SizeToSafeArea(StartMenuPersonalizationZM, f1_arg0)
	return self
end
CoD.ZMPersonalizeCharacterMain.__onClose = function(f11_arg0)
	f11_arg0.__on_close_removeOverrides()
	f11_arg0.Background:close()
	f11_arg0.StartMenuPersonalizationZM:close()
	f11_arg0.SocialFrame:close()
end
