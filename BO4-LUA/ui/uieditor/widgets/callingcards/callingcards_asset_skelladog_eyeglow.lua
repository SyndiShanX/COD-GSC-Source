CoD.CallingCards_Asset_skelladog_eyeglow = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_skelladog_eyeglow.__defaultWidth = 689
CoD.CallingCards_Asset_skelladog_eyeglow.__defaultHeight = 78
CoD.CallingCards_Asset_skelladog_eyeglow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_skelladog_eyeglow)
	self.id = "CallingCards_Asset_skelladog_eyeglow"
	self.soundSet = "default"
	local eyeFlareImage = LUI.UIImage.new(0, 0, 477, 600, 0, 0, 0, 68)
	eyeFlareImage:setImage(RegisterImage(0x9E525E6B1CD616F))
	self:addElement(eyeFlareImage)
	self.eyeFlareImage = eyeFlareImage
	local eyeFlareImage3 = LUI.UIImage.new(0, 0, 118, 241, 0, 0, 5, 73)
	eyeFlareImage3:setImage(RegisterImage(0x9E525E6B1CD616F))
	self:addElement(eyeFlareImage3)
	self.eyeFlareImage3 = eyeFlareImage3
	local eyeFlareImage4 = LUI.UIImage.new(0, 0, 84, 207, 0, 0, 10, 78)
	eyeFlareImage4:setImage(RegisterImage(0x9E525E6B1CD616F))
	self:addElement(eyeFlareImage4)
	self.eyeFlareImage4 = eyeFlareImage4
	local eyeFlareImage5 = LUI.UIImage.new(0, 0, 0, 58, 0, 0, 27, 59)
	eyeFlareImage5:setImage(RegisterImage(0x9E525E6B1CD616F))
	self:addElement(eyeFlareImage5)
	self.eyeFlareImage5 = eyeFlareImage5
	local eyeFlareImage6 = LUI.UIImage.new(0, 0, 619, 677, 0, 0, 34, 66)
	eyeFlareImage6:setImage(RegisterImage(0x9E525E6B1CD616F))
	self:addElement(eyeFlareImage6)
	self.eyeFlareImage6 = eyeFlareImage6
	local eyeFlareImage7 = LUI.UIImage.new(0, 0, 631, 689, 0, 0, 43, 75)
	eyeFlareImage7:setImage(RegisterImage(0x9E525E6B1CD616F))
	self:addElement(eyeFlareImage7)
	self.eyeFlareImage7 = eyeFlareImage7
	local eyeFlareImage2 = LUI.UIImage.new(0, 0, 525.5, 621.5, 0, 0, 5, 58)
	eyeFlareImage2:setImage(RegisterImage(0x9E525E6B1CD616F))
	self:addElement(eyeFlareImage2)
	self.eyeFlareImage2 = eyeFlareImage2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
