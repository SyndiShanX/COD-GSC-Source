require("x64:ae2cf5ba65e8174")
CoD.vhud_ms_StatusWidgetLeft = InheritFrom(LUI.UIElement)
CoD.vhud_ms_StatusWidgetLeft.__defaultWidth = 130
CoD.vhud_ms_StatusWidgetLeft.__defaultHeight = 63
CoD.vhud_ms_StatusWidgetLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_StatusWidgetLeft)
	self.id = "vhud_ms_StatusWidgetLeft"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ALTnumbers = LUI.UIText.new(0, 1, 0, 0, 0, 0, 38, 62)
	ALTnumbers:setTTF("default")
	ALTnumbers:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD756CD9A5F1F1B4))
	ALTnumbers:setShaderVector(0, 0, 1, 0, 0)
	ALTnumbers:setShaderVector(1, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(2, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(3, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(4, 0, 0, 0, 0)
	ALTnumbers:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ALTnumbers:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ALTnumbers:linkToElementModel(self, "altitude", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ALTnumbers:setText(f2_local0)
		end
	end)
	self:addElement(ALTnumbers)
	self.ALTnumbers = ALTnumbers
	local vhudmsNotificationBox0 = CoD.vhud_ms_NotificationBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -65, 65, 0, 0, -0.5, 44.5)
	self:addElement(vhudmsNotificationBox0)
	self.vhudmsNotificationBox0 = vhudmsNotificationBox0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_StatusWidgetLeft.__onClose = function(f3_arg0)
	f3_arg0.ALTnumbers:close()
	f3_arg0.vhudmsNotificationBox0:close()
end
