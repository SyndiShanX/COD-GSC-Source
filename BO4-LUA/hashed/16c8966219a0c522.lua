require("x64:5d497c1e7ee7ebe")
require("x64:5bf4b6f49c15a4c")
CoD.WarzoneInventoryMenuItemSmall = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryMenuItemSmall.__defaultWidth = 96
CoD.WarzoneInventoryMenuItemSmall.__defaultHeight = 96
CoD.WarzoneInventoryMenuItemSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryMenuItemSmall)
	self.id = "WarzoneInventoryMenuItemSmall"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ActiveBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ActiveBG:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	ActiveBG:setAlpha(0)
	ActiveBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ActiveBG)
	self.ActiveBG = ActiveBG
	local internal = CoD.WarzoneInventoryMenuItemSmall_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -46, 46, 0, 0, 0, 90)
	internal:linkToElementModel(self, nil, false, function(model)
		internal:setModel(model, f1_arg1)
	end)
	self:addElement(internal)
	self.internal = internal
	local ConsumedProgress = LUI.UIImage.new(0, 0, 3, 93, 0, 0, 1, 89)
	ConsumedProgress:setRGB(0, 0, 0)
	ConsumedProgress:setAlpha(0.8)
	ConsumedProgress:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	ConsumedProgress:setShaderVector(1, 0.5, 0, 0, 0)
	ConsumedProgress:setShaderVector(2, 0.5, 0, 0, 0)
	ConsumedProgress:setShaderVector(3, 0, 0, 0, 0)
	ConsumedProgress:setShaderVector(4, 0, 0, 0, 0)
	ConsumedProgress:linkToElementModel(self, "endStartFraction", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ConsumedProgress:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(ConsumedProgress)
	self.ConsumedProgress = ConsumedProgress
	local castTimer = nil
	castTimer = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	castTimer:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	castTimer:setImage(RegisterImage(0xC2785B5FC0B6F18))
	castTimer:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	castTimer:setShaderVector(1, 0.5, 0, 0, 0)
	castTimer:setShaderVector(2, 0.5, 0, 0, 0)
	castTimer:setShaderVector(3, 0, 0, 0, 0)
	castTimer:setShaderVector(4, 0, 0, 0, 0)
	castTimer:linkToElementModel(self, "castTimeFraction", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			castTimer:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(castTimer)
	self.castTimer = castTimer
	local NotAvailable = LUI.UIImage.new(0, 0, 2, 90, 0, 0, 1, 89)
	NotAvailable:setAlpha(0)
	NotAvailable:setImage(RegisterImage(0xB1FCC7EA3552F5A))
	NotAvailable:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	local PickupPulse = CoD.WarzoneInventoryPickupPulse.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	self:addElement(PickupPulse)
	self.PickupPulse = PickupPulse
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "disabled", 1)
			end,
		},
		{
			stateName = "NoStack",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "stackCount", 0)
			end,
		},
		{
			stateName = "NotAccessible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "notAccessible", 1)
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "notAvailable", 1)
			end,
		},
		{
			stateName = "InUse",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "endStartFraction", 0)
			end,
		},
		{
			stateName = "FocusTarget",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "focusTarget", 1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:linkToElementModel(self, "stackCount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stackCount",
		})
	end)
	self:linkToElementModel(self, "notAccessible", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "notAccessible",
		})
	end)
	self:linkToElementModel(self, "notAvailable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "notAvailable",
		})
	end)
	self:linkToElementModel(self, "endStartFraction", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "endStartFraction",
		})
	end)
	self:linkToElementModel(self, "focusTarget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "focusTarget",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f17_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	self:linkToElementModel(self, "id", true, function(model, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	self:linkToElementModel(self, "availableAction", true, function(model, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.armorType, function(f21_arg0, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0xE4D2F32833CFA6C](Engine[0x761955642304848](f1_arg1))
	f1_local8(f1_local7, f1_local9.armor, function(f22_arg0, f22_arg1)
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0xE4D2F32833CFA6C](Engine[0x761955642304848](f1_arg1))
	f1_local8(f1_local7, f1_local9.armorMax, function(f23_arg0, f23_arg1)
		CoD.Menu.UpdateButtonShownState(f23_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) then
			CoD.WZUtility.SendInventoryConsumeNotify(controller, element)
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) then
			CoD.WZUtility.SendInventoryConsumeNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.CONSUME) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x1F464950EB4AA26, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "availableAction", CoD.WZUtility.ItemAvailableAction.REPAIR) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "HUDItems", "armorType", 0) and not CoD.HUDUtility.IsArmorAtFullHealth(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x2C27E2320C64A74, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f26_arg2, f26_arg3, f26_arg4)
		if CoD.BaseUtility.IsSelfInState(self, "FocusTarget") and IsPC() then
			SetElementState(self, self.PickupPulse, controller, "PickUpPC")
		elseif CoD.BaseUtility.IsSelfInState(self, "FocusTarget") then
			SetElementState(self, self.PickupPulse, controller, "PickUp")
		else
			SetElementState(self, self.PickupPulse, controller, "DefaultState")
		end
	end)
	internal.id = "internal"
	self.__defaultFocus = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryMenuItemSmall.__resetProperties = function(f27_arg0)
	f27_arg0.internal:completeAnimation()
	f27_arg0.ConsumedProgress:completeAnimation()
	f27_arg0.castTimer:completeAnimation()
	f27_arg0.NotAvailable:completeAnimation()
	f27_arg0.internal:setRGB(1, 1, 1)
	f27_arg0.internal:setAlpha(1)
	f27_arg0.internal:setScale(1, 1)
	f27_arg0.internal.InUseBacking:setAlpha(0)
	f27_arg0.internal.InventoryIcon:setRGB(1, 1, 1)
	f27_arg0.internal.InventoryIcon:setShaderVector(0, 1, 0, 0, 0)
	f27_arg0.ConsumedProgress:setAlpha(0.8)
	f27_arg0.ConsumedProgress:setScale(1, 1)
	f27_arg0.castTimer:setAlpha(1)
	f27_arg0.NotAvailable:setAlpha(0)
