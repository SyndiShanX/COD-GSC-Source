CoD.FE_ListHeader = InheritFrom(LUI.UIElement)
CoD.FE_ListHeader.__defaultWidth = 175
CoD.FE_ListHeader.__defaultHeight = 42
CoD.FE_ListHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_ListHeader)
	self.id = "FE_ListHeader"
	self.soundSet = "default"
	local Label = LUI.UIText.new(0, 1, 4, -4, 0.5, 0.5, -15, 15)
	Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Label:setText("")
	Label:setTTF("ttmussels_regular")
	Label:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	Label:setShaderVector(0, 0.06, 0, 0, 0)
	Label:setShaderVector(1, 0.02, 0, 0, 0)
	Label:setShaderVector(2, 1, 0, 0, 0)
	Label:setLetterSpacing(1)
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(Label, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 0)
	end)
	self:addElement(Label)
	self.Label = Label
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
