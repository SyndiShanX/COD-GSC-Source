require("x64:dab8c3a6f5b136c")
CoD.CommonPixelBackingWithTopPadding = InheritFrom(LUI.UIElement)
CoD.CommonPixelBackingWithTopPadding.__defaultWidth = 504
CoD.CommonPixelBackingWithTopPadding.__defaultHeight = 142
CoD.CommonPixelBackingWithTopPadding.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonPixelBackingWithTopPadding)
	self.id = "CommonPixelBackingWithTopPadding"
	self.soundSet = "default"
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -30, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Tint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -30, 0)
	Tint:setRGB(0, 0, 0)
	Tint:setAlpha(0.75)
	self:addElement(Tint)
	self.Tint = Tint
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, -26, -4)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
	DotTiledBacking.TiledShaderImage:setAlpha(0.15)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonPixelBackingWithTopPadding.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
end
