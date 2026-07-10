require("x64:3f52fc5b4896818")
require("x64:2a1b5374a7ef26a")
require("x64:54f3e7b133e2ff2")
CoD.AmmoWidgetWZContainer = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetWZContainer.__defaultWidth = 590
CoD.AmmoWidgetWZContainer.__defaultHeight = 186
CoD.AmmoWidgetWZContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetWZContainer)
	self.id = "AmmoWidgetWZContainer"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AmmoWidget = CoD.AmmoWidgetWZ.new(f1_arg0, f1_arg1, 0, 0, -3, 588, 0, 0, 21.5, 133.5)
	self:addElement(AmmoWidget)
	self.AmmoWidget = AmmoWidget
	local AmmoWidgetMPAbilityItem = CoD.AmmoWidgetWZ_AbilityItem.new(f1_arg0, f1_arg1, 0, 0, 226, 298, 0, 0, 45, 104)
	AmmoWidgetMPAbilityItem.HeroAbilityUseString.KBMText:setText(Engine[0xF9F1239CFD921FE](0x60A07A7C41A40AA))
	AmmoWidgetMPAbilityItem.HeroAbilityUseString.GamepadText:setText(Engine[0xF9F1239CFD921FE](0x60A07A7C41A40AA))
	AmmoWidgetMPAbilityItem.QuickEquipCycleString.GamepadText:setText(Engine[0xF9F1239CFD921FE](0xA3E8DB201A1E2BF))
	AmmoWidgetMPAbilityItem:subscribeToGlobalModel(f1_arg1, "LethalOffhands", "0", function(model)
		AmmoWidgetMPAbilityItem:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoWidgetMPAbilityItem)
	self.AmmoWidgetMPAbilityItem = AmmoWidgetMPAbilityItem
	local InventoryEquipmentQuickEquip = CoD.WarzoneContextualExtraItems_RightAlign.new(f1_arg0, f1_arg1, 0, 0, 116, 408, 0, 0, -41.5, 54.5)
	InventoryEquipmentQuickEquip.InventoryEquipmentLarge:setFilter(function(f3_arg0)
		local f3_local0
		if f3_arg0.type:get() ~= "equipment" or f3_arg0.equipped:get() ~= 0 or f3_arg0.quickEquip:get() ~= 1 then
			f3_local0 = false
		else
			f3_local0 = true
		end
		return f3_local0
	end)
	InventoryEquipmentQuickEquip.InventoryEquipmentLarge:setDataSource("WarzoneInventory")
	InventoryEquipmentQuickEquip.InventoryEquipmentSmall:setHorizontalCount(10)
	InventoryEquipmentQuickEquip.InventoryEquipmentSmall:setFilter(function(f4_arg0)
		local f4_local0
		if f4_arg0.type:get() ~= "equipment" or f4_arg0.equipped:get() ~= 0 or f4_arg0.quickEquip:get() ~= 1 then
			f4_local0 = false
		else
			f4_local0 = true
		end
		return f4_local0
	end)
	InventoryEquipmentQuickEquip.InventoryEquipmentSmall:setDataSource("WarzoneInventory")
	InventoryEquipmentQuickEquip:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "equipment", function(model)
		InventoryEquipmentQuickEquip.QuickInventoryItemCurrent:setModel(model, f1_arg1)
	end)
	InventoryEquipmentQuickEquip:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "equipment0", function(model)
		InventoryEquipmentQuickEquip.QuickInventoryItemMid:setModel(model, f1_arg1)
	end)
	InventoryEquipmentQuickEquip:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "equipment1", function(model)
		InventoryEquipmentQuickEquip.QuickInventoryItemTop:setModel(model, f1_arg1)
	end)
	self:addElement(InventoryEquipmentQuickEquip)
	self.InventoryEquipmentQuickEquip = InventoryEquipmentQuickEquip
	local InventoryAttachmentsQuickEquip = CoD.WarzoneContextualExtraItems_RightAlign.new(f1_arg0, f1_arg1, 0, 0, 340, 632, 0, 0, -41.5, 54.5)
	InventoryAttachmentsQuickEquip:mergeStateConditions({
		{
			stateName = "InventoryOpen",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "InventoryOpenRightAligned",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "InventoryClosedRightAligned",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local f1_local5 = InventoryAttachmentsQuickEquip
	local f1_local6 = InventoryAttachmentsQuickEquip.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.inventory.open"], function(f11_arg0)
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local5 = InventoryAttachmentsQuickEquip
	f1_local6 = InventoryAttachmentsQuickEquip.subscribeToModel
	f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["storageGlobalRoot.user_settings"], function(f12_arg0)
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	f1_local5 = InventoryAttachmentsQuickEquip
	f1_local6 = InventoryAttachmentsQuickEquip.subscribeToModel
	f1_local7 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.selectedIndex, function(f13_arg0)
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	f1_local5 = InventoryAttachmentsQuickEquip
	f1_local6 = InventoryAttachmentsQuickEquip.subscribeToModel
	f1_local7 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.weapon3dForcedHintItem, function(f14_arg0)
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "weapon3dForcedHintItem",
		})
	end, false)
	f1_local5 = InventoryAttachmentsQuickEquip
	f1_local6 = InventoryAttachmentsQuickEquip.subscribeToModel
	f1_local7 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.showPickupHint, function(f15_arg0)
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "showPickupHint",
		})
	end, false)
	f1_local5 = InventoryAttachmentsQuickEquip
	f1_local6 = InventoryAttachmentsQuickEquip.subscribeToModel
	f1_local7 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.firstFreeSlot, function(f16_arg0)
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "firstFreeSlot",
		})
	end, false)
	f1_local5 = InventoryAttachmentsQuickEquip
	f1_local6 = InventoryAttachmentsQuickEquip.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.PlayerSettingsUpdate, function(f17_arg0)
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	InventoryAttachmentsQuickEquip:appendEventHandler("input_source_changed", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f1_arg0
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, f18_arg1)
	end)
	f1_local5 = InventoryAttachmentsQuickEquip
	f1_local6 = InventoryAttachmentsQuickEquip.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f19_arg0)
		f1_arg0:updateElementState(InventoryAttachmentsQuickEquip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	InventoryAttachmentsQuickEquip.InventoryEquipmentLarge:setFilter(function(f20_arg0)
		local f20_local0
		if f20_arg0.type:get() ~= "attachment" or f20_arg0.availableAction:get() == CoD.WZUtility.ItemAvailableAction.NONE or f20_arg0.notAvailable:get() ~= 0 or f20_arg0.quickEquip:get() ~= 1 then
			f20_local0 = false
		else
			f20_local0 = true
		end
		return f20_local0
	end)
	InventoryAttachmentsQuickEquip.InventoryEquipmentLarge:setDataSource("WarzoneInventory")
	InventoryAttachmentsQuickEquip.InventoryEquipmentSmall:setHorizontalCount(10)
	InventoryAttachmentsQuickEquip.InventoryEquipmentSmall:setFilter(function(f21_arg0)
		local f21_local0
		if f21_arg0.type:get() ~= "attachment" or f21_arg0.availableAction:get() == CoD.WZUtility.ItemAvailableAction.NONE or f21_arg0.notAvailable:get() ~= 0 or f21_arg0.quickEquip:get() ~= 1 then
			f21_local0 = false
		else
			f21_local0 = true
		end
		return f21_local0
	end)
	InventoryAttachmentsQuickEquip.InventoryEquipmentSmall:setDataSource("WarzoneInventory")
	InventoryAttachmentsQuickEquip:registerEventHandler("list_item_gain_focus", function(element, event)
		local f22_local0 = nil
		CoD.WZUtility.SendInventoryItemFocusNotify(f1_arg1, element)
		return f22_local0
	end)
	self:addElement(InventoryAttachmentsQuickEquip)
	self.InventoryAttachmentsQuickEquip = InventoryAttachmentsQuickEquip
	self:mergeStateConditions({
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideWeaponEquipmentUI", "warzoneHideWeaponEquipment")
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f24_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f24_local0 then
					if
						not IsCodCaster(f1_arg1)
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
						and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hideWeaponInfo")
						and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1)
					then
						f24_local0 = not CoD.WZUtility.IsPcInventoryOpen(f1_arg1)
					else
						f24_local0 = false
					end
				end
				return f24_local0
			end,
		},
		{
			stateName = "VisibleCodCaster",
			condition = function(menu, element, event)
				local f25_local0 = IsCodCaster(f1_arg1)
				if f25_local0 then
					f25_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_inventory", 1)
					if f25_local0 then
						if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hideWeaponInfo") then
							f25_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1)
						else
							f25_local0 = false
						end
					end
				end
				return f25_local0
			end,
		},
		{
			stateName = "VisibleKillcam",
			condition = function(menu, element, event)
				local f26_local0
				if not IsCodCaster(f1_arg1) and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hideWeaponInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) and not CoD.WZUtility.IsPcInventoryOpen(f1_arg1) then
					f26_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
				else
					f26_local0 = false
				end
				return f26_local0
			end,
		},
	})
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.PlayerSettingsUpdate, function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.playerSpawned"], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["factions.isCoDCaster"], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f36_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f37_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f38_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f39_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f40_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f41_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["vehicle.hideWeaponInfo"], function(f42_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "vehicle.hideWeaponInfo",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.infiltrationVehicle"], function(f43_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "hudItems.infiltrationVehicle",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f44_arg0, f44_arg1)
		f44_arg1.menu = f44_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f44_arg1)
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f45_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.isOpen, function(f46_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "isOpen",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.profileSettingsUpdated, function(f47_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f48_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f49_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	AmmoWidget.id = "AmmoWidget"
	InventoryEquipmentQuickEquip.id = "InventoryEquipmentQuickEquip"
	InventoryAttachmentsQuickEquip.id = "InventoryAttachmentsQuickEquip"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.WZUtility.AddQuickAccessInventoryWidget(f1_arg0, f1_arg1, InventoryEquipmentQuickEquip, 4, true)
	CoD.WZUtility.AddQuickAccessInventoryWidget(f1_arg0, f1_arg1, InventoryAttachmentsQuickEquip, 5, false)
	return self
end
CoD.AmmoWidgetWZContainer.__resetProperties = function(f50_arg0)
	f50_arg0.AmmoWidget:completeAnimation()
	f50_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
	f50_arg0.InventoryEquipmentQuickEquip:completeAnimation()
	f50_arg0.InventoryAttachmentsQuickEquip:completeAnimation()
	f50_arg0.AmmoWidget:setAlpha(1)
	f50_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
	f50_arg0.InventoryEquipmentQuickEquip:setAlpha(1)
	f50_arg0.InventoryAttachmentsQuickEquip:setAlpha(1)
end
CoD.AmmoWidgetWZContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(4)
			f51_arg0.AmmoWidget:completeAnimation()
			f51_arg0.AmmoWidget:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.AmmoWidget)
			f51_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f51_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.AmmoWidgetMPAbilityItem)
			f51_arg0.InventoryEquipmentQuickEquip:completeAnimation()
			f51_arg0.InventoryEquipmentQuickEquip:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.InventoryEquipmentQuickEquip)
			f51_arg0.InventoryAttachmentsQuickEquip:completeAnimation()
			f51_arg0.InventoryAttachmentsQuickEquip:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.InventoryAttachmentsQuickEquip)
		end,
		Visible = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(2)
			local f52_local0 = function(f53_arg0)
				f52_arg0.AmmoWidget:beginAnimation(200)
				f52_arg0.AmmoWidget:setAlpha(1)
				f52_arg0.AmmoWidget:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.AmmoWidget:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.AmmoWidget:completeAnimation()
			f52_arg0.AmmoWidget:setAlpha(0)
			f52_local0(f52_arg0.AmmoWidget)
			local f52_local1 = function(f54_arg0)
				f52_arg0.AmmoWidgetMPAbilityItem:beginAnimation(200)
				f52_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
				f52_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f52_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f52_local1(f52_arg0.AmmoWidgetMPAbilityItem)
		end,
		VisibleCodCaster = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(2)
			local f55_local0 = function(f56_arg0)
				f55_arg0.AmmoWidget:beginAnimation(200)
				f55_arg0.AmmoWidget:setAlpha(1)
				f55_arg0.AmmoWidget:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.AmmoWidget:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.AmmoWidget:completeAnimation()
			f55_arg0.AmmoWidget:setAlpha(0)
			f55_local0(f55_arg0.AmmoWidget)
			local f55_local1 = function(f57_arg0)
				f55_arg0.AmmoWidgetMPAbilityItem:beginAnimation(200)
				f55_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
				f55_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f55_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f55_local1(f55_arg0.AmmoWidgetMPAbilityItem)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(4)
			f58_arg0.AmmoWidget:completeAnimation()
			f58_arg0.AmmoWidget:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.AmmoWidget)
			f58_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f58_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.AmmoWidgetMPAbilityItem)
			f58_arg0.InventoryEquipmentQuickEquip:completeAnimation()
			f58_arg0.InventoryEquipmentQuickEquip:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.InventoryEquipmentQuickEquip)
			f58_arg0.InventoryAttachmentsQuickEquip:completeAnimation()
			f58_arg0.InventoryAttachmentsQuickEquip:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.InventoryAttachmentsQuickEquip)
		end,
		Visible = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(2)
			local f59_local0 = function(f60_arg0)
				f59_arg0.AmmoWidget:beginAnimation(200)
				f59_arg0.AmmoWidget:setAlpha(1)
				f59_arg0.AmmoWidget:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.AmmoWidget:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
			end
			f59_arg0.AmmoWidget:completeAnimation()
			f59_arg0.AmmoWidget:setAlpha(0)
			f59_local0(f59_arg0.AmmoWidget)
			local f59_local1 = function(f61_arg0)
				f59_arg0.AmmoWidgetMPAbilityItem:beginAnimation(200)
				f59_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
				f59_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
			end
			f59_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f59_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f59_local1(f59_arg0.AmmoWidgetMPAbilityItem)
		end,
		VisibleCodCaster = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(2)
			local f62_local0 = function(f63_arg0)
				f62_arg0.AmmoWidget:beginAnimation(200)
				f62_arg0.AmmoWidget:setAlpha(1)
				f62_arg0.AmmoWidget:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.AmmoWidget:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.AmmoWidget:completeAnimation()
			f62_arg0.AmmoWidget:setAlpha(0)
			f62_local0(f62_arg0.AmmoWidget)
			local f62_local1 = function(f64_arg0)
				f62_arg0.AmmoWidgetMPAbilityItem:beginAnimation(200)
				f62_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
				f62_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f62_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f62_local1(f62_arg0.AmmoWidgetMPAbilityItem)
		end,
	},
	Visible = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(2)
			local f66_local0 = function(f67_arg0)
				f66_arg0.AmmoWidget:beginAnimation(200)
				f66_arg0.AmmoWidget:setAlpha(0)
				f66_arg0.AmmoWidget:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.AmmoWidget:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.AmmoWidget:completeAnimation()
			f66_arg0.AmmoWidget:setAlpha(1)
			f66_local0(f66_arg0.AmmoWidget)
			local f66_local1 = function(f68_arg0)
				f66_arg0.AmmoWidgetMPAbilityItem:beginAnimation(200)
				f66_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
				f66_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f66_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
			f66_local1(f66_arg0.AmmoWidgetMPAbilityItem)
		end,
	},
	VisibleCodCaster = {
		DefaultClip = function(f69_arg0, f69_arg1)
			f69_arg0:__resetProperties()
			f69_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(2)
			local f70_local0 = function(f71_arg0)
				f70_arg0.AmmoWidget:beginAnimation(200)
				f70_arg0.AmmoWidget:setAlpha(0)
				f70_arg0.AmmoWidget:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.AmmoWidget:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.AmmoWidget:completeAnimation()
			f70_arg0.AmmoWidget:setAlpha(1)
			f70_local0(f70_arg0.AmmoWidget)
			local f70_local1 = function(f72_arg0)
				f70_arg0.AmmoWidgetMPAbilityItem:beginAnimation(200)
				f70_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
				f70_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f70_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
			f70_local1(f70_arg0.AmmoWidgetMPAbilityItem)
		end,
	},
	VisibleKillcam = {
		DefaultClip = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(2)
			local f74_local0 = function(f75_arg0)
				f74_arg0.AmmoWidget:beginAnimation(200)
				f74_arg0.AmmoWidget:setAlpha(0)
				f74_arg0.AmmoWidget:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.AmmoWidget:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
			end
			f74_arg0.AmmoWidget:completeAnimation()
			f74_arg0.AmmoWidget:setAlpha(1)
			f74_local0(f74_arg0.AmmoWidget)
			local f74_local1 = function(f76_arg0)
				f74_arg0.AmmoWidgetMPAbilityItem:beginAnimation(200)
				f74_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
				f74_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
			end
			f74_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f74_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
			f74_local1(f74_arg0.AmmoWidgetMPAbilityItem)
		end,
	},
}
CoD.AmmoWidgetWZContainer.__onClose = function(f77_arg0)
	f77_arg0.AmmoWidget:close()
	f77_arg0.AmmoWidgetMPAbilityItem:close()
	f77_arg0.InventoryEquipmentQuickEquip:close()
	f77_arg0.InventoryAttachmentsQuickEquip:close()
end
