CoD.vhud_ms_NotificationFlir = InheritFrom(LUI.UIElement)
CoD.vhud_ms_NotificationFlir.__defaultWidth = 121
CoD.vhud_ms_NotificationFlir.__defaultHeight = 45
CoD.vhud_ms_NotificationFlir.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_NotificationFlir)
	self.id = "vhud_ms_NotificationFlir"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowOrangeOver = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, -2)
	GlowOrangeOver:setRGB(0.42, 0.93, 1)
	GlowOrangeOver:setAlpha(0.4)
	GlowOrangeOver:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	GlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowOrangeOver)
	self.GlowOrangeOver = GlowOrangeOver
	local NotificationAltBox0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAltBox0:setRGB(0.74, 0.94, 0.99)
	NotificationAltBox0:setAlpha(0.08)
	NotificationAltBox0:setYRot(-20)
	NotificationAltBox0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_notificationsignalbox"))
	self:addElement(NotificationAltBox0)
	self.NotificationAltBox0 = NotificationAltBox0
	local NotificationAltBox00 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAltBox00:setRGB(0.74, 0.94, 0.99)
	NotificationAltBox00:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_notificationsignalbox"))
	self:addElement(NotificationAltBox00)
	self.NotificationAltBox00 = NotificationAltBox00
	local FLIR = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -12, 12)
	FLIR:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_D90B4CA18DA31B7"))
	FLIR:setTTF("default")
	FLIR:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	FLIR:setShaderVector(0, 0, 1, 0, 0)
	FLIR:setShaderVector(1, 0, 0, 0, 0)
	FLIR:setShaderVector(2, 0, 0, 0, 0)
	FLIR:setShaderVector(3, 0, 0, 0, 0)
	FLIR:setShaderVector(4, 0, 0, 0, 0)
	FLIR:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FLIR:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(FLIR, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWithMinimum(self, element, 25, 81)
	end)
	self:addElement(FLIR)
	self.FLIR = FLIR
	local arrowUp = LUI.UIImage.new(0.5, 0.5, -5, 6, 0.5, 0.5, -21, -14)
	arrowUp:setAlpha(0.6)
	arrowUp:setImage(RegisterImage(@"uie_img_t7_menu_startmenu_option_arrow"))
	arrowUp:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(arrowUp)
	self.arrowUp = arrowUp
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_NotificationFlir.__resetProperties = function(f3_arg0)
	f3_arg0.GlowOrangeOver:completeAnimation()
	f3_arg0.arrowUp:completeAnimation()
	f3_arg0.GlowOrangeOver:setAlpha(0.4)
	f3_arg0.GlowOrangeOver:setScale(1, 1)
	f3_arg0.arrowUp:setAlpha(0.6)
end
CoD.vhud_ms_NotificationFlir.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.GlowOrangeOver:completeAnimation()
			f4_arg0.GlowOrangeOver:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.GlowOrangeOver)
			f4_arg0.arrowUp:completeAnimation()
			f4_arg0.arrowUp:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.arrowUp)
		end,
		StartUp = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Active = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.GlowOrangeOver:completeAnimation()
			f6_arg0.GlowOrangeOver:setAlpha(0.25)
			f6_arg0.GlowOrangeOver:setScale(1.2, 1.2)
			f6_arg0.clipFinished(f6_arg0.GlowOrangeOver)
		end,
	},
}
