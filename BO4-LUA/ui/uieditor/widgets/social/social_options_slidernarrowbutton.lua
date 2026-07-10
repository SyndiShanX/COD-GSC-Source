CoD.Social_Options_SliderNarrowButton = InheritFrom(LUI.UIElement)
CoD.Social_Options_SliderNarrowButton.__defaultWidth = 204
CoD.Social_Options_SliderNarrowButton.__defaultHeight = 44
CoD.Social_Options_SliderNarrowButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_Options_SliderNarrowButton)
	self.id = "Social_Options_SliderNarrowButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonBacking = LUI.UIImage.new(0.5, 0.5, -98.5, 98.5, 0.5, 0.5, -19, 19)
	ButtonBacking:setRGB(0.13, 0.12, 0.12)
	ButtonBacking:setAlpha(0.5)
	self:addElement(ButtonBacking)
	self.ButtonBacking = ButtonBacking
	local ButtonLabel = LUI.UIText.new(0, 0, 6.5, 197.5, 0, 0, 11.5, 32.5)
	ButtonLabel:setRGB(0.78, 0.74, 0.67)
	ButtonLabel:setTTF("ttmussels_regular")
	ButtonLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ButtonLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	ButtonLabel:linkToElementModel(self, "altText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ButtonLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(ButtonLabel)
	self.ButtonLabel = ButtonLabel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_Options_SliderNarrowButton.__resetProperties = function(f3_arg0)
	f3_arg0.ButtonLabel:completeAnimation()
	f3_arg0.ButtonLabel:setRGB(0.78, 0.74, 0.67)
end
CoD.Social_Options_SliderNarrowButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ButtonLabel:completeAnimation()
			f5_arg0.ButtonLabel:setRGB(0.89, 0.33, 0.03)
			f5_arg0.clipFinished(f5_arg0.ButtonLabel)
		end,
	},
}
CoD.Social_Options_SliderNarrowButton.__onClose = function(f6_arg0)
	f6_arg0.ButtonLabel:close()
end
