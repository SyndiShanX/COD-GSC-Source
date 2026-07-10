require("x64:78c9be6c9bba008")
CoD.ZMLoadoutPreviewLobbyClient = InheritFrom(LUI.UIElement)
CoD.ZMLoadoutPreviewLobbyClient.__defaultWidth = 272
CoD.ZMLoadoutPreviewLobbyClient.__defaultHeight = 379
CoD.ZMLoadoutPreviewLobbyClient.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLoadoutPreviewLobbyClient)
	self.id = "ZMLoadoutPreviewLobbyClient"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, -4, 276, 0, 0, -4.5, 383.5)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Panel = LUI.UIImage.new(0, 0, -4, 276, 0, 0, -4.5, 383.5)
	Panel:setRGB(0, 0, 0)
	Panel:setAlpha(0.27)
	self:addElement(Panel)
	self.Panel = Panel
	local TiledBacking = LUI.UIImage.new(-0.02, 1.02, 1, -1, 0.18, 1.01, -71, -73)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local Perk4 = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 204, 272, 0, 0, 310, 378)
	Perk4:mergeStateConditions({
		{
			stateName = "PerkModifier",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "perk4index", nil, 0)
			end,
		},
	})
	Perk4:linkToElementModel(Perk4, "perk4index", true, function(model)
		f1_arg0:updateElementState(Perk4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "perk4index",
		})
	end)
	Perk4.Name:setText(LocalizeToUpperString(@"menu/new"))
	Perk4:linkToElementModel(self, "loadout", false, function(model)
		Perk4:setModel(model, f1_arg1)
	end)
	Perk4:linkToElementModel(self, "loadout.perk4Index", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Perk4.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f5_local0)))
		end
	end)
	Perk4:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.perk4Index", Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f1_arg1)
		return f6_local0
	end)
	Perk4:linkToElementModel(self, "loadout.perk4Index", true, function(model)
		if IsElementInFocus(Perk4) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.perk4Index", Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f1_arg1)
		end
	end)
	self:addElement(Perk4)
	self.Perk4 = Perk4
	local Perk3 = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 136, 204, 0, 0, 310, 378)
	Perk3.Name:setText(LocalizeToUpperString(@"menu/new"))
	Perk3:linkToElementModel(self, "loadout.perk3Index", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Perk3.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f8_local0)))
		end
	end)
	Perk3:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.perk3Index", Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f1_arg1)
		return f9_local0
	end)
	Perk3:linkToElementModel(self, "loadout.perk3Index", true, function(model)
		if IsElementInFocus(Perk3) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.perk3Index", Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f1_arg1)
		end
	end)
	self:addElement(Perk3)
	self.Perk3 = Perk3
	local Perk2 = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 68, 136, 0, 0, 310, 378)
	Perk2.Name:setText(LocalizeToUpperString(@"menu/new"))
	Perk2:linkToElementModel(self, "loadout.perk2Index", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Perk2.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f11_local0)))
		end
	end)
	Perk2:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.perk2Index", Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f1_arg1)
		return f12_local0
	end)
	Perk2:linkToElementModel(self, "loadout.perk2Index", true, function(model)
		if IsElementInFocus(Perk2) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.perk2Index", Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f1_arg1)
		end
	end)
	self:addElement(Perk2)
	self.Perk2 = Perk2
	local Perk1 = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 0, 68, 0, 0, 310, 378)
	Perk1.Name:setText(LocalizeToUpperString(@"menu/new"))
	Perk1:linkToElementModel(self, "loadout.perk1Index", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Perk1.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f14_local0)))
		end
	end)
	Perk1:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.perk1Index", Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f1_arg1)
		return f15_local0
	end)
	Perk1:linkToElementModel(self, "loadout.perk1Index", true, function(model)
		if IsElementInFocus(Perk1) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.perk1Index", Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f1_arg1)
		end
	end)
	self:addElement(Perk1)
	self.Perk1 = Perk1
	local BGB4 = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 204, 272, 0, 0, 242, 310)
	BGB4.itemImage:setScale(1.2, 1.2)
	BGB4.Name:setText(LocalizeToUpperString(@"menu/new"))
	BGB4:linkToElementModel(self, "loadout.bgb4Index", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			BGB4.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f17_local0)))
		end
	end)
	BGB4:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.bgb4Index", Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f1_arg1)
		return f18_local0
	end)
	BGB4:linkToElementModel(self, "loadout.bgb4Index", true, function(model)
		if IsElementInFocus(BGB4) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.bgb4Index", Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f1_arg1)
		end
	end)
	self:addElement(BGB4)
	self.BGB4 = BGB4
	local BGB3 = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 136, 204, 0, 0, 242, 310)
	BGB3.itemImage:setScale(1.2, 1.2)
	BGB3.Name:setText(LocalizeToUpperString(@"menu/new"))
	BGB3:linkToElementModel(self, "loadout.bgb3Index", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			BGB3.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f20_local0)))
		end
	end)
	BGB3:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.bgb3Index", Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f1_arg1)
		return f21_local0
	end)
	BGB3:linkToElementModel(self, "loadout.bgb3Index", true, function(model)
		if IsElementInFocus(BGB3) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.bgb3Index", Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f1_arg1)
		end
	end)
	self:addElement(BGB3)
	self.BGB3 = BGB3
	local BGB2 = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 68, 136, 0, 0, 242, 310)
	BGB2.itemImage:setScale(1.2, 1.2)
	BGB2.Name:setText(LocalizeToUpperString(@"menu/new"))
	BGB2:linkToElementModel(self, "loadout.bgb2Index", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			BGB2.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f23_local0)))
		end
	end)
	BGB2:registerEventHandler("gain_focus", function(element, event)
		local f24_local0 = nil
		if element.gainFocus then
			f24_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f24_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.bgb2Index", Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f1_arg1)
		return f24_local0
	end)
	BGB2:linkToElementModel(self, "loadout.bgb2Index", true, function(model)
		if IsElementInFocus(BGB2) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.bgb2Index", Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f1_arg1)
		end
	end)
	self:addElement(BGB2)
	self.BGB2 = BGB2
	local BGB1 = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 0, 68, 0, 0, 242, 310)
	BGB1.itemImage:setScale(1.2, 1.2)
	BGB1.Name:setText(LocalizeToUpperString(@"menu/new"))
	BGB1:linkToElementModel(self, "loadout.bgb1Index", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			BGB1.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f26_local0)))
		end
	end)
	BGB1:registerEventHandler("gain_focus", function(element, event)
		local f27_local0 = nil
		if element.gainFocus then
			f27_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f27_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.bgb1Index", Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f1_arg1)
		return f27_local0
	end)
	BGB1:linkToElementModel(self, "loadout.bgb1Index", true, function(model)
		if IsElementInFocus(BGB1) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.bgb1Index", Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f1_arg1)
		end
	end)
	self:addElement(BGB1)
	self.BGB1 = BGB1
	local Talisman = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 0, 272, 0, 0, 160, 242)
	Talisman:mergeStateConditions({
		{
			stateName = "ShowName",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	Talisman.itemImage:setScale(1.04, 1.04)
	Talisman:linkToElementModel(self, "loadout.talismanItemIndex", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			Talisman.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_15544C104CD15F10"], f30_local0)))
		end
	end)
	Talisman:linkToElementModel(self, "loadout.talismanItemIndex", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			Talisman.Name:setText(LocalizeToUpperString(GetItemNameFromIndex(Enum[@"statindexoffset"][@"hash_15544C104CD15F10"], f31_local0)))
		end
	end)
	Talisman:registerEventHandler("gain_focus", function(element, event)
		local f32_local0 = nil
		if element.gainFocus then
			f32_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f32_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.talismanItemIndex", Enum[@"statindexoffset"][@"hash_15544C104CD15F10"], f1_arg1)
		return f32_local0
	end)
	Talisman:linkToElementModel(self, "loadout.talismanItemIndex", true, function(model)
		if IsElementInFocus(Talisman) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.talismanItemIndex", Enum[@"statindexoffset"][@"hash_15544C104CD15F10"], f1_arg1)
		end
	end)
	self:addElement(Talisman)
	self.Talisman = Talisman
	local Equipment = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 136, 272, 0, 0, 100, 160)
	Equipment.itemImage:setScale(0.84, 0.84)
	Equipment.Name:setText(LocalizeToUpperString(@"menu/new"))
	Equipment:linkToElementModel(self, "loadout.primaryGrenadeItemIndex", true, function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			Equipment.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f34_local0)))
		end
	end)
	Equipment:registerEventHandler("gain_focus", function(element, event)
		local f35_local0 = nil
		if element.gainFocus then
			f35_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f35_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.primaryGrenadeItemIndex", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f1_arg1)
		return f35_local0
	end)
	Equipment:linkToElementModel(self, "loadout.primaryGrenadeItemIndex", true, function(model)
		if IsElementInFocus(Equipment) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.primaryGrenadeItemIndex", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f1_arg1)
		end
	end)
	self:addElement(Equipment)
	self.Equipment = Equipment
	local StartWeapon = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 0, 136, 0, 0, 100, 160)
	StartWeapon.itemImage:setScale(0.9, 0.9)
	StartWeapon.Name:setText(LocalizeToUpperString(@"menu/new"))
	StartWeapon:linkToElementModel(self, "loadout.primaryWeaponItemIndex", true, function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			StartWeapon.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f37_local0)))
		end
	end)
	StartWeapon:registerEventHandler("gain_focus", function(element, event)
		local f38_local0 = nil
		if element.gainFocus then
			f38_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f38_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.primaryWeaponItemIndex", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f1_arg1)
		return f38_local0
	end)
	StartWeapon:linkToElementModel(self, "loadout.primaryWeaponItemIndex", true, function(model)
		if IsElementInFocus(StartWeapon) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.primaryWeaponItemIndex", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f1_arg1)
		end
	end)
	self:addElement(StartWeapon)
	self.StartWeapon = StartWeapon
	local SpecialWeapon = CoD.ZMLoadoutPreviewIndexItem.new(f1_arg0, f1_arg1, 0, 0, 0, 272, 0, 0, 0, 100)
	SpecialWeapon.itemImage:setScale(1.66, 1.66)
	SpecialWeapon.Name:setText(LocalizeToUpperString(@"menu/new"))
	SpecialWeapon:linkToElementModel(self, "loadout.heroGadgetItemIndex", true, function(model)
		local f40_local0 = model:get()
		if f40_local0 ~= nil then
			SpecialWeapon.itemImage:setImage(RegisterImage(GetItemImageFromIndex(Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f40_local0)))
		end
	end)
	SpecialWeapon:registerEventHandler("gain_focus", function(element, event)
		local f41_local0 = nil
		if element.gainFocus then
			f41_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f41_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.heroGadgetItemIndex", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f1_arg1)
		return f41_local0
	end)
	SpecialWeapon:linkToElementModel(self, "loadout.heroGadgetItemIndex", true, function(model)
		if IsElementInFocus(SpecialWeapon) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoIndex(self, "loadout.heroGadgetItemIndex", Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f1_arg1)
		end
	end)
	self:addElement(SpecialWeapon)
	self.SpecialWeapon = SpecialWeapon
	local Metalbar = LUI.UIImage.new(0, 0, -14, 286, 0, 0, -13.5, 2.5)
	Metalbar:setImage(RegisterImage(@"uie_ui_menu_zm_metal_bar"))
	self:addElement(Metalbar)
	self.Metalbar = Metalbar
	local Metalbar2 = LUI.UIImage.new(0, 0, -14, 286, 0, 0, 376.5, 392.5)
	Metalbar2:setImage(RegisterImage(@"uie_ui_menu_zm_metal_bar"))
	self:addElement(Metalbar2)
	self.Metalbar2 = Metalbar2
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsBotByXuid(self, "xuid")
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	Perk4.id = "Perk4"
	Perk3.id = "Perk3"
	Perk2.id = "Perk2"
	Perk1.id = "Perk1"
	BGB4.id = "BGB4"
	BGB3.id = "BGB3"
	BGB2.id = "BGB2"
	BGB1.id = "BGB1"
	Talisman.id = "Talisman"
	Equipment.id = "Equipment"
	StartWeapon.id = "StartWeapon"
	SpecialWeapon.id = "SpecialWeapon"
	self.__defaultFocus = SpecialWeapon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMLoadoutPreviewLobbyClient.__resetProperties = function(f45_arg0)
	f45_arg0.Metalbar2:completeAnimation()
	f45_arg0.Metalbar:completeAnimation()
	f45_arg0.SpecialWeapon:completeAnimation()
	f45_arg0.StartWeapon:completeAnimation()
	f45_arg0.Equipment:completeAnimation()
	f45_arg0.Talisman:completeAnimation()
	f45_arg0.BGB1:completeAnimation()
	f45_arg0.BGB2:completeAnimation()
	f45_arg0.BGB3:completeAnimation()
	f45_arg0.BGB4:completeAnimation()
	f45_arg0.Perk1:completeAnimation()
	f45_arg0.Perk2:completeAnimation()
	f45_arg0.Perk3:completeAnimation()
	f45_arg0.Perk4:completeAnimation()
	f45_arg0.TiledBacking:completeAnimation()
	f45_arg0.Panel:completeAnimation()
	f45_arg0.Blur:completeAnimation()
	f45_arg0.Metalbar2:setAlpha(1)
	f45_arg0.Metalbar:setAlpha(1)
	f45_arg0.SpecialWeapon:setAlpha(1)
	f45_arg0.StartWeapon:setAlpha(1)
	f45_arg0.Equipment:setAlpha(1)
	f45_arg0.Talisman:setAlpha(1)
	f45_arg0.BGB1:setAlpha(1)
	f45_arg0.BGB2:setAlpha(1)
	f45_arg0.BGB3:setAlpha(1)
	f45_arg0.BGB4:setAlpha(1)
	f45_arg0.Perk1:setAlpha(1)
	f45_arg0.Perk2:setAlpha(1)
	f45_arg0.Perk3:setAlpha(1)
	f45_arg0.Perk4:setAlpha(1)
	f45_arg0.TiledBacking:setAlpha(0.5)
	f45_arg0.Panel:setAlpha(0.27)
	f45_arg0.Blur:setAlpha(1)
