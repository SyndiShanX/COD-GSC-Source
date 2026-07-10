require("x64:4173a91ca2044e4")
require("x64:301dadc9491523e")
require("x64:fbc104452b6a2c6")
require("x64:72900fb9775b37")
require("x64:adb728c3ce7a4d3")
require("x64:29d84fa68c2a9ef")
CoD.WarzoneInventory = InheritFrom(LUI.UIElement)
CoD.WarzoneInventory.__defaultWidth = 800
CoD.WarzoneInventory.__defaultHeight = 100
CoD.WarzoneInventory.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventory)
	self.id = "WarzoneInventory"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HintTexts = CoD.WarzoneInventoryHintItems.new(f1_arg0, f1_arg1, 0, 0, 369, 469, 0, 0, -23, 77)
	self:addElement(HintTexts)
	self.HintTexts = HintTexts
	local RightConsumed = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 3, 0, nil, nil, false, false, false, false)
	RightConsumed:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return IsPC() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "endStartFraction", 0)
			end,
		},
	})
	RightConsumed:linkToElementModel(RightConsumed, "endStartFraction", true, function(model)
		f1_arg0:updateElementState(RightConsumed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "endStartFraction",
		})
	end)
	RightConsumed:linkToElementModel(RightConsumed, "disabled", true, function(model)
		f1_arg0:updateElementState(RightConsumed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	RightConsumed:linkToElementModel(RightConsumed, "notAvailable", true, function(model)
		f1_arg0:updateElementState(RightConsumed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "notAvailable",
		})
	end)
	RightConsumed:setLeftRight(0, 0, 472, 834)
	RightConsumed:setTopBottom(0, 0, -8, 62)
	RightConsumed:setWidgetType(CoD.WarzoneQuickInventoryMenuItemSmall)
	RightConsumed:setHorizontalCount(5)
	RightConsumed:setSpacing(3)
	RightConsumed:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RightConsumed:setDataSource("WarzoneConsumed")
	self:addElement(RightConsumed)
	self.RightConsumed = RightConsumed
	local RightConsumedHidden = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 3, 0, nil, nil, false, false, false, false)
	RightConsumedHidden:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return IsPC() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "endStartFraction", 0)
			end,
		},
	})
	RightConsumedHidden:linkToElementModel(RightConsumedHidden, "endStartFraction", true, function(model)
		f1_arg0:updateElementState(RightConsumedHidden, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "endStartFraction",
		})
	end)
	RightConsumedHidden:linkToElementModel(RightConsumedHidden, "disabled", true, function(model)
		f1_arg0:updateElementState(RightConsumedHidden, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	RightConsumedHidden:linkToElementModel(RightConsumedHidden, "notAvailable", true, function(model)
		f1_arg0:updateElementState(RightConsumedHidden, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "notAvailable",
		})
	end)
	RightConsumedHidden:setLeftRight(0, 0, 423, 785)
	RightConsumedHidden:setTopBottom(0, 0, -8, 62)
	RightConsumedHidden:setAlpha(0)
	RightConsumedHidden:setWidgetType(CoD.WarzoneQuickInventoryMenuItemSmall)
	RightConsumedHidden:setHorizontalCount(5)
	RightConsumedHidden:setSpacing(3)
	RightConsumedHidden:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RightConsumedHidden:setDataSource("WarzoneConsumed")
	self:addElement(RightConsumedHidden)
	self.RightConsumedHidden = RightConsumedHidden
	local LeftConsumed = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 3, 0, nil, nil, false, false, false, false)
	LeftConsumed:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return IsPC() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "endStartFraction", 0)
			end,
		},
	})
	LeftConsumed:linkToElementModel(LeftConsumed, "endStartFraction", true, function(model)
		f1_arg0:updateElementState(LeftConsumed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "endStartFraction",
		})
	end)
	LeftConsumed:linkToElementModel(LeftConsumed, "disabled", true, function(model)
		f1_arg0:updateElementState(LeftConsumed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LeftConsumed:linkToElementModel(LeftConsumed, "notAvailable", true, function(model)
		f1_arg0:updateElementState(LeftConsumed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "notAvailable",
		})
	end)
	LeftConsumed:setLeftRight(1, 1, -795, -433)
	LeftConsumed:setTopBottom(0, 0, -8, 62)
	LeftConsumed:setWidgetType(CoD.WarzoneQuickInventoryMenuItemSmall)
	LeftConsumed:setHorizontalCount(5)
	LeftConsumed:setSpacing(3)
	LeftConsumed:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	LeftConsumed:setDataSource("WarzoneConsumed")
	self:addElement(LeftConsumed)
	self.LeftConsumed = LeftConsumed
	local LeftConsumedHidden = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 3, 0, nil, nil, false, false, false, false)
	LeftConsumedHidden:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return IsPC() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "endStartFraction", 0)
			end,
		},
	})
	LeftConsumedHidden:linkToElementModel(LeftConsumedHidden, "endStartFraction", true, function(model)
		f1_arg0:updateElementState(LeftConsumedHidden, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "endStartFraction",
		})
	end)
	LeftConsumedHidden:linkToElementModel(LeftConsumedHidden, "disabled", true, function(model)
		f1_arg0:updateElementState(LeftConsumedHidden, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LeftConsumedHidden:linkToElementModel(LeftConsumedHidden, "notAvailable", true, function(model)
		f1_arg0:updateElementState(LeftConsumedHidden, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "notAvailable",
		})
	end)
	LeftConsumedHidden:setLeftRight(1, 1, -743, -381)
	LeftConsumedHidden:setTopBottom(0, 0, -8, 62)
	LeftConsumedHidden:setAlpha(0)
	LeftConsumedHidden:setWidgetType(CoD.WarzoneQuickInventoryMenuItemSmall)
	LeftConsumedHidden:setHorizontalCount(5)
	LeftConsumedHidden:setSpacing(3)
	LeftConsumedHidden:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	LeftConsumedHidden:setDataSource("WarzoneConsumed")
	self:addElement(LeftConsumedHidden)
	self.LeftConsumedHidden = LeftConsumedHidden
	local InventoryEquipmentSmall = CoD.WarzoneContextualExtraItems.new(f1_arg0, f1_arg1, 0, 0, 240.5, 534.5, 0, 0, -112, -16)
	InventoryEquipmentSmall.InventoryEquipmentLarge:setHorizontalCount(10)
	InventoryEquipmentSmall.InventoryEquipmentLarge:setFilter(function(f18_arg0)
		local f18_local0
		if f18_arg0.equipped:get() ~= 0 or f18_arg0.availableAction:get() ~= CoD.WZUtility.ItemAvailableAction.CONSUME or f18_arg0.quickEquip:get() ~= 1 then
			f18_local0 = false
		else
			f18_local0 = true
		end
		return f18_local0
	end)
	InventoryEquipmentSmall.InventoryEquipmentLarge:setDataSource("WarzoneInventory")
	InventoryEquipmentSmall.InventoryEquipmentSmall:setHorizontalCount(10)
	InventoryEquipmentSmall.InventoryEquipmentSmall:setFilter(function(f19_arg0)
		local f19_local0
		if f19_arg0.equipped:get() ~= 0 or f19_arg0.availableAction:get() ~= CoD.WZUtility.ItemAvailableAction.CONSUME or f19_arg0.quickEquip:get() ~= 1 then
			f19_local0 = false
		else
			f19_local0 = true
		end
		return f19_local0
	end)
	InventoryEquipmentSmall.InventoryEquipmentSmall:setDataSource("WarzoneInventory")
	self:addElement(InventoryEquipmentSmall)
	self.InventoryEquipmentSmall = InventoryEquipmentSmall
	local QuickLabel = LUI.UIText.new(0, 0, 319, 519, 0, 0, -22, -4)
	QuickLabel:setText(LocalizeToUpperString(@"warzone/quick_equip"))
	QuickLabel:setTTF("ttmussels_regular")
	QuickLabel:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	QuickLabel:setShaderVector(0, 0.6, 0, 0, 0)
	QuickLabel:setShaderVector(1, 0.3, 0, 0, 0)
	QuickLabel:setShaderVector(2, 0, 0, 0, 1)
	QuickLabel:setLetterSpacing(2)
	QuickLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	QuickLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(QuickLabel)
	self.QuickLabel = QuickLabel
	local InventoryPromptImazge = CoD.WarzoneInventoryNag.new(f1_arg0, f1_arg1, 0.5, 0.5, -102.5, 134.5, 0, 0, 58, 95)
	self:addElement(InventoryPromptImazge)
	self.InventoryPromptImazge = InventoryPromptImazge
	local QuickLabel3 = CoD.WarzoneInventoryCalloutGestureHintText.new(f1_arg0, f1_arg1, 0, 0, 184, 654, 0, 0, 18, 36)
	self:addElement(QuickLabel3)
	self.QuickLabel3 = QuickLabel3
	local WarzoneQuickConsumeSlotPC = nil
	WarzoneQuickConsumeSlotPC = CoD.WarzoneQuickConsumeSlotPC.new(f1_arg0, f1_arg1, 0, 0, 355.5, 485.5, 0, 0, -25, 105)
	WarzoneQuickConsumeSlotPC:setScale(1.07, 1.07)
	self:addElement(WarzoneQuickConsumeSlotPC)
	self.WarzoneQuickConsumeSlotPC = WarzoneQuickConsumeSlotPC
	self:mergeStateConditions({
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				local f20_local0 = IsMouseOrKeyboard(f1_arg1)
				if f20_local0 then
					if not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
						f20_local0 = not CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideActivePerksUI", "warzoneHideActivePerks")
					else
						f20_local0 = false
					end
				end
				return f20_local0
			end,
		},
		{
			stateName = "KeyboardAndMouseHidden",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "InventoryOpenHiddenAllPreference",
			condition = function(menu, element, event)
				local f22_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") then
					f22_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.open", true)
					if f22_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
							f22_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
							if f22_local0 then
								f22_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideActivePerksUI", "warzoneHideActivePerks")
							end
						else
							f22_local0 = false
						end
					end
				else
					f22_local0 = false
				end
				return f22_local0
			end,
		},
		{
			stateName = "InventoryOpenHiddenButtonsPreference",
			condition = function(menu, element, event)
				local f23_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") then
					f23_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.open", true)
					if f23_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
							f23_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
						else
							f23_local0 = false
						end
					end
				else
					f23_local0 = false
				end
				return f23_local0
			end,
		},
		{
			stateName = "InventoryOpenHiddenPerksPreference",
			condition = function(menu, element, event)
				local f24_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") then
					f24_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.open", true)
					if f24_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
							f24_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideActivePerksUI", "warzoneHideActivePerks")
						else
							f24_local0 = false
						end
					end
				else
					f24_local0 = false
				end
				return f24_local0
			end,
		},
		{
			stateName = "InventoryOpen",
			condition = function(menu, element, event)
				local f25_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") then
					f25_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.open", true)
					if f25_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") then
							f25_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1)
						else
							f25_local0 = false
						end
					end
				else
					f25_local0 = false
				end
				return f25_local0
			end,
		},
		{
			stateName = "InventoryVisibleHiddenAllPreference",
			condition = function(menu, element, event)
				local f26_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") then
					f26_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.canUseQuickInventory", true)
					if f26_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
							f26_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
							if f26_local0 then
								f26_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideActivePerksUI", "warzoneHideActivePerks")
							end
						else
							f26_local0 = false
						end
					end
				else
					f26_local0 = false
				end
				return f26_local0
			end,
		},
		{
			stateName = "InventoryVisibleHiddenButtonsPreference",
			condition = function(menu, element, event)
				local f27_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") then
					f27_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.canUseQuickInventory", true)
					if f27_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
							f27_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
						else
							f27_local0 = false
						end
					end
				else
					f27_local0 = false
				end
				return f27_local0
			end,
		},
		{
			stateName = "InventoryVisibleHiddenPerksPreference",
			condition = function(menu, element, event)
				local f28_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") then
					f28_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.canUseQuickInventory", true)
					if f28_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
							f28_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideActivePerksUI", "warzoneHideActivePerks")
						else
							f28_local0 = false
						end
					end
				else
					f28_local0 = false
				end
				return f28_local0
			end,
		},
		{
			stateName = "InventoryVisible",
			condition = function(menu, element, event)
				local f29_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") then
					f29_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.canUseQuickInventory", true)
					if f29_local0 then
						if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "vehicle.hidePlayerInfo") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
							f29_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.playerOnInfectedPlatoon", 0)
						else
							f29_local0 = false
						end
					end
				else
					f29_local0 = false
				end
				return f29_local0
			end,
		},
		{
			stateName = "QuickInventoryEmptyHiddenAllPreference",
			condition = function(menu, element, event)
				local f30_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
					f30_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
					if f30_local0 then
						f30_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideActivePerksUI", "warzoneHideActivePerks")
					end
				else
					f30_local0 = false
				end
				return f30_local0
			end,
		},
		{
			stateName = "QuickInventoryEmptyHiddenButtonsPreference",
			condition = function(menu, element, event)
				local f31_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
					f31_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
				else
					f31_local0 = false
				end
				return f31_local0
			end,
		},
		{
			stateName = "QuickInventoryEmptyHiddenPerksPreference",
			condition = function(menu, element, event)
				local f32_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
					f32_local0 = CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideActivePerksUI", "warzoneHideActivePerks")
				else
					f32_local0 = false
				end
				return f32_local0
			end,
		},
		{
			stateName = "QuickInventoryEmpty",
			condition = function(menu, element, event)
				local f33_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) and not CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) then
					f33_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.playerOnInfectedPlatoon", 0)
				else
					f33_local0 = false
				end
				return f33_local0
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f34_arg0, f34_arg1)
		f34_arg1.menu = f34_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f34_arg1)
	end)
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13.LastInput, function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.lastStand.progress"], function(f36_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "hudItems.lastStand.progress",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.lastStand.beingRevived"], function(f37_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "hudItems.lastStand.beingRevived",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]], function(f38_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f39_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f40_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f41_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f42_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f43_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["vehicle.hidePlayerInfo"], function(f44_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "vehicle.hidePlayerInfo",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.infiltrationVehicle"], function(f45_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "hudItems.infiltrationVehicle",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13.PlayerSettingsUpdate, function(f46_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.inventory.open"], function(f47_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.inventory.canUseQuickInventory"], function(f48_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "hudItems.inventory.canUseQuickInventory",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.playerOnInfectedPlatoon"], function(f49_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "hudItems.playerOnInfectedPlatoon",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f50_arg2, f50_arg3, f50_arg4)
		if CoD.BaseUtility.IsSelfInEitherState(self, "MultiPickupVisible", "MultiPickupVisibleBackpack") then
			SetLoseFocusToSelf(self, controller)
			CoD.HUDUtility.PushAllowButtonRepeats(self, controller)
		elseif CoD.BaseUtility.IsSelfInEitherState(self, "InventoryVisible", "QuickInventoryEmpty") then
			SetFocusToSelf(self, controller)
			CoD.HUDUtility.PopAllowButtonRepeats(self, controller)
		else
			SetLoseFocusToSelf(self, controller)
			CoD.HUDUtility.PopAllowButtonRepeats(self, controller)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.HUDUtility.PopAllowButtonRepeats(self, f1_arg1)
	end)
	RightConsumed.id = "RightConsumed"
	RightConsumedHidden.id = "RightConsumedHidden"
	LeftConsumed.id = "LeftConsumed"
	LeftConsumedHidden.id = "LeftConsumedHidden"
	InventoryEquipmentSmall.id = "InventoryEquipmentSmall"
	if CoD.isPC then
		WarzoneQuickConsumeSlotPC.id = "WarzoneQuickConsumeSlotPC"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	CoD.WZUtility.SetUpPassCustomFunctionToChildElement(self, self.HintTexts, "_cancelInventoryHints")
	CoD.WZUtility.SetUpPassCustomFunctionToChildElement(self, self.HintTexts, "_showInventoryHints")
	CoD.WZUtility.SetUpPassCustomFunctionToChildElement(self, self.HintTexts, "_showInventoryHints_NoEquip")
	SetElementProperty(RightConsumed, "secondHalf", true)
	SetElementProperty(RightConsumedHidden, "secondHalf", true)
	SetElementProperty(LeftConsumed, "firstHalf", true)
	SetElementProperty(LeftConsumedHidden, "firstHalf", true)
	CoD.WZUtility.AddQuickAccessInventoryWidget(f1_arg0, f1_arg1, InventoryEquipmentSmall, 3, false)
	return self
