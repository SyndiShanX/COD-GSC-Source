require("x64:1744d99b88fcb45")
require("x64:aff61c91cbc2694")
require("x64:eef578dc6c7eb0b")
require("x64:2435be124ae6695")
CoD.WarzoneContextualExtraItems_RightAlign = InheritFrom(LUI.UIElement)
CoD.WarzoneContextualExtraItems_RightAlign.__defaultWidth = 292
CoD.WarzoneContextualExtraItems_RightAlign.__defaultHeight = 96
CoD.WarzoneContextualExtraItems_RightAlign.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneContextualExtraItems_RightAlign)
	self.id = "WarzoneContextualExtraItems_RightAlign"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InventoryEquipmentLarge = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	InventoryEquipmentLarge:setLeftRight(0.5, 0.5, -109, 105)
	InventoryEquipmentLarge:setTopBottom(1, 1, -93, -23)
	InventoryEquipmentLarge:setWidgetType(CoD.WarzoneQuickInventoryItem)
	InventoryEquipmentLarge:setHorizontalCount(3)
	InventoryEquipmentLarge:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	InventoryEquipmentLarge:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		UpdateSelfElementState(f1_arg0, self.ArrowL, f1_arg1)
		UpdateSelfElementState(f1_arg0, self.ArrowR, f1_arg1)
		return f2_local0
	end)
	self:addElement(InventoryEquipmentLarge)
	self.InventoryEquipmentLarge = InventoryEquipmentLarge
	local InventoryEquipmentSmall = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	InventoryEquipmentSmall:setLeftRight(0.5, 0.5, -28, 24)
	InventoryEquipmentSmall:setTopBottom(1, 1, -43, -27)
	InventoryEquipmentSmall:setWidgetType(CoD.WarzoneInventoryItemGrayBox)
	InventoryEquipmentSmall:setHorizontalCount(3)
	InventoryEquipmentSmall:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(InventoryEquipmentSmall)
	self.InventoryEquipmentSmall = InventoryEquipmentSmall
	local ArrowL = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 25, 41, 0, 0, 28, 44)
	ArrowL:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return ListElementHasElements(self.InventoryEquipmentLarge) and not CoD.WZUtility.IsQuickEquipListFirstItemVisible(self.InventoryEquipmentLarge)
			end,
		},
	})
	ArrowL:appendEventHandler("grid_updated", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ArrowL, f4_arg1)
	end)
	ArrowL:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ArrowL:setZRot(180)
	LUI.OverrideFunction_CallOriginalFirst(ArrowL, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		UpdateSelfElementState(f1_arg0, element, controller)
	end)
	self:addElement(ArrowL)
	self.ArrowL = ArrowL
	local ArrowR = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 248, 264, 0, 0, 28, 44)
	ArrowR:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return ListElementHasElements(self.InventoryEquipmentLarge) and not CoD.WZUtility.IsQuickEquipListLastItemVisible(self.InventoryEquipmentLarge)
			end,
		},
	})
	ArrowR:appendEventHandler("grid_updated", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ArrowR, f7_arg1)
	end)
	ArrowR:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LUI.OverrideFunction_CallOriginalFirst(ArrowR, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		UpdateSelfElementState(f1_arg0, element, controller)
	end)
	self:addElement(ArrowR)
	self.ArrowR = ArrowR
	local QuickInventoryItemCurrent = CoD.WarzoneQuickInventoryItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 32, 1, 1, -12, 58)
	QuickInventoryItemCurrent:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	QuickInventoryItemCurrent:linkToElementModel(QuickInventoryItemCurrent, "id", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemCurrent, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	QuickInventoryItemCurrent:linkToElementModel(QuickInventoryItemCurrent, "cycle", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemCurrent, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cycle",
		})
	end)
	QuickInventoryItemCurrent:linkToElementModel(QuickInventoryItemCurrent, "type", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemCurrent, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "type",
		})
	end)
	QuickInventoryItemCurrent:setAlpha(0)
	QuickInventoryItemCurrent.Button.Border:setRGB(0.39, 0.37, 0.34)
	QuickInventoryItemCurrent.Button.StackCount.Counter:setBackingColor(0.39, 0.37, 0.34)
	QuickInventoryItemCurrent.Bar:setAlpha(0)
	self:addElement(QuickInventoryItemCurrent)
	self.QuickInventoryItemCurrent = QuickInventoryItemCurrent
	local QuickInventoryItemMid = CoD.WarzoneQuickInventoryItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 32, 1, 1, -93, -23)
	QuickInventoryItemMid:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	QuickInventoryItemMid:linkToElementModel(QuickInventoryItemMid, "id", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemMid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	QuickInventoryItemMid:linkToElementModel(QuickInventoryItemMid, "cycle", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemMid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cycle",
		})
	end)
	QuickInventoryItemMid:linkToElementModel(QuickInventoryItemMid, "type", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemMid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "type",
		})
	end)
	QuickInventoryItemMid:setAlpha(0)
	QuickInventoryItemMid.Button.Border:setRGB(0.39, 0.37, 0.34)
	QuickInventoryItemMid.Button.StackCount.Counter:setBackingColor(0.39, 0.37, 0.34)
	QuickInventoryItemMid.Bar:setAlpha(0)
	self:addElement(QuickInventoryItemMid)
	self.QuickInventoryItemMid = QuickInventoryItemMid
	local QuickInventoryItemTop = CoD.WarzoneQuickInventoryItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 32, 1, 1, -166, -96)
	QuickInventoryItemTop:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	QuickInventoryItemTop:linkToElementModel(QuickInventoryItemTop, "id", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemTop, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	QuickInventoryItemTop:linkToElementModel(QuickInventoryItemTop, "cycle", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemTop, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cycle",
		})
	end)
	QuickInventoryItemTop:linkToElementModel(QuickInventoryItemTop, "type", true, function(model)
		f1_arg0:updateElementState(QuickInventoryItemTop, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "type",
		})
	end)
	QuickInventoryItemTop:setAlpha(0)
	QuickInventoryItemTop.Button.Border:setRGB(0.39, 0.37, 0.34)
	QuickInventoryItemTop.Button.StackCount.Counter:setBackingColor(0.39, 0.37, 0.34)
	QuickInventoryItemTop.Bar:setAlpha(0)
	self:addElement(QuickInventoryItemTop)
	self.QuickInventoryItemTop = QuickInventoryItemTop
	local SquarePrompt = CoD.WarzoneQuickInventoryUsePrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0, 0, -36, 0)
	SquarePrompt:setAlpha(0)
	self:addElement(SquarePrompt)
	self.SquarePrompt = SquarePrompt
	self:mergeStateConditions({
		{
			stateName = "CycleInventoryOpen",
			condition = function(menu, element, event)
				local f21_local0 = CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
				if f21_local0 then
					f21_local0 = CoD.OptionsUtility.IsProfileIntValue(f1_arg1, "warzoneCycleItems", 1)
					if f21_local0 then
						f21_local0 = CoD.WZUtility.IsQuickInventoryMenuDisabledInCycle(f1_arg1, element)
					end
				end
				return f21_local0
			end,
		},
		{
			stateName = "InventoryOpen",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "InventoryOpenRightAligned",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideMinimizedQuickEquipUI", "warzoneHideMinimizedQuickEquip")
			end,
		},
		{
			stateName = "InventoryClosedRightAligned",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["hudItems.inventory.open"], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local10(f1_local9, f1_local11["storageGlobalRoot.user_settings"], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.selectedIndex, function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.weapon3dForcedHintItem, function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "weapon3dForcedHintItem",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.showPickupHint, function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "showPickupHint",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.firstFreeSlot, function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "firstFreeSlot",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11.PlayerSettingsUpdate, function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f34_arg0, f34_arg1)
		f34_arg1.menu = f34_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f34_arg1)
	end)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11.LastInput, function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.inventory.equipment.realId", function(model)
		local f36_local0 = self
		PlayClip(self, "CycleDown", f1_arg1)
	end)
	InventoryEquipmentLarge.id = "InventoryEquipmentLarge"
	InventoryEquipmentSmall.id = "InventoryEquipmentSmall"
	if CoD.isPC then
		ArrowL.id = "ArrowL"
	end
	if CoD.isPC then
		ArrowR.id = "ArrowR"
	end
	QuickInventoryItemCurrent.id = "QuickInventoryItemCurrent"
	QuickInventoryItemMid.id = "QuickInventoryItemMid"
	QuickInventoryItemTop.id = "QuickInventoryItemTop"
	SquarePrompt:appendEventHandler("menu_loaded", function()
		SquarePrompt:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	SquarePrompt.id = "SquarePrompt"
	self.__defaultFocus = InventoryEquipmentLarge
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(InventoryEquipmentLarge, f1_arg1)
	CoD.WZUtility.AddQuickInventoryNavigation(f1_arg0, self, f1_arg1, self.InventoryEquipmentLarge)
	return self
end
CoD.WarzoneContextualExtraItems_RightAlign.__resetProperties = function(f38_arg0)
	f38_arg0.InventoryEquipmentLarge:completeAnimation()
	f38_arg0.ArrowR:completeAnimation()
	f38_arg0.ArrowL:completeAnimation()
	f38_arg0.InventoryEquipmentSmall:completeAnimation()
	f38_arg0.QuickInventoryItemTop:completeAnimation()
	f38_arg0.QuickInventoryItemMid:completeAnimation()
	f38_arg0.QuickInventoryItemCurrent:completeAnimation()
	f38_arg0.SquarePrompt:completeAnimation()
	f38_arg0.InventoryEquipmentLarge:setAlpha(1)
	f38_arg0.ArrowR:setAlpha(1)
	f38_arg0.ArrowL:setAlpha(1)
	f38_arg0.InventoryEquipmentSmall:setLeftRight(0.5, 0.5, -28, 24)
	f38_arg0.InventoryEquipmentSmall:setTopBottom(1, 1, -43, -27)
	f38_arg0.InventoryEquipmentSmall:setAlpha(1)
	f38_arg0.QuickInventoryItemTop:setTopBottom(1, 1, -166, -96)
	f38_arg0.QuickInventoryItemTop:setAlpha(0)
	f38_arg0.QuickInventoryItemTop.Bar:setAlpha(0)
	f38_arg0.QuickInventoryItemMid:setTopBottom(1, 1, -93, -23)
	f38_arg0.QuickInventoryItemMid:setAlpha(0)
	f38_arg0.QuickInventoryItemMid.Bar:setAlpha(0)
	f38_arg0.QuickInventoryItemCurrent:setTopBottom(1, 1, -12, 58)
	f38_arg0.QuickInventoryItemCurrent:setAlpha(0)
	f38_arg0.QuickInventoryItemCurrent.Button.Blur:setAlpha(1)
	f38_arg0.QuickInventoryItemCurrent.Button.Backing:setAlpha(0.95)
	f38_arg0.QuickInventoryItemCurrent.Button.LED:setAlpha(0.08)
	f38_arg0.QuickInventoryItemCurrent.Button.Icon:setScale(0.72, 0.72)
	f38_arg0.QuickInventoryItemCurrent.Button.Border:setAlpha(1)
	f38_arg0.QuickInventoryItemCurrent.Button.StackCount:setAlpha(1)
	f38_arg0.QuickInventoryItemCurrent.Bar:setAlpha(0)
	f38_arg0.SquarePrompt:setAlpha(0)
end
CoD.WarzoneContextualExtraItems_RightAlign.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(3)
			f39_arg0.InventoryEquipmentLarge:completeAnimation()
			f39_arg0.InventoryEquipmentLarge:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.InventoryEquipmentLarge)
			f39_arg0.ArrowL:completeAnimation()
			f39_arg0.ArrowL:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ArrowL)
			f39_arg0.ArrowR:completeAnimation()
			f39_arg0.ArrowR:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ArrowR)
		end,
	},
	CycleInventoryOpen = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(7)
			f40_arg0.InventoryEquipmentLarge:completeAnimation()
			f40_arg0.InventoryEquipmentLarge:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.InventoryEquipmentLarge)
			f40_arg0.InventoryEquipmentSmall:completeAnimation()
			f40_arg0.InventoryEquipmentSmall:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.InventoryEquipmentSmall)
			f40_arg0.ArrowL:completeAnimation()
			f40_arg0.ArrowL:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.ArrowL)
			f40_arg0.ArrowR:completeAnimation()
			f40_arg0.ArrowR:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.ArrowR)
			f40_arg0.QuickInventoryItemCurrent:completeAnimation()
			f40_arg0.QuickInventoryItemCurrent:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.QuickInventoryItemCurrent)
			f40_arg0.QuickInventoryItemMid:completeAnimation()
			f40_arg0.QuickInventoryItemMid.Bar:completeAnimation()
			f40_arg0.QuickInventoryItemMid:setAlpha(1)
			f40_arg0.QuickInventoryItemMid.Bar:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.QuickInventoryItemMid)
			f40_arg0.QuickInventoryItemTop:completeAnimation()
			f40_arg0.QuickInventoryItemTop.Bar:completeAnimation()
			f40_arg0.QuickInventoryItemTop:setAlpha(1)
			f40_arg0.QuickInventoryItemTop.Bar:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.QuickInventoryItemTop)
		end,
		CycleDown = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(7)
			f41_arg0.InventoryEquipmentLarge:completeAnimation()
			f41_arg0.InventoryEquipmentLarge:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.InventoryEquipmentLarge)
			f41_arg0.InventoryEquipmentSmall:completeAnimation()
			f41_arg0.InventoryEquipmentSmall:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.InventoryEquipmentSmall)
			f41_arg0.ArrowL:completeAnimation()
			f41_arg0.ArrowL:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ArrowL)
			f41_arg0.ArrowR:completeAnimation()
			f41_arg0.ArrowR:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ArrowR)
			local f41_local0 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						f44_arg0:beginAnimation(69)
						f44_arg0.Button.Icon:beginAnimation(69)
						f44_arg0:setAlpha(0)
						f44_arg0.Button.Icon:setScale(0, 0)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
					end
					f43_arg0:beginAnimation(69)
					f43_arg0.Button.Icon:beginAnimation(69)
					f43_arg0:setAlpha(0.5)
					f43_arg0.Button.Icon:setScale(0.9, 0.9)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f41_arg0.QuickInventoryItemCurrent:beginAnimation(180)
				f41_arg0.QuickInventoryItemCurrent.Button.Blur:beginAnimation(180)
				f41_arg0.QuickInventoryItemCurrent.Button.Backing:beginAnimation(180)
				f41_arg0.QuickInventoryItemCurrent.Button.LED:beginAnimation(180)
				f41_arg0.QuickInventoryItemCurrent.Button.Border:beginAnimation(180)
				f41_arg0.QuickInventoryItemCurrent.Button.StackCount:beginAnimation(180)
				f41_arg0.QuickInventoryItemCurrent:setTopBottom(1, 1, -11, 59)
				f41_arg0.QuickInventoryItemCurrent.Button.Blur:setAlpha(0)
				f41_arg0.QuickInventoryItemCurrent.Button.Backing:setAlpha(0)
				f41_arg0.QuickInventoryItemCurrent.Button.LED:setAlpha(0)
				f41_arg0.QuickInventoryItemCurrent.Button.Border:setAlpha(0)
				f41_arg0.QuickInventoryItemCurrent.Button.StackCount:setAlpha(0)
				f41_arg0.QuickInventoryItemCurrent:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.QuickInventoryItemCurrent:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f41_arg0.QuickInventoryItemCurrent:completeAnimation()
			f41_arg0.QuickInventoryItemCurrent.Button.Blur:completeAnimation()
			f41_arg0.QuickInventoryItemCurrent.Button.Backing:completeAnimation()
			f41_arg0.QuickInventoryItemCurrent.Button.LED:completeAnimation()
			f41_arg0.QuickInventoryItemCurrent.Button.Icon:completeAnimation()
			f41_arg0.QuickInventoryItemCurrent.Button.Border:completeAnimation()
			f41_arg0.QuickInventoryItemCurrent.Button.StackCount:completeAnimation()
			f41_arg0.QuickInventoryItemCurrent.Bar:completeAnimation()
			f41_arg0.QuickInventoryItemCurrent:setTopBottom(1, 1, -85, -15)
			f41_arg0.QuickInventoryItemCurrent:setAlpha(1)
			f41_arg0.QuickInventoryItemCurrent.Button.Blur:setAlpha(1)
			f41_arg0.QuickInventoryItemCurrent.Button.Backing:setAlpha(0.95)
			f41_arg0.QuickInventoryItemCurrent.Button.LED:setAlpha(0.08)
			f41_arg0.QuickInventoryItemCurrent.Button.Icon:setScale(0.72, 0.72)
			f41_arg0.QuickInventoryItemCurrent.Button.Border:setAlpha(1)
			f41_arg0.QuickInventoryItemCurrent.Button.StackCount:setAlpha(1)
			f41_arg0.QuickInventoryItemCurrent.Bar:setAlpha(0)
			f41_local0(f41_arg0.QuickInventoryItemCurrent)
			local f41_local1 = function(f45_arg0)
				f41_arg0.QuickInventoryItemMid:beginAnimation(180)
				f41_arg0.QuickInventoryItemMid:setTopBottom(1, 1, -93, -23)
				f41_arg0.QuickInventoryItemMid:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.QuickInventoryItemMid:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.QuickInventoryItemMid:completeAnimation()
			f41_arg0.QuickInventoryItemMid.Bar:completeAnimation()
			f41_arg0.QuickInventoryItemMid:setTopBottom(1, 1, -166, -96)
			f41_arg0.QuickInventoryItemMid:setAlpha(1)
			f41_arg0.QuickInventoryItemMid.Bar:setAlpha(0)
			f41_local1(f41_arg0.QuickInventoryItemMid)
			local f41_local2 = function(f46_arg0)
				f41_arg0.QuickInventoryItemTop:beginAnimation(180)
				f41_arg0.QuickInventoryItemTop:setTopBottom(1, 1, -166, -96)
				f41_arg0.QuickInventoryItemTop:setAlpha(1)
				f41_arg0.QuickInventoryItemTop:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.QuickInventoryItemTop:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.QuickInventoryItemTop:completeAnimation()
			f41_arg0.QuickInventoryItemTop:setTopBottom(1, 1, -239, -169)
			f41_arg0.QuickInventoryItemTop:setAlpha(0)
			f41_local2(f41_arg0.QuickInventoryItemTop)
		end,
	},
	InventoryOpen = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(1)
			f47_arg0.InventoryEquipmentSmall:completeAnimation()
			f47_arg0.InventoryEquipmentSmall:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.InventoryEquipmentSmall)
		end,
	},
	InventoryOpenRightAligned = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(3)
			f48_arg0.InventoryEquipmentLarge:completeAnimation()
			f48_arg0.clipFinished(f48_arg0.InventoryEquipmentLarge)
			f48_arg0.InventoryEquipmentSmall:completeAnimation()
			f48_arg0.InventoryEquipmentSmall:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.InventoryEquipmentSmall)
			f48_arg0.SquarePrompt:completeAnimation()
			f48_arg0.SquarePrompt:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.SquarePrompt)
		end,
		ChildFocus = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			f49_arg0.InventoryEquipmentLarge:completeAnimation()
			f49_arg0.clipFinished(f49_arg0.InventoryEquipmentLarge)
			f49_arg0.InventoryEquipmentSmall:completeAnimation()
			f49_arg0.InventoryEquipmentSmall:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.InventoryEquipmentSmall)
			f49_arg0.SquarePrompt:completeAnimation()
			f49_arg0.SquarePrompt:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.SquarePrompt)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(4)
			f50_arg0.InventoryEquipmentLarge:completeAnimation()
			f50_arg0.InventoryEquipmentLarge:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.InventoryEquipmentLarge)
			f50_arg0.InventoryEquipmentSmall:completeAnimation()
			f50_arg0.InventoryEquipmentSmall:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.InventoryEquipmentSmall)
			f50_arg0.ArrowL:completeAnimation()
			f50_arg0.ArrowL:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.ArrowL)
			f50_arg0.ArrowR:completeAnimation()
			f50_arg0.ArrowR:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.ArrowR)
		end,
	},
	InventoryClosedRightAligned = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(4)
			f51_arg0.InventoryEquipmentLarge:completeAnimation()
			f51_arg0.InventoryEquipmentLarge:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.InventoryEquipmentLarge)
			f51_arg0.InventoryEquipmentSmall:completeAnimation()
			f51_arg0.InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 14, 66)
			f51_arg0.clipFinished(f51_arg0.InventoryEquipmentSmall)
			f51_arg0.ArrowL:completeAnimation()
			f51_arg0.ArrowL:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.ArrowL)
			f51_arg0.ArrowR:completeAnimation()
			f51_arg0.ArrowR:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.ArrowR)
		end,
	},
	KBM = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(4)
			f52_arg0.InventoryEquipmentLarge:completeAnimation()
			f52_arg0.InventoryEquipmentLarge:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.InventoryEquipmentLarge)
			f52_arg0.InventoryEquipmentSmall:completeAnimation()
			f52_arg0.InventoryEquipmentSmall:setTopBottom(1, 1, 63, 79)
			f52_arg0.InventoryEquipmentSmall:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.InventoryEquipmentSmall)
			f52_arg0.ArrowL:completeAnimation()
			f52_arg0.ArrowL:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.ArrowL)
			f52_arg0.ArrowR:completeAnimation()
			f52_arg0.ArrowR:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.ArrowR)
		end,
	},
}
CoD.WarzoneContextualExtraItems_RightAlign.__onClose = function(f53_arg0)
	f53_arg0.InventoryEquipmentLarge:close()
	f53_arg0.InventoryEquipmentSmall:close()
	f53_arg0.ArrowL:close()
	f53_arg0.ArrowR:close()
	f53_arg0.QuickInventoryItemCurrent:close()
	f53_arg0.QuickInventoryItemMid:close()
	f53_arg0.QuickInventoryItemTop:close()
	f53_arg0.SquarePrompt:close()
end
