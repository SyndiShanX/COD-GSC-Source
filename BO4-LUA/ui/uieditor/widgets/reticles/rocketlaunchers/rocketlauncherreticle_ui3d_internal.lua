require("x64:5e9cbf7380a884d")
require("x64:ca0eb707e29487a")
require("x64:e83ff1effe38ef5")
CoD.rocketLauncherReticle_UI3D_Internal = InheritFrom(LUI.UIElement)
CoD.rocketLauncherReticle_UI3D_Internal.__defaultWidth = 768
CoD.rocketLauncherReticle_UI3D_Internal.__defaultHeight = 768
CoD.rocketLauncherReticle_UI3D_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.rocketLauncherReticle_UI3D_Internal)
	self.id = "rocketLauncherReticle_UI3D_Internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GreenBacking = LUI.UIImage.new(0, 0, 0, 759, 0, 0, 101, 667)
	GreenBacking:setRGB(0.64, 1, 0.81)
	GreenBacking:setAlpha(0.45)
	GreenBacking:setImage(RegisterImage(0xD2B81E07F5D9C6E))
	self:addElement(GreenBacking)
	self.GreenBacking = GreenBacking
	local reticle = LUI.UIImage.new(0, 0, 12, 762, 0, 0, 90, 649)
	reticle:setRGB(0.64, 1, 0.81)
	reticle:setImage(RegisterImage(0xFFC4F3156666395))
	self:addElement(reticle)
	self.reticle = reticle
	local Target = CoD.Target.new(f1_arg0, f1_arg1, 0, 0, 573, 750, 0, 0, 386, 476)
	Target:setRGB(0.64, 1, 0.81)
	Target:setScale(0.8, 0.8)
	self:addElement(Target)
	self.Target = Target
	local Timer = CoD.Timer.new(f1_arg0, f1_arg1, 0, 0, 575, 766, 0, 0, 298, 385)
	Timer:setRGB(0.64, 1, 0.81)
	Timer:setScale(0.8, 0.8)
	self:addElement(Timer)
	self.Timer = Timer
	local TeamMateLockOn = CoD.TeamMateLockOn.new(f1_arg0, f1_arg1, 0, 0, 5, 208, 0, 0, 307, 461)
	TeamMateLockOn:setScale(0.9, 0.9)
	self:addElement(TeamMateLockOn)
	self.TeamMateLockOn = TeamMateLockOn
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.rocketLauncherReticle_UI3D_Internal.__resetProperties = function(f2_arg0)
	f2_arg0.reticle:completeAnimation()
	f2_arg0.Target:completeAnimation()
	f2_arg0.Timer:completeAnimation()
	f2_arg0.GreenBacking:completeAnimation()
	f2_arg0.reticle:setRGB(0.64, 1, 0.81)
	f2_arg0.Target:setRGB(0.64, 1, 0.81)
	f2_arg0.Timer:setRGB(0.64, 1, 0.81)
	f2_arg0.GreenBacking:setRGB(0.64, 1, 0.81)
end
CoD.rocketLauncherReticle_UI3D_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Locked = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.GreenBacking:completeAnimation()
			f4_arg0.GreenBacking:setRGB(1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.GreenBacking)
			f4_arg0.reticle:completeAnimation()
			f4_arg0.reticle:setRGB(1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.reticle)
			f4_arg0.Target:completeAnimation()
			f4_arg0.Target:setRGB(1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.Target)
			f4_arg0.Timer:completeAnimation()
			f4_arg0.Timer:setRGB(1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.Timer)
		end,
	},
}
CoD.rocketLauncherReticle_UI3D_Internal.__onClose = function(f5_arg0)
	f5_arg0.Target:close()
	f5_arg0.Timer:close()
	f5_arg0.TeamMateLockOn:close()
end
