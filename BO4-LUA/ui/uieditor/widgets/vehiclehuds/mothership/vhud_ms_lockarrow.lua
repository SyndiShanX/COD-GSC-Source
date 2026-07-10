CoD.vhud_ms_LockArrow = InheritFrom(LUI.UIElement)
CoD.vhud_ms_LockArrow.__defaultWidth = 54
CoD.vhud_ms_LockArrow.__defaultHeight = 54
CoD.vhud_ms_LockArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_LockArrow)
	self.id = "vhud_ms_LockArrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0.5, 0.5, -18, 16, 0.5, 0.5, -18, 16)
	Image0:setRGB(1, 0.03, 0)
	Image0:setAlpha(0.7)
	Image0:setZRot(90)
	Image0:setImage(RegisterImage(0x1234A0111C7E7F0))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_LockArrow.__resetProperties = function(f2_arg0)
	f2_arg0.Image0:completeAnimation()
	f2_arg0.Image0:setRGB(1, 0.03, 0)
	f2_arg0.Image0:setAlpha(0.7)
end
CoD.vhud_ms_LockArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Image0:completeAnimation()
			f3_arg0.Image0:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Image0)
		end,
		StartUp = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Zoom = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	On = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Image0:completeAnimation()
			f6_arg0.Image0:setRGB(1, 0, 0.06)
			f6_arg0.Image0:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Image0)
		end,
	},
}
