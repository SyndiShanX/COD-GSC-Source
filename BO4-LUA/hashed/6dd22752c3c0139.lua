require("x64:f4d0533332aae24")
require("x64:b19ebf9e6a9ffd7")
CoD.ZMTalismanEquipLine = InheritFrom(LUI.UIElement)
CoD.ZMTalismanEquipLine.__defaultWidth = 1920
CoD.ZMTalismanEquipLine.__defaultHeight = 1080
CoD.ZMTalismanEquipLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMTalismanEquipLine)
	self.id = "ZMTalismanEquipLine"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Channels = CoD.ZMTalismanChannelPathBG.new(f1_arg0, f1_arg1, 0, 0, 306, 1586, 0, 0, 267, 875)
	self:addElement(Channels)
	self.Channels = Channels
	local LongHorizontalLine = LUI.UIImage.new(0, 0, 259, 1531, 0, 0, 827, 875)
	LongHorizontalLine:setAlpha(0)
	LongHorizontalLine:setImage(RegisterImage(@"hash_496691A214F3B5E4"))
	LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	LongHorizontalLine:setShaderVector(0, 1, 0, 0, 0)
	LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
	LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
	LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
	LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LongHorizontalLine)
	self.LongHorizontalLine = LongHorizontalLine
	local LongVerticalLine = LUI.UIImage.new(0, 0, 1486, 1534, 0, 0, 278, 862)
	LongVerticalLine:setAlpha(0)
	LongVerticalLine:setZRot(180)
	LongVerticalLine:setImage(RegisterImage(@"hash_BE2C44A1CF38C0A"))
	LongVerticalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	LongVerticalLine:setShaderVector(0, 1, 0, 0, 0)
	LongVerticalLine:setShaderVector(1, 0, 0, 0, 0)
	LongVerticalLine:setShaderVector(2, 1, 0, 0, 0)
	LongVerticalLine:setShaderVector(3, 0, 0, 0, 0)
	LongVerticalLine:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LongVerticalLine)
	self.LongVerticalLine = LongVerticalLine
	local Perk1Line = LUI.UIImage.new(0, 0, 568, 616, 0, 0, 724, 864)
	Perk1Line:setAlpha(0)
	Perk1Line:setZRot(180)
	Perk1Line:setImage(RegisterImage(@"hash_61801AC09948CA50"))
	Perk1Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	Perk1Line:setShaderVector(0, 1, 0, 0, 0)
	Perk1Line:setShaderVector(1, 0, 0, 0, 0)
	Perk1Line:setShaderVector(2, 1, 0, 0, 0)
	Perk1Line:setShaderVector(3, 0, 0, 0, 0)
	Perk1Line:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Perk1Line)
	self.Perk1Line = Perk1Line
	local Perk2Line = LUI.UIImage.new(0, 0, 813, 861, 0, 0, 724, 864)
	Perk2Line:setAlpha(0)
	Perk2Line:setZRot(180)
	Perk2Line:setImage(RegisterImage(@"hash_61801AC09948CA50"))
	Perk2Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	Perk2Line:setShaderVector(0, 1, 0, 0, 0)
	Perk2Line:setShaderVector(1, 0, 0, 0, 0)
	Perk2Line:setShaderVector(2, 1, 0, 0, 0)
	Perk2Line:setShaderVector(3, 0, 0, 0, 0)
	Perk2Line:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Perk2Line)
	self.Perk2Line = Perk2Line
	local Perk3Line = LUI.UIImage.new(0, 0, 1057, 1105, 0, 0, 724, 864)
	Perk3Line:setAlpha(0)
	Perk3Line:setZRot(180)
	Perk3Line:setImage(RegisterImage(@"hash_61801AC09948CA50"))
	Perk3Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	Perk3Line:setShaderVector(0, 1, 0, 0, 0)
	Perk3Line:setShaderVector(1, 0, 0, 0, 0)
	Perk3Line:setShaderVector(2, 1, 0, 0, 0)
	Perk3Line:setShaderVector(3, 0, 0, 0, 0)
	Perk3Line:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Perk3Line)
	self.Perk3Line = Perk3Line
	local Perk4Line = LUI.UIImage.new(0, 0, 1301, 1349, 0, 0, 724, 864)
	Perk4Line:setAlpha(0)
	Perk4Line:setZRot(180)
	Perk4Line:setImage(RegisterImage(@"hash_61801AC09948CA50"))
	Perk4Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	Perk4Line:setShaderVector(0, 1, 0, 0, 0)
	Perk4Line:setShaderVector(1, 0, 0, 0, 0)
	Perk4Line:setShaderVector(2, 1, 0, 0, 0)
	Perk4Line:setShaderVector(3, 0, 0, 0, 0)
	Perk4Line:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Perk4Line)
	self.Perk4Line = Perk4Line
	local StartWeaponLine = LUI.UIImage.new(0, 0, 1498, 1592, 0, 0, 640.5, 688.5)
	StartWeaponLine:setAlpha(0)
	StartWeaponLine:setImage(RegisterImage(@"hash_735C3C75193CB64"))
	StartWeaponLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	StartWeaponLine:setShaderVector(0, 1, 0, 0, 0)
	StartWeaponLine:setShaderVector(1, 0, 0, 0, 0)
	StartWeaponLine:setShaderVector(2, 1, 0, 0, 0)
	StartWeaponLine:setShaderVector(3, 0, 0, 0, 0)
	StartWeaponLine:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(StartWeaponLine)
	self.StartWeaponLine = StartWeaponLine
	local EquipmentLine = LUI.UIImage.new(0, 0, 1498, 1592, 0, 0, 475.5, 523.5)
	EquipmentLine:setAlpha(0)
	EquipmentLine:setImage(RegisterImage(@"hash_735C3C75193CB64"))
	EquipmentLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	EquipmentLine:setShaderVector(0, 1, 0, 0, 0)
	EquipmentLine:setShaderVector(1, 0, 0, 0, 0)
	EquipmentLine:setShaderVector(2, 1, 0, 0, 0)
	EquipmentLine:setShaderVector(3, 0, 0, 0, 0)
	EquipmentLine:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(EquipmentLine)
	self.EquipmentLine = EquipmentLine
	local HeroWeaponLine = LUI.UIImage.new(0, 0, 1498, 1592, 0, 0, 281, 329)
	HeroWeaponLine:setAlpha(0)
	HeroWeaponLine:setImage(RegisterImage(@"hash_735C3C75193CB64"))
	HeroWeaponLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	HeroWeaponLine:setShaderVector(0, 1, 0, 0, 0)
	HeroWeaponLine:setShaderVector(1, 0, 0, 0, 0)
	HeroWeaponLine:setShaderVector(2, 1, 0, 0, 0)
	HeroWeaponLine:setShaderVector(3, 0, 0, 0, 0)
	HeroWeaponLine:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(HeroWeaponLine)
	self.HeroWeaponLine = HeroWeaponLine
	local TalismanPerk1 = CoD.ZMTalismanEquipSlot.new(f1_arg0, f1_arg1, 0, 0, 564, 614, 0, 0, 743, 793)
	TalismanPerk1:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.PERK1)
			end,
		},
	})
	TalismanPerk1:linkToElementModel(TalismanPerk1, "itemIndex", true, function(model)
		f1_arg0:updateElementState(TalismanPerk1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	TalismanPerk1:setAlpha(0)
	TalismanPerk1.SlotIcon:setImage(RegisterImage(CoD.ZMTalismanUtility.GetTalismanSlotIcon(CoD.ZMTalismanUtility.TalismanTypes.PERK1, @"hash_5621DB435A480979")))
	TalismanPerk1:linkToElementModel(self, nil, false, function(model)
		TalismanPerk1:setModel(model, f1_arg1)
	end)
	self:addElement(TalismanPerk1)
	self.TalismanPerk1 = TalismanPerk1
	local TalismanPerk2 = CoD.ZMTalismanEquipSlot.new(f1_arg0, f1_arg1, 0, 0, 804, 854, 0, 0, 743, 793)
	TalismanPerk2:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.PERK2)
			end,
		},
	})
	TalismanPerk2:linkToElementModel(TalismanPerk2, "itemIndex", true, function(model)
		f1_arg0:updateElementState(TalismanPerk2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	TalismanPerk2:setAlpha(0)
	TalismanPerk2.SlotIcon:setImage(RegisterImage(CoD.ZMTalismanUtility.GetTalismanSlotIcon(CoD.ZMTalismanUtility.TalismanTypes.PERK2, @"hash_5621DB435A480979")))
	TalismanPerk2:linkToElementModel(self, nil, false, function(model)
		TalismanPerk2:setModel(model, f1_arg1)
	end)
	self:addElement(TalismanPerk2)
	self.TalismanPerk2 = TalismanPerk2
	local TalismanPerk3 = CoD.ZMTalismanEquipSlot.new(f1_arg0, f1_arg1, 0, 0, 1044, 1094, 0, 0, 743, 793)
	TalismanPerk3:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.PERK3)
			end,
		},
	})
	TalismanPerk3:linkToElementModel(TalismanPerk3, "itemIndex", true, function(model)
		f1_arg0:updateElementState(TalismanPerk3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	TalismanPerk3:setAlpha(0)
	TalismanPerk3.SlotIcon:setImage(RegisterImage(CoD.ZMTalismanUtility.GetTalismanSlotIcon(CoD.ZMTalismanUtility.TalismanTypes.PERK3, @"hash_5621DB435A480979")))
	TalismanPerk3:linkToElementModel(self, nil, false, function(model)
		TalismanPerk3:setModel(model, f1_arg1)
	end)
	self:addElement(TalismanPerk3)
	self.TalismanPerk3 = TalismanPerk3
	local TalismanPerk4 = CoD.ZMTalismanEquipSlot.new(f1_arg0, f1_arg1, 0, 0, 1284, 1334, 0, 0, 743, 793)
	TalismanPerk4:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.PERK4)
			end,
		},
	})
	TalismanPerk4:linkToElementModel(TalismanPerk4, "itemIndex", true, function(model)
		f1_arg0:updateElementState(TalismanPerk4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	TalismanPerk4:setAlpha(0)
	TalismanPerk4.SlotIcon:setImage(RegisterImage(CoD.ZMTalismanUtility.GetTalismanSlotIcon(CoD.ZMTalismanUtility.TalismanTypes.PERK4, @"hash_5621DB435A480979")))
	TalismanPerk4:linkToElementModel(self, nil, false, function(model)
		TalismanPerk4:setModel(model, f1_arg1)
	end)
	self:addElement(TalismanPerk4)
	self.TalismanPerk4 = TalismanPerk4
	local TalismanHeroWeapon = CoD.ZMTalismanEquipSlot.new(f1_arg0, f1_arg1, 0, 0, 1470, 1520, 0, 0, 306.5, 356.5)
	TalismanHeroWeapon:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.HERO_WEAPON)
			end,
		},
	})
	TalismanHeroWeapon:linkToElementModel(TalismanHeroWeapon, "itemIndex", true, function(model)
		f1_arg0:updateElementState(TalismanHeroWeapon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	TalismanHeroWeapon:setAlpha(0)
	TalismanHeroWeapon.SlotIcon:setImage(RegisterImage(CoD.ZMTalismanUtility.GetTalismanSlotIcon(CoD.ZMTalismanUtility.TalismanTypes.HERO_WEAPON, @"hash_5621DB435A480979")))
	TalismanHeroWeapon:linkToElementModel(self, nil, false, function(model)
		TalismanHeroWeapon:setModel(model, f1_arg1)
	end)
	self:addElement(TalismanHeroWeapon)
	self.TalismanHeroWeapon = TalismanHeroWeapon
	local TalismanEquipment = CoD.ZMTalismanEquipSlot.new(f1_arg0, f1_arg1, 0, 0, 1470, 1520, 0, 0, 527, 577)
	TalismanEquipment:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.EQUIPMENT)
			end,
		},
	})
	TalismanEquipment:linkToElementModel(TalismanEquipment, "itemIndex", true, function(model)
		f1_arg0:updateElementState(TalismanEquipment, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	TalismanEquipment:setAlpha(0)
	TalismanEquipment.SlotIcon:setImage(RegisterImage(CoD.ZMTalismanUtility.GetTalismanSlotIcon(CoD.ZMTalismanUtility.TalismanTypes.EQUIPMENT, @"hash_5621DB435A480979")))
	TalismanEquipment:linkToElementModel(self, nil, false, function(model)
		TalismanEquipment:setModel(model, f1_arg1)
	end)
	self:addElement(TalismanEquipment)
	self.TalismanEquipment = TalismanEquipment
	local TalismanStartWeapon = CoD.ZMTalismanEquipSlot.new(f1_arg0, f1_arg1, 0, 0, 1470, 1520, 0, 0, 752, 802)
	TalismanStartWeapon:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.START_WEAPON)
			end,
		},
	})
	TalismanStartWeapon:linkToElementModel(TalismanStartWeapon, "itemIndex", true, function(model)
		f1_arg0:updateElementState(TalismanStartWeapon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	TalismanStartWeapon:setAlpha(0)
	TalismanStartWeapon.SlotIcon:setImage(RegisterImage(CoD.ZMTalismanUtility.GetTalismanSlotIcon(CoD.ZMTalismanUtility.TalismanTypes.START_WEAPON, @"hash_5621DB435A480979")))
	TalismanStartWeapon:linkToElementModel(self, nil, false, function(model)
		TalismanStartWeapon:setModel(model, f1_arg1)
	end)
	self:addElement(TalismanStartWeapon)
	self.TalismanStartWeapon = TalismanStartWeapon
	self:mergeStateConditions({
		{
			stateName = "Perk1",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.PERK1)
			end,
		},
		{
			stateName = "Perk2",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.PERK2)
			end,
		},
		{
			stateName = "Perk3",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.PERK3)
			end,
		},
		{
			stateName = "Perk4",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.PERK4)
			end,
		},
		{
			stateName = "StartWeapon",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.START_WEAPON)
			end,
		},
		{
			stateName = "Equipment",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.EQUIPMENT)
			end,
		},
		{
			stateName = "HeroWeapon",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsEquippedTalismanOfType(element, f1_arg1, CoD.ZMTalismanUtility.TalismanTypes.HERO_WEAPON)
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTalismanEquipLine.__resetProperties = function(f31_arg0)
	f31_arg0.Perk1Line:completeAnimation()
	f31_arg0.LongHorizontalLine:completeAnimation()
	f31_arg0.Perk2Line:completeAnimation()
	f31_arg0.Perk3Line:completeAnimation()
	f31_arg0.Perk4Line:completeAnimation()
	f31_arg0.LongVerticalLine:completeAnimation()
	f31_arg0.StartWeaponLine:completeAnimation()
	f31_arg0.EquipmentLine:completeAnimation()
	f31_arg0.HeroWeaponLine:completeAnimation()
	f31_arg0.Perk1Line:setAlpha(0)
	f31_arg0.Perk1Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.Perk1Line:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.Perk1Line:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.Perk1Line:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.Perk1Line:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.Perk1Line:setShaderVector(4, 0, 0, 0, 0)
	f31_arg0.LongHorizontalLine:setAlpha(0)
	f31_arg0.LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.LongHorizontalLine:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
	f31_arg0.Perk2Line:setAlpha(0)
	f31_arg0.Perk2Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.Perk2Line:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.Perk2Line:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.Perk2Line:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.Perk2Line:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.Perk2Line:setShaderVector(4, 0, 0, 0, 0)
	f31_arg0.Perk3Line:setAlpha(0)
	f31_arg0.Perk3Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.Perk3Line:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.Perk3Line:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.Perk3Line:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.Perk3Line:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.Perk3Line:setShaderVector(4, 0, 0, 0, 0)
	f31_arg0.Perk4Line:setAlpha(0)
	f31_arg0.Perk4Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.Perk4Line:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.Perk4Line:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.Perk4Line:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.Perk4Line:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.Perk4Line:setShaderVector(4, 0, 0, 0, 0)
	f31_arg0.LongVerticalLine:setAlpha(0)
	f31_arg0.LongVerticalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.LongVerticalLine:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.LongVerticalLine:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.LongVerticalLine:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.LongVerticalLine:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.LongVerticalLine:setShaderVector(4, 0, 0, 0, 0)
	f31_arg0.StartWeaponLine:setAlpha(0)
	f31_arg0.StartWeaponLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.StartWeaponLine:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.StartWeaponLine:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.StartWeaponLine:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.StartWeaponLine:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.StartWeaponLine:setShaderVector(4, 0, 0, 0, 0)
	f31_arg0.EquipmentLine:setAlpha(0)
	f31_arg0.EquipmentLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.EquipmentLine:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.EquipmentLine:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.EquipmentLine:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.EquipmentLine:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.EquipmentLine:setShaderVector(4, 0, 0, 0, 0)
	f31_arg0.HeroWeaponLine:setAlpha(0)
	f31_arg0.HeroWeaponLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	f31_arg0.HeroWeaponLine:setShaderVector(0, 1, 0, 0, 0)
	f31_arg0.HeroWeaponLine:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.HeroWeaponLine:setShaderVector(2, 1, 0, 0, 0)
	f31_arg0.HeroWeaponLine:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.HeroWeaponLine:setShaderVector(4, 0, 0, 0, 0)
end
CoD.ZMTalismanEquipLine.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
	},
	Perk1 = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			local f33_local0 = function(f34_arg0)
				f33_arg0.LongHorizontalLine:beginAnimation(500)
				f33_arg0.LongHorizontalLine:setShaderVector(0, 0.26, 0, 0, 0)
				f33_arg0.LongHorizontalLine:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.LongHorizontalLine:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.LongHorizontalLine:completeAnimation()
			f33_arg0.LongHorizontalLine:setAlpha(1)
			f33_arg0.LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f33_arg0.LongHorizontalLine:setShaderVector(0, 0, 0, 0, 0)
			f33_arg0.LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
			f33_arg0.LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
			f33_arg0.LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
			f33_arg0.LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
			f33_local0(f33_arg0.LongHorizontalLine)
			local f33_local1 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(100)
					f36_arg0:setShaderVector(2, 1, 0, 0, 0)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.Perk1Line:beginAnimation(500)
				f33_arg0.Perk1Line:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Perk1Line:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f33_arg0.Perk1Line:completeAnimation()
			f33_arg0.Perk1Line:setAlpha(1)
			f33_arg0.Perk1Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f33_arg0.Perk1Line:setShaderVector(0, 1, 0, 0, 0)
			f33_arg0.Perk1Line:setShaderVector(1, 0, 0, 0, 0)
			f33_arg0.Perk1Line:setShaderVector(2, 0, 0, 0, 0)
			f33_arg0.Perk1Line:setShaderVector(3, 0, 0, 0, 0)
			f33_arg0.Perk1Line:setShaderVector(4, 0, 0, 0, 0)
			f33_local1(f33_arg0.Perk1Line)
		end,
	},
	Perk2 = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			local f37_local0 = function(f38_arg0)
				f37_arg0.LongHorizontalLine:beginAnimation(500)
				f37_arg0.LongHorizontalLine:setShaderVector(0, 0.46, 0, 0, 0)
				f37_arg0.LongHorizontalLine:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.LongHorizontalLine:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.LongHorizontalLine:completeAnimation()
			f37_arg0.LongHorizontalLine:setAlpha(1)
			f37_arg0.LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f37_arg0.LongHorizontalLine:setShaderVector(0, 0, 0, 0, 0)
			f37_arg0.LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
			f37_arg0.LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
			f37_arg0.LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
			f37_arg0.LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
			f37_local0(f37_arg0.LongHorizontalLine)
			local f37_local1 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(100)
					f40_arg0:setShaderVector(2, 1, 0, 0, 0)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
				end
				f37_arg0.Perk2Line:beginAnimation(500)
				f37_arg0.Perk2Line:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Perk2Line:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f37_arg0.Perk2Line:completeAnimation()
			f37_arg0.Perk2Line:setAlpha(1)
			f37_arg0.Perk2Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f37_arg0.Perk2Line:setShaderVector(0, 1, 0, 0, 0)
			f37_arg0.Perk2Line:setShaderVector(1, 0, 0, 0, 0)
			f37_arg0.Perk2Line:setShaderVector(2, 0, 0, 0, 0)
			f37_arg0.Perk2Line:setShaderVector(3, 0, 0, 0, 0)
			f37_arg0.Perk2Line:setShaderVector(4, 0, 0, 0, 0)
			f37_local1(f37_arg0.Perk2Line)
		end,
	},
	Perk3 = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			local f41_local0 = function(f42_arg0)
				f41_arg0.LongHorizontalLine:beginAnimation(500)
				f41_arg0.LongHorizontalLine:setShaderVector(0, 0.65, 0, 0, 0)
				f41_arg0.LongHorizontalLine:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.LongHorizontalLine:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.LongHorizontalLine:completeAnimation()
			f41_arg0.LongHorizontalLine:setAlpha(1)
			f41_arg0.LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f41_arg0.LongHorizontalLine:setShaderVector(0, 0, 0, 0, 0)
			f41_arg0.LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
			f41_arg0.LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
			f41_arg0.LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
			f41_arg0.LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
			f41_local0(f41_arg0.LongHorizontalLine)
			local f41_local1 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					f44_arg0:beginAnimation(100)
					f44_arg0:setShaderVector(2, 1, 0, 0, 0)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
				end
				f41_arg0.Perk3Line:beginAnimation(500)
				f41_arg0.Perk3Line:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.Perk3Line:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f41_arg0.Perk3Line:completeAnimation()
			f41_arg0.Perk3Line:setAlpha(1)
			f41_arg0.Perk3Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f41_arg0.Perk3Line:setShaderVector(0, 1, 0, 0, 0)
			f41_arg0.Perk3Line:setShaderVector(1, 0, 0, 0, 0)
			f41_arg0.Perk3Line:setShaderVector(2, 0, 0, 0, 0)
			f41_arg0.Perk3Line:setShaderVector(3, 0, 0, 0, 0)
			f41_arg0.Perk3Line:setShaderVector(4, 0, 0, 0, 0)
			f41_local1(f41_arg0.Perk3Line)
		end,
	},
	Perk4 = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			local f45_local0 = function(f46_arg0)
				f45_arg0.LongHorizontalLine:beginAnimation(500)
				f45_arg0.LongHorizontalLine:setShaderVector(0, 0.84, 0, 0, 0)
				f45_arg0.LongHorizontalLine:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.LongHorizontalLine:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.LongHorizontalLine:completeAnimation()
			f45_arg0.LongHorizontalLine:setAlpha(1)
			f45_arg0.LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f45_arg0.LongHorizontalLine:setShaderVector(0, 0, 0, 0, 0)
			f45_arg0.LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
			f45_arg0.LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
			f45_arg0.LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
			f45_arg0.LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
			f45_local0(f45_arg0.LongHorizontalLine)
			local f45_local1 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(100)
					f48_arg0:setShaderVector(2, 1, 0, 0, 0)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
				end
				f45_arg0.Perk4Line:beginAnimation(500)
				f45_arg0.Perk4Line:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.Perk4Line:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f45_arg0.Perk4Line:completeAnimation()
			f45_arg0.Perk4Line:setAlpha(1)
			f45_arg0.Perk4Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f45_arg0.Perk4Line:setShaderVector(0, 1, 0, 0, 0)
			f45_arg0.Perk4Line:setShaderVector(1, 0, 0, 0, 0)
			f45_arg0.Perk4Line:setShaderVector(2, 0, 0, 0, 0)
			f45_arg0.Perk4Line:setShaderVector(3, 0, 0, 0, 0)
			f45_arg0.Perk4Line:setShaderVector(4, 0, 0, 0, 0)
			f45_local1(f45_arg0.Perk4Line)
		end,
	},
	StartWeapon = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			local f49_local0 = function(f50_arg0)
				f49_arg0.LongHorizontalLine:beginAnimation(500)
				f49_arg0.LongHorizontalLine:setShaderVector(0, 1, 0, 0, 0)
				f49_arg0.LongHorizontalLine:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.LongHorizontalLine:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.LongHorizontalLine:completeAnimation()
			f49_arg0.LongHorizontalLine:setAlpha(1)
			f49_arg0.LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f49_arg0.LongHorizontalLine:setShaderVector(0, 0, 0, 0, 0)
			f49_arg0.LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
			f49_arg0.LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
			f49_arg0.LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
			f49_arg0.LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
			f49_local0(f49_arg0.LongHorizontalLine)
			local f49_local1 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(69)
					f52_arg0:setShaderVector(2, 0.34, 0, 0, 0)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.LongVerticalLine:beginAnimation(500)
				f49_arg0.LongVerticalLine:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.LongVerticalLine:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f49_arg0.LongVerticalLine:completeAnimation()
			f49_arg0.LongVerticalLine:setAlpha(1)
			f49_arg0.LongVerticalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f49_arg0.LongVerticalLine:setShaderVector(0, 1, 0, 0, 0)
			f49_arg0.LongVerticalLine:setShaderVector(1, 0, 0, 0, 0)
			f49_arg0.LongVerticalLine:setShaderVector(2, 0, 0, 0, 0)
			f49_arg0.LongVerticalLine:setShaderVector(3, 0, 0, 0, 0)
			f49_arg0.LongVerticalLine:setShaderVector(4, 0, 0, 0, 0)
			f49_local1(f49_arg0.LongVerticalLine)
			local f49_local2 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					f54_arg0:beginAnimation(30)
					f54_arg0:setShaderVector(0, 1, 0, 0, 0)
					f54_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
				end
				f49_arg0.StartWeaponLine:beginAnimation(570)
				f49_arg0.StartWeaponLine:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.StartWeaponLine:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f49_arg0.StartWeaponLine:completeAnimation()
			f49_arg0.StartWeaponLine:setAlpha(1)
			f49_arg0.StartWeaponLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f49_arg0.StartWeaponLine:setShaderVector(0, 0, 0, 0, 0)
			f49_arg0.StartWeaponLine:setShaderVector(1, 0, 0, 0, 0)
			f49_arg0.StartWeaponLine:setShaderVector(2, 1, 0, 0, 0)
			f49_arg0.StartWeaponLine:setShaderVector(3, 0, 0, 0, 0)
			f49_arg0.StartWeaponLine:setShaderVector(4, 0, 0, 0, 0)
			f49_local2(f49_arg0.StartWeaponLine)
		end,
	},
	Equipment = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(3)
			local f55_local0 = function(f56_arg0)
				f55_arg0.LongHorizontalLine:beginAnimation(450)
				f55_arg0.LongHorizontalLine:setShaderVector(0, 1, 0, 0, 0)
				f55_arg0.LongHorizontalLine:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.LongHorizontalLine:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.LongHorizontalLine:completeAnimation()
			f55_arg0.LongHorizontalLine:setAlpha(1)
			f55_arg0.LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f55_arg0.LongHorizontalLine:setShaderVector(0, 0, 0, 0, 0)
			f55_arg0.LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
			f55_arg0.LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
			f55_arg0.LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
			f55_arg0.LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
			f55_local0(f55_arg0.LongHorizontalLine)
			local f55_local1 = function(f57_arg0)
				local f57_local0 = function(f58_arg0)
					f58_arg0:beginAnimation(120)
					f58_arg0:setShaderVector(2, 0.62, 0, 0, 0)
					f58_arg0:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
				end
				f55_arg0.LongVerticalLine:beginAnimation(450)
				f55_arg0.LongVerticalLine:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.LongVerticalLine:registerEventHandler("transition_complete_keyframe", f57_local0)
			end
			f55_arg0.LongVerticalLine:completeAnimation()
			f55_arg0.LongVerticalLine:setAlpha(1)
			f55_arg0.LongVerticalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f55_arg0.LongVerticalLine:setShaderVector(0, 1, 0, 0, 0)
			f55_arg0.LongVerticalLine:setShaderVector(1, 0, 0, 0, 0)
			f55_arg0.LongVerticalLine:setShaderVector(2, 0, 0, 0, 0)
			f55_arg0.LongVerticalLine:setShaderVector(3, 0, 0, 0, 0)
			f55_arg0.LongVerticalLine:setShaderVector(4, 0, 0, 0, 0)
			f55_local1(f55_arg0.LongVerticalLine)
			local f55_local2 = function(f59_arg0)
				local f59_local0 = function(f60_arg0)
					f60_arg0:beginAnimation(30)
					f60_arg0:setShaderVector(0, 1, 0, 0, 0)
					f60_arg0:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
				end
				f55_arg0.EquipmentLine:beginAnimation(570)
				f55_arg0.EquipmentLine:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.EquipmentLine:registerEventHandler("transition_complete_keyframe", f59_local0)
			end
			f55_arg0.EquipmentLine:completeAnimation()
			f55_arg0.EquipmentLine:setAlpha(1)
			f55_arg0.EquipmentLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f55_arg0.EquipmentLine:setShaderVector(0, 0, 0, 0, 0)
			f55_arg0.EquipmentLine:setShaderVector(1, 0, 0, 0, 0)
			f55_arg0.EquipmentLine:setShaderVector(2, 1, 0, 0, 0)
			f55_arg0.EquipmentLine:setShaderVector(3, 0, 0, 0, 0)
			f55_arg0.EquipmentLine:setShaderVector(4, 0, 0, 0, 0)
			f55_local2(f55_arg0.EquipmentLine)
		end,
	},
	HeroWeapon = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(3)
			local f61_local0 = function(f62_arg0)
				f61_arg0.LongHorizontalLine:beginAnimation(350)
				f61_arg0.LongHorizontalLine:setShaderVector(0, 1, 0, 0, 0)
				f61_arg0.LongHorizontalLine:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.LongHorizontalLine:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.LongHorizontalLine:completeAnimation()
			f61_arg0.LongHorizontalLine:setAlpha(1)
			f61_arg0.LongHorizontalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f61_arg0.LongHorizontalLine:setShaderVector(0, 0, 0, 0, 0)
			f61_arg0.LongHorizontalLine:setShaderVector(1, 0, 0, 0, 0)
			f61_arg0.LongHorizontalLine:setShaderVector(2, 1, 0, 0, 0)
			f61_arg0.LongHorizontalLine:setShaderVector(3, 0, 0, 0, 0)
			f61_arg0.LongHorizontalLine:setShaderVector(4, 0, 0, 0, 0)
			f61_local0(f61_arg0.LongHorizontalLine)
			local f61_local1 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					f64_arg0:beginAnimation(220)
					f64_arg0:setShaderVector(2, 0.95, 0, 0, 0)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
				end
				f61_arg0.LongVerticalLine:beginAnimation(350)
				f61_arg0.LongVerticalLine:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.LongVerticalLine:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f61_arg0.LongVerticalLine:completeAnimation()
			f61_arg0.LongVerticalLine:setAlpha(1)
			f61_arg0.LongVerticalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f61_arg0.LongVerticalLine:setShaderVector(0, 1, 0, 0, 0)
			f61_arg0.LongVerticalLine:setShaderVector(1, 0, 0, 0, 0)
			f61_arg0.LongVerticalLine:setShaderVector(2, 0, 0, 0, 0)
			f61_arg0.LongVerticalLine:setShaderVector(3, 0, 0, 0, 0)
			f61_arg0.LongVerticalLine:setShaderVector(4, 0, 0, 0, 0)
			f61_local1(f61_arg0.LongVerticalLine)
			local f61_local2 = function(f65_arg0)
				local f65_local0 = function(f66_arg0)
					f66_arg0:beginAnimation(30)
					f66_arg0:setShaderVector(0, 1, 0, 0, 0)
					f66_arg0:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
				end
				f61_arg0.HeroWeaponLine:beginAnimation(570)
				f61_arg0.HeroWeaponLine:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.HeroWeaponLine:registerEventHandler("transition_complete_keyframe", f65_local0)
			end
			f61_arg0.HeroWeaponLine:completeAnimation()
			f61_arg0.HeroWeaponLine:setAlpha(1)
			f61_arg0.HeroWeaponLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
			f61_arg0.HeroWeaponLine:setShaderVector(0, 0, 0, 0, 0)
			f61_arg0.HeroWeaponLine:setShaderVector(1, 0, 0, 0, 0)
			f61_arg0.HeroWeaponLine:setShaderVector(2, 1, 0, 0, 0)
			f61_arg0.HeroWeaponLine:setShaderVector(3, 0, 0, 0, 0)
			f61_arg0.HeroWeaponLine:setShaderVector(4, 0, 0, 0, 0)
			f61_local2(f61_arg0.HeroWeaponLine)
		end,
	},
}
CoD.ZMTalismanEquipLine.__onClose = function(f67_arg0)
	f67_arg0.Channels:close()
	f67_arg0.TalismanPerk1:close()
	f67_arg0.TalismanPerk2:close()
	f67_arg0.TalismanPerk3:close()
	f67_arg0.TalismanPerk4:close()
	f67_arg0.TalismanHeroWeapon:close()
	f67_arg0.TalismanEquipment:close()
	f67_arg0.TalismanStartWeapon:close()
end
