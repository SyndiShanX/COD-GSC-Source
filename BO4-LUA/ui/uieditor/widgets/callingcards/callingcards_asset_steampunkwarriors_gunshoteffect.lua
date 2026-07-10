CoD.CallingCards_Asset_steampunkwarriors_gunshoteffect = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_steampunkwarriors_gunshoteffect.__defaultWidth = 10
CoD.CallingCards_Asset_steampunkwarriors_gunshoteffect.__defaultHeight = 10
CoD.CallingCards_Asset_steampunkwarriors_gunshoteffect.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_steampunkwarriors_gunshoteffect)
	self.id = "CallingCards_Asset_steampunkwarriors_gunshoteffect"
	self.soundSet = "default"
	local gunshot = LUI.UIImage.new(0, 0, -207, 97, 0, 0, -81, 95)
	gunshot:setImage(RegisterImage(0x5B081EF25253C37))
	gunshot:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(gunshot)
	self.gunshot = gunshot
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
