CoD.vhud_ms_NotificationSeatingTop = InheritFrom(LUI.UIElement)
CoD.vhud_ms_NotificationSeatingTop.__defaultWidth = 28
CoD.vhud_ms_NotificationSeatingTop.__defaultHeight = 42
CoD.vhud_ms_NotificationSeatingTop.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_NotificationSeatingTop)
	self.id = "vhud_ms_NotificationSeatingTop"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image1 = LUI.UIImage.new(0.5, 0.5, -14, 14, 0, 0, 28, 42)
	Image1:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_damagepassenger"))
	Image1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image1)
	self.Image1 = Image1
	local Image2 = LUI.UIImage.new(1, 1, -25, -3, 0.5, 0.5, -21, 1)
	Image2:setZRot(90)
	Image2:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_seatingarrow"))
	Image2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image2)
	self.Image2 = Image2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_NotificationSeatingTop.__resetProperties = function(f2_arg0)
	f2_arg0.Image1:completeAnimation()
	f2_arg0.Image2:completeAnimation()
	f2_arg0.Image1:setAlpha(1)
	f2_arg0.Image2:setAlpha(1)
end
CoD.vhud_ms_NotificationSeatingTop.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Image1:completeAnimation()
			f4_arg0.Image1:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Image1)
			f4_arg0.Image2:completeAnimation()
			f4_arg0.Image2:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Image2)
		end,
	},
}
