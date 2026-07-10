CoD.TabbedScoreboardLayoutCorner = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardLayoutCorner.__defaultWidth = 985
CoD.TabbedScoreboardLayoutCorner.__defaultHeight = 472
CoD.TabbedScoreboardLayoutCorner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardLayoutCorner)
	self.id = "TabbedScoreboardLayoutCorner"
	self.soundSet = "default"
	local CornerTL = LUI.UIImage.new(0, 0, 1, 63, 0, 0, 1, 63)
	CornerTL:setImage(RegisterImage(@"hash_2CABC3612E8AD001"))
	CornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CornerTL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CornerTL)
	self.CornerTL = CornerTL
	local CornerTR = LUI.UIImage.new(0, 0, 923, 985, 0, 0, 0, 62)
	CornerTR:setZRot(270)
	CornerTR:setImage(RegisterImage(@"hash_2CABC3612E8AD001"))
	CornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CornerTR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CornerTR)
	self.CornerTR = CornerTR
	local CornerBL = LUI.UIImage.new(0, 0, 0, 62, 0, 0, 409.5, 471.5)
	CornerBL:setZRot(90)
	CornerBL:setImage(RegisterImage(@"hash_2CABC3612E8AD001"))
	CornerBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CornerBL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CornerBL)
	self.CornerBL = CornerBL
	local CornerBR = LUI.UIImage.new(0, 0, 922, 984, 0, 0, 409.5, 471.5)
	CornerBR:setZRot(180)
	CornerBR:setImage(RegisterImage(@"hash_2CABC3612E8AD001"))
	CornerBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	CornerBR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CornerBR)
	self.CornerBR = CornerBR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
