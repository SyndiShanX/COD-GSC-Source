require("x64:94dab3a4d2d79b2")
CoD.ZMLoadoutPreviewSelectClass = InheritFrom(LUI.UIElement)
CoD.ZMLoadoutPreviewSelectClass.__defaultWidth = 272
CoD.ZMLoadoutPreviewSelectClass.__defaultHeight = 52
CoD.ZMLoadoutPreviewSelectClass.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLoadoutPreviewSelectClass)
	self.id = "ZMLoadoutPreviewSelectClass"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 0, 174, 0, 0, 9.5, 41.5)
	DotCorner9Slice:setAlpha(0.9)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local f1_local2 = nil
	self.SelectClassPrompt = LUI.UIElement.createFake()
	local buttonPromptImagePC = nil
	buttonPromptImagePC = LUI.UIImage.new(0, 0, 9, 39, 0, 0, 11, 41)
	buttonPromptImagePC:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	buttonPromptImagePC:setShaderVector(0, 1, 0, 0, 0)
	buttonPromptImagePC:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			buttonPromptImagePC:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(buttonPromptImagePC)
	self.buttonPromptImagePC = buttonPromptImagePC
	local buttonPromptStringPC = nil
	buttonPromptStringPC = LUI.UIText.new(0.5, 0.5, -88, 212, 0.5, 0.5, -9, 8)
	buttonPromptStringPC:setText(Engine[0xF9F1239CFD921FE](0xAC3B80C833B60E1))
	buttonPromptStringPC:setTTF("ttmussels_regular")
	buttonPromptStringPC:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	buttonPromptStringPC:setShaderVector(0, 0, 0, 0, 0)
	buttonPromptStringPC:setShaderVector(1, 0, 0, 0, 0)
	buttonPromptStringPC:setShaderVector(2, 1, 0, 0, 0)
	buttonPromptStringPC:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	buttonPromptStringPC:setLetterSpacing(0.5)
	buttonPromptStringPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	buttonPromptStringPC:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(buttonPromptStringPC)
	self.buttonPromptStringPC = buttonPromptStringPC
	self:mergeStateConditions({
		{
			stateName = "IsMouseKeyboard",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMLoadoutPreviewSelectClass.__resetProperties = function(f7_arg0)
	f7_arg0.buttonPromptStringPC:completeAnimation()
	f7_arg0.buttonPromptImagePC:completeAnimation()
	f7_arg0.SelectClassPrompt:completeAnimation()
	f7_arg0.DotCorner9Slice:completeAnimation()
	f7_arg0.buttonPromptStringPC:setAlpha(1)
	f7_arg0.buttonPromptImagePC:setAlpha(1)
	f7_arg0.SelectClassPrompt:setAlpha(1)
	f7_arg0.DotCorner9Slice:setAlpha(0.9)
end
CoD.ZMLoadoutPreviewSelectClass.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.DotCorner9Slice:completeAnimation()
			f8_arg0.DotCorner9Slice:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DotCorner9Slice)
			f8_arg0.SelectClassPrompt:completeAnimation()
			f8_arg0.SelectClassPrompt:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.SelectClassPrompt)
			f8_arg0.buttonPromptImagePC:completeAnimation()
			f8_arg0.buttonPromptImagePC:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.buttonPromptImagePC)
			f8_arg0.buttonPromptStringPC:completeAnimation()
			f8_arg0.buttonPromptStringPC:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.buttonPromptStringPC)
		end,
	},
	IsMouseKeyboard = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.DotCorner9Slice:completeAnimation()
			f9_arg0.DotCorner9Slice:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DotCorner9Slice)
			f9_arg0.SelectClassPrompt:completeAnimation()
			f9_arg0.SelectClassPrompt:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.SelectClassPrompt)
			f9_arg0.buttonPromptImagePC:completeAnimation()
			f9_arg0.buttonPromptImagePC:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonPromptImagePC)
			f9_arg0.buttonPromptStringPC:completeAnimation()
			f9_arg0.buttonPromptStringPC:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonPromptStringPC)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ZMLoadoutPreviewSelectClass.__onClose = function(f11_arg0)
	f11_arg0.DotCorner9Slice:close()
	f11_arg0.SelectClassPrompt:close()
	f11_arg0.buttonPromptImagePC:close()
end
