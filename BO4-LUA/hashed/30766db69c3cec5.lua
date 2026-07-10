CoD.SwipeTak5_LayoutPlusGrid = InheritFrom(LUI.UIElement)
CoD.SwipeTak5_LayoutPlusGrid.__defaultWidth = 530
CoD.SwipeTak5_LayoutPlusGrid.__defaultHeight = 322
CoD.SwipeTak5_LayoutPlusGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SwipeTak5_LayoutPlusGrid)
	self.id = "SwipeTak5_LayoutPlusGrid"
	self.soundSet = "default"
	local GridPlus01 = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 311.5, 321.5)
	GridPlus01:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus01:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus01)
	self.GridPlus01 = GridPlus01
	local GridPlus02 = LUI.UIImage.new(0, 0, 104, 114, 0, 0, 311.5, 321.5)
	GridPlus02:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus02:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus02)
	self.GridPlus02 = GridPlus02
	local GridPlus03 = LUI.UIImage.new(0, 0, 208, 218, 0, 0, 311.5, 321.5)
	GridPlus03:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus03:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus03)
	self.GridPlus03 = GridPlus03
	local GridPlus04 = LUI.UIImage.new(0, 0, 312, 322, 0, 0, 311.5, 321.5)
	GridPlus04:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus04:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus04:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus04)
	self.GridPlus04 = GridPlus04
	local GridPlus05 = LUI.UIImage.new(0, 0, 416, 426, 0, 0, 311.5, 321.5)
	GridPlus05:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus05:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus05:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus05)
	self.GridPlus05 = GridPlus05
	local GridPlus06 = LUI.UIImage.new(0, 0, 520, 530, 0, 0, 311.5, 321.5)
	GridPlus06:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus06:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus06:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus06)
	self.GridPlus06 = GridPlus06
	local GridPlus07 = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 208, 218)
	GridPlus07:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus07:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus07:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus07)
	self.GridPlus07 = GridPlus07
	local GridPlus08 = LUI.UIImage.new(0, 0, 104, 114, 0, 0, 208, 218)
	GridPlus08:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus08:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus08:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus08)
	self.GridPlus08 = GridPlus08
	local GridPlus09 = LUI.UIImage.new(0, 0, 208, 218, 0, 0, 208, 218)
	GridPlus09:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus09:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus09:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus09)
	self.GridPlus09 = GridPlus09
	local GridPlus10 = LUI.UIImage.new(0, 0, 312, 322, 0, 0, 208, 218)
	GridPlus10:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus10:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus10:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus10)
	self.GridPlus10 = GridPlus10
	local GridPlus11 = LUI.UIImage.new(0, 0, 416, 426, 0, 0, 208, 218)
	GridPlus11:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus11:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus11:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus11)
	self.GridPlus11 = GridPlus11
	local GridPlus12 = LUI.UIImage.new(0, 0, 520, 530, 0, 0, 208, 218)
	GridPlus12:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus12:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus12:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus12)
	self.GridPlus12 = GridPlus12
	local GridPlus13 = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 104, 114)
	GridPlus13:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus13:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus13:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus13)
	self.GridPlus13 = GridPlus13
	local GridPlus14 = LUI.UIImage.new(0, 0, 104, 114, 0, 0, 104, 114)
	GridPlus14:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus14:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus14:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus14)
	self.GridPlus14 = GridPlus14
	local GridPlus15 = LUI.UIImage.new(0, 0, 208, 218, 0, 0, 104, 114)
	GridPlus15:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus15:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus15:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus15)
	self.GridPlus15 = GridPlus15
	local GridPlus16 = LUI.UIImage.new(0, 0, 312, 322, 0, 0, 104, 114)
	GridPlus16:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus16:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus16:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus16)
	self.GridPlus16 = GridPlus16
	local GridPlus17 = LUI.UIImage.new(0, 0, 416, 426, 0, 0, 104, 114)
	GridPlus17:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus17:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus17:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus17)
	self.GridPlus17 = GridPlus17
	local GridPlus18 = LUI.UIImage.new(0, 0, 520, 530, 0, 0, 104, 114)
	GridPlus18:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus18:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus18:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus18)
	self.GridPlus18 = GridPlus18
	local GridPlus19 = LUI.UIImage.new(0, 0, 520, 530, 0, 0, 0, 10)
	GridPlus19:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus19:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus19:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus19)
	self.GridPlus19 = GridPlus19
	local GridPlus20 = LUI.UIImage.new(0, 0, 416, 426, 0, 0, 0, 10)
	GridPlus20:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus20:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus20:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus20)
	self.GridPlus20 = GridPlus20
	local GridPlus21 = LUI.UIImage.new(0, 0, 312, 322, 0, 0, 0, 10)
	GridPlus21:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus21:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus21:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus21)
	self.GridPlus21 = GridPlus21
	local GridPlus22 = LUI.UIImage.new(0, 0, 208, 218, 0, 0, 0, 10)
	GridPlus22:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus22:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus22:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus22)
	self.GridPlus22 = GridPlus22
	local GridPlus23 = LUI.UIImage.new(0, 0, 104, 114, 0, 0, 0, 10)
	GridPlus23:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus23:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus23:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus23)
	self.GridPlus23 = GridPlus23
	local GridPlus24 = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 0, 10)
	GridPlus24:setImage(RegisterImage(0x43D9C0C33B14125))
	GridPlus24:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridPlus24:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridPlus24)
	self.GridPlus24 = GridPlus24
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
