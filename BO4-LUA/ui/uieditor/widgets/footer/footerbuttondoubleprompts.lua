CoD.FooterButtonDoublePrompts = InheritFrom(LUI.UIElement)
CoD.FooterButtonDoublePrompts.__defaultWidth = 283
CoD.FooterButtonDoublePrompts.__defaultHeight = 48
CoD.FooterButtonDoublePrompts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButtonDoublePrompts)
	self.id = "FooterButtonDoublePrompts"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 16, 52, 0, 0, 10, 37)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local buttonPromptImage1 = LUI.UIImage.new(1, 1, -44, -8, 0, 0, 10, 37)
	buttonPromptImage1:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	buttonPromptImage1:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage1)
	self.buttonPromptImage1 = buttonPromptImage1
	local label = LUI.UIText.new(0, 0, 66, 236, 0, 0, 10, 37)
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(6)
	label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	label:linkToElementModel(self, "Label", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			label:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(label, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, -10)
	end)
	self:addElement(label)
	self.label = label
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[0xF4865E3551C3835][0x42F62C12777D074])
				if f4_local0 then
					f4_local0 = IsGamepad(f1_arg1)
					if f4_local0 then
						f4_local0 = not CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "Label")
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[0xF4865E3551C3835][0x901DFC093ED4187])
				if f5_local0 then
					f5_local0 = IsGamepad(f1_arg1)
					if f5_local0 then
						f5_local0 = not CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "Label")
					end
				end
				return f5_local0
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
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f7_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "Label", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Label",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButtonDoublePrompts.__resetProperties = function(f10_arg0)
	f10_arg0.buttonPromptImage:completeAnimation()
	f10_arg0.label:completeAnimation()
	f10_arg0.buttonPromptImage1:completeAnimation()
	f10_arg0.buttonPromptImage:setLeftRight(0, 0, 16, 52)
	f10_arg0.buttonPromptImage:setTopBottom(0, 0, 10, 37)
	f10_arg0.buttonPromptImage:setRGB(1, 1, 1)
	f10_arg0.buttonPromptImage:setAlpha(1)
	f10_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	f10_arg0.buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	f10_arg0.label:setRGB(1, 1, 1)
	f10_arg0.label:setAlpha(1)
	f10_arg0.buttonPromptImage1:setRGB(1, 1, 1)
	f10_arg0.buttonPromptImage1:setAlpha(1)
	f10_arg0.buttonPromptImage1:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	f10_arg0.buttonPromptImage1:setShaderVector(0, 1, 0, 0, 0)
end
CoD.FooterButtonDoublePrompts.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.buttonPromptImage:completeAnimation()
			f11_arg0.buttonPromptImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.buttonPromptImage)
			f11_arg0.buttonPromptImage1:completeAnimation()
			f11_arg0.buttonPromptImage1:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.buttonPromptImage1)
			f11_arg0.label:completeAnimation()
			f11_arg0.label:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.label)
		end,
	},
	Disabled = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.buttonPromptImage:completeAnimation()
			f12_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f12_arg0.buttonPromptImage:setAlpha(0.5)
			f12_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
			f12_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f12_arg0.clipFinished(f12_arg0.buttonPromptImage)
			f12_arg0.buttonPromptImage1:completeAnimation()
			f12_arg0.buttonPromptImage1:setRGB(0.5, 0.5, 0.5)
			f12_arg0.buttonPromptImage1:setAlpha(0.5)
			f12_arg0.buttonPromptImage1:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
			f12_arg0.buttonPromptImage1:setShaderVector(0, 0, 0, 0, 0)
			f12_arg0.clipFinished(f12_arg0.buttonPromptImage1)
			f12_arg0.label:completeAnimation()
			f12_arg0.label:setRGB(0.5, 0.5, 0.5)
			f12_arg0.label:setAlpha(0.5)
			f12_arg0.clipFinished(f12_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		Hide = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.buttonPromptImage:completeAnimation()
			f14_arg0.buttonPromptImage:setLeftRight(0, 0, 0, 48)
			f14_arg0.buttonPromptImage:setTopBottom(0, 0, 0.5, 46.5)
			f14_arg0.buttonPromptImage:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.buttonPromptImage)
			f14_arg0.label:completeAnimation()
			f14_arg0.label:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.label)
		end,
	},
}
CoD.FooterButtonDoublePrompts.__onClose = function(f15_arg0)
	f15_arg0.label:close()
end
