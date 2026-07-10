require("x64:ae2cf5ba65e8174")
CoD.vhud_hellstorm_AltWidget = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_AltWidget.__defaultWidth = 220
CoD.vhud_hellstorm_AltWidget.__defaultHeight = 33
CoD.vhud_hellstorm_AltWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_AltWidget)
	self.id = "vhud_hellstorm_AltWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ALTnumbers = LUI.UIText.new(0.5, 0.5, -65, 65, 0, 0, 19, 37)
	ALTnumbers:setTTF("0arame_mono_stencil")
	ALTnumbers:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	ALTnumbers:setShaderVector(0, 0, 1, 0, 0)
	ALTnumbers:setShaderVector(1, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(2, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(3, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(4, 0, 0, 0, 0)
	ALTnumbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ALTnumbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ALTnumbers:linkToElementModel(self, "altitude", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ALTnumbers:setText(CoD.BaseUtility.RoundFraction(0, f2_local0))
		end
	end)
	self:addElement(ALTnumbers)
	self.ALTnumbers = ALTnumbers
	local vhudmsNotificationBox0 = CoD.vhud_ms_NotificationBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -65, 65, 0, 0, 18, 63)
	vhudmsNotificationBox0:setAlpha(0)
	self:addElement(vhudmsNotificationBox0)
	self.vhudmsNotificationBox0 = vhudmsNotificationBox0
	local altitudeText = LUI.UIText.new(0.5, 0.5, -110, 110, 0, 0, -2.5, 12.5)
	altitudeText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BD23A68618982EF"))
	altitudeText:setTTF("ttmussels_regular")
	altitudeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	altitudeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(altitudeText)
	self.altitudeText = altitudeText
	local bracketL = LUI.UIImage.new(0, 0, 73.5, 79.5, 0, 0, 13, 35)
	bracketL:setAlpha(0)
	bracketL:setImage(RegisterImage(@"hash_480B4C9BD564D5B0"))
	self:addElement(bracketL)
	self.bracketL = bracketL
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_hellstorm_AltWidget.__onClose = function(f3_arg0)
	f3_arg0.ALTnumbers:close()
	f3_arg0.vhudmsNotificationBox0:close()
end
