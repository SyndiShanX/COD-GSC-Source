CoD.Challenges_ProfilerLockBacking = InheritFrom(LUI.UIElement)
CoD.Challenges_ProfilerLockBacking.__defaultWidth = 105
CoD.Challenges_ProfilerLockBacking.__defaultHeight = 45
CoD.Challenges_ProfilerLockBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_ProfilerLockBacking)
	self.id = "Challenges_ProfilerLockBacking"
	self.soundSet = "default"
	local TitleBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TitleBg:setRGB(0, 0, 0)
	TitleBg:setAlpha(0.85)
	TitleBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	TitleBg:setShaderVector(0, 0.02, 0.02, 0.02, 0.02)
	self:addElement(TitleBg)
	self.TitleBg = TitleBg
	local PixelGridTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
