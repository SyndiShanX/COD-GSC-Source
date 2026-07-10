CoD.vhud_sentinel_NotificationBox = InheritFrom(LUI.UIElement)
CoD.vhud_sentinel_NotificationBox.__defaultWidth = 121
CoD.vhud_sentinel_NotificationBox.__defaultHeight = 45
CoD.vhud_sentinel_NotificationBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_sentinel_NotificationBox)
	self.id = "vhud_sentinel_NotificationBox"
	self.soundSet = "default"
	local NotificationAltBox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAltBox:setAlpha(0.08)
	NotificationAltBox:setZoom(-20)
	NotificationAltBox:setImage(RegisterImage(0x5D6174F532A5982))
	NotificationAltBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NotificationAltBox:setShaderVector(0, 0, 0, 0, 0)
	NotificationAltBox:setupNineSliceShader(27, 15)
	self:addElement(NotificationAltBox)
	self.NotificationAltBox = NotificationAltBox
	local NotificationAltBox0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAltBox0:setImage(RegisterImage(0x5D6174F532A5982))
	NotificationAltBox0:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	NotificationAltBox0:setShaderVector(0, 0, 0, 0, 0)
	NotificationAltBox0:setupNineSliceShader(27, 15)
	self:addElement(NotificationAltBox0)
	self.NotificationAltBox0 = NotificationAltBox0
	local SignalText = LUI.UIText.new(0.5, 0.5, -150, 150, 0.5, 0.5, -12, 12)
	SignalText:setRGB(0.6, 0.82, 0.91)
	SignalText:setText(Engine[0xF9F1239CFD921FE](0x74F45BCDE2B3C58))
	SignalText:setTTF("default")
	SignalText:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD756CD9A5F1F1B4))
	SignalText:setShaderVector(0, 0, 1, 0, 0)
	SignalText:setShaderVector(1, 0, 0, 0, 0)
	SignalText:setShaderVector(2, 0, 0, 0, 0)
	SignalText:setShaderVector(3, 0, 0, 0, 0)
	SignalText:setShaderVector(4, 0, 0, 0, 0)
	SignalText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SignalText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LUI.OverrideFunction_CallOriginalFirst(SignalText, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWithMinimum(self, element, 20, 81)
	end)
	self:addElement(SignalText)
	self.SignalText = SignalText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
