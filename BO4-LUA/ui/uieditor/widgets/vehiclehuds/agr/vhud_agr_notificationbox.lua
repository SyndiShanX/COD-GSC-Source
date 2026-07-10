CoD.vhud_agr_NotificationBox = InheritFrom(LUI.UIElement)
CoD.vhud_agr_NotificationBox.__defaultWidth = 121
CoD.vhud_agr_NotificationBox.__defaultHeight = 45
CoD.vhud_agr_NotificationBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_NotificationBox)
	self.id = "vhud_agr_NotificationBox"
	self.soundSet = "default"
	local normalBox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	normalBox:setRGB(0.49, 1, 0.74)
	normalBox:setAlpha(0.08)
	normalBox:setZoom(-20)
	normalBox:setImage(RegisterImage(0xA21BBF7C2B1FCAA))
	normalBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	normalBox:setShaderVector(0, 0, 0, 0, 0)
	normalBox:setupNineSliceShader(27, 15)
	self:addElement(normalBox)
	self.normalBox = normalBox
	local addBox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	addBox:setRGB(0.74, 0.99, 0.84)
	addBox:setImage(RegisterImage(0xA21BBF7C2B1FCAA))
	addBox:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	addBox:setShaderVector(0, 0, 0, 0, 0)
	addBox:setupNineSliceShader(27, 15)
	self:addElement(addBox)
	self.addBox = addBox
	local text = LUI.UIText.new(0.5, 0.5, -150, 150, 0.5, 0.5, -12, 12)
	text:setRGB(0.49, 1, 0.74)
	text:setText(Engine[0xF9F1239CFD921FE](0xFA90E68B570AF69))
	text:setTTF("default")
	text:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD756CD9A5F1F1B4))
	text:setShaderVector(0, 0, 1, 0, 0)
	text:setShaderVector(1, 0, 0, 0, 0)
	text:setShaderVector(2, 0, 0, 0, 0)
	text:setShaderVector(3, 0, 0, 0, 0)
	text:setShaderVector(4, 0, 0, 0, 0)
	text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LUI.OverrideFunction_CallOriginalFirst(text, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWithMinimum(self, element, 20, 81)
	end)
	self:addElement(text)
	self.text = text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
