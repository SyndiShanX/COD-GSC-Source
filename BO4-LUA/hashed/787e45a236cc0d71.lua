CoD.SpawnSelectLayoutGrid = InheritFrom(LUI.UIElement)
CoD.SpawnSelectLayoutGrid.__defaultWidth = 1572
CoD.SpawnSelectLayoutGrid.__defaultHeight = 648
CoD.SpawnSelectLayoutGrid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectLayoutGrid)
	self.id = "SpawnSelectLayoutGrid"
	self.soundSet = "default"
	local mapGridRT = LUI.UIImage.new(0, 0, 786, 1572, 0, 0, 0, 324)
	mapGridRT:setYRot(180)
	mapGridRT:setImage(RegisterImage(0xF4B18E563E6CBCB))
	self:addElement(mapGridRT)
	self.mapGridRT = mapGridRT
	local mapGridLB = LUI.UIImage.new(0, 0, 0, 786, 0, 0, 324, 648)
	mapGridLB:setXRot(180)
	mapGridLB:setImage(RegisterImage(0xF4B18E563E6CBCB))
	self:addElement(mapGridLB)
	self.mapGridLB = mapGridLB
	local mapGridRB = LUI.UIImage.new(0, 0, 786, 1572, 0, 0, 324, 648)
	mapGridRB:setZRot(180)
	mapGridRB:setImage(RegisterImage(0xF4B18E563E6CBCB))
	self:addElement(mapGridRB)
	self.mapGridRB = mapGridRB
	local mapGridLT = LUI.UIImage.new(0, 0, 0, 786, 0, 0, 0, 324)
	mapGridLT:setImage(RegisterImage(0xF4B18E563E6CBCB))
	self:addElement(mapGridLT)
	self.mapGridLT = mapGridLT
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
