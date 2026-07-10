require("x64:3e5e2d573b37ba")
CoD.StartMenu_InventoryDescription_Internal = InheritFrom(LUI.UIElement)
CoD.StartMenu_InventoryDescription_Internal.__defaultWidth = 600
CoD.StartMenu_InventoryDescription_Internal.__defaultHeight = 383
CoD.StartMenu_InventoryDescription_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_InventoryDescription_Internal)
	self.id = "StartMenu_InventoryDescription_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 383)
	backing:setRGB(0.45, 0.45, 0.45)
	backing:setAlpha(0)
	self:addElement(backing)
	self.backing = backing
	local description = LUI.UIText.new(0, 0.89, 0, 0, 0, 0, 3, 23)
	description:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	description:setTTF("ttmussels_regular")
	description:setLetterSpacing(1)
	description:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	description:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	description:linkToElementModel(self, "description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			description:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(description)
	self.description = description
	local DamageAttribute = CoD.WeaponAttributeStat.new(f1_arg0, f1_arg1, 1, 1, -452, -15, 0, 0, 92.5, 110.5)
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
	DamageAttribute:linkToElementModel(self, "attributes.damage", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DamageAttribute.weaponAttribute:setShaderVector(0, GetWeaponAttributes(f1_arg0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	DamageAttribute:linkToElementModel(self, "attributes.damage", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			DamageAttribute.attachmentAttribute:setShaderVector(0, GetWeaponAttributesForAttachment(f1_arg0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	self:addElement(DamageAttribute)
	self.DamageAttribute = DamageAttribute
	local RangeAttribute = CoD.WeaponAttributeStat.new(f1_arg0, f1_arg1, 1, 1, -452, -15, 0, 0, 115.5, 133.5)
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
	RangeAttribute:linkToElementModel(self, "attributes.range", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			RangeAttribute.weaponAttribute:setShaderVector(0, GetWeaponAttributes(f1_arg0, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4)))
		end
	end)
	RangeAttribute:linkToElementModel(self, "attributes.range", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			RangeAttribute.attachmentAttribute:setShaderVector(0, GetWeaponAttributesForAttachment(f1_arg0, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4)))
		end
	end)
	self:addElement(RangeAttribute)
	self.RangeAttribute = RangeAttribute
	local FireRateAttribute = CoD.WeaponAttributeStat.new(f1_arg0, f1_arg1, 1, 1, -452, -15, 0, 0, 138.5, 156.5)
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
	FireRateAttribute:linkToElementModel(self, "attributes.fireRate", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			FireRateAttribute.weaponAttribute:setShaderVector(0, GetWeaponAttributes(f1_arg0, CoD.GetVectorComponentFromString(f13_local0, 1), CoD.GetVectorComponentFromString(f13_local0, 2), CoD.GetVectorComponentFromString(f13_local0, 3), CoD.GetVectorComponentFromString(f13_local0, 4)))
		end
	end)
	FireRateAttribute:linkToElementModel(self, "attributes.fireRate", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			FireRateAttribute.attachmentAttribute:setShaderVector(0, GetWeaponAttributesForAttachment(f1_arg0, CoD.GetVectorComponentFromString(f14_local0, 1), CoD.GetVectorComponentFromString(f14_local0, 2), CoD.GetVectorComponentFromString(f14_local0, 3), CoD.GetVectorComponentFromString(f14_local0, 4)))
		end
	end)
	self:addElement(FireRateAttribute)
	self.FireRateAttribute = FireRateAttribute
	local AccuracyAttribute = CoD.WeaponAttributeStat.new(f1_arg0, f1_arg1, 1, 1, -452, -15, 0, 0, 161.5, 179.5)
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
	AccuracyAttribute:linkToElementModel(self, "attributes.accuracy", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			AccuracyAttribute.weaponAttribute:setShaderVector(0, GetWeaponAttributes(f1_arg0, CoD.GetVectorComponentFromString(f17_local0, 1), CoD.GetVectorComponentFromString(f17_local0, 2), CoD.GetVectorComponentFromString(f17_local0, 3), CoD.GetVectorComponentFromString(f17_local0, 4)))
		end
	end)
	AccuracyAttribute:linkToElementModel(self, "attributes.accuracy", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			AccuracyAttribute.attachmentAttribute:setShaderVector(0, GetWeaponAttributesForAttachment(f1_arg0, CoD.GetVectorComponentFromString(f18_local0, 1), CoD.GetVectorComponentFromString(f18_local0, 2), CoD.GetVectorComponentFromString(f18_local0, 3), CoD.GetVectorComponentFromString(f18_local0, 4)))
		end
	end)
	self:addElement(AccuracyAttribute)
	self.AccuracyAttribute = AccuracyAttribute
	self:mergeStateConditions({
		{
			stateName = "WeaponStats",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "attributes.valid")
			end,
		},
		{
			stateName = "DefaultAsianLanguages",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	self:linkToElementModel(self, "attributes.valid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "attributes.valid",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_InventoryDescription_Internal.__resetProperties = function(f22_arg0)
	f22_arg0.DamageAttribute:completeAnimation()
	f22_arg0.RangeAttribute:completeAnimation()
	f22_arg0.FireRateAttribute:completeAnimation()
	f22_arg0.AccuracyAttribute:completeAnimation()
	f22_arg0.backing:completeAnimation()
	f22_arg0.description:completeAnimation()
	f22_arg0.DamageAttribute:setAlpha(1)
	f22_arg0.RangeAttribute:setAlpha(1)
	f22_arg0.FireRateAttribute:setAlpha(1)
	f22_arg0.AccuracyAttribute:setAlpha(1)
	f22_arg0.backing:setTopBottom(0, 0, 0, 383)
	f22_arg0.description:setTopBottom(0, 0, 3, 23)
	f22_arg0.description:setLetterSpacing(1)
end
CoD.StartMenu_InventoryDescription_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			f23_arg0.backing:completeAnimation()
			f23_arg0.backing:setTopBottom(0, 0, 0, 178)
			f23_arg0.clipFinished(f23_arg0.backing)
			f23_arg0.DamageAttribute:completeAnimation()
			f23_arg0.DamageAttribute:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.DamageAttribute)
			f23_arg0.RangeAttribute:completeAnimation()
			f23_arg0.RangeAttribute:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RangeAttribute)
			f23_arg0.FireRateAttribute:completeAnimation()
			f23_arg0.FireRateAttribute:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FireRateAttribute)
			f23_arg0.AccuracyAttribute:completeAnimation()
			f23_arg0.AccuracyAttribute:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.AccuracyAttribute)
		end,
	},
	WeaponStats = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.backing:completeAnimation()
			f24_arg0.backing:setTopBottom(0, 0, 0, 221)
			f24_arg0.clipFinished(f24_arg0.backing)
		end,
	},
	DefaultAsianLanguages = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(6)
			f25_arg0.backing:completeAnimation()
			f25_arg0.backing:setTopBottom(0, 0, 0, 221)
			f25_arg0.clipFinished(f25_arg0.backing)
			f25_arg0.description:completeAnimation()
			f25_arg0.description:setTopBottom(0, 0, 3, 15)
			f25_arg0.description:setLetterSpacing(2)
			f25_arg0.clipFinished(f25_arg0.description)
			f25_arg0.DamageAttribute:completeAnimation()
			f25_arg0.DamageAttribute:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.DamageAttribute)
			f25_arg0.RangeAttribute:completeAnimation()
			f25_arg0.RangeAttribute:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RangeAttribute)
			f25_arg0.FireRateAttribute:completeAnimation()
			f25_arg0.FireRateAttribute:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.FireRateAttribute)
			f25_arg0.AccuracyAttribute:completeAnimation()
			f25_arg0.AccuracyAttribute:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.AccuracyAttribute)
		end,
	},
}
CoD.StartMenu_InventoryDescription_Internal.__onClose = function(f26_arg0)
	f26_arg0.description:close()
	f26_arg0.DamageAttribute:close()
	f26_arg0.RangeAttribute:close()
	f26_arg0.FireRateAttribute:close()
	f26_arg0.AccuracyAttribute:close()
end
