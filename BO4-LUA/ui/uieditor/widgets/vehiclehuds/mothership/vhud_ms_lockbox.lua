CoD.vhud_ms_LockBox = InheritFrom(LUI.UIElement)
CoD.vhud_ms_LockBox.__defaultWidth = 82
CoD.vhud_ms_LockBox.__defaultHeight = 82
CoD.vhud_ms_LockBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_LockBox)
	self.id = "vhud_ms_LockBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glow = LUI.UIImage.new(0.5, 0.5, -59, 59, 0.5, 0.5, -35, 34)
	Glow:setRGB(1, 0.52, 0)
	Glow:setAlpha(0.4)
	Glow:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_textlockonglow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local msLockOn = LUI.UIImage.new(0.5, 0.5, -41.5, 41.5, 0.5, 0.5, -41, 42)
	msLockOn:setRGB(1, 0.07, 0)
	msLockOn:setAlpha(0.7)
	msLockOn:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_textlockon"))
	msLockOn:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(msLockOn)
	self.msLockOn = msLockOn
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_LockBox.__resetProperties = function(f2_arg0)
	f2_arg0.Glow:completeAnimation()
	f2_arg0.msLockOn:completeAnimation()
	f2_arg0.Glow:setAlpha(0.4)
	f2_arg0.msLockOn:setAlpha(0.7)
end
CoD.vhud_ms_LockBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Glow:completeAnimation()
			f3_arg0.Glow:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Glow)
			f3_arg0.msLockOn:completeAnimation()
			f3_arg0.msLockOn:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.msLockOn)
		end,
	},
	On = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Glow:completeAnimation()
			f4_arg0.Glow:setAlpha(0.2)
			f4_arg0.clipFinished(f4_arg0.Glow)
		end,
	},
	HasLock = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Glow:completeAnimation()
			f5_arg0.Glow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Glow)
		end,
	},
}
