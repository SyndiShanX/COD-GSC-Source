CoD.CommonHUDTiledBackground01 = InheritFrom(LUI.UIElement)
CoD.CommonHUDTiledBackground01.__defaultWidth = 128
CoD.CommonHUDTiledBackground01.__defaultHeight = 135
CoD.CommonHUDTiledBackground01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonHUDTiledBackground01)
	self.id = "CommonHUDTiledBackground01"
	self.soundSet = "default"
	local TiledBGTL = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 17, -9)
	TiledBGTL:setAlpha(0.9)
	TiledBGTL:setImage(RegisterImage(@"hash_397AC44A115B27CC"))
	TiledBGTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBGTL:setShaderVector(0, 0, 0, 0, 0)
	TiledBGTL:setupNineSliceShader(88, 88)
	self:addElement(TiledBGTL)
	self.TiledBGTL = TiledBGTL
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 1, 17)
	TiledShaderImage:setImage(RegisterImage(@"hash_47F2ED83F97016C3"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(16, 16)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local TiledShaderImage2 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -9, -1)
	TiledShaderImage2:setImage(RegisterImage(@"hash_3D566FAA6434DC5"))
	TiledShaderImage2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage2:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage2:setupNineSliceShader(296, 8)
	self:addElement(TiledShaderImage2)
	self.TiledShaderImage2 = TiledShaderImage2
	local TintBody03Left2 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -20, -12)
	TintBody03Left2:setRGB(0, 0, 0)
	TintBody03Left2:setAlpha(0.15)
	self:addElement(TintBody03Left2)
	self.TintBody03Left2 = TintBody03Left2
	local TintBody01Left = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 8)
	TintBody01Left:setRGB(0, 0, 0)
	TintBody01Left:setAlpha(0.15)
	self:addElement(TintBody01Left)
	self.TintBody01Left = TintBody01Left
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
