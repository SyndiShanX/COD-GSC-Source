require("x64:7344a74ebe1d40c")
require("x64:afb0fdb9191a2d2")
CoD.StartMenu_InventoryDualWeapons = InheritFrom(LUI.UIElement)
CoD.StartMenu_InventoryDualWeapons.__defaultWidth = 450
CoD.StartMenu_InventoryDualWeapons.__defaultHeight = 900
CoD.StartMenu_InventoryDualWeapons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_InventoryDualWeapons)
	self.id = "StartMenu_InventoryDualWeapons"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Weapon2 = CoD.StartMenu_Inventory_WeaponsDisplayPC.new(f1_arg0, f1_arg1, 0.5, 0.5, -225, 224, 0.5, 0.5, -10, 270)
	Weapon2:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon1.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	local inventoryDescription = Weapon2
	local Weapon1 = Weapon2.subscribeToModel
	local f1_local4 = DataSources.WarzoneInventory.getModel(f1_arg1)
	Weapon1(inventoryDescription, f1_local4["weapon1.id"], function(f3_arg0)
		f1_arg0:updateElementState(Weapon2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "weapon1.id",
		})
	end, false)
	inventoryDescription = Weapon2
	Weapon1 = Weapon2.subscribeToModel
	f1_local4 = DataSources.WarzoneInventory.getModel(f1_arg1)
	Weapon1(inventoryDescription, f1_local4.currentWeaponIndex, function(f4_arg0)
		f1_arg0:updateElementState(Weapon2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "currentWeaponIndex",
		})
	end, false)
	inventoryDescription = Weapon2
	Weapon1 = Weapon2.subscribeToModel
	f1_local4 = DataSources.WarzoneInventory.getModel(f1_arg1)
	Weapon1(inventoryDescription, f1_local4["weapon0.supportsAttachments"], function(f5_arg0)
		f1_arg0:updateElementState(Weapon2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "weapon0.supportsAttachments",
		})
	end, false)
	inventoryDescription = Weapon2
	Weapon1 = Weapon2.subscribeToModel
	f1_local4 = DataSources.WarzoneInventory.getModel(f1_arg1)
	Weapon1(inventoryDescription, f1_local4["weapon1.supportsAttachments"], function(f6_arg0)
		f1_arg0:updateElementState(Weapon2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "weapon1.supportsAttachments",
		})
	end, false)
	Weapon2:setAlpha(0.5)
	Weapon2.WeaponAttachments:setDataSource("WarzoneStowedAttachments")
	Weapon2.WeaponAttachmentsSmall:setDataSource("WarzoneStowedAttachments")
	Weapon2:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "weapon1", function(model)
		Weapon2:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Weapon2, "childFocusGained", function(element)
		CoD.WZUtility.SetElementModelToElementWeaponModel(f1_arg1, self.inventoryDescription, self.Weapon2)
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Weapon2, "childFocusLost", function(element)
		CoD.BaseUtility.SetElementModelToNil(f1_arg1, self.inventoryDescription)
	end)
	Weapon2:subscribeToGlobalModel(f1_arg1, "WarzoneInventory", "currentWeaponIndex", function(model)
		local f10_local0 = Weapon2
		if CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "Weapon2") then
			CoD.WZUtility.SetElementModelToCurrentWeaponModel(f1_arg1, self.inventoryDescription)
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, f10_local0)
		end
	end)
	self:addElement(Weapon2)
	self.Weapon2 = Weapon2
	Weapon1 = CoD.StartMenu_Inventory_WeaponsDisplayPC.new(f1_arg0, f1_arg1, 0.5, 0.5, -225, 224, 0.5, 0.5, -450, -7)
	Weapon1:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon0.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	f1_local4 = Weapon1
	inventoryDescription = Weapon1.subscribeToModel
	local f1_local5 = DataSources.WarzoneInventory.getModel(f1_arg1)
	inventoryDescription(f1_local4, f1_local5["weapon0.id"], function(f12_arg0)
		f1_arg0:updateElementState(Weapon1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "weapon0.id",
		})
	end, false)
	f1_local4 = Weapon1
	inventoryDescription = Weapon1.subscribeToModel
	f1_local5 = DataSources.WarzoneInventory.getModel(f1_arg1)
	inventoryDescription(f1_local4, f1_local5.currentWeaponIndex, function(f13_arg0)
		f1_arg0:updateElementState(Weapon1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "currentWeaponIndex",
		})
	end, false)
	f1_local4 = Weapon1
	inventoryDescription = Weapon1.subscribeToModel
	f1_local5 = DataSources.WarzoneInventory.getModel(f1_arg1)
	inventoryDescription(f1_local4, f1_local5["weapon0.supportsAttachments"], function(f14_arg0)
		f1_arg0:updateElementState(Weapon1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "weapon0.supportsAttachments",
		})
	end, false)
	f1_local4 = Weapon1
	inventoryDescription = Weapon1.subscribeToModel
	f1_local5 = DataSources.WarzoneInventory.getModel(f1_arg1)
	inventoryDescription(f1_local4, f1_local5["weapon1.supportsAttachments"], function(f15_arg0)
		f1_arg0:updateElementState(Weapon1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "weapon1.supportsAttachments",
		})
	end, false)
	Weapon1.WeaponAttachments:setDataSource("WarzoneAttachments")
	Weapon1.WeaponAttachmentsSmall:setDataSource("WarzoneAttachments")
	Weapon1:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "weapon0", function(model)
		Weapon1:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Weapon1, "childFocusGained", function(element)
		CoD.WZUtility.SetElementModelToElementWeaponModel(f1_arg1, self.inventoryDescription, self.Weapon1)
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Weapon1, "childFocusLost", function(element)
		CoD.BaseUtility.SetElementModelToNil(f1_arg1, self.inventoryDescription)
	end)
	Weapon1:subscribeToGlobalModel(f1_arg1, "WarzoneInventory", "currentWeaponIndex", function(model)
		local f19_local0 = Weapon1
		if CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "Weapon1") then
			CoD.WZUtility.SetElementModelToCurrentWeaponModel(f1_arg1, self.inventoryDescription)
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, f19_local0)
		end
	end)
	self:addElement(Weapon1)
	self.Weapon1 = Weapon1
	inventoryDescription = CoD.StartMenu_InventoryDescription.new(f1_arg0, f1_arg1, 0.5, 0.5, -547, -235, 0.5, 0.5, -384, -184)
	self:addElement(inventoryDescription)
	self.inventoryDescription = inventoryDescription
	self:mergeStateConditions({
		{
			stateName = "OnlySecondWeapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon0.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon1.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
		{
			stateName = "OnlyOneWeapon",
			condition = function(menu, element, event)
				local f21_local0
				if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon0.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
					f21_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneInventory", "weapon1.id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
				else
					f21_local0 = false
				end
				return f21_local0
			end,
		},
		{
			stateName = "FirstWeaponNoAttachments",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", 0) and not CoD.WZUtility.HasWeaponAttachments(f1_arg1, 0)
			end,
		},
		{
			stateName = "FirstWeapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", 0)
			end,
		},
		{
			stateName = "SecondWeaponNoAttachments",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", 1) and not CoD.WZUtility.HasWeaponAttachments(f1_arg1, 0)
			end,
		},
		{
			stateName = "SecondWeapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "WarzoneInventory", "currentWeaponIndex", 1)
			end,
		},
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	local f1_local6 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local4(f1_local5, f1_local6["weapon0.id"], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "weapon0.id",
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local4(f1_local5, f1_local6["weapon1.id"], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "weapon1.id",
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local4(f1_local5, f1_local6.currentWeaponIndex, function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "currentWeaponIndex",
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local4(f1_local5, f1_local6["weapon0.supportsAttachments"], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "weapon0.supportsAttachments",
		})
	end, false)
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local4(f1_local5, f1_local6["weapon1.supportsAttachments"], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "weapon1.supportsAttachments",
		})
	end, false)
	Weapon2.id = "Weapon2"
	Weapon1.id = "Weapon1"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	f1_local4 = Weapon2
	DisableAutoButtonCallback(f1_arg0, f1_local4, f1_arg1)
	CoD.PCWidgetUtility.SetupContextualMenu(f1_local4, f1_arg1, "name", "", "")
	SetElementProperty(f1_local4, "weaponId", 1)
	SetElementProperty(f1_local4, "nextWeaponId", 0)
	f1_local4 = Weapon1
	DisableAutoButtonCallback(f1_arg0, f1_local4, f1_arg1)
	CoD.PCWidgetUtility.SetupContextualMenu(f1_local4, f1_arg1, "name", "", "")
	SetElementProperty(f1_local4, "weaponId", 0)
	SetElementProperty(f1_local4, "nextWeaponId", 1)
	return self
end
CoD.StartMenu_InventoryDualWeapons.__resetProperties = function(f32_arg0)
	f32_arg0.Weapon2:completeAnimation()
	f32_arg0.Weapon1:completeAnimation()
	f32_arg0.inventoryDescription:completeAnimation()
	f32_arg0.Weapon2:setLeftRight(0.5, 0.5, -225, 224)
	f32_arg0.Weapon2:setTopBottom(0.5, 0.5, -10, 270)
	f32_arg0.Weapon2:setAlpha(0.5)
	f32_arg0.Weapon1:setLeftRight(0.5, 0.5, -225, 224)
	f32_arg0.Weapon1:setTopBottom(0.5, 0.5, -450, -7)
	f32_arg0.Weapon1:setAlpha(1)
	f32_arg0.inventoryDescription:setAlpha(1)
end
CoD.StartMenu_InventoryDualWeapons.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.Weapon2:completeAnimation()
			f33_arg0.Weapon2:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Weapon2)
			f33_arg0.Weapon1:completeAnimation()
			f33_arg0.Weapon1:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.Weapon1)
		end,
	},
	OnlySecondWeapon = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.Weapon2:completeAnimation()
			f34_arg0.Weapon2:setTopBottom(0.5, 0.5, -450, 7)
			f34_arg0.Weapon2:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.Weapon2)
			f34_arg0.Weapon1:completeAnimation()
			f34_arg0.Weapon1:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Weapon1)
		end,
	},
	OnlyOneWeapon = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.Weapon2:completeAnimation()
			f35_arg0.Weapon2:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.Weapon2)
			f35_arg0.Weapon1:completeAnimation()
			f35_arg0.Weapon1:setLeftRight(0.5, 0.5, -225, 225)
			f35_arg0.Weapon1:setTopBottom(0.5, 0.5, -450, 10)
			f35_arg0.Weapon1:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.Weapon1)
		end,
	},
	FirstWeaponNoAttachments = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			local f36_local0 = function(f37_arg0)
				f36_arg0.Weapon2:beginAnimation(130)
				f36_arg0.Weapon2:setTopBottom(0.5, 0.5, -232, 39)
				f36_arg0.Weapon2:setAlpha(0.55)
				f36_arg0.Weapon2:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.Weapon2:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.Weapon2:completeAnimation()
			f36_arg0.Weapon2:setTopBottom(0.5, 0.5, -232, 228)
			f36_arg0.Weapon2:setAlpha(1)
			f36_local0(f36_arg0.Weapon2)
			local f36_local1 = function(f38_arg0)
				f36_arg0.Weapon1:beginAnimation(130)
				f36_arg0.Weapon1:setAlpha(1)
				f36_arg0.Weapon1:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.Weapon1:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.Weapon1:completeAnimation()
			f36_arg0.Weapon1:setTopBottom(0.5, 0.5, -450, -238)
			f36_arg0.Weapon1:setAlpha(0.55)
			f36_local1(f36_arg0.Weapon1)
		end,
	},
	FirstWeapon = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			local f39_local0 = function(f40_arg0)
				f39_arg0.Weapon2:beginAnimation(130)
				f39_arg0.Weapon2:setTopBottom(0.5, 0.5, -10, 261)
				f39_arg0.Weapon2:setAlpha(0.55)
				f39_arg0.Weapon2:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Weapon2:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.Weapon2:completeAnimation()
			f39_arg0.Weapon2:setLeftRight(0.5, 0.5, -225, 225)
			f39_arg0.Weapon2:setTopBottom(0.5, 0.5, -175, 285)
			f39_arg0.Weapon2:setAlpha(1)
			f39_local0(f39_arg0.Weapon2)
			local f39_local1 = function(f41_arg0)
				f39_arg0.Weapon1:beginAnimation(130)
				f39_arg0.Weapon1:setTopBottom(0.5, 0.5, -450, -16)
				f39_arg0.Weapon1:setAlpha(1)
				f39_arg0.Weapon1:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Weapon1:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.Weapon1:completeAnimation()
			f39_arg0.Weapon1:setLeftRight(0.5, 0.5, -225, 225)
			f39_arg0.Weapon1:setTopBottom(0.5, 0.5, -450, -175)
			f39_arg0.Weapon1:setAlpha(0.55)
			f39_local1(f39_arg0.Weapon1)
		end,
	},
	SecondWeaponNoAttachments = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			local f42_local0 = function(f43_arg0)
				f42_arg0.Weapon2:beginAnimation(130)
				f42_arg0.Weapon2:setTopBottom(0.5, 0.5, -232, 228)
				f42_arg0.Weapon2:setAlpha(1)
				f42_arg0.Weapon2:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.Weapon2:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.Weapon2:completeAnimation()
			f42_arg0.Weapon2:setTopBottom(0.5, 0.5, -232, 39)
			f42_arg0.Weapon2:setAlpha(0.55)
			f42_local0(f42_arg0.Weapon2)
			local f42_local1 = function(f44_arg0)
				f42_arg0.Weapon1:beginAnimation(130)
				f42_arg0.Weapon1:setAlpha(0.55)
				f42_arg0.Weapon1:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.Weapon1:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.Weapon1:completeAnimation()
			f42_arg0.Weapon1:setTopBottom(0.5, 0.5, -450, -238)
			f42_arg0.Weapon1:setAlpha(1)
			f42_local1(f42_arg0.Weapon1)
		end,
	},
	SecondWeapon = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			local f45_local0 = function(f46_arg0)
				f45_arg0.Weapon2:beginAnimation(130)
				f45_arg0.Weapon2:setTopBottom(0.5, 0.5, -172, 288)
				f45_arg0.Weapon2:setAlpha(1)
				f45_arg0.Weapon2:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.Weapon2:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.Weapon2:completeAnimation()
			f45_arg0.Weapon2:setLeftRight(0.5, 0.5, -225, 225)
			f45_arg0.Weapon2:setTopBottom(0.5, 0.5, 21, 292)
			f45_arg0.Weapon2:setAlpha(0.55)
			f45_local0(f45_arg0.Weapon2)
			local f45_local1 = function(f47_arg0)
				f45_arg0.Weapon1:beginAnimation(130)
				f45_arg0.Weapon1:setTopBottom(0.5, 0.5, -450, -175)
				f45_arg0.Weapon1:setAlpha(0.55)
				f45_arg0.Weapon1:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.Weapon1:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.Weapon1:completeAnimation()
			f45_arg0.Weapon1:setLeftRight(0.5, 0.5, -225, 225)
			f45_arg0.Weapon1:setTopBottom(0.5, 0.5, -450, 10)
			f45_arg0.Weapon1:setAlpha(1)
			f45_local1(f45_arg0.Weapon1)
		end,
	},
	Invisible = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(3)
			f48_arg0.Weapon2:completeAnimation()
			f48_arg0.Weapon2:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.Weapon2)
			f48_arg0.Weapon1:completeAnimation()
			f48_arg0.Weapon1:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.Weapon1)
			f48_arg0.inventoryDescription:completeAnimation()
			f48_arg0.inventoryDescription:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.inventoryDescription)
		end,
	},
}
CoD.StartMenu_InventoryDualWeapons.__onClose = function(f49_arg0)
	f49_arg0.Weapon2:close()
	f49_arg0.Weapon1:close()
	f49_arg0.inventoryDescription:close()
end
