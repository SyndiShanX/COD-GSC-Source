CoD.fe_FooterButtonPromptWithContainerMain = InheritFrom(LUI.UIElement)
CoD.fe_FooterButtonPromptWithContainerMain.__defaultWidth = 150
CoD.fe_FooterButtonPromptWithContainerMain.__defaultHeight = 97
CoD.fe_FooterButtonPromptWithContainerMain.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.fe_FooterButtonPromptWithContainerMain)
	self.id = "fe_FooterButtonPromptWithContainerMain"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 2, 38, 0, 0, 28, 64)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0, 0, 44, 107, 0, 0, 33, 60)
	label:setRGB(ColorSet.T8__SLATE.r, ColorSet.T8__SLATE.g, ColorSet.T8__SLATE.b)
	label:setText("")
	label:setTTF("ttmussels_regular")
	label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LUI.OverrideFunction_CallOriginalFirst(label, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, -10)
	end)
	self:addElement(label)
	self.label = label
	local keybind = LUI.UIText.new(0, 0, 2, 38, 0, 0, 28, 66)
	keybind:setAlpha(0)
	keybind:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	keybind:setTTF("default")
	keybind:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	keybind:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(keybind)
	self.keybind = keybind
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "DisabledPC",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "EnabledPC",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.fe_FooterButtonPromptWithContainerMain.__resetProperties = function(f7_arg0)
	f7_arg0.buttonPromptImage:completeAnimation()
	f7_arg0.label:completeAnimation()
	f7_arg0.keybind:completeAnimation()
	f7_arg0.buttonPromptImage:setRGB(1, 1, 1)
	f7_arg0.buttonPromptImage:setAlpha(1)
	f7_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	f7_arg0.buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	f7_arg0.label:setRGB(ColorSet.T8__SLATE.r, ColorSet.T8__SLATE.g, ColorSet.T8__SLATE.b)
	f7_arg0.label:setAlpha(1)
	f7_arg0.keybind:setAlpha(0)
end
CoD.fe_FooterButtonPromptWithContainerMain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.buttonPromptImage:completeAnimation()
			f8_arg0.buttonPromptImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.buttonPromptImage)
			f8_arg0.label:completeAnimation()
			f8_arg0.label:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.label)
		end,
	},
	Disabled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.buttonPromptImage:completeAnimation()
			f9_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f9_arg0.buttonPromptImage:setAlpha(0.5)
			f9_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
			f9_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f9_arg0.clipFinished(f9_arg0.buttonPromptImage)
			f9_arg0.label:completeAnimation()
			f9_arg0.label:setRGB(0.5, 0.5, 0.5)
			f9_arg0.label:setAlpha(0.5)
			f9_arg0.clipFinished(f9_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.label:completeAnimation()
			f11_arg0.label:setRGB(0.87, 0.37, 0)
			f11_arg0.clipFinished(f11_arg0.label)
		end,
	},
	DisabledPC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.buttonPromptImage:completeAnimation()
			f12_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f12_arg0.buttonPromptImage:setAlpha(0)
			f12_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
			f12_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f12_arg0.clipFinished(f12_arg0.buttonPromptImage)
			f12_arg0.label:completeAnimation()
			f12_arg0.label:setRGB(0.5, 0.5, 0.5)
			f12_arg0.label:setAlpha(0.5)
			f12_arg0.clipFinished(f12_arg0.label)
			f12_arg0.keybind:completeAnimation()
			f12_arg0.keybind:setAlpha(0.25)
			f12_arg0.clipFinished(f12_arg0.keybind)
		end,
	},
	EnabledPC = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.buttonPromptImage:completeAnimation()
			f13_arg0.buttonPromptImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.buttonPromptImage)
			f13_arg0.keybind:completeAnimation()
			f13_arg0.keybind:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.keybind)
		end,
		Focus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.buttonPromptImage:completeAnimation()
			f14_arg0.buttonPromptImage:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.buttonPromptImage)
			f14_arg0.label:completeAnimation()
			f14_arg0.label:setRGB(0.87, 0.37, 0)
			f14_arg0.clipFinished(f14_arg0.label)
		end,
	},
}
