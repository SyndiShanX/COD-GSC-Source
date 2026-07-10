require("x64:3c71a587b3212e8")
CoD.AARPaintCansStat = InheritFrom(LUI.UIElement)
CoD.AARPaintCansStat.__defaultWidth = 180
CoD.AARPaintCansStat.__defaultHeight = 132
CoD.AARPaintCansStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARPaintCansStat)
	self.id = "AARPaintCansStat"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 0, 0, 180, 0, 0, 0, 132)
	PerformBg:setAlpha(0)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local StatValueGlow = LUI.UIText.new(0, 0, 76, 180, 0, 0, 42, 122)
	StatValueGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	StatValueGlow:setAlpha(0)
	StatValueGlow:setText(15)
	StatValueGlow:setTTF("ttmussels_regular")
	StatValueGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	StatValueGlow:setShaderVector(0, 0.3, 0, 0, 0)
	StatValueGlow:setShaderVector(1, 0, 0, 0, 0)
	StatValueGlow:setShaderVector(2, 1, 0, 0, 0.8)
	StatValueGlow:setLetterSpacing(2)
	StatValueGlow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StatValueGlow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(StatValueGlow)
	self.StatValueGlow = StatValueGlow
	local StatLabel = LUI.UIText.new(0, 0, 17.5, 179.5, 0, 0, 12, 33)
	StatLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	StatLabel:setAlpha(0)
	StatLabel:setText(Engine[0xF9F1239CFD921FE](0x9FE863E6425C8CE))
	StatLabel:setTTF("dinnext_regular")
	StatLabel:setLetterSpacing(2)
	StatLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StatLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(StatLabel)
	self.StatLabel = StatLabel
	local StatValue = LUI.UIText.new(0, 0, 76, 180, 0, 0, 42, 122)
	StatValue:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	StatValue:setAlpha(0)
	StatValue:setText(15)
	StatValue:setTTF("ttmussels_regular")
	StatValue:setLetterSpacing(2)
	StatValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StatValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(StatValue)
	self.StatValue = StatValue
	local PaintCanImage = LUI.UIImage.new(0, 0, -13, 92, 0, 0, 29, 134)
	PaintCanImage:setAlpha(0)
	PaintCanImage:setImage(RegisterImage(0xB808223FCD4471D))
	self:addElement(PaintCanImage)
	self.PaintCanImage = PaintCanImage
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("ui_ShowWZPersonalization")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARPaintCansStat.__resetProperties = function(f3_arg0)
	f3_arg0.PaintCanImage:completeAnimation()
	f3_arg0.StatValue:completeAnimation()
	f3_arg0.StatLabel:completeAnimation()
	f3_arg0.StatValueGlow:completeAnimation()
	f3_arg0.PerformBg:completeAnimation()
	f3_arg0.PaintCanImage:setAlpha(0)
	f3_arg0.StatValue:setAlpha(0)
	f3_arg0.StatLabel:setAlpha(0)
	f3_arg0.StatValueGlow:setAlpha(0)
	f3_arg0.PerformBg:setAlpha(0)
end
CoD.AARPaintCansStat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			f5_arg0.PerformBg:completeAnimation()
			f5_arg0.PerformBg:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.PerformBg)
			f5_arg0.StatValueGlow:completeAnimation()
			f5_arg0.StatValueGlow:setAlpha(0.4)
			f5_arg0.clipFinished(f5_arg0.StatValueGlow)
			f5_arg0.StatLabel:completeAnimation()
			f5_arg0.StatLabel:setAlpha(0.2)
			f5_arg0.clipFinished(f5_arg0.StatLabel)
			f5_arg0.StatValue:completeAnimation()
			f5_arg0.StatValue:setAlpha(0.8)
			f5_arg0.clipFinished(f5_arg0.StatValue)
			f5_arg0.PaintCanImage:completeAnimation()
			f5_arg0.PaintCanImage:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.PaintCanImage)
		end,
	},
}
CoD.AARPaintCansStat.__onClose = function(f6_arg0)
	f6_arg0.PerformBg:close()
end
