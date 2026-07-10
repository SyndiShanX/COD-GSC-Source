require("x64:eda152e1d10147a")
require("x64:e9cfc3cb5356fa5")
CoD.WeaponTabbedAccessoriesSelect = InheritFrom(CoD.Menu)
LUI.createMenu.WeaponTabbedAccessoriesSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WeaponTabbedAccessoriesSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.WeaponTabbedAccessoriesSelect)
	self.soundSet = "CAC_WeaponPersonalization"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(Engine[0xF9F1239CFD921FE](CoD.WeaponOptionsUtility.GetWeaponPersonalizationHeader(f1_local1, f1_arg0, 0xF549344C4D372C)))
	MenuFrame.CommonHeader.subtitle.subtitle:setText("")
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local CommonTabBarLeftAlign = CoD.CommonTabBar.new(f1_local1, f1_arg0, 0.5, 0.5, -1650, 1650, 0, 0, 35, 96)
	CommonTabBarLeftAlign:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return MenuPropertyIsTrue(menu, "_isMastercraftCustomization")
			end,
		},
	})
	CommonTabBarLeftAlign.Tabs.grid:setDataSource("WeaponAccessoriesCategories")
	self:addElement(CommonTabBarLeftAlign)
	self.CommonTabBarLeftAlign = CommonTabBarLeftAlign
	local InternalFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	InternalFrame:setLeftRight(0.5, 0.5, -960, 960)
	InternalFrame:setTopBottom(0.5, 0.5, -540, 540)
	self:addElement(InternalFrame)
	self.InternalFrame = InternalFrame
	InternalFrame:linkToElementModel(CommonTabBarLeftAlign.Tabs.grid, "tabWidget", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			InternalFrame:changeFrameWidget(f3_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.CACUtility.UpdateCustomClassModelIfModified(menu, controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		CoD.BaseUtility.UINoAction()
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		CoD.BaseUtility.UINoAction()
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		PlaySoundAlias("uin_cmn_backout")
		CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_local1, f1_arg0)
	end)
	self.__on_menuOpened_self = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		local f11_local0 = self
		if not IsPC() then
			SizeToSafeArea(f11_local0, f11_arg1)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	CommonTabBarLeftAlign.id = "CommonTabBarLeftAlign"
	InternalFrame.id = "InternalFrame"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = InternalFrame
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
	local f1_local5 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	return self
end
CoD.WeaponTabbedAccessoriesSelect.__onClose = function(f13_arg0)
	f13_arg0.__on_close_removeOverrides()
	f13_arg0.InternalFrame:close()
	f13_arg0.MenuFrame:close()
	f13_arg0.CommonTabBarLeftAlign:close()
end
