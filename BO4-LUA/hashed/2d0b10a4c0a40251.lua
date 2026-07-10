require("x64:1744d99b88fcb45")
require("x64:aff61c91cbc2694")
require("x64:eef578dc6c7eb0b")
CoD.WarzoneContextualExtraItems_LeftAlign = InheritFrom(LUI.UIElement)
CoD.WarzoneContextualExtraItems_LeftAlign.__defaultWidth = 292
CoD.WarzoneContextualExtraItems_LeftAlign.__defaultHeight = 96
CoD.WarzoneContextualExtraItems_LeftAlign.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneContextualExtraItems_LeftAlign)
	self.id = "WarzoneContextualExtraItems_LeftAlign"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InventoryEquipmentSmall = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 7, 59)
	InventoryEquipmentSmall:setTopBottom(1, 1, -24, -8)
	InventoryEquipmentSmall:setWidgetType(CoD.WarzoneInventoryItemGrayBox)
	InventoryEquipmentSmall:setHorizontalCount(3)
	InventoryEquipmentSmall:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(InventoryEquipmentSmall)
	self.InventoryEquipmentSmall = InventoryEquipmentSmall
	local InventoryEquipmentLarge = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	InventoryEquipmentLarge:setLeftRight(1, 1, -292, -78)
	InventoryEquipmentLarge:setTopBottom(1, 1, -75, -5)
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
	local ArrowR = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 210, 226, 0, 0, 48, 64)
	ArrowR:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return ListElementHasElements(self.InventoryEquipmentLarge) and not CoD.WZUtility.IsQuickEquipListLastItemVisible(self.InventoryEquipmentLarge)
			end,
		},
	})
	ArrowR:appendEventHandler("grid_updated", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ArrowR, f4_arg1)
	end)
	ArrowR:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LUI.OverrideFunction_CallOriginalFirst(ArrowR, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		UpdateSelfElementState(f1_arg0, element, controller)
	end)
	self:addElement(ArrowR)
	self.ArrowR = ArrowR
	local ArrowL = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, -13, 3, 0, 0, 48, 64)
	ArrowL:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return ListElementHasElements(self.InventoryEquipmentLarge) and not CoD.WZUtility.IsQuickEquipListFirstItemVisible(self.InventoryEquipmentLarge)
			end,
		},
	})
	ArrowL:appendEventHandler("grid_updated", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ArrowL, f7_arg1)
	end)
	ArrowL:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ArrowL:setZRot(180)
	LUI.OverrideFunction_CallOriginalFirst(ArrowL, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		UpdateSelfElementState(f1_arg0, element, controller)
	end)
	self:addElement(ArrowL)
	self.ArrowL = ArrowL
	local QuickInventoryItemCurrent = CoD.WarzoneQuickInventoryItem.new(f1_arg0, f1_arg1, 1, 1, -148, -78, 1, 1, 9, 79)
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
	QuickInventoryItemCurrent.Button.StackCount.Counter:setBackingColor(0.41, 0.41, 0.41)
	QuickInventoryItemCurrent.Bar:setAlpha(0)
	self:addElement(QuickInventoryItemCurrent)
	self.QuickInventoryItemCurrent = QuickInventoryItemCurrent
	local QuickInventoryItemMid = CoD.WarzoneQuickInventoryItem.new(f1_arg0, f1_arg1, 1, 1, -148, -78, 1, 1, -75, -5)
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
	local QuickInventoryItemTop = CoD.WarzoneQuickInventoryItem.new(f1_arg0, f1_arg1, 1, 1, -148, -78, 1, 1, -149, -79)
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
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.inventory.open"], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["storageGlobalRoot.user_settings"], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.selectedIndex, function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.weapon3dForcedHintItem, function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "weapon3dForcedHintItem",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.showPickupHint, function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "showPickupHint",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.firstFreeSlot, function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "firstFreeSlot",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10.PlayerSettingsUpdate, function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f32_arg0, f32_arg1)
		f32_arg1.menu = f32_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f32_arg1)
	end)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.inventory.health.realId", function(model)
		local f34_local0 = self
		PlayClip(self, "CycleDown", f1_arg1)
	end)
	InventoryEquipmentSmall.id = "InventoryEquipmentSmall"
	InventoryEquipmentLarge.id = "InventoryEquipmentLarge"
	if CoD.isPC then
		ArrowR.id = "ArrowR"
	end
	if CoD.isPC then
		ArrowL.id = "ArrowL"
	end
	QuickInventoryItemCurrent.id = "QuickInventoryItemCurrent"
	QuickInventoryItemMid.id = "QuickInventoryItemMid"
	QuickInventoryItemTop.id = "QuickInventoryItemTop"
	self.__defaultFocus = InventoryEquipmentLarge
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(InventoryEquipmentLarge, f1_arg1)
	CoD.WZUtility.AddQuickInventoryNavigation(f1_arg0, self, f1_arg1, self.InventoryEquipmentLarge)
	return self
