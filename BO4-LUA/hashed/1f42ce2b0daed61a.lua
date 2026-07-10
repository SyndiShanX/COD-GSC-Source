CoD.WZCompassMinorInternal = InheritFrom(LUI.UIElement)
CoD.WZCompassMinorInternal.__defaultWidth = 62
CoD.WZCompassMinorInternal.__defaultHeight = 43
CoD.WZCompassMinorInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZCompassMinorInternal)
	self.id = "WZCompassMinorInternal"
	self.soundSet = "default"
	local Text = LUI.UIText.new(0.5, 0.5, -31, 31, 0, 0, 9, 28)
	Text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Text:setTTF("ttmussels_regular")
	Text:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Text:setShaderVector(0, 0.8, 0, 0, 0)
	Text:setShaderVector(1, 0, 0, 0, 0)
	Text:setShaderVector(2, 1, 1, 1, 0.35)
	Text:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	Text:setLetterSpacing(2)
	Text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Text:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Text:setText(f2_local0)
		end
	end)
	self:addElement(Text)
	self.Text = Text
	local Image = LUI.UIImage.new(0.5, 0.5, -7, 9, 0, 0, -8, 8)
	Image:setImage(RegisterImage(0xF1FE913FFF48899))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xFEAF4A18C11A89E))
	self:addElement(Image)
	self.Image = Image
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZCompassMinorInternal.__onClose = function(f3_arg0)
	f3_arg0.Text:close()
end
