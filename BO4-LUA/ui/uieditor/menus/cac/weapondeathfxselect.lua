require("x64:eda152e1d10147a")
require("x64:116c2065cc3ac5e")
CoD.WeaponDeathFxSelect = InheritFrom(CoD.Menu)
LUI.createMenu.WeaponDeathFxSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WeaponDeathFxSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	self:setClass(CoD.WeaponDeathFxSelect)
	self.soundSet = "CAC_WeaponPersonalization"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.WeaponOptionsUtility.GetWeaponPersonalizationHeader(f1_local1, f1_arg0, @"hash_16A9947DB03D188F")))
	MenuFrame.CommonHeader.subtitle.subtitle:setText("")
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local WeaponDeathFxSelectInternal = CoD.WeaponDeathFxSelectInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(WeaponDeathFxSelectInternal)
	self.WeaponDeathFxSelectInternal = WeaponDeathFxSelectInternal
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self.__on_menuOpened_self = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		local f4_local0 = self
		SendClientScriptMenuChangeNotify(f4_arg1, f4_arg2, true)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		PlaySoundAlias("uin_cmn_backout")
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_local1, f1_arg0)
	end)
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	WeaponDeathFxSelectInternal.id = "WeaponDeathFxSelectInternal"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = WeaponDeathFxSelectInternal
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
	return self
end
CoD.WeaponDeathFxSelect.__onClose = function(f7_arg0)
	f7_arg0.__on_close_removeOverrides()
	f7_arg0.MenuFrame:close()
	f7_arg0.WeaponDeathFxSelectInternal:close()
end
