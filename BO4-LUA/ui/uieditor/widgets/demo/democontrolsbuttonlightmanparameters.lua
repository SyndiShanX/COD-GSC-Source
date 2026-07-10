require("x64:f6720200fee8f1f")
require("x64:4fb5d5732c72812")
require("x64:2675595fa323085")
CoD.DemoControlsButtonLightmanParameters = InheritFrom(LUI.UIElement)
CoD.DemoControlsButtonLightmanParameters.__defaultWidth = 38
CoD.DemoControlsButtonLightmanParameters.__defaultHeight = 76
CoD.DemoControlsButtonLightmanParameters.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoControlsButtonLightmanParameters)
	self.id = "DemoControlsButtonLightmanParameters"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BorderThin = CoD.BorderThin.new(f1_arg0, f1_arg1, 0.5, 0.5, -19, 19, 0.5, 0.5, -38, 0)
	self:addElement(BorderThin)
	self.BorderThin = BorderThin
	local icon = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -34.5, -17.5)
	self:addElement(icon)
	self.icon = icon
	local progressRing = CoD.ButtonProgressRingContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 1, 1, -40, 2)
	progressRing:setAlpha(0)
	progressRing:setScale(0.75, 0.75)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f1_arg1)
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local buttonPromptImage = LUI.UIImage.new(0.5, 0.5, -16, 14, 0, 0, 42, 72)
	buttonPromptImage:setScale(0.75, 0.75)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local Backing = LUI.UIImage.new(0.5, 0.5, -19, 19, 0.5, 0.5, -14.5, -1.5)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.85)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Backing:setShaderVector(0, 0.05, 0.05, 0.05, 0.05)
	self:addElement(Backing)
	self.Backing = Backing
	local value = LUI.UIText.new(0.5, 0.5, -19, 19, 0.5, 0.5, -15.5, -0.5)
	value:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	value:setScale(0.9, 0.9)
	value:setTTF("dinnext_regular")
	value:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	value:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(value)
	self.value = value
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -15, 15, 0.5, 0.5, -34, -4)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self.icon:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			icon:setImage(RegisterImage(f3_local0))
		end
	end)
	self.buttonPromptImage:linkToElementModel(self, "buttonPromptImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self.value:linkToElementModel(self, "text", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			value:setText(f5_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "DisabledKBM",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
		{
			stateName = "ShowValueKBM",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTimescale") and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "ShowValue",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTimescale")
			end,
		},
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f12_arg1)
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "showTimescale", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showTimescale",
		})
	end)
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DemoControlsButtonLightmanParameters.__resetProperties = function(f15_arg0)
	f15_arg0.icon:completeAnimation()
	f15_arg0.value:completeAnimation()
	f15_arg0.Backing:completeAnimation()
	f15_arg0.BorderThin:completeAnimation()
	f15_arg0.buttonPromptImage:completeAnimation()
	f15_arg0.emptyFocusable:completeAnimation()
	f15_arg0.progressRing:completeAnimation()
	f15_arg0.icon:setTopBottom(0.5, 0.5, -34.5, -17.5)
	f15_arg0.icon:setRGB(1, 1, 1)
	f15_arg0.icon:setAlpha(1)
	f15_arg0.icon:setYRot(0)
	f15_arg0.icon:setScale(1, 1)
	f15_arg0.value:setTopBottom(0.5, 0.5, -15.5, -0.5)
	f15_arg0.value:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f15_arg0.value:setAlpha(1)
	f15_arg0.Backing:setTopBottom(0.5, 0.5, -14.5, -1.5)
	f15_arg0.Backing:setAlpha(0.85)
	f15_arg0.BorderThin:setTopBottom(0.5, 0.5, -38, 0)
	f15_arg0.BorderThin:setRGB(1, 1, 1)
	f15_arg0.BorderThin:setAlpha(1)
	f15_arg0.buttonPromptImage:setLeftRight(0.5, 0.5, -16, 14)
	f15_arg0.buttonPromptImage:setAlpha(1)
	f15_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -34, -4)
	f15_arg0.progressRing:setAlpha(0)
