require("x64:74a2834581ae4c5")
require("x64:ae2cf5ba65e8174")
require("x64:a1295ffce06997")
CoD.vhud_ms_StatusWidgetRight = InheritFrom(LUI.UIElement)
CoD.vhud_ms_StatusWidgetRight.__defaultWidth = 124
CoD.vhud_ms_StatusWidgetRight.__defaultHeight = 243
CoD.vhud_ms_StatusWidgetRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_StatusWidgetRight)
	self.id = "vhud_ms_StatusWidgetRight"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local SpeedNumbers = LUI.UIText.new(0, 1, 0, 0, 0, 0, 38, 62)
	SpeedNumbers:setTTF("default")
	SpeedNumbers:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	SpeedNumbers:setShaderVector(0, 0, 1, 0, 0)
	SpeedNumbers:setShaderVector(1, 0, 0, 0, 0)
	SpeedNumbers:setShaderVector(2, 0, 0, 0, 0)
	SpeedNumbers:setShaderVector(3, 0, 0, 0, 0)
	SpeedNumbers:setShaderVector(4, 0, 0, 0, 0)
	SpeedNumbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SpeedNumbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SpeedNumbers:linkToElementModel(self, "speed", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpeedNumbers:setText(f2_local0)
		end
	end)
	self:addElement(SpeedNumbers)
	self.SpeedNumbers = SpeedNumbers
	local vhudsentinelNotificationLine = CoD.vhud_sentinel_NotificationLine.new(f1_arg0, f1_arg1, 0, 1, 3, -3, 0, 0, 61, 73)
	vhudsentinelNotificationLine:setRGB(0.74, 0.94, 0.99)
	vhudsentinelNotificationLine:setAlpha(0.7)
	self:addElement(vhudsentinelNotificationLine)
	self.vhudsentinelNotificationLine = vhudsentinelNotificationLine
	local vhudmsNotificationBox = CoD.vhud_ms_NotificationBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -62, 62, 0, 0, -0.5, 44.5)
	vhudmsNotificationBox.ALTtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_43755C926654C027"))
	self:addElement(vhudmsNotificationBox)
	self.vhudmsNotificationBox = vhudmsNotificationBox
	local vhudmsmissilesWidget = CoD.vhud_ms_missilesWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -49, 45, 0, 0, 93, 178)
	vhudmsmissilesWidget:linkToElementModel(self, nil, false, function(model)
		vhudmsmissilesWidget:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsmissilesWidget)
	self.vhudmsmissilesWidget = vhudmsmissilesWidget
	local vhudmsmissilesWidget0 = CoD.vhud_ms_missilesWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -49, 45, 0, 0, 93, 178)
	vhudmsmissilesWidget0:setAlpha(0.15)
	vhudmsmissilesWidget0:setZoom(-15)
	vhudmsmissilesWidget0:linkToElementModel(self, nil, false, function(model)
		vhudmsmissilesWidget0:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsmissilesWidget0)
	self.vhudmsmissilesWidget0 = vhudmsmissilesWidget0
	local vhudsentinelNotificationLine0 = CoD.vhud_sentinel_NotificationLine.new(f1_arg0, f1_arg1, 0, 1, 3, -3, 0, 0, 208, 220)
	vhudsentinelNotificationLine0:setRGB(0.74, 0.94, 0.99)
	vhudsentinelNotificationLine0:setAlpha(0.7)
	self:addElement(vhudsentinelNotificationLine0)
	self.vhudsentinelNotificationLine0 = vhudsentinelNotificationLine0
	local MISSILEStext = LUI.UIText.new(0, 1, 0, 0, 0, 0, 221, 243)
	MISSILEStext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2EF98B8EA89AA3E5"))
	MISSILEStext:setTTF("default")
	MISSILEStext:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	MISSILEStext:setShaderVector(0, 0, 1, 0, 0)
	MISSILEStext:setShaderVector(1, 0, 0, 0, 0)
	MISSILEStext:setShaderVector(2, 0, 0, 0, 0)
	MISSILEStext:setShaderVector(3, 0, 0, 0, 0)
	MISSILEStext:setShaderVector(4, 0, 0, 0, 0)
	MISSILEStext:setLetterSpacing(0.5)
	MISSILEStext:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MISSILEStext:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MISSILEStext)
	self.MISSILEStext = MISSILEStext
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_StatusWidgetRight.__onClose = function(f5_arg0)
	f5_arg0.SpeedNumbers:close()
	f5_arg0.vhudsentinelNotificationLine:close()
	f5_arg0.vhudmsNotificationBox:close()
	f5_arg0.vhudmsmissilesWidget:close()
	f5_arg0.vhudmsmissilesWidget0:close()
	f5_arg0.vhudsentinelNotificationLine0:close()
end
