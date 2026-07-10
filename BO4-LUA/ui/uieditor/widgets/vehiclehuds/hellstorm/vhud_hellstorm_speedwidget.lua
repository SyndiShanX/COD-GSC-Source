require("x64:ae2cf5ba65e8174")
CoD.vhud_hellstorm_SpeedWidget = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_SpeedWidget.__defaultWidth = 220
CoD.vhud_hellstorm_SpeedWidget.__defaultHeight = 33
CoD.vhud_hellstorm_SpeedWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_SpeedWidget)
	self.id = "vhud_hellstorm_SpeedWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local speednumbers = LUI.UIText.new(0.5, 0.5, -65, 65, 0, 0, 19, 34)
	speednumbers:setTTF("0arame_mono_stencil")
	speednumbers:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	speednumbers:setShaderVector(0, 0, 1, 0, 0)
	speednumbers:setShaderVector(1, 0, 0, 0, 0)
	speednumbers:setShaderVector(2, 0, 0, 0, 0)
	speednumbers:setShaderVector(3, 0, 0, 0, 0)
	speednumbers:setShaderVector(4, 0, 0, 0, 0)
	speednumbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	speednumbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	speednumbers:linkToElementModel(self, "speed", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			speednumbers:setText(CoD.BaseUtility.RoundFraction(0, f2_local0))
		end
	end)
	self:addElement(speednumbers)
	self.speednumbers = speednumbers
	local vhudmsNotificationBox0 = CoD.vhud_ms_NotificationBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -65, 65, 0, 0, -0.5, 44.5)
	vhudmsNotificationBox0:setAlpha(0)
	vhudmsNotificationBox0.ALTtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_43755C926654C027"))
	self:addElement(vhudmsNotificationBox0)
	self.vhudmsNotificationBox0 = vhudmsNotificationBox0
	local TextBox = LUI.UIText.new(0, 0, 0, 220, 0, 0, -2.5, 12.5)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_43755C926654C027"))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_hellstorm_SpeedWidget.__onClose = function(f3_arg0)
	f3_arg0.speednumbers:close()
	f3_arg0.vhudmsNotificationBox0:close()
end
