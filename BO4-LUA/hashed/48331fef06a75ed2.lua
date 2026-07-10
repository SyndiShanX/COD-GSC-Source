require("x64:aff61c91cbc2694")
require("x64:e4705fd24dac4b3")
require("x64:3427b3362fad774")
CoD.WarzoneContextualArmorStashItems = InheritFrom(LUI.UIElement)
CoD.WarzoneContextualArmorStashItems.__defaultWidth = 292
CoD.WarzoneContextualArmorStashItems.__defaultHeight = 96
CoD.WarzoneContextualArmorStashItems.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneContextualArmorStashItems)
	self.id = "WarzoneContextualArmorStashItems"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InventoryEquipmentLarge = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	InventoryEquipmentLarge:setLeftRight(0.5, 0.5, 12, 82)
	InventoryEquipmentLarge:setTopBottom(1, 1, -74, -4)
	InventoryEquipmentLarge:setWidgetType(CoD.WarzoneQuickInventoryShardItem)
	InventoryEquipmentLarge:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(InventoryEquipmentLarge)
	self.InventoryEquipmentLarge = InventoryEquipmentLarge
	local InventoryEquipmentSmall = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 25, 41)
	InventoryEquipmentSmall:setTopBottom(1, 1, -24, -8)
	InventoryEquipmentSmall:setWidgetType(CoD.WarzoneInventoryItemGrayBox)
	InventoryEquipmentSmall:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(InventoryEquipmentSmall)
	self.InventoryEquipmentSmall = InventoryEquipmentSmall
	local f1_local3 = nil
	local InventoryEquipmentStashCount = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	InventoryEquipmentStashCount:setLeftRight(0.5, 0.5, -21, 91)
	InventoryEquipmentStashCount:setTopBottom(1, 1, 77, 101)
	InventoryEquipmentStashCount:setAlpha(0)
	InventoryEquipmentStashCount:setWidgetType(CoD.WarzoneArmorStashCount_PC)
	InventoryEquipmentStashCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(InventoryEquipmentStashCount)
	self.InventoryEquipmentStashCount = InventoryEquipmentStashCount
	self:mergeStateConditions({
		{
			stateName = "InventoryOpen",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideMinimizedQuickEquipUI", "warzoneHideMinimizedQuickEquip")
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.inventory.open"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.PlayerSettingsUpdate, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f7_arg1)
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	InventoryEquipmentLarge.id = "InventoryEquipmentLarge"
	InventoryEquipmentSmall.id = "InventoryEquipmentSmall"
	InventoryEquipmentStashCount.id = "InventoryEquipmentStashCount"
	self.__defaultFocus = InventoryEquipmentLarge
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(InventoryEquipmentLarge, f1_arg1)
	CoD.WZUtility.AddQuickInventoryNavigation(f1_arg0, self, f1_arg1, self.InventoryEquipmentLarge)
	return self
end
CoD.WarzoneContextualArmorStashItems.__resetProperties = function(f9_arg0)
	f9_arg0.InventoryEquipmentLarge:completeAnimation()
	f9_arg0.InventoryEquipmentSmall:completeAnimation()
	f9_arg0.InventoryEquipmentStashCount:completeAnimation()
	f9_arg0.InventoryEquipmentLarge:setAlpha(1)
	f9_arg0.InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 25, 41)
	f9_arg0.InventoryEquipmentSmall:setTopBottom(1, 1, -24, -8)
	f9_arg0.InventoryEquipmentSmall:setAlpha(1)
	f9_arg0.InventoryEquipmentStashCount:setAlpha(0)
end
CoD.WarzoneContextualArmorStashItems.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.InventoryEquipmentLarge:completeAnimation()
			f10_arg0.InventoryEquipmentLarge:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.InventoryEquipmentLarge)
		end,
	},
	InventoryOpen = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.InventoryEquipmentSmall:completeAnimation()
			f11_arg0.InventoryEquipmentSmall:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.InventoryEquipmentSmall)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.InventoryEquipmentLarge:completeAnimation()
			f12_arg0.InventoryEquipmentLarge:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.InventoryEquipmentLarge)
		end,
	},
	KBM = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.InventoryEquipmentLarge:completeAnimation()
			f13_arg0.InventoryEquipmentLarge:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.InventoryEquipmentLarge)
			f13_arg0.InventoryEquipmentSmall:completeAnimation()
			f13_arg0.InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 6, 58)
			f13_arg0.InventoryEquipmentSmall:setTopBottom(1, 1, 77, 93)
			f13_arg0.InventoryEquipmentSmall:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.InventoryEquipmentSmall)
			f13_arg0.InventoryEquipmentStashCount:completeAnimation()
			f13_arg0.InventoryEquipmentStashCount:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.InventoryEquipmentStashCount)
		end,
	},
}
CoD.WarzoneContextualArmorStashItems.__onClose = function(f14_arg0)
	f14_arg0.InventoryEquipmentLarge:close()
	f14_arg0.InventoryEquipmentSmall:close()
	f14_arg0.InventoryEquipmentStashCount:close()
end
