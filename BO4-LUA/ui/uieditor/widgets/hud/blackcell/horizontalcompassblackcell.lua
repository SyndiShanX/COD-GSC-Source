CoD.HorizontalCompassBlackCell = InheritFrom(LUI.UIElement)
CoD.HorizontalCompassBlackCell.__defaultWidth = 1114
CoD.HorizontalCompassBlackCell.__defaultHeight = 112
CoD.HorizontalCompassBlackCell.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HorizontalCompassBlackCell)
	self.id = "HorizontalCompassBlackCell"
	self.soundSet = "default"
	local user = LUI.UIImage.new(0.5, 0.5, -28, 28, 1, 1, -51, 5)
	user:setImage(RegisterImage(0x65AA457EFC48EF6))
	self:addElement(user)
	self.user = user
	local enemy = LUI.UIImage.new(0.5, 0.5, -28, 28, 0, 0, -4, 52)
	enemy:setAlpha(0)
	enemy:setImage(RegisterImage(0x63400FA1D7F77D6))
	self:addElement(enemy)
	self.enemy = enemy
	local HorizontalCompass = LUI.UIImage.new(0.5, 0.5, -431.5, 431.5, 0.5, 0.5, -26, 11)
	HorizontalCompass:setupHorizontalCompass(0.75)
	HorizontalCompass:setImage(RegisterMaterial("hud_horizontal_compass_blackcell"))
	HorizontalCompass:setShaderVector(0, 0.6, 0, 0, 0)
	self:addElement(HorizontalCompass)
	self.HorizontalCompass = HorizontalCompass
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
