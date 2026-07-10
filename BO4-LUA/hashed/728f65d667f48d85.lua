require("x64:a8fa0931078710f")
require("x64:248fb16d4210b9d")
require("x64:248cf55ddbe77b")
CoD.WZHudMenus = InheritFrom(LUI.UIElement)
CoD.WZHudMenus.__defaultWidth = 910
CoD.WZHudMenus.__defaultHeight = 331
CoD.WZHudMenus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZHudMenus)
	self.id = "WZHudMenus"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WarzoneInventory = CoD.WarzoneInventory.new(f1_arg0, f1_arg1, 0.5, 0.5, -419.5, 381.5, 1, 1, -75, 25)
	WarzoneInventory:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "availableAction", CoD.WZUtility.ItemAvailableAction.NONE) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.open", true) then
			CoD.HUDUtility.SetDataSourceModelToSelectedIndex(f1_arg1, "WarzoneInventory", "selectedIndex", element)
			CallCustomElementFunction_Element(self.WarzoneInventory, "_showInventoryHints")
			SendCustomClientScriptNotifyForAdjustedClient(f1_arg1, "inventory_focus", element.gridInfoTable.zeroBasedIndex)
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.open", true) then
			CoD.HUDUtility.SetDataSourceModelToSelectedIndex(f1_arg1, "WarzoneInventory", "selectedIndex", element)
			CallCustomElementFunction_Element(self.WarzoneInventory, "_showInventoryHints_NoEquip")
			SendCustomClientScriptNotifyForAdjustedClient(f1_arg1, "inventory_focus", element.gridInfoTable.zeroBasedIndex)
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.open", true) then
			CoD.HUDUtility.SetDataSourceModelToSelectedIndex(f1_arg1, "WarzoneInventory", "selectedIndex", element)
			CallCustomElementFunction_Element(self.WarzoneInventory, "_cancelInventoryHints")
			SendCustomClientScriptNotifyForAdjustedClient(f1_arg1, "inventory_focus", element.gridInfoTable.zeroBasedIndex)
		end
		return f2_local0
	end)
	self:addElement(WarzoneInventory)
	self.WarzoneInventory = WarzoneInventory
	local TabbedMultiItemPickup = CoD.TabbedMultiItemPickup.new(f1_arg0, f1_arg1, 0.5, 0.5, -550, 550, 1, 1, -266, -16)
	self:addElement(TabbedMultiItemPickup)
	self.TabbedMultiItemPickup = TabbedMultiItemPickup
	local DeadSpectate = CoD.DeadSpectate.new(f1_arg0, f1_arg1, 0.5, 0.5, -218, 232, 1, 1, -136, -46)
	DeadSpectate:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f3_local0
				if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xC57360571B0917E]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
					f3_local0 = IsPC()
					if f3_local0 then
						f3_local0 = AlwaysFalse()
					end
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	local f1_local4 = DeadSpectate
	local f1_local5 = DeadSpectate.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6]], function(f4_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6],
		})
	end, false)
	f1_local4 = DeadSpectate
	f1_local5 = DeadSpectate.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f5_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local4 = DeadSpectate
	f1_local5 = DeadSpectate.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f6_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local4 = DeadSpectate
	f1_local5 = DeadSpectate.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f7_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local4 = DeadSpectate
	f1_local5 = DeadSpectate.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f8_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local4 = DeadSpectate
	f1_local5 = DeadSpectate.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f9_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local4 = DeadSpectate
	f1_local5 = DeadSpectate.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f10_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local4 = DeadSpectate
	f1_local5 = DeadSpectate.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f11_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
		})
	end, false)
	f1_local4 = DeadSpectate
	f1_local5 = DeadSpectate.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f12_arg0)
		f1_arg0:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	self:addElement(DeadSpectate)
	self.DeadSpectate = DeadSpectate
	self:mergeStateConditions({
		{
			stateName = "VisibleSpectatingClient",
			condition = function(menu, element, event)
				local f13_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
				if f13_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]) and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
						f13_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
					else
						f13_local0 = false
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f14_local0
				if
					not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
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
				then
					f14_local0 = not CoD.WZUtility.IsPcInventoryOpen(f1_arg1)
				else
					f14_local0 = false
				end
				return f14_local0
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f28_arg0, f28_arg1)
		f28_arg1.menu = f28_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f28_arg1)
	end)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.isOpen, function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "isOpen",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f31_arg2, f31_arg3, f31_arg4)
		if not IsMouseOrKeyboard(controller) and not CoD.BaseUtility.IsSelfInState(self, "Visible") and IsIntDvarNonZero("tabbedMultiItemPickup") then
			CoD.WZUtility.CloseMultiItemPickup(controller)
		end
	end)
	WarzoneInventory:appendEventHandler("menu_loaded", function()
		WarzoneInventory:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	WarzoneInventory.id = "WarzoneInventory"
	TabbedMultiItemPickup.id = "TabbedMultiItemPickup"
	DeadSpectate.id = "DeadSpectate"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.WarzoneInventory)
	return self
end
CoD.WZHudMenus.__resetProperties = function(f33_arg0)
	f33_arg0.WarzoneInventory:completeAnimation()
	f33_arg0.DeadSpectate:completeAnimation()
	f33_arg0.WarzoneInventory:setAlpha(1)
	f33_arg0.DeadSpectate:setAlpha(1)
end
CoD.WZHudMenus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.WarzoneInventory:completeAnimation()
			f34_arg0.WarzoneInventory:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.WarzoneInventory)
			f34_arg0.DeadSpectate:completeAnimation()
			f34_arg0.DeadSpectate:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DeadSpectate)
		end,
	},
	VisibleSpectatingClient = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.WarzoneInventory:completeAnimation()
			f35_arg0.WarzoneInventory:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.WarzoneInventory)
		end,
	},
	Visible = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WZHudMenus.__onClose = function(f37_arg0)
	f37_arg0.WarzoneInventory:close()
	f37_arg0.TabbedMultiItemPickup:close()
	f37_arg0.DeadSpectate:close()
end