end
CoD.WarzoneInventoryMenuItemSmall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.internal:completeAnimation()
			f29_arg0.internal:setScale(1.08, 1.08)
			f29_arg0.clipFinished(f29_arg0.internal)
		end,
		GainChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.internal:beginAnimation(140)
				f30_arg0.internal:setScale(1.08, 1.08)
				f30_arg0.internal:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.internal:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.internal:completeAnimation()
			f30_arg0.internal:setScale(1, 1)
			f30_local0(f30_arg0.internal)
		end,
		LoseChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			local f32_local0 = function(f33_arg0)
				f32_arg0.internal:beginAnimation(140)
				f32_arg0.internal:setScale(1, 1)
				f32_arg0.internal:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.internal:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.internal:completeAnimation()
			f32_arg0.internal:setScale(1.08, 1.08)
			f32_local0(f32_arg0.internal)
		end,
	},
	Disabled = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(3)
			f34_arg0.internal:completeAnimation()
			f34_arg0.internal:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.internal)
			f34_arg0.ConsumedProgress:completeAnimation()
			f34_arg0.ConsumedProgress:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ConsumedProgress)
			f34_arg0.castTimer:completeAnimation()
			f34_arg0.castTimer:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.castTimer)
		end,
	},
	NoStack = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.internal:completeAnimation()
			f35_arg0.internal.InventoryIcon:completeAnimation()
			f35_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f35_arg0.internal.InventoryIcon:setShaderVector(0, 0, 0, 0, 0)
			f35_arg0.clipFinished(f35_arg0.internal)
		end,
		ChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.internal:completeAnimation()
			f36_arg0.internal.InventoryIcon:completeAnimation()
			f36_arg0.internal:setScale(1.08, 1.08)
			f36_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f36_arg0.internal.InventoryIcon:setShaderVector(0, 0, 0, 0, 0)
			f36_arg0.clipFinished(f36_arg0.internal)
		end,
		GainChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			local f37_local0 = function(f38_arg0)
				f37_arg0.internal:beginAnimation(140)
				f37_arg0.internal:setScale(1.08, 1.08)
				f37_arg0.internal:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.internal:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.internal:completeAnimation()
			f37_arg0.internal.InventoryIcon:completeAnimation()
			f37_arg0.internal:setScale(1, 1)
			f37_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f37_arg0.internal.InventoryIcon:setShaderVector(0, 0, 0, 0, 0)
			f37_local0(f37_arg0.internal)
		end,
		LoseChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			local f39_local0 = function(f40_arg0)
				f39_arg0.internal:beginAnimation(140)
				f39_arg0.internal:setScale(1, 1)
				f39_arg0.internal:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.internal:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.internal:completeAnimation()
			f39_arg0.internal.InventoryIcon:completeAnimation()
			f39_arg0.internal:setScale(1.08, 1.08)
			f39_arg0.internal.InventoryIcon:setRGB(0.36, 0.36, 0.38)
			f39_arg0.internal.InventoryIcon:setShaderVector(0, 0, 0, 0, 0)
			f39_local0(f39_arg0.internal)
		end,
	},
	NotAccessible = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(1)
			f41_arg0.NotAvailable:completeAnimation()
			f41_arg0.NotAvailable:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.NotAvailable)
		end,
	},
	NotAvailable = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(2)
			f43_arg0.internal:completeAnimation()
			f43_arg0.internal:setRGB(1, 1, 1)
			f43_arg0.internal:setScale(1.14, 1.14)
			f43_arg0.clipFinished(f43_arg0.internal)
			f43_arg0.NotAvailable:completeAnimation()
			f43_arg0.NotAvailable:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.NotAvailable)
		end,
		GainChildFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			local f44_local0 = function(f45_arg0)
				f44_arg0.internal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f44_arg0.internal:setScale(1.14, 1.14)
				f44_arg0.internal:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.internal:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.internal:completeAnimation()
			f44_arg0.internal:setScale(1, 1)
			f44_local0(f44_arg0.internal)
			f44_arg0.NotAvailable:completeAnimation()
			f44_arg0.NotAvailable:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.NotAvailable)
		end,
		LoseChildFocus = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(2)
			local f46_local0 = function(f47_arg0)
				f46_arg0.internal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f46_arg0.internal:setScale(1, 1)
				f46_arg0.internal:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.internal:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.internal:completeAnimation()
			f46_arg0.internal:setScale(1.14, 1.14)
			f46_local0(f46_arg0.internal)
			f46_arg0.NotAvailable:completeAnimation()
			f46_arg0.NotAvailable:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.NotAvailable)
		end,
	},
	InUse = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(1)
			f48_arg0.internal:completeAnimation()
			f48_arg0.internal.InUseBacking:completeAnimation()
			f48_arg0.internal:setRGB(1, 1, 1)
			f48_arg0.internal.InUseBacking:setAlpha(0.95)
			f48_arg0.clipFinished(f48_arg0.internal)
		end,
		ChildFocus = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(2)
			f49_arg0.internal:completeAnimation()
			f49_arg0.internal.InUseBacking:completeAnimation()
			f49_arg0.internal:setScale(1.08, 1.08)
			f49_arg0.internal.InUseBacking:setAlpha(0.95)
			f49_arg0.clipFinished(f49_arg0.internal)
			f49_arg0.ConsumedProgress:completeAnimation()
			f49_arg0.ConsumedProgress:setScale(1.08, 1.08)
			f49_arg0.clipFinished(f49_arg0.ConsumedProgress)
		end,
		GainChildFocus = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(2)
			local f50_local0 = function(f51_arg0)
				f50_arg0.internal:beginAnimation(140)
				f50_arg0.internal:setScale(1.08, 1.08)
				f50_arg0.internal:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.internal:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.internal:completeAnimation()
			f50_arg0.internal.InUseBacking:completeAnimation()
			f50_arg0.internal:setScale(1, 1)
			f50_arg0.internal.InUseBacking:setAlpha(0.95)
			f50_local0(f50_arg0.internal)
			local f50_local1 = function(f52_arg0)
				f50_arg0.ConsumedProgress:beginAnimation(140)
				f50_arg0.ConsumedProgress:setScale(1.08, 1.08)
				f50_arg0.ConsumedProgress:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.ConsumedProgress:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.ConsumedProgress:completeAnimation()
			f50_arg0.ConsumedProgress:setScale(1, 1)
			f50_local1(f50_arg0.ConsumedProgress)
		end,
		LoseChildFocus = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(2)
			local f53_local0 = function(f54_arg0)
				f53_arg0.internal:beginAnimation(140)
				f53_arg0.internal:setScale(1, 1)
				f53_arg0.internal:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.internal:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.internal:completeAnimation()
			f53_arg0.internal.InUseBacking:completeAnimation()
			f53_arg0.internal:setScale(1.08, 1.08)
			f53_arg0.internal.InUseBacking:setAlpha(0.95)
			f53_local0(f53_arg0.internal)
			local f53_local1 = function(f55_arg0)
				f53_arg0.ConsumedProgress:beginAnimation(140)
				f53_arg0.ConsumedProgress:setScale(1, 1)
				f53_arg0.ConsumedProgress:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.ConsumedProgress:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.ConsumedProgress:completeAnimation()
			f53_arg0.ConsumedProgress:setScale(1.08, 1.08)
			f53_local1(f53_arg0.ConsumedProgress)
		end,
	},
	FocusTarget = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WarzoneInventoryMenuItemSmall.__onClose = function(f57_arg0)
	f57_arg0.internal:close()
	f57_arg0.ConsumedProgress:close()
	f57_arg0.castTimer:close()
	f57_arg0.PickupPulse:close()
end
