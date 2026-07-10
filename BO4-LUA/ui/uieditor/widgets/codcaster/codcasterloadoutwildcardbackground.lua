CoD.CodCasterLoadoutWildcardBackground = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutWildcardBackground.__defaultWidth = 110
CoD.CodCasterLoadoutWildcardBackground.__defaultHeight = 76
CoD.CodCasterLoadoutWildcardBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutWildcardBackground)
	self.id = "CodCasterLoadoutWildcardBackground"
	self.soundSet = "default"
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 4, 67)
	BG:setRGB(0, 0, 0)
	BG:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BG:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BG)
	self.BG = BG
	local CodCasterLoadoutWildcardBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 76)
	CodCasterLoadoutWildcardBackground:setImage(RegisterImage(0x6237BCC6F1A8D53))
	CodCasterLoadoutWildcardBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	CodCasterLoadoutWildcardBackground:setShaderVector(0, 0, 0, 0, 0)
	CodCasterLoadoutWildcardBackground:setupNineSliceShader(55, 38)
	self:addElement(CodCasterLoadoutWildcardBackground)
	self.CodCasterLoadoutWildcardBackground = CodCasterLoadoutWildcardBackground
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