end
CoD.WarzoneInventory.__resetProperties = function(f52_arg0)
	f52_arg0.InventoryEquipmentSmall:completeAnimation()
	f52_arg0.QuickLabel:completeAnimation()
	f52_arg0.HintTexts:completeAnimation()
	f52_arg0.InventoryPromptImazge:completeAnimation()
	f52_arg0.QuickLabel3:completeAnimation()
	f52_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
	f52_arg0.LeftConsumedHidden:completeAnimation()
	f52_arg0.LeftConsumed:completeAnimation()
	f52_arg0.RightConsumedHidden:completeAnimation()
	f52_arg0.RightConsumed:completeAnimation()
	f52_arg0.InventoryEquipmentSmall:setAlpha(1)
	f52_arg0.QuickLabel:setAlpha(1)
	f52_arg0.HintTexts:setAlpha(1)
	f52_arg0.InventoryPromptImazge:setAlpha(1)
	f52_arg0.QuickLabel3:setAlpha(1)
	f52_arg0.WarzoneQuickConsumeSlotPC:setAlpha(1)
	f52_arg0.LeftConsumedHidden:setAlpha(0)
	f52_arg0.LeftConsumed:setAlpha(1)
	f52_arg0.RightConsumedHidden:setAlpha(0)
	f52_arg0.RightConsumed:setAlpha(1)
