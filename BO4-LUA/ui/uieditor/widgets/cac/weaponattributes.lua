require("x64:e4f4fd1023f5306")
require("x64:8b6d473440aa0a2")
require("x64:3e5e2d573b37ba")
require("x64:f2e8f6288093f9b")
CoD.WeaponAttributes = InheritFrom(LUI.UIElement)
CoD.WeaponAttributes.__defaultWidth = 445
CoD.WeaponAttributes.__defaultHeight = 250
CoD.WeaponAttributes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponAttributes)
	self.id = "WeaponAttributes"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DamageAttribute = CoD.WeaponAttributeStat.new(f1_arg0, f1_arg1, 0, 0, 0, 437, 0, 0, 60, 78)
	DamageAttribute:mergeStateConditions({
		{
			stateName = "Increase",
			condition = function(menu, element, event)
				return IsCACWeaponAttributeIncrease(element, f1_arg1, "damage")
			end,
		},
	})
	DamageAttribute:linkToElementModel(DamageAttribute, "damage", true, function(model)
		f1_arg0:updateElementState(DamageAttribute, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "damage",
		})
	end)
	DamageAttribute.attributeName:setText(LocalizeToUpperString(@"hash_6CFFC6656E99316E"))
	DamageAttribute:linkToElementModel(self, nil, false, function(model)
		DamageAttribute:setModel(model, f1_arg1)
	end)
	DamageAttribute:linkToElementModel(self, "damage", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DamageAttribute.weaponAttribute:setShaderVector(0, GetWeaponAttributes(f1_arg0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	DamageAttribute:linkToElementModel(self, "damage", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			DamageAttribute.attachmentAttribute:setShaderVector(0, GetWeaponAttributesForAttachment(f1_arg0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	self:addElement(DamageAttribute)
	self.DamageAttribute = DamageAttribute
	local RangeAttribute = CoD.WeaponAttributeStat.new(f1_arg0, f1_arg1, 0, 0, 0, 437, 0, 0, 82, 100)
	RangeAttribute:mergeStateConditions({
		{
			stateName = "Increase",
			condition = function(menu, element, event)
				return IsCACWeaponAttributeIncrease(element, f1_arg1, "range")
			end,
		},
	})
	RangeAttribute:linkToElementModel(RangeAttribute, "range", true, function(model)
		f1_arg0:updateElementState(RangeAttribute, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "range",
		})
	end)
	RangeAttribute.attributeName:setText(LocalizeToUpperString(@"hash_7470B2F1C3BDE7F4"))
	RangeAttribute:linkToElementModel(self, nil, false, function(model)
		RangeAttribute:setModel(model, f1_arg1)
	end)
	RangeAttribute:linkToElementModel(self, "range", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			RangeAttribute.weaponAttribute:setShaderVector(0, GetWeaponAttributes(f1_arg0, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4)))
		end
	end)
	RangeAttribute:linkToElementModel(self, "range", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			RangeAttribute.attachmentAttribute:setShaderVector(0, GetWeaponAttributesForAttachment(f1_arg0, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4)))
		end
	end)
	self:addElement(RangeAttribute)
	self.RangeAttribute = RangeAttribute
	local FireRateAttribute = CoD.WeaponAttributeStat.new(f1_arg0, f1_arg1, 0, 0, 0, 437, 0, 0, 104, 122)
	FireRateAttribute:mergeStateConditions({
		{
			stateName = "Increase",
			condition = function(menu, element, event)
				return IsCACWeaponAttributeIncrease(element, f1_arg1, "fireRate")
			end,
		},
	})
	FireRateAttribute:linkToElementModel(FireRateAttribute, "fireRate", true, function(model)
		f1_arg0:updateElementState(FireRateAttribute, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "fireRate",
		})
	end)
	FireRateAttribute.attributeName:setText(LocalizeToUpperString(@"hash_2A995770D23477EE"))
	FireRateAttribute:linkToElementModel(self, nil, false, function(model)
		FireRateAttribute:setModel(model, f1_arg1)
	end)
	FireRateAttribute:linkToElementModel(self, "fireRate", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			FireRateAttribute.weaponAttribute:setShaderVector(0, GetWeaponAttributes(f1_arg0, CoD.GetVectorComponentFromString(f15_local0, 1), CoD.GetVectorComponentFromString(f15_local0, 2), CoD.GetVectorComponentFromString(f15_local0, 3), CoD.GetVectorComponentFromString(f15_local0, 4)))
		end
	end)
	FireRateAttribute:linkToElementModel(self, "fireRate", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			FireRateAttribute.attachmentAttribute:setShaderVector(0, GetWeaponAttributesForAttachment(f1_arg0, CoD.GetVectorComponentFromString(f16_local0, 1), CoD.GetVectorComponentFromString(f16_local0, 2), CoD.GetVectorComponentFromString(f16_local0, 3), CoD.GetVectorComponentFromString(f16_local0, 4)))
		end
	end)
	self:addElement(FireRateAttribute)
	self.FireRateAttribute = FireRateAttribute
	local AccuracyAttribute = CoD.WeaponAttributeStat.new(f1_arg0, f1_arg1, 0, 0, 0, 437, 0, 0, 126, 144)
	AccuracyAttribute:mergeStateConditions({
		{
			stateName = "Increase",
			condition = function(menu, element, event)
				return IsCACWeaponAttributeIncrease(element, f1_arg1, "accuracy")
			end,
		},
	})
	AccuracyAttribute:linkToElementModel(AccuracyAttribute, "accuracy", true, function(model)
		f1_arg0:updateElementState(AccuracyAttribute, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "accuracy",
		})
	end)
	AccuracyAttribute.attributeName:setText(LocalizeToUpperString(@"hash_4F669512DF581896"))
	AccuracyAttribute:linkToElementModel(self, nil, false, function(model)
		AccuracyAttribute:setModel(model, f1_arg1)
	end)
	AccuracyAttribute:linkToElementModel(self, "accuracy", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			AccuracyAttribute.weaponAttribute:setShaderVector(0, GetWeaponAttributes(f1_arg0, CoD.GetVectorComponentFromString(f20_local0, 1), CoD.GetVectorComponentFromString(f20_local0, 2), CoD.GetVectorComponentFromString(f20_local0, 3), CoD.GetVectorComponentFromString(f20_local0, 4)))
		end
	end)
	AccuracyAttribute:linkToElementModel(self, "accuracy", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			AccuracyAttribute.attachmentAttribute:setShaderVector(0, GetWeaponAttributesForAttachment(f1_arg0, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4)))
		end
	end)
	self:addElement(AccuracyAttribute)
	self.AccuracyAttribute = AccuracyAttribute
	local MagCountAttribute = CoD.WeaponAttributeValueStat.new(f1_arg0, f1_arg1, 0, 0, 151, 251, 0, 0, 154, 172)
	MagCountAttribute:mergeStateConditions({
		{
			stateName = "PositiveAddValue",
			condition = function(menu, element, event)
				return IsCACWeaponAttributeAddedValuePositive(self, element, f1_arg1, "magCount")
			end,
		},
	})
	MagCountAttribute:linkToElementModel(MagCountAttribute, "magCount", true, function(model)
		f1_arg0:updateElementState(MagCountAttribute, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "magCount",
		})
	end)
	MagCountAttribute:linkToElementModel(self, nil, false, function(model)
		MagCountAttribute:setModel(model, f1_arg1)
	end)
	MagCountAttribute:linkToElementModel(self, "magCount", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			MagCountAttribute.AttributeBaseValue:setText(GetWeaponAttributeBaseValueForAttachment(self, f25_local0))
		end
	end)
	MagCountAttribute:linkToElementModel(self, "magCount", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			MagCountAttribute.AttributeAddedValue:setText(GetWeaponAttributeAddedValueForAttachment(self, f26_local0))
		end
	end)
	self:addElement(MagCountAttribute)
	self.MagCountAttribute = MagCountAttribute
	local MagSizeAttribute = CoD.WeaponAttributeValueStat.new(f1_arg0, f1_arg1, 0, 0, 375, 475, 0, 0, 154, 172)
	MagSizeAttribute:mergeStateConditions({
		{
			stateName = "PositiveAddValue",
			condition = function(menu, element, event)
				return IsCACWeaponAttributeAddedValuePositive(self, element, f1_arg1, "magSize")
			end,
		},
	})
	MagSizeAttribute:linkToElementModel(MagSizeAttribute, "magSize", true, function(model)
		f1_arg0:updateElementState(MagSizeAttribute, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "magSize",
		})
	end)
	MagSizeAttribute:linkToElementModel(self, nil, false, function(model)
		MagSizeAttribute:setModel(model, f1_arg1)
	end)
	MagSizeAttribute:linkToElementModel(self, "magSize", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			MagSizeAttribute.AttributeBaseValue:setText(GetWeaponAttributeBaseValueForAttachment(self, f30_local0))
		end
	end)
	MagSizeAttribute:linkToElementModel(self, "magSize", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			MagSizeAttribute.AttributeAddedValue:setText(GetWeaponAttributeAddedValueForAttachment(self, f31_local0))
		end
	end)
	self:addElement(MagSizeAttribute)
	self.MagSizeAttribute = MagSizeAttribute
	local MagCountName = LUI.UIText.new(0, 0, 9, 139, 0, 0, 154, 172)
	MagCountName:setRGB(0.39, 0.39, 0.39)
	MagCountName:setText(LocalizeToUpperString(@"weapon/mags"))
	MagCountName:setTTF("ttmussels_regular")
	MagCountName:setLetterSpacing(3)
	MagCountName:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(MagCountName)
	self.MagCountName = MagCountName
	local UberAttachmentName = LUI.UIText.new(0, 0, 234, 364, 0, 0, 154, 172)
	UberAttachmentName:setRGB(0.39, 0.39, 0.39)
	UberAttachmentName:setText(LocalizeToUpperString(@"hash_4D3E9656E7289B9B"))
	UberAttachmentName:setTTF("ttmussels_regular")
	UberAttachmentName:setLetterSpacing(3)
	UberAttachmentName:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(UberAttachmentName)
	self.UberAttachmentName = UberAttachmentName
	local UberAttachmentIcon = CoD.WeaponAttributeUberInfo.new(f1_arg0, f1_arg1, 0, 0, -5, 245, 0, 0, 164, 228)
	UberAttachmentIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "uberName") and not IsElementPropertyValue(menu, "_loadoutSlot", "zmStartWeapon")
			end,
		},
	})
	UberAttachmentIcon:linkToElementModel(UberAttachmentIcon, "uberName", true, function(model)
		f1_arg0:updateElementState(UberAttachmentIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "uberName",
		})
	end)
	UberAttachmentIcon:linkToElementModel(self, nil, false, function(model)
		UberAttachmentIcon:setModel(model, f1_arg1)
	end)
	self:addElement(UberAttachmentIcon)
	self.UberAttachmentIcon = UberAttachmentIcon
	local MutualExclusiveWarning = CoD.MutualExclusiveWarning.new(f1_arg0, f1_arg1, 0, 0, 121, 496, 0, 0, 24, 61)
	self:addElement(MutualExclusiveWarning)
	self.MutualExclusiveWarning = MutualExclusiveWarning
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponAttributes.__resetProperties = function(f36_arg0)
	f36_arg0.MutualExclusiveWarning:completeAnimation()
	f36_arg0.UberAttachmentIcon:completeAnimation()
	f36_arg0.UberAttachmentName:completeAnimation()
	f36_arg0.MagCountName:completeAnimation()
	f36_arg0.MagSizeAttribute:completeAnimation()
	f36_arg0.MagCountAttribute:completeAnimation()
	f36_arg0.AccuracyAttribute:completeAnimation()
	f36_arg0.FireRateAttribute:completeAnimation()
	f36_arg0.RangeAttribute:completeAnimation()
	f36_arg0.DamageAttribute:completeAnimation()
	f36_arg0.MutualExclusiveWarning:setAlpha(1)
	f36_arg0.UberAttachmentIcon:setAlpha(1)
	f36_arg0.UberAttachmentName:setAlpha(1)
	f36_arg0.MagCountName:setAlpha(1)
	f36_arg0.MagSizeAttribute:setAlpha(1)
	f36_arg0.MagCountAttribute:setAlpha(1)
	f36_arg0.AccuracyAttribute:setAlpha(1)
	f36_arg0.FireRateAttribute:setAlpha(1)
	f36_arg0.RangeAttribute:setAlpha(1)
	f36_arg0.DamageAttribute:setAlpha(1)
