require("x64:2dee1d9f1ec4c33")
require("x64:f5e1dce43cc9eb3")
CoD.SignatureWeaponGridItem = InheritFrom(LUI.UIElement)
CoD.SignatureWeaponGridItem.__defaultWidth = 274
CoD.SignatureWeaponGridItem.__defaultHeight = 126
CoD.SignatureWeaponGridItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SignatureWeaponGridItem)
	self.id = "SignatureWeaponGridItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponSelectGridItemInternal = CoD.WeaponSelectGridItemInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 274, 0, 0, 0, 126)
	WeaponSelectGridItemInternal:mergeStateConditions({
		{
			stateName = "LootNotOwned",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "owned")
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsSignatureWeaponLockedByProgression(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsSignatureWeaponNew(menu, element, f1_arg1)
			end,
		},
	})
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "owned", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "selected", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
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
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "weaponNameHash", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponNameHash",
		})
	end)
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "weaponModelSlotIndex", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponModelSlotIndex",
		})
	end)
	WeaponSelectGridItemInternal.WeaponLevel:setAlpha(0)
	WeaponSelectGridItemInternal:linkToElementModel(self, nil, false, function(model)
		WeaponSelectGridItemInternal:setModel(model, f1_arg1)
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, "displayImage", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			WeaponSelectGridItemInternal.WeaponImage:setImage(CoD.BaseUtility.AlreadyRegistered(f12_local0))
		end
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, "displayName", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			WeaponSelectGridItemInternal.WeaponName.WeaponName:setText(LocalizeToUpperString(f13_local0))
		end
	end)
	WeaponSelectGridItemInternal:registerEventHandler("lose_focus", function(element, event)
		local f14_local0 = nil
		if element.loseFocus then
			f14_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f14_local0 = element.super:loseFocus(event)
		end
		CoD.BreadcrumbUtility.SetSignatureWeaponAsOld(f1_arg0, element, f1_arg1)
		UpdateElementState(self, "WeaponSelectGridItemInternal", f1_arg1)
		return f14_local0
	end)
	WeaponSelectGridItemInternal:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		if CoD.CACUtility.IsMark2Weapon(f1_arg1, self) then
			SetControllerModelValue(f1_arg1, "hudItems.previewingMK2Weapon", 1)
		else
			SetControllerModelValue(f1_arg1, "hudItems.previewingMK2Weapon", 0)
		end
		return f15_local0
	end)
	self:addElement(WeaponSelectGridItemInternal)
	self.WeaponSelectGridItemInternal = WeaponSelectGridItemInternal
	local MastercraftDetailsHintText = CoD.ItemHintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -146, 146, 0, 0, 146, 191)
	MastercraftDetailsHintText:mergeStateConditions({
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "ref")
			end,
		},
	})
	MastercraftDetailsHintText:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(MastercraftDetailsHintText, f17_arg1)
	end)
	local f1_local3 = MastercraftDetailsHintText
	local f1_local4 = MastercraftDetailsHintText.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(MastercraftDetailsHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	MastercraftDetailsHintText:linkToElementModel(MastercraftDetailsHintText, "ref", true, function(model)
		f1_arg0:updateElementState(MastercraftDetailsHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ref",
		})
	end)
	MastercraftDetailsHintText:setAlpha(0)
	MastercraftDetailsHintText.textCenterAlign:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/details_button"))
	MastercraftDetailsHintText:linkToElementModel(self, nil, false, function(model)
		MastercraftDetailsHintText:setModel(model, f1_arg1)
	end)
	self:addElement(MastercraftDetailsHintText)
	self.MastercraftDetailsHintText = MastercraftDetailsHintText
	WeaponSelectGridItemInternal.id = "WeaponSelectGridItemInternal"
	self.__defaultFocus = WeaponSelectGridItemInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SignatureWeaponGridItem.__resetProperties = function(f21_arg0)
	f21_arg0.MastercraftDetailsHintText:completeAnimation()
	f21_arg0.MastercraftDetailsHintText:setAlpha(0)
end
CoD.SignatureWeaponGridItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.MastercraftDetailsHintText:completeAnimation()
			f23_arg0.MastercraftDetailsHintText:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.MastercraftDetailsHintText)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.MastercraftDetailsHintText:beginAnimation(200)
				f24_arg0.MastercraftDetailsHintText:setAlpha(1)
				f24_arg0.MastercraftDetailsHintText:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.MastercraftDetailsHintText:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.MastercraftDetailsHintText:completeAnimation()
			f24_arg0.MastercraftDetailsHintText:setAlpha(0)
			f24_local0(f24_arg0.MastercraftDetailsHintText)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.MastercraftDetailsHintText:beginAnimation(200)
				f26_arg0.MastercraftDetailsHintText:setAlpha(0)
				f26_arg0.MastercraftDetailsHintText:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.MastercraftDetailsHintText:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.MastercraftDetailsHintText:completeAnimation()
			f26_arg0.MastercraftDetailsHintText:setAlpha(1)
			f26_local0(f26_arg0.MastercraftDetailsHintText)
		end,
	},
}
CoD.SignatureWeaponGridItem.__onClose = function(f28_arg0)
	f28_arg0.WeaponSelectGridItemInternal:close()
	f28_arg0.MastercraftDetailsHintText:close()
end
