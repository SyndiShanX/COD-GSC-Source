CoD.smokewidget = InheritFrom(LUI.UIElement)
CoD.smokewidget.__defaultWidth = 273
CoD.smokewidget.__defaultHeight = 357
CoD.smokewidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.smokewidget)
	self.id = "smokewidget"
	self.soundSet = "default"
	local smoke1 = LUI.UIImage.new(0, 0, -8, 280, 0, 0, 0, 267)
	smoke1:setImage(RegisterImage(0x3A1BD0A6BCA88EE))
	smoke1:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	smoke1:setShaderVector(0, 1, 0.66, 0, 0)
	smoke1:setShaderVector(1, 0, 0.08, 0, 0)
	self:addElement(smoke1)
	self.smoke1 = smoke1
	local smoke2 = LUI.UIImage.new(0, 0, -8, 280, 0, 0, 0, 267)
	smoke2:setImage(RegisterImage(0x3A1BD0A6BCA88EE))
	smoke2:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	smoke2:setShaderVector(0, 1, 0.66, 0, 0)
	smoke2:setShaderVector(1, 0, 0.08, 0, 0)
	self:addElement(smoke2)
	self.smoke2 = smoke2
	local smoke3 = LUI.UIImage.new(0, 0, -8, 280, 0, 0, 0, 267)
	smoke3:setImage(RegisterImage(0x3A1BD0A6BCA88EE))
	smoke3:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	smoke3:setShaderVector(0, 1, 0.66, 0, 0)
	smoke3:setShaderVector(1, 0, 0.08, 0, 0)
	self:addElement(smoke3)
	self.smoke3 = smoke3
	local smoke4 = LUI.UIImage.new(0, 0, -8, 280, 0, 0, 0, 267)
	smoke4:setImage(RegisterImage(0x3A1BD0A6BCA88EE))
	smoke4:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	smoke4:setShaderVector(0, 1, 0.66, 0, 0)
	smoke4:setShaderVector(1, 0, 0.08, 0, 0)
	self:addElement(smoke4)
	self.smoke4 = smoke4
	local mask = LUI.UIImage.new(0, 0, 0, 273, 0, 0, -57, 357)
	mask:setImage(RegisterImage(0x1A57A07BDE1F1E0))
	self:addElement(mask)
	self.mask = mask
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
