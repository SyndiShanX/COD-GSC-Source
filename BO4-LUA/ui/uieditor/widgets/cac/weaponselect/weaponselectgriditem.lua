require("x64:f5e1dce43cc9eb3")
CoD.WeaponSelectGridItem = InheritFrom(LUI.UIElement)
CoD.WeaponSelectGridItem.__defaultWidth = 274
CoD.WeaponSelectGridItem.__defaultHeight = 126
CoD.WeaponSelectGridItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "weaponSelectItemIndex", 0)
	self:setClass(CoD.WeaponSelectGridItem)
	self.id = "WeaponSelectGridItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponSelectGridItemInternal = CoD.WeaponSelectGridItemInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 126)
	WeaponSelectGridItemInternal:mergeStateConditions({
		{
			stateName = "LootNotOwned",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsItemEquippedInCurrentSlot(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsItemNew(menu, element, f1_arg1)
			end,
		},
	})
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "refHash", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refHash",
		})
	end)
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "itemIndex", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, nil, false, function(model)
		WeaponSelectGridItemInternal:setModel(model, f1_arg1)
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, "image", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			WeaponSelectGridItemInternal.WeaponImage:setImage(CoD.BaseUtility.AlreadyRegistered(f10_local0))
		end
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, nil, false, function(model)
		WeaponSelectGridItemInternal.ItemHintText:setModel(model, f1_arg1)
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, "hintText", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			WeaponSelectGridItemInternal.ItemHintText.textCenterAlign:setText(f12_local0)
		end
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, nil, false, function(model)
		WeaponSelectGridItemInternal.RestrictedIcon:setModel(model, f1_arg1)
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, "displayName", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			WeaponSelectGridItemInternal.WeaponName.WeaponName:setText(LocalizeToUpperString(f14_local0))
		end
	end)
	WeaponSelectGridItemInternal:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		if IsPC() and IsMouse(f1_arg1) and CoD.CACUtility.HasSignatureWeapons(f1_arg0, element, f1_arg1) and CoD.CACUtility.IsMark2Weapon(f1_arg1, self) then
			SetControllerModelValue(f1_arg1, "hudItems.previewingMK2Weapon", 1)
			CoD.FreeCursorUtility.RetriggerCursorPosition(element, f1_arg1)
		elseif IsPC() and IsMouse(f1_arg1) and CoD.CACUtility.HasSignatureWeapons(f1_arg0, element, f1_arg1) then
			SetControllerModelValue(f1_arg1, "hudItems.previewingMK2Weapon", 0)
			CoD.FreeCursorUtility.RetriggerCursorPosition(element, f1_arg1)
		elseif CoD.CACUtility.IsMark2Weapon(f1_arg1, self) then
			SetControllerModelValue(f1_arg1, "hudItems.previewingMK2Weapon", 1)
		else
			SetControllerModelValue(f1_arg1, "hudItems.previewingMK2Weapon", 0)
		end
		return f15_local0
	end)
	WeaponSelectGridItemInternal:registerEventHandler("lose_focus", function(element, event)
		local f16_local0 = nil
		if element.loseFocus then
			f16_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f16_local0 = element.super:loseFocus(event)
		end
		if IsElementInState(element, "New") then
			CoD.BreadcrumbUtility.SetLootWeaponAsOld(f1_arg0, element, f1_arg1)
			UpdateElementState(self, "WeaponSelectGridItemInternal", f1_arg1)
		end
		return f16_local0
	end)
	self:addElement(WeaponSelectGridItemInternal)
	self.WeaponSelectGridItemInternal = WeaponSelectGridItemInternal
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.BaseUtility.SetControllerModelToSelfModelValue(f1_arg1, element, "weaponSelectItemIndex", "itemIndex")
	end)
	WeaponSelectGridItemInternal.id = "WeaponSelectGridItemInternal"
	self.__defaultFocus = WeaponSelectGridItemInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponSelectGridItem.__resetProperties = function(f19_arg0)
	f19_arg0.WeaponSelectGridItemInternal:completeAnimation()
	f19_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
end
CoD.WeaponSelectGridItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f21_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.WeaponSelectGridItemInternal)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.WeaponSelectGridItemInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f22_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
				f22_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f22_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
			f22_local0(f22_arg0.WeaponSelectGridItemInternal)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.WeaponSelectGridItemInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f24_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
				f24_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f24_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f24_local0(f24_arg0.WeaponSelectGridItemInternal)
		end,
	},
	PC = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WeaponSelectGridItem.__onClose = function(f27_arg0)
	f27_arg0.WeaponSelectGridItemInternal:close()
end
