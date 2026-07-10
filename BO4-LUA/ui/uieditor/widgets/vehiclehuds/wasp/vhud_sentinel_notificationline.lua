CoD.vhud_sentinel_NotificationLine = InheritFrom(LUI.UIElement)
CoD.vhud_sentinel_NotificationLine.__defaultWidth = 118
CoD.vhud_sentinel_NotificationLine.__defaultHeight = 12
CoD.vhud_sentinel_NotificationLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_sentinel_NotificationLine)
	self.id = "vhud_sentinel_NotificationLine"
	self.soundSet = "default"
	local NotificationAmmoLineTop0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAmmoLineTop0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_notificationline"))
	NotificationAmmoLineTop0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(NotificationAmmoLineTop0)
	self.NotificationAmmoLineTop0 = NotificationAmmoLineTop0
	local NotificationAmmoLineTop00 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAmmoLineTop00:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_notificationline"))
	NotificationAmmoLineTop00:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(NotificationAmmoLineTop00)
	self.NotificationAmmoLineTop00 = NotificationAmmoLineTop00
	local NotificationAmmoLineTop000 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NotificationAmmoLineTop000:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_notificationline"))
	NotificationAmmoLineTop000:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(NotificationAmmoLineTop000)
	self.NotificationAmmoLineTop000 = NotificationAmmoLineTop000
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
