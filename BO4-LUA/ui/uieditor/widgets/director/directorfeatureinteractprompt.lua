CoD.DirectorFeatureInteractPrompt = InheritFrom(LUI.UIElement)
CoD.DirectorFeatureInteractPrompt.__defaultWidth = 550
CoD.DirectorFeatureInteractPrompt.__defaultHeight = 40
CoD.DirectorFeatureInteractPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFeatureInteractPrompt)
	self.id = "DirectorFeatureInteractPrompt"
	self.soundSet = "none"
	local Description = LUI.UIText.new(0, 0, 30.5, 547.5, 1, 1, -28.5, -11.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(1)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	Description:setBackingType(2)
	Description:setBackingColor(0, 0, 0)
	Description:setBackingAlpha(0.7)
	Description:setBackingXPadding(10)
	Description:setBackingYPadding(4)
	Description:setBackingImage(RegisterImage(@"hash_7C229CEBABEEAB0E"))
	Description:linkToElementModel(self, "descriptionText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Description:setText(CoD.BaseUtility.LocalizeIfXHash(f2_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local buttonPromptImagePC = nil
	buttonPromptImagePC = LUI.UIImage.new(0, 0, 3, 29, 1, 1, -33, -7)
	buttonPromptImagePC:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	buttonPromptImagePC:setShaderVector(0, 1, 0, 0, 0)
	buttonPromptImagePC:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			buttonPromptImagePC:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(buttonPromptImagePC)
	self.buttonPromptImagePC = buttonPromptImagePC
	local f1_local3 = nil
	self.buttonPromptImage = LUI.UIElement.createFake()
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorFeatureInteractPrompt.__onClose = function(f4_arg0)
	f4_arg0.Description:close()
	f4_arg0.buttonPromptImagePC:close()
	f4_arg0.buttonPromptImage:close()
end
