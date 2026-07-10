CoD.vhud_ms_DamageIconSide = InheritFrom(LUI.UIElement)
CoD.vhud_ms_DamageIconSide.__defaultWidth = 39
CoD.vhud_ms_DamageIconSide.__defaultHeight = 39
CoD.vhud_ms_DamageIconSide.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_DamageIconSide)
	self.id = "vhud_ms_DamageIconSide"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local msDamageRight = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msDamageRight:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_damageredside"))
	self:addElement(msDamageRight)
	self.msDamageRight = msDamageRight
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_DamageIconSide.__resetProperties = function(f2_arg0)
	f2_arg0.msDamageRight:completeAnimation()
	f2_arg0.msDamageRight:setAlpha(1)
end
CoD.vhud_ms_DamageIconSide.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.msDamageRight:completeAnimation()
			f4_arg0.msDamageRight:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.msDamageRight)
		end,
	},
}
