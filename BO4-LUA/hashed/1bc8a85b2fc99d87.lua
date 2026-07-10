require("x64:2d7fb8ef55c1922")
require("x64:31d6eb4412a3e5")
require("x64:56fad2ca5ee75b7")
require("x64:5ee2a7efbd7bef7")
CoD.ZMInventoryListInternal = InheritFrom(LUI.UIElement)
CoD.ZMInventoryListInternal.__defaultWidth = 1000
CoD.ZMInventoryListInternal.__defaultHeight = 80
CoD.ZMInventoryListInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.ZMInventoryListInternal)
	self.id = "ZMInventoryListInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local BG = CoD.ZMInventoryListBackingInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 80)
	self:addElement(BG)
	self.BG = BG
	local PackAPunchItems = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -12, 0, nil, nil, false, false, false, false)
	PackAPunchItems:setLeftRight(0, 0, 716, 1000)
	PackAPunchItems:setTopBottom(0, 0, 0, 80)
	PackAPunchItems:setWidgetType(CoD.ZMInvPaPItem)
	PackAPunchItems:setHorizontalCount(4)
	PackAPunchItems:setSpacing(-12)
	PackAPunchItems:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PackAPunchItems:setDataSource("ZMInventoryPaPItems")
	self:addElement(PackAPunchItems)
	self.PackAPunchItems = PackAPunchItems
	local Divider = LUI.UIImage.new(0, 0, 706, 716, 0, 0, 0, 80)
	Divider:setImage(RegisterImage(0xDA3E86054B0E24D))
	self:addElement(Divider)
	self.Divider = Divider
	local WonderWeaponItems = CoD.ZMInvPhasedItemsContainer.new(f1_arg0, f1_arg1, 0, 0, 458, 706, 0, 0, 0, 80)
	WonderWeaponItems.ItemsPhase0:setDataSource("ZMInventoryWonderWeaponItems")
	WonderWeaponItems.ItemsPhase1:setDataSource("ZMInventoryWonderWeaponItems")
	WonderWeaponItems.ItemsPhase2:setDataSource("ZMInventoryWonderWeaponItems")
	WonderWeaponItems.ItemsPhase3:setDataSource("ZMInventoryWonderWeaponItems")
	self:addElement(WonderWeaponItems)
	self.WonderWeaponItems = WonderWeaponItems
	local Divider2 = LUI.UIImage.new(0, 0, 448, 458, 0, 0, 0, 80)
	Divider2:setImage(RegisterImage(0xDA3E86054B0E24D))
	self:addElement(Divider2)
	self.Divider2 = Divider2
	local ShieldComponents = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	ShieldComponents:setLeftRight(0, 0, 208, 448)
	ShieldComponents:setTopBottom(0, 0, 0, 80)
	ShieldComponents:setWidgetType(CoD.ZMInvShieldItem)
	ShieldComponents:setHorizontalCount(3)
	ShieldComponents:setSpacing(0)
	ShieldComponents:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ShieldComponents:setDataSource("ZMInventoryShieldPieces")
	self:addElement(ShieldComponents)
	self.ShieldComponents = ShieldComponents
	PackAPunchItems.id = "PackAPunchItems"
	WonderWeaponItems.id = "WonderWeaponItems"
	ShieldComponents.id = "ShieldComponents"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.ZMInventoryUtility.SetupWonderWeaponModels(f1_arg1, self.WonderWeaponItems)
	return self
end
CoD.ZMInventoryListInternal.__onClose = function(f2_arg0)
	f2_arg0.BG:close()
	f2_arg0.PackAPunchItems:close()
	f2_arg0.WonderWeaponItems:close()
	f2_arg0.ShieldComponents:close()
end
