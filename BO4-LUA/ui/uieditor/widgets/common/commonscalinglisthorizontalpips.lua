CoD.CommonScalingListHorizontalPips = InheritFrom(LUI.UIElement)
CoD.CommonScalingListHorizontalPips.__defaultWidth = 100
CoD.CommonScalingListHorizontalPips.__defaultHeight = 2
CoD.CommonScalingListHorizontalPips.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonScalingListHorizontalPips)
	self.id = "CommonScalingListHorizontalPips"
	self.soundSet = "default"
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.3, 0.29, 0.28)
	backing:setAlpha(0.9)
	backing:setImage(RegisterImage(@"uie_hud_core_loadout_panel1"))
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_631E7B3C72564429"))
	backing:setShaderVector(0, 0, 0, 0.55, 0.13)
	backing:setShaderVector(1, 10, 1, 0, 0)
	backing:setShaderVector(2, 0, 1, 0, 1)
	backing:setupNineSliceShader(25, 4)
	self:addElement(backing)
	self.backing = backing
	local current = LUI.UIImage.new(0, 1, 0, 0, 0, 2, 0, 0)
	current:setRGB(0.96, 0.93, 0.84)
	current:setImage(RegisterImage(@"uie_hud_core_loadout_panel1"))
	current:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_631E7B3C72564429"))
	current:setShaderVector(0, 0, 0, 0.55, 0.13)
	current:setShaderVector(1, 10, 1, 0, 0)
	current:setShaderVector(2, 0.3, 0.4, 0, 1)
	current:setupNineSliceShader(25, 4)
	self:addElement(current)
	self.current = current
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
