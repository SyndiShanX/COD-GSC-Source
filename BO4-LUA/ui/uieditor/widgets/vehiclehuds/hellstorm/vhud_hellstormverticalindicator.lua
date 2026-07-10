CoD.vhud_HellstormVerticalIndicator = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormVerticalIndicator.__defaultWidth = 80
CoD.vhud_HellstormVerticalIndicator.__defaultHeight = 100
CoD.vhud_HellstormVerticalIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormVerticalIndicator)
	self.id = "vhud_HellstormVerticalIndicator"
	self.soundSet = "default"
	local LayoutBar = LUI.UIImage.new(0, 0, 8, 72, 0, 0, 88, 0)
	LayoutBar:setImage(RegisterImage(0x328F3B7DAD2C9EA))
	LayoutBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	LayoutBar:setShaderVector(0, 0, 1, 0, 0)
	LayoutBar:setShaderVector(1, 0, 0, 0, 0)
	LayoutBar:setShaderVector(2, 0, 1, 0, 0)
	LayoutBar:setShaderVector(3, 0, 0, 0, 0)
	LayoutBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LayoutBar)
	self.LayoutBar = LayoutBar
	local LayoutBarAdd = LUI.UIImage.new(0, 0, 8, 72, 0, 0, 88, 0)
	LayoutBarAdd:setAlpha(0.5)
	LayoutBarAdd:setImage(RegisterImage(0x328F3B7DAD2C9EA))
	LayoutBarAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x5956C6C1FD41D3C))
	LayoutBarAdd:setShaderVector(0, 0.2, 1, 0, 0)
	LayoutBarAdd:setShaderVector(1, 0, 0, 0, 0)
	LayoutBarAdd:setShaderVector(2, 0, 0, 0, 0)
	LayoutBarAdd:setShaderVector(3, 0, 0, 0, 0)
	LayoutBarAdd:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LayoutBarAdd)
	self.LayoutBarAdd = LayoutBarAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
