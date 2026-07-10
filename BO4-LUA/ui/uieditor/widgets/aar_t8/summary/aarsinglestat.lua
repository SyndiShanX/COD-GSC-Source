require("x64:3c71a587b3212e8")
CoD.AARSingleStat = InheritFrom(LUI.UIElement)
CoD.AARSingleStat.__defaultWidth = 225
CoD.AARSingleStat.__defaultHeight = 132
CoD.AARSingleStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSingleStat)
	self.id = "AARSingleStat"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 0, 0, 225, 0, 0, 0, 132)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local StatLabel = LUI.UIText.new(0, 0, 17.5, 225.5, 0, 0, 12, 33)
	StatLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	StatLabel:setAlpha(0.2)
	StatLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2C4B84A4968AAC62"))
	StatLabel:setTTF("dinnext_regular")
	StatLabel:setLetterSpacing(2)
	StatLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StatLabel)
	self.StatLabel = StatLabel
	local StatValueGlow = LUI.UIText.new(0, 0, 20, 283, 0, 0, 42, 122)
	StatValueGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	StatValueGlow:setAlpha(0.4)
	StatValueGlow:setText(1500)
	StatValueGlow:setTTF("ttmussels_regular")
	StatValueGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	StatValueGlow:setShaderVector(0, 0.3, 0, 0, 0)
	StatValueGlow:setShaderVector(1, 0, 0, 0, 0)
	StatValueGlow:setShaderVector(2, 1, 0, 0, 0.8)
	StatValueGlow:setLetterSpacing(2)
	StatValueGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatValueGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StatValueGlow)
	self.StatValueGlow = StatValueGlow
	local StatValue = LUI.UIText.new(0, 0, 20, 225, 0, 0, 42, 122)
	StatValue:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	StatValue:setAlpha(0.8)
	StatValue:setText(1500)
	StatValue:setTTF("ttmussels_regular")
	StatValue:setLetterSpacing(2)
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StatValue)
	self.StatValue = StatValue
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSingleStat.__onClose = function(f2_arg0)
	f2_arg0.PerformBg:close()
end
