require("x64:34778f864da9dda")
require("x64:aff61c91cbc2694")
require("x64:adb728c3ce7a4d3")
CoD.WarzoneQuickConsumeSlotPC = InheritFrom(LUI.UIElement)
CoD.WarzoneQuickConsumeSlotPC.__defaultWidth = 130
CoD.WarzoneQuickConsumeSlotPC.__defaultHeight = 130
CoD.WarzoneQuickConsumeSlotPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneQuickConsumeSlotPC)
	self.id = "WarzoneQuickConsumeSlotPC"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InventoryEquipmentSmall = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	InventoryEquipmentSmall:setLeftRight(0, 0, 38, 90)
	InventoryEquipmentSmall:setTopBottom(0, 0, 92, 108)
	InventoryEquipmentSmall:setWidgetType(CoD.WarzoneInventoryItemGrayBox)
	InventoryEquipmentSmall:setHorizontalCount(3)
	InventoryEquipmentSmall:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(InventoryEquipmentSmall)
	self.InventoryEquipmentSmall = InventoryEquipmentSmall
	local ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -43, 46, 0, 0, 93, 115)
	ControllerDependentTextBox:mergeStateConditions({
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbility",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseUltimate",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseScoreStreak",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbilityWZ",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.WZUtility.ShowQuickInventoryPC(f1_arg1)
			end,
		},
		{
			stateName = "Hidden2",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	local EmptyPanel = ControllerDependentTextBox
	local EmptyBlur = ControllerDependentTextBox.subscribeToModel
	local FullConsumed = Engine[@"getmodelforcontroller"](f1_arg1)
	EmptyBlur(EmptyPanel, FullConsumed["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f8_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	EmptyPanel = ControllerDependentTextBox
	EmptyBlur = ControllerDependentTextBox.subscribeToModel
	FullConsumed = Engine[@"getmodelforcontroller"](f1_arg1)
	EmptyBlur(EmptyPanel, FullConsumed["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f9_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	ControllerDependentTextBox:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ControllerDependentTextBox, f10_arg1)
	end)
	EmptyPanel = ControllerDependentTextBox
	EmptyBlur = ControllerDependentTextBox.subscribeToModel
	FullConsumed = Engine[@"getmodelforcontroller"](f1_arg1)
	EmptyBlur(EmptyPanel, FullConsumed.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	EmptyPanel = ControllerDependentTextBox
	EmptyBlur = ControllerDependentTextBox.subscribeToModel
	FullConsumed = Engine[@"getmodelforcontroller"](f1_arg1)
	EmptyBlur(EmptyPanel, FullConsumed["hudItems.inventory.quickConsumeNetworkId"], function(f12_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.inventory.quickConsumeNetworkId",
		})
	end, false)
	ControllerDependentTextBox.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{quickconsume1}]"))
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	EmptyBlur = LUI.UIImage.new(0.5, 0.5, -33.5, 33.5, 0, 0, 21.5, 88.5)
	EmptyBlur:setScale(0.96, 0.96)
	EmptyBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	EmptyBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(EmptyBlur)
	self.EmptyBlur = EmptyBlur
	EmptyPanel = LUI.UIImage.new(0.5, 0.5, -33.5, 33.5, 0, 0, 21.5, 88.5)
	EmptyPanel:setRGB(0.11, 0.11, 0.11)
	EmptyPanel:setAlpha(0.65)
	EmptyPanel:setScale(0.95, 0.94)
	self:addElement(EmptyPanel)
	self.EmptyPanel = EmptyPanel
	FullConsumed = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 3, 0, nil, nil, false, false, false, false)
	FullConsumed:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	FullConsumed:linkToElementModel(FullConsumed, "endStartFraction", true, function(model)
		f1_arg0:updateElementState(FullConsumed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "endStartFraction",
		})
	end)
	FullConsumed:setLeftRight(0, 0, 31, 101)
	FullConsumed:setTopBottom(0, 0, 19.5, 89.5)
	FullConsumed:setWidgetType(CoD.WarzoneQuickInventoryMenuItemSmall)
	FullConsumed:setSpacing(3)
	FullConsumed:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	FullConsumed:setFilter(function(f16_arg0)
		return f16_arg0.type:get() ~= "ammo"
	end)
	FullConsumed:setDataSource("WarzoneInventory")
	self:addElement(FullConsumed)
	self.FullConsumed = FullConsumed
	local LED = LUI.UIImage.new(0, 0, 31, 99, 0, 0, 19.5, 87.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.2)
	LED:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_player_widget_led_heal"))
	self:addElement(LED)
	self.LED = LED
	local EmptyFrame = LUI.UIImage.new(0.5, 0.5, -42.5, 41.5, 0, 0, 12, 96)
	EmptyFrame:setImage(RegisterImage(@"uie_ui_pc_quickconsume_slot"))
	self:addElement(EmptyFrame)
	self.EmptyFrame = EmptyFrame
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.WZUtility.ShowQuickInventoryPC(f1_arg1)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.inventory.quickConsumeNetworkId"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.inventory.quickConsumeNetworkId",
		})
	end, false)
	InventoryEquipmentSmall.id = "InventoryEquipmentSmall"
	FullConsumed.id = "FullConsumed"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	CoD.WZUtility.SetQuickConsumeFilter(self, f1_arg1, self.FullConsumed)
	return self