end
CoD.WeaponAttributes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(10)
			f38_arg0.DamageAttribute:completeAnimation()
			f38_arg0.DamageAttribute:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.DamageAttribute)
			f38_arg0.RangeAttribute:completeAnimation()
			f38_arg0.RangeAttribute:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.RangeAttribute)
			f38_arg0.FireRateAttribute:completeAnimation()
			f38_arg0.FireRateAttribute:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.FireRateAttribute)
			f38_arg0.AccuracyAttribute:completeAnimation()
			f38_arg0.AccuracyAttribute:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.AccuracyAttribute)
			f38_arg0.MagCountAttribute:completeAnimation()
			f38_arg0.MagCountAttribute:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.MagCountAttribute)
			f38_arg0.MagSizeAttribute:completeAnimation()
			f38_arg0.MagSizeAttribute:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.MagSizeAttribute)
			f38_arg0.MagCountName:completeAnimation()
			f38_arg0.MagCountName:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.MagCountName)
			f38_arg0.UberAttachmentName:completeAnimation()
			f38_arg0.UberAttachmentName:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.UberAttachmentName)
			f38_arg0.UberAttachmentIcon:completeAnimation()
			f38_arg0.UberAttachmentIcon:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.UberAttachmentIcon)
			f38_arg0.MutualExclusiveWarning:completeAnimation()
			f38_arg0.MutualExclusiveWarning:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.MutualExclusiveWarning)
		end,
	},
}
CoD.WeaponAttributes.__onClose = function(f39_arg0)
	f39_arg0.DamageAttribute:close()
	f39_arg0.RangeAttribute:close()
	f39_arg0.FireRateAttribute:close()
	f39_arg0.AccuracyAttribute:close()
	f39_arg0.MagCountAttribute:close()
	f39_arg0.MagSizeAttribute:close()
	f39_arg0.UberAttachmentIcon:close()
	f39_arg0.MutualExclusiveWarning:close()
end
