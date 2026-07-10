CoD.WarzoneAbilityItemCounter = InheritFrom(LUI.UIElement)
CoD.WarzoneAbilityItemCounter.__defaultWidth = 36
CoD.WarzoneAbilityItemCounter.__defaultHeight = 24
CoD.WarzoneAbilityItemCounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneAbilityItemCounter)
	self.id = "WarzoneAbilityItemCounter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CounterCorner = LUI.UIImage.new(0, 0, 0, 36, 0, 0, 0, 24)
	CounterCorner:setRGB(0, 0, 0)
	CounterCorner:setImage(RegisterImage(0x25AE8AF4C635914))
	self:addElement(CounterCorner)
	self.CounterCorner = CounterCorner
	local Quantity = LUI.UIText.new(0, 0, 4, 32, 0, 0, 2.5, 22.5)
	Quantity:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Quantity:setTTF("0arame_mono_stencil")
	Quantity:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Quantity:setShaderVector(0, 0.8, 0, 0, 0)
	Quantity:setShaderVector(1, 0, 0, 0, 0)
	Quantity:setShaderVector(2, 1, 1, 1, 0.5)
	Quantity:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	Quantity:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Quantity:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Quantity:linkToElementModel(self, "stackCount", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Quantity:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(Quantity)
	self.Quantity = Quantity
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "stackCount", 1)
			end,
		},
		{
			stateName = "InvisibleHeavyMetalHeroes",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("warzone_heavy_metal_heroes") and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "id", 0xD794B7E34CF01C9)
			end,
		},
	})
	self:linkToElementModel(self, "stackCount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stackCount",
		})
	end)
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneAbilityItemCounter.__resetProperties = function(f7_arg0)
	f7_arg0.Quantity:completeAnimation()
	f7_arg0.CounterCorner:completeAnimation()
	f7_arg0.Quantity:setAlpha(1)
	f7_arg0.CounterCorner:setAlpha(1)
end
CoD.WarzoneAbilityItemCounter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.CounterCorner:completeAnimation()
			f9_arg0.CounterCorner:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CounterCorner)
			f9_arg0.Quantity:completeAnimation()
			f9_arg0.Quantity:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Quantity)
		end,
	},
	InvisibleHeavyMetalHeroes = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.CounterCorner:completeAnimation()
			f10_arg0.CounterCorner:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CounterCorner)
			f10_arg0.Quantity:completeAnimation()
			f10_arg0.Quantity:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Quantity)
		end,
	},
}
CoD.WarzoneAbilityItemCounter.__onClose = function(f11_arg0)
	f11_arg0.Quantity:close()
end
