CoD.CallingCards_Asset_steampunkwarriors_gunsmoke = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_steampunkwarriors_gunsmoke.__defaultWidth = 10
CoD.CallingCards_Asset_steampunkwarriors_gunsmoke.__defaultHeight = 10
CoD.CallingCards_Asset_steampunkwarriors_gunsmoke.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_steampunkwarriors_gunsmoke)
	self.id = "CallingCards_Asset_steampunkwarriors_gunsmoke"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 0, -33, 39, 0, 0, -283, 37)
	Image:setImage(RegisterImage(0x94414E3405B163E))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
