CoD.CallingCards_Asset_pirate_arm = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_pirate_arm.__defaultWidth = 814
CoD.CallingCards_Asset_pirate_arm.__defaultHeight = 128
CoD.CallingCards_Asset_pirate_arm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_pirate_arm)
	self.id = "CallingCards_Asset_pirate_arm"
	self.soundSet = "default"
	local captainArm = LUI.UIImage.new(0, 0, 0, 407, 0, 0, 0, 128)
	captainArm:setAlpha(0.9)
	captainArm:setImage(RegisterImage(0x9BA2438245E911C))
	self:addElement(captainArm)
	self.captainArm = captainArm
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
