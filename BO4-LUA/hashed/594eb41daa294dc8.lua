require("x64:1744d99b88fcb45")
require("x64:aff61c91cbc2694")
require("x64:eef578dc6c7eb0b")
CoD.WarzoneContextualExtraItems = InheritFrom(LUI.UIElement)
CoD.WarzoneContextualExtraItems.__defaultWidth = 292
CoD.WarzoneContextualExtraItems.__defaultHeight = 96
CoD.WarzoneContextualExtraItems.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneContextualExtraItems)
	self.id = "WarzoneContextualExtraItems"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InventoryEquipmentLarge = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	InventoryEquipmentLarge:setLeftRight(0.5, 0.5, -75, 139)
	InventoryEquipmentLarge:setTopBottom(1, 1, -74, -4)
	InventoryEquipmentLarge:setWidgetType(CoD.WarzoneQuickInventoryItem)
	InventoryEquipmentLarge:setHorizontalCount(3)
	InventoryEquipmentLarge:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	InventoryEquipmentLarge:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		UpdateSelfElementState(f1_arg0, self.ArrowL, f1_arg1)
		UpdateSelfElementState(f1_arg0, self.ArrowR, f1_arg1)
		return f2_local0
	end)
	self:addElement(InventoryEquipmentLarge)
	self.InventoryEquipmentLarge = InventoryEquipmentLarge
	local InventoryEquipmentSmall = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 7, 59)
	InventoryEquipmentSmall:setTopBottom(1, 1, -24, -8)
	InventoryEquipmentSmall:setWidgetType(CoD.WarzoneInventoryItemGrayBox)
	InventoryEquipmentSmall:setHorizontalCount(3)
	InventoryEquipmentSmall:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(InventoryEquipmentSmall)
	self.InventoryEquipmentSmall = InventoryEquipmentSmall
	local ArrowR = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 282, 298, 0, 0, 48, 64)
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
	local ArrowL = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 59, 75, 0, 0, 48, 64)
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
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.inventory.open"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.PlayerSettingsUpdate, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f14_arg1)
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	InventoryEquipmentLarge.id = "InventoryEquipmentLarge"
	InventoryEquipmentSmall.id = "InventoryEquipmentSmall"
	if CoD.isPC then
		ArrowR.id = "ArrowR"
	end
	if CoD.isPC then
		ArrowL.id = "ArrowL"
	end
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
CoD.WarzoneContextualExtraItems.__resetProperties = function(f16_arg0)
	f16_arg0.InventoryEquipmentLarge:completeAnimation()
	f16_arg0.ArrowR:completeAnimation()
	f16_arg0.ArrowL:completeAnimation()
	f16_arg0.InventoryEquipmentSmall:completeAnimation()
	f16_arg0.InventoryEquipmentLarge:setAlpha(1)
	f16_arg0.ArrowR:setAlpha(1)
	f16_arg0.ArrowL:setAlpha(1)
	f16_arg0.InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 7, 59)
	f16_arg0.InventoryEquipmentSmall:setTopBottom(1, 1, -24, -8)
	f16_arg0.InventoryEquipmentSmall:setAlpha(1)
end
CoD.WarzoneContextualExtraItems.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.InventoryEquipmentLarge:completeAnimation()
			f17_arg0.InventoryEquipmentLarge:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.InventoryEquipmentLarge)
			f17_arg0.ArrowR:completeAnimation()
			f17_arg0.ArrowR:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArrowR)
			f17_arg0.ArrowL:completeAnimation()
			f17_arg0.ArrowL:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArrowL)
		end,
	},
	InventoryOpen = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.InventoryEquipmentSmall:completeAnimation()
			f18_arg0.InventoryEquipmentSmall:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.InventoryEquipmentSmall)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.InventoryEquipmentLarge:completeAnimation()
			f19_arg0.InventoryEquipmentLarge:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.InventoryEquipmentLarge)
			f19_arg0.InventoryEquipmentSmall:completeAnimation()
			f19_arg0.InventoryEquipmentSmall:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.InventoryEquipmentSmall)
			f19_arg0.ArrowR:completeAnimation()
			f19_arg0.ArrowR:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ArrowR)
			f19_arg0.ArrowL:completeAnimation()
			f19_arg0.ArrowL:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ArrowL)
		end,
	},
	KBM = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			f20_arg0.InventoryEquipmentLarge:completeAnimation()
			f20_arg0.InventoryEquipmentLarge:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.InventoryEquipmentLarge)
			f20_arg0.InventoryEquipmentSmall:completeAnimation()
			f20_arg0.InventoryEquipmentSmall:setLeftRight(0.5, 0.5, 6, 58)
			f20_arg0.InventoryEquipmentSmall:setTopBottom(1, 1, 77, 93)
			f20_arg0.InventoryEquipmentSmall:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.InventoryEquipmentSmall)
			f20_arg0.ArrowR:completeAnimation()
			f20_arg0.ArrowR:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ArrowR)
			f20_arg0.ArrowL:completeAnimation()
			f20_arg0.ArrowL:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ArrowL)
		end,
	},
}
CoD.WarzoneContextualExtraItems.__onClose = function(f21_arg0)
	f21_arg0.InventoryEquipmentLarge:close()
	f21_arg0.InventoryEquipmentSmall:close()
	f21_arg0.ArrowR:close()
	f21_arg0.ArrowL:close()
end
