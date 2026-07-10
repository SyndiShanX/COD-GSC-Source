require("x64:714a8bb51b2892")
require("x64:286cf531f95c8bd")
CoD.ZMLoadoutPreview = InheritFrom(LUI.UIElement)
CoD.ZMLoadoutPreview.__defaultWidth = 272
CoD.ZMLoadoutPreview.__defaultHeight = 379
CoD.ZMLoadoutPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLoadoutPreview)
	self.id = "ZMLoadoutPreview"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerkList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	PerkList:mergeStateConditions({
		{
			stateName = "PerkModifier",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "image", @"hash_0", @"blacktransparent") then
					f2_local0 = IsLastListElement(element)
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	PerkList:linkToElementModel(PerkList, "image", true, function(model)
		f1_arg0:updateElementState(PerkList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "image",
		})
	end)
	PerkList:setLeftRight(0, 0, 0, 272)
	PerkList:setTopBottom(0, 0, 311, 379)
	PerkList:setWidgetType(CoD.ZMLoadoutPreviewItem)
	PerkList:setHorizontalCount(4)
	PerkList:setSpacing(0)
	PerkList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PerkList:setDataSource("ZMEquippedPerks")
	PerkList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f4_local0
	end)
	PerkList:linkToElementModel(self, "classNum", true, function(model)
		CoD.GridAndListUtility.UpdateDataSource(PerkList, false, false, true)
	end)
	PerkList:subscribeToGlobalModel(f1_arg1, "ZMEquippedPerks", "slotIndex", function(model)
		local f6_local0 = PerkList
		if IsElementInFocus(f6_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f6_local0, f1_arg1)
		end
	end)
	self:addElement(PerkList)
	self.PerkList = PerkList
	local BGB4 = CoD.ZMLoadoutPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 204, 272, 0, 0, 242, 310)
	BGB4.itemImage:setScale(1.2, 1.2)
	BGB4:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Left", function(model)
		BGB4:setModel(model, f1_arg1)
	end)
	BGB4:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f8_local0
	end)
	BGB4:subscribeToGlobalModel(f1_arg1, "PerController", "BGBLoadout.Left", function(model)
		local f9_local0 = BGB4
		if IsElementInFocus(f9_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f9_local0, f1_arg1)
		end
	end)
	self:addElement(BGB4)
	self.BGB4 = BGB4
	local BGB3 = CoD.ZMLoadoutPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 136, 204, 0, 0, 242, 310)
	BGB3.itemImage:setScale(1.2, 1.2)
	BGB3:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Down", function(model)
		BGB3:setModel(model, f1_arg1)
	end)
	BGB3:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f11_local0
	end)
	BGB3:subscribeToGlobalModel(f1_arg1, "PerController", "BGBLoadout.Down", function(model)
		local f12_local0 = BGB3
		if IsElementInFocus(f12_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f12_local0, f1_arg1)
		end
	end)
	self:addElement(BGB3)
	self.BGB3 = BGB3
	local BGB2 = CoD.ZMLoadoutPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 68, 136, 0, 0, 242, 310)
	BGB2.itemImage:setScale(1.2, 1.2)
	BGB2:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Right", function(model)
		BGB2:setModel(model, f1_arg1)
	end)
	BGB2:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f14_local0
	end)
	BGB2:subscribeToGlobalModel(f1_arg1, "PerController", "BGBLoadout.Right", function(model)
		local f15_local0 = BGB2
		if IsElementInFocus(f15_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f15_local0, f1_arg1)
		end
	end)
	self:addElement(BGB2)
	self.BGB2 = BGB2
	local BGB1 = CoD.ZMLoadoutPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 0, 68, 0, 0, 242, 310)
	BGB1.itemImage:setScale(1.2, 1.2)
	BGB1:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Up", function(model)
		BGB1:setModel(model, f1_arg1)
	end)
	BGB1:registerEventHandler("gain_focus", function(element, event)
		local f17_local0 = nil
		if element.gainFocus then
			f17_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f17_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f17_local0
	end)
	BGB1:subscribeToGlobalModel(f1_arg1, "PerController", "BGBLoadout.Up", function(model)
		local f18_local0 = BGB1
		if IsElementInFocus(f18_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f18_local0, f1_arg1)
		end
	end)
	self:addElement(BGB1)
	self.BGB1 = BGB1
	local Talisman = CoD.ZMLoadoutPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 0, 272, 0, 0, 160, 242)
	Talisman:mergeStateConditions({
		{
			stateName = "ShowName",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	Talisman.itemImage:setScale(1.04, 1.04)
	Talisman:linkToElementModel(self, "talisman1", false, function(model)
		Talisman:setModel(model, f1_arg1)
	end)
	Talisman:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f21_local0
	end)
	Talisman:linkToElementModel(self, "talisman1", true, function(model)
		local f22_local0 = Talisman
		if IsElementInFocus(f22_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f22_local0, f1_arg1)
		end
	end)
	self:addElement(Talisman)
	self.Talisman = Talisman
	local Equipment = CoD.ZMLoadoutPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 136, 272, 0, 0, 100, 160)
	Equipment.itemImage:setScale(0.9, 0.9)
	Equipment:linkToElementModel(self, "primarygrenade", false, function(model)
		Equipment:setModel(model, f1_arg1)
	end)
	Equipment:registerEventHandler("gain_focus", function(element, event)
		local f24_local0 = nil
		if element.gainFocus then
			f24_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f24_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f24_local0
	end)
	Equipment:linkToElementModel(self, "primarygrenade", true, function(model)
		local f25_local0 = Equipment
		if IsElementInFocus(f25_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f25_local0, f1_arg1)
		end
	end)
	self:addElement(Equipment)
	self.Equipment = Equipment
	local StartWeapon = CoD.ZMLoadoutPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 0, 136, 0, 0, 100, 160)
	StartWeapon.itemImage:setScale(0.9, 0.9)
	StartWeapon:linkToElementModel(self, "primary", false, function(model)
		StartWeapon:setModel(model, f1_arg1)
	end)
	StartWeapon:registerEventHandler("gain_focus", function(element, event)
		local f27_local0 = nil
		if element.gainFocus then
			f27_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f27_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f27_local0
	end)
	StartWeapon:linkToElementModel(self, "primary", true, function(model)
		local f28_local0 = StartWeapon
		if IsElementInFocus(f28_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f28_local0, f1_arg1)
		end
	end)
	self:addElement(StartWeapon)
	self.StartWeapon = StartWeapon
	local SpecialWeapon = CoD.ZMLoadoutPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 0, 272, 0, 0, 0, 100)
	SpecialWeapon.itemImage:setScale(1.66, 1.66)
	SpecialWeapon:linkToElementModel(self, "herogadget", false, function(model)
		SpecialWeapon:setModel(model, f1_arg1)
	end)
	SpecialWeapon:registerEventHandler("gain_focus", function(element, event)
		local f30_local0 = nil
		if element.gainFocus then
			f30_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f30_local0 = element.super:gainFocus(event)
		end
		CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, element, f1_arg1)
		return f30_local0
	end)
	SpecialWeapon:linkToElementModel(self, "heroGadget", true, function(model)
		local f31_local0 = SpecialWeapon
		if IsElementInFocus(f31_local0) then
			CoD.ZombieUtility.SetZMLoadoutPreviewInfoElement(self, f31_local0, f1_arg1)
		end
	end)
	self:addElement(SpecialWeapon)
	self.SpecialWeapon = SpecialWeapon
	local ChooseClassLockedOverlay = CoD.ZMLoadoutPreviewLockedOverlay.new(f1_arg0, f1_arg1, 0.5, 0.5, -136, 136, 1, 1, -379, 0)
	ChooseClassLockedOverlay:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsCurrentPreviewClassLocked(element, f1_arg1)
			end,
		},
	})
	ChooseClassLockedOverlay:linkToElementModel(ChooseClassLockedOverlay, nil, true, function(model)
		f1_arg0:updateElementState(ChooseClassLockedOverlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	ChooseClassLockedOverlay:linkToElementModel(self, nil, false, function(model)
		ChooseClassLockedOverlay:setModel(model, f1_arg1)
	end)
	self:addElement(ChooseClassLockedOverlay)
	self.ChooseClassLockedOverlay = ChooseClassLockedOverlay
	self:mergeStateConditions({
		{
			stateName = "ClassLocked",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsCurrentPreviewClassLocked(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	PerkList.id = "PerkList"
	BGB4.id = "BGB4"
	BGB3.id = "BGB3"
	BGB2.id = "BGB2"
	BGB1.id = "BGB1"
	Talisman.id = "Talisman"
	Equipment.id = "Equipment"
	StartWeapon.id = "StartWeapon"
	SpecialWeapon.id = "SpecialWeapon"
	if CoD.isPC then
		ChooseClassLockedOverlay.id = "ChooseClassLockedOverlay"
	end
	self.__defaultFocus = SpecialWeapon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local11 = self
	UpdateDataSource(self, PerkList, f1_arg1)
	return self
end
CoD.ZMLoadoutPreview.__resetProperties = function(f37_arg0)
	f37_arg0.PerkList:completeAnimation()
	f37_arg0.BGB4:completeAnimation()
	f37_arg0.BGB3:completeAnimation()
	f37_arg0.BGB2:completeAnimation()
	f37_arg0.BGB1:completeAnimation()
	f37_arg0.Talisman:completeAnimation()
	f37_arg0.Equipment:completeAnimation()
	f37_arg0.StartWeapon:completeAnimation()
	f37_arg0.SpecialWeapon:completeAnimation()
	f37_arg0.PerkList:setAlpha(1)
	f37_arg0.BGB4:setAlpha(1)
	f37_arg0.BGB3:setAlpha(1)
	f37_arg0.BGB2:setAlpha(1)
	f37_arg0.BGB1:setAlpha(1)
	f37_arg0.Talisman:setAlpha(1)
	f37_arg0.Equipment:setAlpha(1)
	f37_arg0.StartWeapon:setAlpha(1)
	f37_arg0.SpecialWeapon:setAlpha(1)
end
CoD.ZMLoadoutPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(0)
		end,
	},
	ClassLocked = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(9)
			f39_arg0.PerkList:completeAnimation()
			f39_arg0.PerkList:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.PerkList)
			f39_arg0.BGB4:completeAnimation()
			f39_arg0.BGB4:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.BGB4)
			f39_arg0.BGB3:completeAnimation()
			f39_arg0.BGB3:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.BGB3)
			f39_arg0.BGB2:completeAnimation()
			f39_arg0.BGB2:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.BGB2)
			f39_arg0.BGB1:completeAnimation()
			f39_arg0.BGB1:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.BGB1)
			f39_arg0.Talisman:completeAnimation()
			f39_arg0.Talisman:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.Talisman)
			f39_arg0.Equipment:completeAnimation()
			f39_arg0.Equipment:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.Equipment)
			f39_arg0.StartWeapon:completeAnimation()
			f39_arg0.StartWeapon:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.StartWeapon)
			f39_arg0.SpecialWeapon:completeAnimation()
			f39_arg0.SpecialWeapon:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.SpecialWeapon)
		end,
	},
}
CoD.ZMLoadoutPreview.__onClose = function(f40_arg0)
	f40_arg0.PerkList:close()
	f40_arg0.BGB4:close()
	f40_arg0.BGB3:close()
	f40_arg0.BGB2:close()
	f40_arg0.BGB1:close()
	f40_arg0.Talisman:close()
	f40_arg0.Equipment:close()
	f40_arg0.StartWeapon:close()
	f40_arg0.SpecialWeapon:close()
	f40_arg0.ChooseClassLockedOverlay:close()
end
