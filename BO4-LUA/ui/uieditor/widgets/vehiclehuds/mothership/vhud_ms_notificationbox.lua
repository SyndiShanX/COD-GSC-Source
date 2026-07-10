CoD.vhud_ms_NotificationBox = InheritFrom(LUI.UIElement)
CoD.vhud_ms_NotificationBox.__defaultWidth = 121
CoD.vhud_ms_NotificationBox.__defaultHeight = 45
CoD.vhud_ms_NotificationBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_NotificationBox)
	self.id = "vhud_ms_NotificationBox"
	self.soundSet = "default"
	local NotificationAltBox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAltBox:setAlpha(0.08)
	NotificationAltBox:setZoom(-20)
	NotificationAltBox:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_notificationbox"))
	NotificationAltBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	NotificationAltBox:setShaderVector(0, 0, 0, 0, 0)
	NotificationAltBox:setupNineSliceShader(27, 15)
	self:addElement(NotificationAltBox)
	self.NotificationAltBox = NotificationAltBox
	local NotificationAltBox0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAltBox0:setRGB(0.74, 0.94, 0.99)
	NotificationAltBox0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_notificationbox"))
	NotificationAltBox0:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	NotificationAltBox0:setShaderVector(0, 0, 0, 0, 0)
	NotificationAltBox0:setupNineSliceShader(27, 15)
	self:addElement(NotificationAltBox0)
	self.NotificationAltBox0 = NotificationAltBox0
	local ALTtext = LUI.UIText.new(0.5, 0.5, -150, 150, 0.5, 0.5, -11, 13)
	ALTtext:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BD23A68618982EF"))
	ALTtext:setTTF("default")
	ALTtext:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	ALTtext:setShaderVector(0, 0, 1, 0, 0)
	ALTtext:setShaderVector(1, 0, 0, 0, 0)
	ALTtext:setShaderVector(2, 0, 0, 0, 0)
	ALTtext:setShaderVector(3, 0, 0, 0, 0)
	ALTtext:setShaderVector(4, 0, 0, 0, 0)
	ALTtext:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ALTtext:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(ALTtext, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWithMinimum(self, element, 20, 81)
	end)
	self:addElement(ALTtext)
	self.ALTtext = ALTtext
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
