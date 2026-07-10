CoD.TabletTak5Grid = InheritFrom(LUI.UIElement)
CoD.TabletTak5Grid.__defaultWidth = 209
CoD.TabletTak5Grid.__defaultHeight = 110
CoD.TabletTak5Grid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletTak5Grid)
	self.id = "TabletTak5Grid"
	self.soundSet = "default"
	local GridPlus = LUI.UIImage.new(0, 0, 198.5, 208.5, 0, 0, 100, 110)
	GridPlus:setImage(RegisterImage(@"hash_543D9C0C33B14125"))
	GridPlus:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GridPlus:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GridPlus)
	self.GridPlus = GridPlus
	local GridPlus2 = LUI.UIImage.new(0, 0, 99, 109, 0, 0, 100, 110)
	GridPlus2:setImage(RegisterImage(@"hash_543D9C0C33B14125"))
	GridPlus2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GridPlus2:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GridPlus2)
	self.GridPlus2 = GridPlus2
	local GridPlus3 = LUI.UIImage.new(0, 0, 198.5, 208.5, 0, 0, 0, 10)
	GridPlus3:setImage(RegisterImage(@"hash_543D9C0C33B14125"))
	GridPlus3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GridPlus3:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GridPlus3)
	self.GridPlus3 = GridPlus3
	local GridPlus4 = LUI.UIImage.new(0, 0, 99, 109, 0, 0, 0, 10)
	GridPlus4:setImage(RegisterImage(@"hash_543D9C0C33B14125"))
	GridPlus4:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GridPlus4:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GridPlus4)
	self.GridPlus4 = GridPlus4
	local GridPlus5 = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 100, 110)
	GridPlus5:setImage(RegisterImage(@"hash_543D9C0C33B14125"))
	GridPlus5:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GridPlus5:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GridPlus5)
	self.GridPlus5 = GridPlus5
	local GridPlus6 = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 0, 10)
	GridPlus6:setImage(RegisterImage(@"hash_543D9C0C33B14125"))
	GridPlus6:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GridPlus6:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GridPlus6)
	self.GridPlus6 = GridPlus6
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
