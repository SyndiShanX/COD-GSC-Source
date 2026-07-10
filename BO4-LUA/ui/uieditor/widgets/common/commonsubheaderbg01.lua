CoD.CommonSubHeaderBG01 = InheritFrom(LUI.UIElement)
CoD.CommonSubHeaderBG01.__defaultWidth = 200
CoD.CommonSubHeaderBG01.__defaultHeight = 34
CoD.CommonSubHeaderBG01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonSubHeaderBG01)
	self.id = "CommonSubHeaderBG01"
	self.soundSet = "default"
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setRGB(0.48, 0.59, 0.41)
	NoiseTiledBacking:setAlpha(0.75)
	NoiseTiledBacking:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBacking3 = LUI.UIImage.new(1, 1, -2, 0, 0, 1, 0, 0)
	NoiseTiledBacking3:setRGB(0.75, 0.92, 0.59)
	NoiseTiledBacking3:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking3:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking3:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking3)
	self.NoiseTiledBacking3 = NoiseTiledBacking3
	local NoiseTiledBacking2 = LUI.UIImage.new(0, 0, 0, 2, 0, 1, 0, 0)
	NoiseTiledBacking2:setRGB(0.75, 0.92, 0.59)
	NoiseTiledBacking2:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
