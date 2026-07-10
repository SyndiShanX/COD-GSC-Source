require("x64:e95c1a1a693ac70")
CoD.scorestreaks_TitleBox = InheritFrom(LUI.UIElement)
CoD.scorestreaks_TitleBox.__defaultWidth = 674
CoD.scorestreaks_TitleBox.__defaultHeight = 51
CoD.scorestreaks_TitleBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.scorestreaks_TitleBox)
	self.id = "scorestreaks_TitleBox"
	self.soundSet = "default"
	local TitleGlow1 = CoD.cac_ItemTitleGlow.new(f1_arg0, f1_arg1, 0, 1, -4, 4, 0, 1, -4, 4)
	TitleGlow1:setRGB(0.9, 0.9, 0.9)
	TitleGlow1:setAlpha(0)
	self:addElement(TitleGlow1)
	self.TitleGlow1 = TitleGlow1
	local Glow = LUI.UIImage.new(0, 1, -81, 73, 0.5, 0.5, -45, 65)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(0x1078C36A022A4FE))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	local ScorestreaksLabel = LUI.UIText.new(0, 0, 0, 674, 0.5, 0.5, -25.5, 10.5)
	ScorestreaksLabel:setRGB(0.96, 0.93, 0.84)
	ScorestreaksLabel:setText(LocalizeToUpperString(LocalizeIntoString(0x0, 0x0)))
	ScorestreaksLabel:setTTF("ttmussels_regular")
	ScorestreaksLabel:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	ScorestreaksLabel:setShaderVector(0, 0.06, 0, 0, 0)
	ScorestreaksLabel:setShaderVector(1, 0.02, 0, 0, 0)
	ScorestreaksLabel:setShaderVector(2, 1, 0, 0, 0)
	ScorestreaksLabel:setLetterSpacing(3)
	ScorestreaksLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ScorestreaksLabel:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	LUI.OverrideFunction_CallOriginalFirst(ScorestreaksLabel, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 2)
	end)
	self:addElement(ScorestreaksLabel)
	self.ScorestreaksLabel = ScorestreaksLabel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.scorestreaks_TitleBox.__onClose = function(f3_arg0)
	f3_arg0.TitleGlow1:close()
end
