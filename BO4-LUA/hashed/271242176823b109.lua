require("x64:ff067acac78c2da")
CoD.WarzoneInventoryLine = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryLine.__defaultWidth = 1920
CoD.WarzoneInventoryLine.__defaultHeight = 128
CoD.WarzoneInventoryLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryLine)
	self.id = "WarzoneInventoryLine"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PointerHealth = CoD.WarzoneInventoryLineArrow.new(f1_arg0, f1_arg1, 0, 0, 175, 219, 0, 0, 56, 84)
	PointerHealth:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableHealthCount", 0)
			end,
		},
	})
	local PointerAttachments = PointerHealth
	local PointerEquipment = PointerHealth.subscribeToModel
	local f1_local4 = DataSources.WarzoneInventory.getModel(f1_arg1)
	PointerEquipment(PointerAttachments, f1_local4.availableHealthCount, function(f3_arg0)
		f1_arg0:updateElementState(PointerHealth, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "availableHealthCount",
		})
	end, false)
	self:addElement(PointerHealth)
	self.PointerHealth = PointerHealth
	PointerEquipment = CoD.WarzoneInventoryLineArrow.new(f1_arg0, f1_arg1, 1, 1, -348, -304, 0, 0, 56, 84)
	PointerEquipment:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableEquipmentCount", 0)
			end,
		},
	})
	f1_local4 = PointerEquipment
	PointerAttachments = PointerEquipment.subscribeToModel
	local f1_local5 = DataSources.WarzoneInventory.getModel(f1_arg1)
	PointerAttachments(f1_local4, f1_local5.availableEquipmentCount, function(f5_arg0)
		f1_arg0:updateElementState(PointerEquipment, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "availableEquipmentCount",
		})
	end, false)
	self:addElement(PointerEquipment)
	self.PointerEquipment = PointerEquipment
	PointerAttachments = CoD.WarzoneInventoryLineArrow.new(f1_arg0, f1_arg1, 1, 1, -55, -11, 0, 0, 56, 84)
	PointerAttachments:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableAttachmentCount", 0)
			end,
		},
	})
	f1_local5 = PointerAttachments
	f1_local4 = PointerAttachments.subscribeToModel
	local f1_local6 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local4(f1_local5, f1_local6.availableAttachmentCount, function(f7_arg0)
		f1_arg0:updateElementState(PointerAttachments, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "availableAttachmentCount",
		})
	end, false)
	self:addElement(PointerAttachments)
	self.PointerAttachments = PointerAttachments
	self:mergeStateConditions({
		{
			stateName = "Open",
			condition = function(menu, element, event)
				local f8_local0 = CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
				if f8_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) then
						f8_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
	})
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["hudItems.inventory.open"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local5, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryLine.__resetProperties = function(f22_arg0)
	f22_arg0.PointerHealth:completeAnimation()
	f22_arg0.PointerEquipment:completeAnimation()
	f22_arg0.PointerAttachments:completeAnimation()
	f22_arg0.PointerHealth:setAlpha(1)
	f22_arg0.PointerEquipment:setAlpha(1)
	f22_arg0.PointerAttachments:setAlpha(1)
end
CoD.WarzoneInventoryLine.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.PointerHealth:completeAnimation()
			f23_arg0.PointerHealth:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PointerHealth)
			f23_arg0.PointerEquipment:completeAnimation()
			f23_arg0.PointerEquipment:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PointerEquipment)
			f23_arg0.PointerAttachments:completeAnimation()
			f23_arg0.PointerAttachments:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PointerAttachments)
		end,
	},
	Open = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WarzoneInventoryLine.__onClose = function(f25_arg0)
	f25_arg0.PointerHealth:close()
	f25_arg0.PointerEquipment:close()
	f25_arg0.PointerAttachments:close()
end