end
CoD.WarzoneInventory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(5)
			f53_arg0.HintTexts:completeAnimation()
			f53_arg0.HintTexts:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.HintTexts)
			f53_arg0.InventoryEquipmentSmall:completeAnimation()
			f53_arg0.InventoryEquipmentSmall:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.InventoryEquipmentSmall)
			f53_arg0.QuickLabel:completeAnimation()
			f53_arg0.QuickLabel:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.QuickLabel)
			f53_arg0.InventoryPromptImazge:completeAnimation()
			f53_arg0.InventoryPromptImazge:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.InventoryPromptImazge)
			f53_arg0.QuickLabel3:completeAnimation()
			f53_arg0.QuickLabel3:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.QuickLabel3)
		end,
	},
	KeyboardAndMouse = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(6)
			f54_arg0.HintTexts:completeAnimation()
			f54_arg0.HintTexts:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.HintTexts)
			f54_arg0.InventoryEquipmentSmall:completeAnimation()
			f54_arg0.InventoryEquipmentSmall:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.InventoryEquipmentSmall)
			f54_arg0.QuickLabel:completeAnimation()
			f54_arg0.QuickLabel:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.QuickLabel)
			f54_arg0.InventoryPromptImazge:completeAnimation()
			f54_arg0.InventoryPromptImazge:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.InventoryPromptImazge)
			f54_arg0.QuickLabel3:completeAnimation()
			f54_arg0.QuickLabel3:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.QuickLabel3)
			f54_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f54_arg0.WarzoneQuickConsumeSlotPC:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	KeyboardAndMouseHidden = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(10)
			f55_arg0.HintTexts:completeAnimation()
			f55_arg0.HintTexts:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.HintTexts)
			f55_arg0.RightConsumed:completeAnimation()
			f55_arg0.RightConsumed:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.RightConsumed)
			f55_arg0.RightConsumedHidden:completeAnimation()
			f55_arg0.RightConsumedHidden:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.RightConsumedHidden)
			f55_arg0.LeftConsumed:completeAnimation()
			f55_arg0.LeftConsumed:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.LeftConsumed)
			f55_arg0.LeftConsumedHidden:completeAnimation()
			f55_arg0.LeftConsumedHidden:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.LeftConsumedHidden)
			f55_arg0.InventoryEquipmentSmall:completeAnimation()
			f55_arg0.InventoryEquipmentSmall:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.InventoryEquipmentSmall)
			f55_arg0.QuickLabel:completeAnimation()
			f55_arg0.QuickLabel:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.QuickLabel)
			f55_arg0.InventoryPromptImazge:completeAnimation()
			f55_arg0.InventoryPromptImazge:setAlpha(1)
			f55_arg0.clipFinished(f55_arg0.InventoryPromptImazge)
			f55_arg0.QuickLabel3:completeAnimation()
			f55_arg0.QuickLabel3:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.QuickLabel3)
			f55_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f55_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	InventoryOpenHiddenAllPreference = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(9)
			f56_arg0.HintTexts:completeAnimation()
			f56_arg0.HintTexts:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.HintTexts)
			f56_arg0.RightConsumed:completeAnimation()
			f56_arg0.RightConsumed:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.RightConsumed)
			f56_arg0.RightConsumedHidden:completeAnimation()
			f56_arg0.RightConsumedHidden:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.RightConsumedHidden)
			f56_arg0.LeftConsumed:completeAnimation()
			f56_arg0.LeftConsumed:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.LeftConsumed)
			f56_arg0.LeftConsumedHidden:completeAnimation()
			f56_arg0.LeftConsumedHidden:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.LeftConsumedHidden)
			f56_arg0.QuickLabel:completeAnimation()
			f56_arg0.QuickLabel:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.QuickLabel)
			f56_arg0.InventoryPromptImazge:completeAnimation()
			f56_arg0.InventoryPromptImazge:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.InventoryPromptImazge)
			f56_arg0.QuickLabel3:completeAnimation()
			f56_arg0.QuickLabel3:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.QuickLabel3)
			f56_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f56_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	InventoryOpenHiddenButtonsPreference = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(9)
			f57_arg0.HintTexts:completeAnimation()
			f57_arg0.HintTexts:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.HintTexts)
			f57_arg0.RightConsumed:completeAnimation()
			f57_arg0.RightConsumed:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.RightConsumed)
			f57_arg0.RightConsumedHidden:completeAnimation()
			f57_arg0.RightConsumedHidden:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.RightConsumedHidden)
			f57_arg0.LeftConsumed:completeAnimation()
			f57_arg0.LeftConsumed:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.LeftConsumed)
			f57_arg0.LeftConsumedHidden:completeAnimation()
			f57_arg0.LeftConsumedHidden:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.LeftConsumedHidden)
			f57_arg0.QuickLabel:completeAnimation()
			f57_arg0.QuickLabel:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.QuickLabel)
			f57_arg0.InventoryPromptImazge:completeAnimation()
			f57_arg0.InventoryPromptImazge:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.InventoryPromptImazge)
			f57_arg0.QuickLabel3:completeAnimation()
			f57_arg0.QuickLabel3:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.QuickLabel3)
			f57_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f57_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	InventoryOpenHiddenPerksPreference = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(6)
			f58_arg0.RightConsumed:completeAnimation()
			f58_arg0.RightConsumed:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.RightConsumed)
			f58_arg0.LeftConsumed:completeAnimation()
			f58_arg0.LeftConsumed:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.LeftConsumed)
			f58_arg0.QuickLabel:completeAnimation()
			f58_arg0.QuickLabel:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.QuickLabel)
			f58_arg0.InventoryPromptImazge:completeAnimation()
			f58_arg0.InventoryPromptImazge:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.InventoryPromptImazge)
			f58_arg0.QuickLabel3:completeAnimation()
			f58_arg0.QuickLabel3:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.QuickLabel3)
			f58_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f58_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	InventoryOpen = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(4)
			f59_arg0.QuickLabel:completeAnimation()
			f59_arg0.QuickLabel:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.QuickLabel)
			f59_arg0.InventoryPromptImazge:completeAnimation()
			f59_arg0.InventoryPromptImazge:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.InventoryPromptImazge)
			f59_arg0.QuickLabel3:completeAnimation()
			f59_arg0.QuickLabel3:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.QuickLabel3)
			f59_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f59_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	InventoryVisibleHiddenAllPreference = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(9)
			f60_arg0.HintTexts:completeAnimation()
			f60_arg0.HintTexts:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.HintTexts)
			f60_arg0.RightConsumed:completeAnimation()
			f60_arg0.RightConsumed:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.RightConsumed)
			f60_arg0.RightConsumedHidden:completeAnimation()
			f60_arg0.RightConsumedHidden:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.RightConsumedHidden)
			f60_arg0.LeftConsumed:completeAnimation()
			f60_arg0.LeftConsumed:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.LeftConsumed)
			f60_arg0.LeftConsumedHidden:completeAnimation()
			f60_arg0.LeftConsumedHidden:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.LeftConsumedHidden)
			f60_arg0.QuickLabel:completeAnimation()
			f60_arg0.QuickLabel:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.QuickLabel)
			f60_arg0.InventoryPromptImazge:completeAnimation()
			f60_arg0.InventoryPromptImazge:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.InventoryPromptImazge)
			f60_arg0.QuickLabel3:completeAnimation()
			f60_arg0.QuickLabel3:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.QuickLabel3)
			f60_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f60_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	InventoryVisibleHiddenButtonsPreference = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(9)
			f61_arg0.HintTexts:completeAnimation()
			f61_arg0.HintTexts:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.HintTexts)
			f61_arg0.RightConsumed:completeAnimation()
			f61_arg0.RightConsumed:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.RightConsumed)
			f61_arg0.RightConsumedHidden:completeAnimation()
			f61_arg0.RightConsumedHidden:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.RightConsumedHidden)
			f61_arg0.LeftConsumed:completeAnimation()
			f61_arg0.LeftConsumed:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.LeftConsumed)
			f61_arg0.LeftConsumedHidden:completeAnimation()
			f61_arg0.LeftConsumedHidden:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.LeftConsumedHidden)
			f61_arg0.QuickLabel:completeAnimation()
			f61_arg0.QuickLabel:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.QuickLabel)
			f61_arg0.InventoryPromptImazge:completeAnimation()
			f61_arg0.InventoryPromptImazge:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.InventoryPromptImazge)
			f61_arg0.QuickLabel3:completeAnimation()
			f61_arg0.QuickLabel3:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.QuickLabel3)
			f61_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f61_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	InventoryVisibleHiddenPerksPreference = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(9)
			f62_arg0.HintTexts:completeAnimation()
			f62_arg0.HintTexts:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.HintTexts)
			f62_arg0.RightConsumed:completeAnimation()
			f62_arg0.RightConsumed:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.RightConsumed)
			f62_arg0.RightConsumedHidden:completeAnimation()
			f62_arg0.RightConsumedHidden:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.RightConsumedHidden)
			f62_arg0.LeftConsumed:completeAnimation()
			f62_arg0.LeftConsumed:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.LeftConsumed)
			f62_arg0.LeftConsumedHidden:completeAnimation()
			f62_arg0.LeftConsumedHidden:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.LeftConsumedHidden)
			f62_arg0.QuickLabel:completeAnimation()
			f62_arg0.QuickLabel:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.QuickLabel)
			f62_arg0.InventoryPromptImazge:completeAnimation()
			f62_arg0.InventoryPromptImazge:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.InventoryPromptImazge)
			f62_arg0.QuickLabel3:completeAnimation()
			f62_arg0.QuickLabel3:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.QuickLabel3)
			f62_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f62_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	InventoryVisible = {
		DefaultClip = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(1)
			f63_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f63_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	QuickInventoryEmptyHiddenAllPreference = {
		DefaultClip = function(f64_arg0, f64_arg1)
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter(10)
			f64_arg0.HintTexts:completeAnimation()
			f64_arg0.HintTexts:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.HintTexts)
			f64_arg0.RightConsumed:completeAnimation()
			f64_arg0.RightConsumed:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.RightConsumed)
			f64_arg0.RightConsumedHidden:completeAnimation()
			f64_arg0.RightConsumedHidden:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.RightConsumedHidden)
			f64_arg0.LeftConsumed:completeAnimation()
			f64_arg0.LeftConsumed:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.LeftConsumed)
			f64_arg0.LeftConsumedHidden:completeAnimation()
			f64_arg0.LeftConsumedHidden:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.LeftConsumedHidden)
			f64_arg0.InventoryEquipmentSmall:completeAnimation()
			f64_arg0.InventoryEquipmentSmall:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.InventoryEquipmentSmall)
			f64_arg0.QuickLabel:completeAnimation()
			f64_arg0.QuickLabel:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.QuickLabel)
			f64_arg0.InventoryPromptImazge:completeAnimation()
			f64_arg0.InventoryPromptImazge:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.InventoryPromptImazge)
			f64_arg0.QuickLabel3:completeAnimation()
			f64_arg0.QuickLabel3:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.QuickLabel3)
			f64_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f64_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	QuickInventoryEmptyHiddenButtonsPreference = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(10)
			f65_arg0.HintTexts:completeAnimation()
			f65_arg0.HintTexts:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.HintTexts)
			f65_arg0.RightConsumed:completeAnimation()
			f65_arg0.RightConsumed:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.RightConsumed)
			f65_arg0.RightConsumedHidden:completeAnimation()
			f65_arg0.RightConsumedHidden:setAlpha(1)
			f65_arg0.clipFinished(f65_arg0.RightConsumedHidden)
			f65_arg0.LeftConsumed:completeAnimation()
			f65_arg0.LeftConsumed:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.LeftConsumed)
			f65_arg0.LeftConsumedHidden:completeAnimation()
			f65_arg0.LeftConsumedHidden:setAlpha(1)
			f65_arg0.clipFinished(f65_arg0.LeftConsumedHidden)
			f65_arg0.InventoryEquipmentSmall:completeAnimation()
			f65_arg0.InventoryEquipmentSmall:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.InventoryEquipmentSmall)
			f65_arg0.QuickLabel:completeAnimation()
			f65_arg0.QuickLabel:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.QuickLabel)
			f65_arg0.InventoryPromptImazge:completeAnimation()
			f65_arg0.InventoryPromptImazge:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.InventoryPromptImazge)
			f65_arg0.QuickLabel3:completeAnimation()
			f65_arg0.QuickLabel3:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.QuickLabel3)
			f65_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f65_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	QuickInventoryEmptyHiddenPerksPreference = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(6)
			f66_arg0.HintTexts:completeAnimation()
			f66_arg0.HintTexts:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.HintTexts)
			f66_arg0.RightConsumed:completeAnimation()
			f66_arg0.RightConsumed:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.RightConsumed)
			f66_arg0.LeftConsumed:completeAnimation()
			f66_arg0.LeftConsumed:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.LeftConsumed)
			f66_arg0.InventoryEquipmentSmall:completeAnimation()
			f66_arg0.InventoryEquipmentSmall:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.InventoryEquipmentSmall)
			f66_arg0.QuickLabel:completeAnimation()
			f66_arg0.QuickLabel:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.QuickLabel)
			f66_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f66_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
	QuickInventoryEmpty = {
		DefaultClip = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(4)
			f67_arg0.HintTexts:completeAnimation()
			f67_arg0.HintTexts:setAlpha(1)
			f67_arg0.clipFinished(f67_arg0.HintTexts)
			f67_arg0.InventoryEquipmentSmall:completeAnimation()
			f67_arg0.InventoryEquipmentSmall:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.InventoryEquipmentSmall)
			f67_arg0.QuickLabel:completeAnimation()
			f67_arg0.QuickLabel:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.QuickLabel)
			f67_arg0.WarzoneQuickConsumeSlotPC:completeAnimation()
			f67_arg0.WarzoneQuickConsumeSlotPC:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.WarzoneQuickConsumeSlotPC)
		end,
	},
}
CoD.WarzoneInventory.__onClose = function(f68_arg0)
	f68_arg0.HintTexts:close()
	f68_arg0.RightConsumed:close()
	f68_arg0.RightConsumedHidden:close()
	f68_arg0.LeftConsumed:close()
	f68_arg0.LeftConsumedHidden:close()
	f68_arg0.InventoryEquipmentSmall:close()
	f68_arg0.InventoryPromptImazge:close()
	f68_arg0.QuickLabel3:close()
	f68_arg0.WarzoneQuickConsumeSlotPC:close()
end
