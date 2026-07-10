CoD.WeaponVariantPipInternal = InheritFrom(LUI.UIElement)
CoD.WeaponVariantPipInternal.__defaultWidth = 16
CoD.WeaponVariantPipInternal.__defaultHeight = 16
CoD.WeaponVariantPipInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponVariantPipInternal)
	self.id = "WeaponVariantPipInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Pip = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Pip:setImage(RegisterImage(0xEEA1EF8036976B6))
	self:addElement(Pip)
	self.Pip = Pip
	self:mergeStateConditions({
		{
			stateName = "Mark2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isMark2")
			end,
		},
		{
			stateName = "Mastercraft",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "weaponModelSlotIndex", 0)
			end,
		},
	})
	self:linkToElementModel(self, "isMark2", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isMark2",
		})
	end)
	self:linkToElementModel(self, "weaponModelSlotIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponModelSlotIndex",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponVariantPipInternal.__resetProperties = function(f6_arg0)
	f6_arg0.Pip:completeAnimation()
	f6_arg0.Pip:setRGB(1, 1, 1)
end
CoD.WeaponVariantPipInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Pip:completeAnimation()
			f7_arg0.Pip:setRGB(1, 1, 1)
			f7_arg0.clipFinished(f7_arg0.Pip)
		end,
	},
	Mark2 = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Pip:completeAnimation()
			f8_arg0.Pip:setRGB(1, 1, 1)
			f8_arg0.clipFinished(f8_arg0.Pip)
		end,
	},
	Mastercraft = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Pip:completeAnimation()
			f9_arg0.Pip:setRGB(1, 1, 1)
			f9_arg0.clipFinished(f9_arg0.Pip)
		end,
	},
}
