require("x64:eda152e1d10147a")
require("x64:e2c12f88c203134")
CoD.WeaponAccessoriesSelect = InheritFrom(CoD.Menu)
LUI.createMenu.WeaponAccessoriesSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WeaponAccessoriesSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.WeaponAccessoriesSelect)
	self.soundSet = "CAC_WeaponPersonalization"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.WeaponOptionsUtility.GetWeaponPersonalizationHeader(f1_local1, f1_arg0, 0xF549344C4D372C)))
	MenuFrame.CommonHeader.subtitle.subtitle:setText("")
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local WeaponAccessoriesSelectInternal = CoD.WeaponAccessoriesSelectInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(WeaponAccessoriesSelectInternal)
	self.WeaponAccessoriesSelectInternal = WeaponAccessoriesSelectInternal
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.CACUtility.UpdateCustomClassModelIfModified(menu, controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		PlaySoundAlias("uin_cmn_backout")
		CoD.WeaponOptionsUtility.SetBaseWeaponOptions(element, f1_local1, f1_arg0)
	end)
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	WeaponAccessoriesSelectInternal.id = "WeaponAccessoriesSelectInternal"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = WeaponAccessoriesSelectInternal
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local4 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	return self
end
CoD.WeaponAccessoriesSelect.__onClose = function(f5_arg0)
	f5_arg0.MenuFrame:close()
	f5_arg0.WeaponAccessoriesSelectInternal:close()
end
