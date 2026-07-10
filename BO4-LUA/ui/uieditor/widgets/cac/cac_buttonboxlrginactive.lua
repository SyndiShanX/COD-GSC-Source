CoD.cac_ButtonBoxLrgInactive = InheritFrom(LUI.UIElement)
CoD.cac_ButtonBoxLrgInactive.__defaultWidth = 168
CoD.cac_ButtonBoxLrgInactive.__defaultHeight = 168
CoD.cac_ButtonBoxLrgInactive.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cac_ButtonBoxLrgInactive)
	self.id = "cac_ButtonBoxLrgInactive"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setAlpha(0.8)
	Image:setImage(RegisterImage(@"uie_t7_menu_cac_buttonboxlrginactivefull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Image:setShaderVector(0, 0, 0, 0.36, 0.36)
	Image:setupNineSliceShader(24, 24)
	self:addElement(Image)
	self.Image = Image
	local strokeTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	strokeTop:setRGB(0.38, 0.36, 0.33)
	self:addElement(strokeTop)
	self.strokeTop = strokeTop
	local strokeBot = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 1)
	strokeBot:setRGB(0.38, 0.36, 0.33)
	self:addElement(strokeBot)
	self.strokeBot = strokeBot
	local strokeLeft = LUI.UIImage.new(0, 0, 0, 2, 0, 1, 0, 0)
	strokeLeft:setRGB(0.38, 0.36, 0.33)
	self:addElement(strokeLeft)
	self.strokeLeft = strokeLeft
	local strokeRight = LUI.UIImage.new(1, 1, -1, 0, 0, 1, 0, 0)
	strokeRight:setRGB(0.38, 0.36, 0.33)
	self:addElement(strokeRight)
	self.strokeRight = strokeRight
	local corner1 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	self:addElement(corner1)
	self.corner1 = corner1
	local Image2 = LUI.UIImage.new(1, 1, -0.5, 0.5, 0, 0, 0, 1)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(1, 1, 0, 1, 1, 1, 0, 1)
	self:addElement(Image3)
	self.Image3 = Image3
	local Image4 = LUI.UIImage.new(0, 0, 0, 1, 1, 1, 0, 1)
	self:addElement(Image4)
	self.Image4 = Image4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
