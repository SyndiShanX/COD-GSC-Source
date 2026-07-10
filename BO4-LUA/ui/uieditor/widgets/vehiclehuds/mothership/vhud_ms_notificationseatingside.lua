CoD.vhud_ms_NotificationSeatingSide = InheritFrom(LUI.UIElement)
CoD.vhud_ms_NotificationSeatingSide.__defaultWidth = 49
CoD.vhud_ms_NotificationSeatingSide.__defaultHeight = 22
CoD.vhud_ms_NotificationSeatingSide.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_NotificationSeatingSide)
	self.id = "vhud_ms_NotificationSeatingSide"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local msSeatingBoxL = LUI.UIImage.new(0.5, 0.5, -24, 4, 0, 0, 4, 18)
	msSeatingBoxL:setImage(RegisterImage(0xB6EC1426EF9B0F3))
	msSeatingBoxL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msSeatingBoxL)
	self.msSeatingBoxL = msSeatingBoxL
	local Image0 = LUI.UIImage.new(1, 1, -22, 0, 0.5, 0.5, -11, 11)
	Image0:setImage(RegisterImage(0x595FE88BD044D30))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_NotificationSeatingSide.__resetProperties = function(f2_arg0)
	f2_arg0.Image0:completeAnimation()
	f2_arg0.msSeatingBoxL:completeAnimation()
	f2_arg0.Image0:setAlpha(1)
	f2_arg0.msSeatingBoxL:setAlpha(1)
end
CoD.vhud_ms_NotificationSeatingSide.__clipsPerState = {
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
			f4_arg0.msSeatingBoxL:completeAnimation()
			f4_arg0.msSeatingBoxL:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.msSeatingBoxL)
			f4_arg0.Image0:completeAnimation()
			f4_arg0.Image0:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Image0)
		end,
	},
}
