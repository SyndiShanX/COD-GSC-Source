CoD.HVOStat = InheritFrom(LUI.UIElement)
CoD.HVOStat.__defaultWidth = 400
CoD.HVOStat.__defaultHeight = 40
CoD.HVOStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HVOStat)
	self.id = "HVOStat"
	self.soundSet = "none"
	local StatValue = LUI.UIText.new(0, 0, 0.5, 84.5, 0, 0, 2, 39)
	StatValue:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	StatValue:setTTF("ttmussels_regular")
	StatValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	StatValue:setShaderVector(0, 0.5, 0, 0, 0)
	StatValue:setShaderVector(1, 0.2, 0, 0, 0)
	StatValue:setShaderVector(2, 1, 0.23, 0, 0.4)
	StatValue:setLetterSpacing(4)
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	StatValue:linkToElementModel(self, "value", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StatValue:setText(f2_local0)
		end
	end)
	self:addElement(StatValue)
	self.StatValue = StatValue
	local StatLabel = LUI.UIText.new(0, 0, 95, 511, 0, 0, 8.5, 33.5)
	StatLabel:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	StatLabel:setTTF("ttmussels_regular")
	StatLabel:setLetterSpacing(2)
	StatLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	StatLabel:linkToElementModel(self, "label", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StatLabel:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(StatLabel)
	self.StatLabel = StatLabel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HVOStat.__onClose = function(f4_arg0)
	f4_arg0.StatValue:close()
	f4_arg0.StatLabel:close()
end