end
CoD.ZMLoadoutPreviewLobbyClient.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(17)
			f47_arg0.Blur:completeAnimation()
			f47_arg0.Blur:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Blur)
			f47_arg0.Panel:completeAnimation()
			f47_arg0.Panel:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Panel)
			f47_arg0.TiledBacking:completeAnimation()
			f47_arg0.TiledBacking:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.TiledBacking)
			f47_arg0.Perk4:completeAnimation()
			f47_arg0.Perk4:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Perk4)
			f47_arg0.Perk3:completeAnimation()
			f47_arg0.Perk3:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Perk3)
			f47_arg0.Perk2:completeAnimation()
			f47_arg0.Perk2:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Perk2)
			f47_arg0.Perk1:completeAnimation()
			f47_arg0.Perk1:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Perk1)
			f47_arg0.BGB4:completeAnimation()
			f47_arg0.BGB4:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.BGB4)
			f47_arg0.BGB3:completeAnimation()
			f47_arg0.BGB3:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.BGB3)
			f47_arg0.BGB2:completeAnimation()
			f47_arg0.BGB2:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.BGB2)
			f47_arg0.BGB1:completeAnimation()
			f47_arg0.BGB1:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.BGB1)
			f47_arg0.Talisman:completeAnimation()
			f47_arg0.Talisman:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Talisman)
			f47_arg0.Equipment:completeAnimation()
			f47_arg0.Equipment:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Equipment)
			f47_arg0.StartWeapon:completeAnimation()
			f47_arg0.StartWeapon:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.StartWeapon)
			f47_arg0.SpecialWeapon:completeAnimation()
			f47_arg0.SpecialWeapon:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.SpecialWeapon)
			f47_arg0.Metalbar:completeAnimation()
			f47_arg0.Metalbar:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Metalbar)
			f47_arg0.Metalbar2:completeAnimation()
			f47_arg0.Metalbar2:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Metalbar2)
		end,
	},
}
CoD.ZMLoadoutPreviewLobbyClient.__onClose = function(f48_arg0)
	f48_arg0.Perk4:close()
	f48_arg0.Perk3:close()
	f48_arg0.Perk2:close()
	f48_arg0.Perk1:close()
	f48_arg0.BGB4:close()
	f48_arg0.BGB3:close()
	f48_arg0.BGB2:close()
	f48_arg0.BGB1:close()
	f48_arg0.Talisman:close()
	f48_arg0.Equipment:close()
	f48_arg0.StartWeapon:close()
	f48_arg0.SpecialWeapon:close()
end