end
CoD.WarzoneContextualExtraItems_LeftAlign.__resetProperties = function(f35_arg0)
	f35_arg0.InventoryEquipmentLarge:completeAnimation()
	f35_arg0.ArrowR:completeAnimation()
	f35_arg0.ArrowL:completeAnimation()
	f35_arg0.InventoryEquipmentSmall:completeAnimation()
	f35_arg0.QuickInventoryItemTop:completeAnimation()
	f35_arg0.QuickInventoryItemMid:completeAnimation()
	f35_arg0.QuickInventoryItemCurrent:completeAnimation()
	f35_arg0.InventoryEquipmentLarge:setAlpha(1)
	f35_arg0.ArrowR:setAlpha(1)
	f35_arg0.ArrowL:setAlpha(1)
	f35_arg0.InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 7, 59)
	f35_arg0.InventoryEquipmentSmall:setTopBottom(1, 1, -24, -8)
	f35_arg0.InventoryEquipmentSmall:setAlpha(1)
	f35_arg0.QuickInventoryItemTop:setTopBottom(1, 1, -149, -79)
	f35_arg0.QuickInventoryItemTop:setAlpha(0)
	f35_arg0.QuickInventoryItemTop.Bar:setAlpha(0)
	f35_arg0.QuickInventoryItemMid:setTopBottom(1, 1, -75, -5)
	f35_arg0.QuickInventoryItemMid:setAlpha(0)
	f35_arg0.QuickInventoryItemMid.Bar:setAlpha(0)
	f35_arg0.QuickInventoryItemCurrent:setTopBottom(1, 1, 9, 79)
	f35_arg0.QuickInventoryItemCurrent:setAlpha(0)
	f35_arg0.QuickInventoryItemCurrent.Button.Blur:setAlpha(1)
	f35_arg0.QuickInventoryItemCurrent.Button.Backing:setAlpha(0.95)
	f35_arg0.QuickInventoryItemCurrent.Button.LED:setAlpha(0.08)
	f35_arg0.QuickInventoryItemCurrent.Button.Icon:setScale(0.72, 0.72)
	f35_arg0.QuickInventoryItemCurrent.Button.Border:setAlpha(1)
	f35_arg0.QuickInventoryItemCurrent.Button.StackCount:setAlpha(1)
	f35_arg0.QuickInventoryItemCurrent.Bar:setAlpha(0)
