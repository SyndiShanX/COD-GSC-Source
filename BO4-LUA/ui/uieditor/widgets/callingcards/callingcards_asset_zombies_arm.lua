CoD.CallingCards_Asset_zombies_arm = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_zombies_arm.__defaultWidth = 30
CoD.CallingCards_Asset_zombies_arm.__defaultHeight = 30
CoD.CallingCards_Asset_zombies_arm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_zombies_arm)
	self.id = "CallingCards_Asset_zombies_arm"
	self.soundSet = "default"
	local arm = LUI.UIImage.new(0, 0, -36, 356, 0, 0, -132, 132)
	arm:setImage(RegisterImage(0x51843256F2F4C18))
	self:addElement(arm)
	self.arm = arm
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
