CoD.PaintshopBlendButtonPrompt = InheritFrom(LUI.UIElement)
CoD.PaintshopBlendButtonPrompt.__defaultWidth = 321
CoD.PaintshopBlendButtonPrompt.__defaultHeight = 36
CoD.PaintshopBlendButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintshopBlendButtonPrompt)
	self.id = "PaintshopBlendButtonPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 0, 36, 0, 0, 0, 36)
	buttonPromptImage:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0, 0, 62, 321, 0, 0, 5, 30)
	label:setRGB(0.92, 0.92, 0.92)
	label:setText(Engine[0xF9F1239CFD921FE](0x4336F8BDF41A51E))
	label:setTTF("ttmussels_regular")
	label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(label)
	self.label = label
	self:mergeStateConditions({
		{
			stateName = "Blend",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "blend", 0)
			end,
		},
		{
			stateName = "Sticker",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "blend", 1)
			end,
		},
	})
	self:linkToElementModel(self, "blend", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "blend",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintshopBlendButtonPrompt.__resetProperties = function(f6_arg0)
	f6_arg0.label:completeAnimation()
	f6_arg0.label:setText(Engine[0xF9F1239CFD921FE](0x4336F8BDF41A51E))
end
CoD.PaintshopBlendButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.label:completeAnimation()
			f7_arg0.label:setText(Engine[0xF9F1239CFD921FE](0xCB9F26855E3227A))
			f7_arg0.clipFinished(f7_arg0.label)
		end,
	},
	Blend = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Sticker = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.label:completeAnimation()
			f9_arg0.label:setText(Engine[0xF9F1239CFD921FE](0xCB9F26855E3227A))
			f9_arg0.clipFinished(f9_arg0.label)
		end,
	},
}
CoD.PaintshopBlendButtonPrompt.__onClose = function(f10_arg0)
	f10_arg0.buttonPromptImage:close()
end
