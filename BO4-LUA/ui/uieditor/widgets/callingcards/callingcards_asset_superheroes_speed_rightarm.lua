CoD.CallingCards_Asset_superheroes_speed_rightarm = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_superheroes_speed_rightarm.__defaultWidth = 10
CoD.CallingCards_Asset_superheroes_speed_rightarm.__defaultHeight = 10
CoD.CallingCards_Asset_superheroes_speed_rightarm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_superheroes_speed_rightarm)
	self.id = "CallingCards_Asset_superheroes_speed_rightarm"
	self.soundSet = "default"
	local rightarm = LUI.UIImage.new(0, 0, -294, 34, 0, 0, -24, 136)
	rightarm:setImage(RegisterImage(0xB6095FD1CC47F34))
	self:addElement(rightarm)
	self.rightarm = rightarm
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
