CoD.ZMEquipmentItemCounter = InheritFrom(LUI.UIElement)
CoD.ZMEquipmentItemCounter.__defaultWidth = 36
CoD.ZMEquipmentItemCounter.__defaultHeight = 24
CoD.ZMEquipmentItemCounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMEquipmentItemCounter)
	self.id = "ZMEquipmentItemCounter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CounterCorner = LUI.UIImage.new(0, 0, 0, 36, 0, 0, 0, 24)
	CounterCorner:setRGB(0, 0, 0)
	CounterCorner:setImage(RegisterImage(@"hash_525AE8AF4C635914"))
	self:addElement(CounterCorner)
	self.CounterCorner = CounterCorner
	local Quantity = LUI.UIText.new(0, 0, 5, 27, 0, 0, 3, 24)
	Quantity:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Quantity:setText(CoD.BaseUtility.AlreadyLocalized("X"))
	Quantity:setTTF("0arame_mono_stencil")
	Quantity:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Quantity:setShaderVector(0, 0.8, 0, 0, 0)
	Quantity:setShaderVector(1, 0, 0, 0, 0)
	Quantity:setShaderVector(2, 1, 1, 1, 0.5)
	Quantity:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	Quantity:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Quantity:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(Quantity)
	self.Quantity = Quantity
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "id")
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMEquipmentItemCounter.__resetProperties = function(f4_arg0)
	f4_arg0.Quantity:completeAnimation()
	f4_arg0.CounterCorner:completeAnimation()
	f4_arg0.Quantity:setAlpha(1)
	f4_arg0.CounterCorner:setAlpha(1)
end
CoD.ZMEquipmentItemCounter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.CounterCorner:completeAnimation()
			f6_arg0.CounterCorner:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CounterCorner)
			f6_arg0.Quantity:completeAnimation()
			f6_arg0.Quantity:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Quantity)
		end,
	},
}
