CoD.BowLauncherReticle_L1 = InheritFrom(LUI.UIElement)
CoD.BowLauncherReticle_L1.__defaultWidth = 160
CoD.BowLauncherReticle_L1.__defaultHeight = 160
CoD.BowLauncherReticle_L1.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BowLauncherReticle_L1)
	self.id = "BowLauncherReticle_L1"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Line1 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Line1:setAlpha(0)
	Line1:setImage(RegisterImage(0x43FE29993DEBD23))
	Line1:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Line1)
	self.Line1 = Line1
	local WingL = LUI.UIImage.new(-1.31, -1.2, 220, 220, 0.27, 0.5, 34.5, 34.5)
	WingL:setImage(RegisterImage(0x3CE9CF4F5C3D42F))
	self:addElement(WingL)
	self.WingL = WingL
	local WingR = LUI.UIImage.new(-1.08, -0.96, 304, 304, 0.4, 0.63, 12.5, 12.5)
	WingR:setImage(RegisterImage(0x3CE92F4F5C3C331))
	self:addElement(WingR)
	self.WingR = WingR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BowLauncherReticle_L1.__resetProperties = function(f2_arg0)
	f2_arg0.Line1:completeAnimation()
	f2_arg0.WingL:completeAnimation()
	f2_arg0.WingR:completeAnimation()
	f2_arg0.Line1:setAlpha(0)
	f2_arg0.WingL:setLeftRight(-1.31, -1.2, 220, 220)
	f2_arg0.WingR:setLeftRight(-1.08, -0.96, 304, 304)
end
CoD.BowLauncherReticle_L1.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Drawn = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Line1:completeAnimation()
			f4_arg0.Line1:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Line1)
			f4_arg0.WingL:completeAnimation()
			f4_arg0.WingL:setLeftRight(-1.31, -1.2, 264, 264)
			f4_arg0.clipFinished(f4_arg0.WingL)
			f4_arg0.WingR:completeAnimation()
			f4_arg0.WingR:setLeftRight(-1.08, -0.96, 260, 260)
			f4_arg0.clipFinished(f4_arg0.WingR)
		end,
	},
}