end
CoD.WarzoneQuickConsumeSlotPC.__resetProperties = function(f19_arg0)
	f19_arg0.LED:completeAnimation()
	f19_arg0.InventoryEquipmentSmall:completeAnimation()
	f19_arg0.FullConsumed:completeAnimation()
	f19_arg0.EmptyPanel:completeAnimation()
	f19_arg0.EmptyBlur:completeAnimation()
	f19_arg0.EmptyFrame:completeAnimation()
	f19_arg0.ControllerDependentTextBox:completeAnimation()
	f19_arg0.LED:setAlpha(0.2)
	f19_arg0.InventoryEquipmentSmall:setAlpha(1)
	f19_arg0.FullConsumed:setAlpha(1)
	f19_arg0.EmptyPanel:setAlpha(0.65)
	f19_arg0.EmptyBlur:setAlpha(1)
	f19_arg0.EmptyFrame:setAlpha(1)
	f19_arg0.ControllerDependentTextBox:setAlpha(1)
end
CoD.WarzoneQuickConsumeSlotPC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(7)
			f21_arg0.InventoryEquipmentSmall:completeAnimation()
			f21_arg0.InventoryEquipmentSmall:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.InventoryEquipmentSmall)
			f21_arg0.ControllerDependentTextBox:completeAnimation()
			f21_arg0.ControllerDependentTextBox:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ControllerDependentTextBox)
			f21_arg0.EmptyBlur:completeAnimation()
			f21_arg0.EmptyBlur:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.EmptyBlur)
			f21_arg0.EmptyPanel:completeAnimation()
			f21_arg0.EmptyPanel:setAlpha(0.65)
			f21_arg0.clipFinished(f21_arg0.EmptyPanel)
			f21_arg0.FullConsumed:completeAnimation()
			f21_arg0.FullConsumed:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.FullConsumed)
			f21_arg0.LED:completeAnimation()
			f21_arg0.LED:setAlpha(0.2)
			f21_arg0.clipFinished(f21_arg0.LED)
			f21_arg0.EmptyFrame:completeAnimation()
			f21_arg0.EmptyFrame:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.EmptyFrame)
		end,
	},
}
CoD.WarzoneQuickConsumeSlotPC.__onClose = function(f22_arg0)
	f22_arg0.InventoryEquipmentSmall:close()
	f22_arg0.ControllerDependentTextBox:close()
	f22_arg0.FullConsumed:close()
end