end
CoD.WarzoneContextualExtraItems_LeftAlign.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(3)
			f36_arg0.InventoryEquipmentLarge:completeAnimation()
			f36_arg0.InventoryEquipmentLarge:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.InventoryEquipmentLarge)
			f36_arg0.ArrowR:completeAnimation()
			f36_arg0.ArrowR:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ArrowR)
			f36_arg0.ArrowL:completeAnimation()
			f36_arg0.ArrowL:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ArrowL)
		end,
	},
	CycleInventoryOpen = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(7)
			f37_arg0.InventoryEquipmentSmall:completeAnimation()
			f37_arg0.InventoryEquipmentSmall:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.InventoryEquipmentSmall)
			f37_arg0.InventoryEquipmentLarge:completeAnimation()
			f37_arg0.InventoryEquipmentLarge:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.InventoryEquipmentLarge)
			f37_arg0.ArrowR:completeAnimation()
			f37_arg0.ArrowR:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ArrowR)
			f37_arg0.ArrowL:completeAnimation()
			f37_arg0.ArrowL:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ArrowL)
			f37_arg0.QuickInventoryItemCurrent:completeAnimation()
			f37_arg0.QuickInventoryItemCurrent.Bar:completeAnimation()
			f37_arg0.QuickInventoryItemCurrent.Bar:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.QuickInventoryItemCurrent)
			f37_arg0.QuickInventoryItemMid:completeAnimation()
			f37_arg0.QuickInventoryItemMid.Bar:completeAnimation()
			f37_arg0.QuickInventoryItemMid:setAlpha(1)
			f37_arg0.QuickInventoryItemMid.Bar:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.QuickInventoryItemMid)
			f37_arg0.QuickInventoryItemTop:completeAnimation()
			f37_arg0.QuickInventoryItemTop:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.QuickInventoryItemTop)
		end,
		CycleDown = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(7)
			f38_arg0.InventoryEquipmentSmall:completeAnimation()
			f38_arg0.InventoryEquipmentSmall:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.InventoryEquipmentSmall)
			f38_arg0.InventoryEquipmentLarge:completeAnimation()
			f38_arg0.InventoryEquipmentLarge:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.InventoryEquipmentLarge)
			f38_arg0.ArrowR:completeAnimation()
			f38_arg0.ArrowR:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ArrowR)
			f38_arg0.ArrowL:completeAnimation()
			f38_arg0.ArrowL:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ArrowL)
			local f38_local0 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						f41_arg0:beginAnimation(69)
						f41_arg0.Button.Icon:beginAnimation(69)
						f41_arg0:setAlpha(0)
						f41_arg0.Button.Icon:setScale(0.72, 0.72)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
					end
					f40_arg0:beginAnimation(69)
					f40_arg0.Button.Icon:beginAnimation(69)
					f40_arg0:setAlpha(0.5)
					f40_arg0.Button.Icon:setScale(0.9, 0.9)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f38_arg0.QuickInventoryItemCurrent:beginAnimation(180, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.QuickInventoryItemCurrent.Button.Blur:beginAnimation(180, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.QuickInventoryItemCurrent.Button.Backing:beginAnimation(180, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.QuickInventoryItemCurrent.Button.LED:beginAnimation(180, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.QuickInventoryItemCurrent.Button.Border:beginAnimation(180, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.QuickInventoryItemCurrent.Button.StackCount:beginAnimation(180, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.QuickInventoryItemCurrent:setTopBottom(1, 1, 9, 79)
				f38_arg0.QuickInventoryItemCurrent.Button.Blur:setAlpha(0)
				f38_arg0.QuickInventoryItemCurrent.Button.Backing:setAlpha(0)
				f38_arg0.QuickInventoryItemCurrent.Button.LED:setAlpha(0)
				f38_arg0.QuickInventoryItemCurrent.Button.Border:setAlpha(0)
				f38_arg0.QuickInventoryItemCurrent.Button.StackCount:setAlpha(0)
				f38_arg0.QuickInventoryItemCurrent:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.QuickInventoryItemCurrent:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f38_arg0.QuickInventoryItemCurrent:completeAnimation()
			f38_arg0.QuickInventoryItemCurrent.Button.Blur:completeAnimation()
			f38_arg0.QuickInventoryItemCurrent.Button.Backing:completeAnimation()
			f38_arg0.QuickInventoryItemCurrent.Button.LED:completeAnimation()
			f38_arg0.QuickInventoryItemCurrent.Button.Icon:completeAnimation()
			f38_arg0.QuickInventoryItemCurrent.Button.Border:completeAnimation()
			f38_arg0.QuickInventoryItemCurrent.Button.StackCount:completeAnimation()
			f38_arg0.QuickInventoryItemCurrent.Bar:completeAnimation()
			f38_arg0.QuickInventoryItemCurrent:setTopBottom(1, 1, -75, -5)
			f38_arg0.QuickInventoryItemCurrent:setAlpha(1)
			f38_arg0.QuickInventoryItemCurrent.Button.Blur:setAlpha(1)
			f38_arg0.QuickInventoryItemCurrent.Button.Backing:setAlpha(0.95)
			f38_arg0.QuickInventoryItemCurrent.Button.LED:setAlpha(0.08)
			f38_arg0.QuickInventoryItemCurrent.Button.Icon:setScale(0.72, 0.72)
			f38_arg0.QuickInventoryItemCurrent.Button.Border:setAlpha(1)
			f38_arg0.QuickInventoryItemCurrent.Button.StackCount:setAlpha(1)
			f38_arg0.QuickInventoryItemCurrent.Bar:setAlpha(0)
			f38_local0(f38_arg0.QuickInventoryItemCurrent)
			local f38_local1 = function(f42_arg0)
				f38_arg0.QuickInventoryItemMid:beginAnimation(180)
				f38_arg0.QuickInventoryItemMid:setTopBottom(1, 1, -75, -5)
				f38_arg0.QuickInventoryItemMid:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.QuickInventoryItemMid:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.QuickInventoryItemMid:completeAnimation()
			f38_arg0.QuickInventoryItemMid.Bar:completeAnimation()
			f38_arg0.QuickInventoryItemMid:setTopBottom(1, 1, -159, -89)
			f38_arg0.QuickInventoryItemMid:setAlpha(1)
			f38_arg0.QuickInventoryItemMid.Bar:setAlpha(0)
			f38_local1(f38_arg0.QuickInventoryItemMid)
			local f38_local2 = function(f43_arg0)
				f38_arg0.QuickInventoryItemTop:beginAnimation(180)
				f38_arg0.QuickInventoryItemTop:setTopBottom(1, 1, -149, -79)
				f38_arg0.QuickInventoryItemTop:setAlpha(1)
				f38_arg0.QuickInventoryItemTop:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.QuickInventoryItemTop:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.QuickInventoryItemTop:completeAnimation()
			f38_arg0.QuickInventoryItemTop.Bar:completeAnimation()
			f38_arg0.QuickInventoryItemTop:setTopBottom(1, 1, -233, -163)
			f38_arg0.QuickInventoryItemTop:setAlpha(0)
			f38_arg0.QuickInventoryItemTop.Bar:setAlpha(0)
			f38_local2(f38_arg0.QuickInventoryItemTop)
		end,
	},
	InventoryOpen = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(1)
			f44_arg0.InventoryEquipmentSmall:completeAnimation()
			f44_arg0.InventoryEquipmentSmall:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.InventoryEquipmentSmall)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(4)
			f45_arg0.InventoryEquipmentSmall:completeAnimation()
			f45_arg0.InventoryEquipmentSmall:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.InventoryEquipmentSmall)
			f45_arg0.InventoryEquipmentLarge:completeAnimation()
			f45_arg0.InventoryEquipmentLarge:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.InventoryEquipmentLarge)
			f45_arg0.ArrowR:completeAnimation()
			f45_arg0.ArrowR:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.ArrowR)
			f45_arg0.ArrowL:completeAnimation()
			f45_arg0.ArrowL:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.ArrowL)
		end,
	},
	KBM = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(4)
			f46_arg0.InventoryEquipmentSmall:completeAnimation()
			f46_arg0.InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 6, 58)
			f46_arg0.InventoryEquipmentSmall:setTopBottom(1, 1, 77, 93)
			f46_arg0.InventoryEquipmentSmall:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.InventoryEquipmentSmall)
			f46_arg0.InventoryEquipmentLarge:completeAnimation()
			f46_arg0.InventoryEquipmentLarge:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.InventoryEquipmentLarge)
			f46_arg0.ArrowR:completeAnimation()
			f46_arg0.ArrowR:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.ArrowR)
			f46_arg0.ArrowL:completeAnimation()
			f46_arg0.ArrowL:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.ArrowL)
		end,
	},
}
CoD.WarzoneContextualExtraItems_LeftAlign.__onClose = function(f47_arg0)
	f47_arg0.InventoryEquipmentSmall:close()
	f47_arg0.InventoryEquipmentLarge:close()
	f47_arg0.ArrowR:close()
	f47_arg0.ArrowL:close()
	f47_arg0.QuickInventoryItemCurrent:close()
	f47_arg0.QuickInventoryItemMid:close()
	f47_arg0.QuickInventoryItemTop:close()
end
