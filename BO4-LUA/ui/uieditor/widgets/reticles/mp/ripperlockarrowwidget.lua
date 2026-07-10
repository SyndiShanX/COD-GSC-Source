CoD.RipperLockArrowWidget = InheritFrom(LUI.UIElement)
CoD.RipperLockArrowWidget.__defaultWidth = 8
CoD.RipperLockArrowWidget.__defaultHeight = 8
CoD.RipperLockArrowWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.RipperLockArrowWidget)
	self.id = "RipperLockArrowWidget"
	self.soundSet = "default"
	local Image1 = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 8)
	Image1:setImage(RegisterImage(@"hash_17115FBB78B0C2F7"))
	Image1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Image1:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Image1)
	self.Image1 = Image1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
