CoD.BowLauncherReticle_L2 = InheritFrom(LUI.UIElement)
CoD.BowLauncherReticle_L2.__defaultWidth = 160
CoD.BowLauncherReticle_L2.__defaultHeight = 160
CoD.BowLauncherReticle_L2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BowLauncherReticle_L2)
	self.id = "BowLauncherReticle_L2"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Line2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Line2:setAlpha(0)
	Line2:setImage(RegisterImage(0x43FE39993DEBED6))
	Line2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Line2)
	self.Line2 = Line2
	local pip1 = LUI.UIImage.new(0.25, 0.75, 0, 0, 0.25, 0.75, 0, 0)
	pip1:setImage(RegisterImage(0x62EAE1CA751BEA4))
	self:addElement(pip1)
	self.pip1 = pip1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BowLauncherReticle_L2.__resetProperties = function(f2_arg0)
	f2_arg0.Line2:completeAnimation()
	f2_arg0.Line2:setAlpha(0)
end
CoD.BowLauncherReticle_L2.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Drawn = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Line2:completeAnimation()
			f4_arg0.Line2:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Line2)
		end,
	},
}
