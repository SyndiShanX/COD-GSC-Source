CoD.vhud_layoutPlusGrid = InheritFrom(LUI.UIElement)
CoD.vhud_layoutPlusGrid.__defaultWidth = 234
CoD.vhud_layoutPlusGrid.__defaultHeight = 235
CoD.vhud_layoutPlusGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_layoutPlusGrid)
	self.id = "vhud_layoutPlusGrid"
	self.soundSet = "default"
	local gridPlus01 = LUI.UIImage.new(0, 0, 0, 18, 0, 0, 0, 18)
	gridPlus01:setImage(RegisterImage(0xFC173FF2534BB4C))
	gridPlus01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	gridPlus01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(gridPlus01)
	self.gridPlus01 = gridPlus01
	local gridPlus02 = LUI.UIImage.new(0, 0, 216, 234, 0, 0, 0, 18)
	gridPlus02:setImage(RegisterImage(0xFC173FF2534BB4C))
	gridPlus02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	gridPlus02:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(gridPlus02)
	self.gridPlus02 = gridPlus02
	local gridPlus03 = LUI.UIImage.new(0, 0, 1, 19, 0, 0, 216.5, 234.5)
	gridPlus03:setImage(RegisterImage(0xFC173FF2534BB4C))
	gridPlus03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	gridPlus03:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(gridPlus03)
	self.gridPlus03 = gridPlus03
	local gridPlus04 = LUI.UIImage.new(0, 0, 216, 234, 0, 0, 216.5, 234.5)
	gridPlus04:setImage(RegisterImage(0xFC173FF2534BB4C))
	gridPlus04:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	gridPlus04:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(gridPlus04)
	self.gridPlus04 = gridPlus04
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