end
CoD.DemoControlsButtonLightmanParameters.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.icon:completeAnimation()
			f16_arg0.icon:setTopBottom(0.5, 0.5, -27.5, -10.5)
			f16_arg0.icon:setAlpha(1)
			f16_arg0.icon:setYRot(0)
			f16_arg0.clipFinished(f16_arg0.icon)
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Backing)
			f16_arg0.value:completeAnimation()
			f16_arg0.value:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.value)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.icon:completeAnimation()
			f17_arg0.icon:setTopBottom(0.5, 0.5, -27.5, -10.5)
			f17_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f17_arg0.icon:setAlpha(1)
			f17_arg0.icon:setYRot(0)
			f17_arg0.icon:setScale(1.2, 1.2)
			f17_arg0.clipFinished(f17_arg0.icon)
			f17_arg0.Backing:completeAnimation()
			f17_arg0.Backing:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Backing)
			f17_arg0.value:completeAnimation()
			f17_arg0.value:setRGB(0.92, 0.89, 0.72)
			f17_arg0.value:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.value)
		end,
	},
	DisabledKBM = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(6)
			f18_arg0.BorderThin:completeAnimation()
			f18_arg0.BorderThin:setTopBottom(0, 0, 19, 57)
			f18_arg0.BorderThin:setRGB(0, 0, 0)
			f18_arg0.BorderThin:setAlpha(0.2)
			f18_arg0.clipFinished(f18_arg0.BorderThin)
			f18_arg0.icon:completeAnimation()
			f18_arg0.icon:setTopBottom(0.5, 0.5, -15.5, 1.5)
			f18_arg0.icon:setRGB(0, 0, 0)
			f18_arg0.icon:setAlpha(0.2)
			f18_arg0.clipFinished(f18_arg0.icon)
			f18_arg0.buttonPromptImage:completeAnimation()
			f18_arg0.buttonPromptImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.buttonPromptImage)
			f18_arg0.Backing:completeAnimation()
			f18_arg0.Backing:setTopBottom(0, 0, 21, 34)
			f18_arg0.Backing:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Backing)
			f18_arg0.value:completeAnimation()
			f18_arg0.value:setTopBottom(0.5, 0.5, -18, -3)
			f18_arg0.value:setRGB(0.7, 0.7, 0.7)
			f18_arg0.value:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.value)
			f18_arg0.emptyFocusable:completeAnimation()
			f18_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f18_arg0.clipFinished(f18_arg0.emptyFocusable)
		end,
	},
	Disabled = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.BorderThin:completeAnimation()
			f19_arg0.BorderThin:setRGB(0, 0, 0)
			f19_arg0.BorderThin:setAlpha(0.2)
			f19_arg0.clipFinished(f19_arg0.BorderThin)
			f19_arg0.icon:completeAnimation()
			f19_arg0.icon:setRGB(0, 0, 0)
			f19_arg0.icon:setAlpha(0.2)
			f19_arg0.clipFinished(f19_arg0.icon)
			f19_arg0.buttonPromptImage:completeAnimation()
			f19_arg0.buttonPromptImage:setAlpha(0.2)
			f19_arg0.clipFinished(f19_arg0.buttonPromptImage)
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Backing)
			f19_arg0.value:completeAnimation()
			f19_arg0.value:setRGB(0.7, 0.7, 0.7)
			f19_arg0.value:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.value)
		end,
	},
	ShowValueKBM = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(7)
			f20_arg0.BorderThin:completeAnimation()
			f20_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f20_arg0.clipFinished(f20_arg0.BorderThin)
			f20_arg0.icon:completeAnimation()
			f20_arg0.icon:setTopBottom(0.5, 0.5, -23, 9)
			f20_arg0.icon:setAlpha(1)
			f20_arg0.icon:setYRot(0)
			f20_arg0.clipFinished(f20_arg0.icon)
			f20_arg0.progressRing:completeAnimation()
			f20_arg0.progressRing:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.progressRing)
			f20_arg0.buttonPromptImage:completeAnimation()
			f20_arg0.buttonPromptImage:setLeftRight(0.5, 0.5, -15, 15)
			f20_arg0.buttonPromptImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.buttonPromptImage)
			f20_arg0.Backing:completeAnimation()
			f20_arg0.Backing:setTopBottom(0.5, 0.5, 4.5, 17.5)
			f20_arg0.Backing:setAlpha(0.85)
			f20_arg0.clipFinished(f20_arg0.Backing)
			f20_arg0.value:completeAnimation()
			f20_arg0.value:setTopBottom(0.5, 0.5, 3.5, 18.5)
			f20_arg0.value:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.value)
			f20_arg0.emptyFocusable:completeAnimation()
			f20_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f20_arg0.clipFinished(f20_arg0.emptyFocusable)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(7)
			f21_arg0.BorderThin:completeAnimation()
			f21_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f21_arg0.clipFinished(f21_arg0.BorderThin)
			f21_arg0.icon:completeAnimation()
			f21_arg0.icon:setTopBottom(0.5, 0.5, -23, 9)
			f21_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f21_arg0.icon:setAlpha(1)
			f21_arg0.icon:setYRot(0)
			f21_arg0.icon:setScale(1.2, 1.2)
			f21_arg0.clipFinished(f21_arg0.icon)
			f21_arg0.progressRing:completeAnimation()
			f21_arg0.progressRing:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.progressRing)
			f21_arg0.buttonPromptImage:completeAnimation()
			f21_arg0.buttonPromptImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.buttonPromptImage)
			f21_arg0.Backing:completeAnimation()
			f21_arg0.Backing:setTopBottom(0.5, 0.5, 4.5, 17.5)
			f21_arg0.Backing:setAlpha(0.85)
			f21_arg0.clipFinished(f21_arg0.Backing)
			f21_arg0.value:completeAnimation()
			f21_arg0.value:setTopBottom(0.5, 0.5, 3.5, 18.5)
			f21_arg0.value:setRGB(0.92, 0.89, 0.72)
			f21_arg0.value:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.value)
			f21_arg0.emptyFocusable:completeAnimation()
			f21_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f21_arg0.clipFinished(f21_arg0.emptyFocusable)
		end,
	},
	ShowValue = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.icon:completeAnimation()
			f22_arg0.icon:setTopBottom(0.5, 0.5, -34.5, -17.5)
			f22_arg0.icon:setAlpha(1)
			f22_arg0.icon:setYRot(0)
			f22_arg0.clipFinished(f22_arg0.icon)
			f22_arg0.Backing:completeAnimation()
			f22_arg0.Backing:setAlpha(0.85)
			f22_arg0.clipFinished(f22_arg0.Backing)
			f22_arg0.value:completeAnimation()
			f22_arg0.value:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.value)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.icon:completeAnimation()
			f23_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f23_arg0.icon:setAlpha(1)
			f23_arg0.icon:setYRot(0)
			f23_arg0.icon:setScale(1.2, 1.2)
			f23_arg0.clipFinished(f23_arg0.icon)
			f23_arg0.Backing:completeAnimation()
			f23_arg0.Backing:setAlpha(0.85)
			f23_arg0.clipFinished(f23_arg0.Backing)
			f23_arg0.value:completeAnimation()
			f23_arg0.value:setRGB(0.92, 0.89, 0.72)
			f23_arg0.value:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.value)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(7)
			f24_arg0.BorderThin:completeAnimation()
			f24_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f24_arg0.clipFinished(f24_arg0.BorderThin)
			f24_arg0.icon:completeAnimation()
			f24_arg0.icon:setTopBottom(0.5, 0.5, -16, 16)
			f24_arg0.icon:setAlpha(1)
			f24_arg0.icon:setYRot(0)
			f24_arg0.clipFinished(f24_arg0.icon)
			f24_arg0.progressRing:completeAnimation()
			f24_arg0.progressRing:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.progressRing)
			f24_arg0.buttonPromptImage:completeAnimation()
			f24_arg0.buttonPromptImage:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.buttonPromptImage)
			f24_arg0.Backing:completeAnimation()
			f24_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f24_arg0.Backing:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Backing)
			f24_arg0.value:completeAnimation()
			f24_arg0.value:setTopBottom(0.5, 0.5, 3.5, 18.5)
			f24_arg0.value:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.value)
			f24_arg0.emptyFocusable:completeAnimation()
			f24_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f24_arg0.clipFinished(f24_arg0.emptyFocusable)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(7)
			f25_arg0.BorderThin:completeAnimation()
			f25_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f25_arg0.clipFinished(f25_arg0.BorderThin)
			f25_arg0.icon:completeAnimation()
			f25_arg0.icon:setTopBottom(0.5, 0.5, -16, 16)
			f25_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f25_arg0.icon:setAlpha(1)
			f25_arg0.icon:setYRot(0)
			f25_arg0.icon:setScale(1.2, 1.2)
			f25_arg0.clipFinished(f25_arg0.icon)
			f25_arg0.progressRing:completeAnimation()
			f25_arg0.progressRing:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressRing)
			f25_arg0.buttonPromptImage:completeAnimation()
			f25_arg0.buttonPromptImage:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.buttonPromptImage)
			f25_arg0.Backing:completeAnimation()
			f25_arg0.Backing:setTopBottom(0.5, 0.5, 4.5, 17.5)
			f25_arg0.Backing:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Backing)
			f25_arg0.value:completeAnimation()
			f25_arg0.value:setTopBottom(0.5, 0.5, 3.5, 18.5)
			f25_arg0.value:setRGB(0.92, 0.89, 0.72)
			f25_arg0.value:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.value)
			f25_arg0.emptyFocusable:completeAnimation()
			f25_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f25_arg0.clipFinished(f25_arg0.emptyFocusable)
		end,
	},
}
if not CoD.isPC then
	CoD.DemoControlsButtonLightmanParameters.__clipsPerState.DefaultState.ChildFocus = nil
	CoD.DemoControlsButtonLightmanParameters.__clipsPerState.ShowValueKBM.ChildFocus = nil
	CoD.DemoControlsButtonLightmanParameters.__clipsPerState.ShowValue.ChildFocus = nil
	CoD.DemoControlsButtonLightmanParameters.__clipsPerState.DefaultStateKBM.ChildFocus = nil
end
CoD.DemoControlsButtonLightmanParameters.__onClose = function(f26_arg0)
	f26_arg0.BorderThin:close()
	f26_arg0.icon:close()
	f26_arg0.progressRing:close()
	f26_arg0.buttonPromptImage:close()
	f26_arg0.value:close()
	f26_arg0.emptyFocusable:close()
end
