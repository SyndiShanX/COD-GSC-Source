CoD.SpecialistOutfitRowBacking = InheritFrom(LUI.UIElement)
CoD.SpecialistOutfitRowBacking.__defaultWidth = 700
CoD.SpecialistOutfitRowBacking.__defaultHeight = 69
CoD.SpecialistOutfitRowBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistOutfitRowBacking)
	self.id = "SpecialistOutfitRowBacking"
	self.soundSet = "default"
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local TiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBackingAdd:setAlpha(0)
	TiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingAdd)
	self.TiledBackingAdd = TiledBackingAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
