CoD.fe_LeftContainerMain = InheritFrom(LUI.UIElement)
CoD.fe_LeftContainerMain.__defaultWidth = 800
CoD.fe_LeftContainerMain.__defaultHeight = 27
CoD.fe_LeftContainerMain.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.fe_LeftContainerMain)
	self.id = "fe_LeftContainerMain"
	self.soundSet = "default"
	local lblPressToPlay = LUI.UIText.new(0, 1, 0, 0, 1, 1, -27.5, 0.5)
	lblPressToPlay:setRGB(ColorSet.T8__SLATE.r, ColorSet.T8__SLATE.g, ColorSet.T8__SLATE.b)
	lblPressToPlay:setText(LocalizeToUpperString(0xF5814C348E0C9F1))
	lblPressToPlay:setTTF("ttmussels_regular")
	lblPressToPlay:setLetterSpacing(5)
	lblPressToPlay:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	lblPressToPlay:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(lblPressToPlay)
	self.lblPressToPlay = lblPressToPlay
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
