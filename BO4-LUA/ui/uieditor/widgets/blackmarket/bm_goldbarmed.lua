CoD.BM_GoldBarMed = InheritFrom(LUI.UIElement)
CoD.BM_GoldBarMed.__defaultWidth = 285
CoD.BM_GoldBarMed.__defaultHeight = 30
CoD.BM_GoldBarMed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_GoldBarMed)
	self.id = "BM_GoldBarMed"
	self.soundSet = "default"
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 30)
	backing:setImage(RegisterImage(@"ui_icon_blackmarket_lockbar_large"))
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	backing:setShaderVector(0, 0, 0, 0, 0)
	backing:setupNineSliceShader(150, 53)
	self:addElement(backing)
	self.backing = backing
	local skull = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	skull:setImage(RegisterImage(@"ui_icon_blackmarket_lockskull_128"))
	self:addElement(skull)
	self.skull = skull
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
