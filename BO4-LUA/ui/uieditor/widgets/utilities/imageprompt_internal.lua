CoD.ImagePrompt_Internal = InheritFrom(LUI.UIElement)
CoD.ImagePrompt_Internal.__defaultWidth = 400
CoD.ImagePrompt_Internal.__defaultHeight = 60
CoD.ImagePrompt_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ImagePrompt_Internal)
	self.id = "ImagePrompt_Internal"
	self.soundSet = "none"
	local warningIcon = LUI.UIImage.new(0, 0.14, 0, 0, 0, 0.93, 0, 0)
	warningIcon:setScale(0.7, 0.7)
	warningIcon:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			warningIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(warningIcon)
	self.warningIcon = warningIcon
	local warningTextPrompt = LUI.UIText.new(0.02, 0.83, 50, 50, 0.3, 0.7, 0, 0)
	warningTextPrompt:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	warningTextPrompt:setTTF("dinnext_regular")
	warningTextPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	warningTextPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	warningTextPrompt:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			warningTextPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(warningTextPrompt)
	self.warningTextPrompt = warningTextPrompt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ImagePrompt_Internal.__onClose = function(f4_arg0)
	f4_arg0.warningIcon:close()
	f4_arg0.warningTextPrompt:close()
end
