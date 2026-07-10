CoD.CodCasterLoadoutEquipmentBackground = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutEquipmentBackground.__defaultWidth = 110
CoD.CodCasterLoadoutEquipmentBackground.__defaultHeight = 76
CoD.CodCasterLoadoutEquipmentBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutEquipmentBackground)
	self.id = "CodCasterLoadoutEquipmentBackground"
	self.soundSet = "default"
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 4, 67)
	BG:setRGB(0, 0, 0)
	BG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BG:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BG)
	self.BG = BG
	local CodCasterLoadoutEquipmentBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 76)
	CodCasterLoadoutEquipmentBackground:setImage(RegisterImage(@"hash_36237BCC6F1A8D53"))
	CodCasterLoadoutEquipmentBackground:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	CodCasterLoadoutEquipmentBackground:setShaderVector(0, 0, 0, 0, 0)
	CodCasterLoadoutEquipmentBackground:setupNineSliceShader(55, 38)
	self:addElement(CodCasterLoadoutEquipmentBackground)
	self.CodCasterLoadoutEquipmentBackground = CodCasterLoadoutEquipmentBackground
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
