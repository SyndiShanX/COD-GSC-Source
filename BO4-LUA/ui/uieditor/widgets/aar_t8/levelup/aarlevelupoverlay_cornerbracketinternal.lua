CoD.AARLevelUpOverlay_CornerBracketInternal = InheritFrom(LUI.UIElement)
CoD.AARLevelUpOverlay_CornerBracketInternal.__defaultWidth = 360
CoD.AARLevelUpOverlay_CornerBracketInternal.__defaultHeight = 360
CoD.AARLevelUpOverlay_CornerBracketInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARLevelUpOverlay_CornerBracketInternal)
	self.id = "AARLevelUpOverlay_CornerBracketInternal"
	self.soundSet = "default"
	local Corner4 = LUI.UIImage.new(0, 0, 0, 32, 1, 1, -32, 0)
	Corner4:setZRot(90)
	Corner4:setImage(RegisterImage(@"uie_ui_menu_aar_common_corner_blur"))
	Corner4:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Corner4:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Corner4)
	self.Corner4 = Corner4
	local Corner3 = LUI.UIImage.new(1, 1, -32, 0, 1, 1, -32, 0)
	Corner3:setZRot(180)
	Corner3:setImage(RegisterImage(@"uie_ui_menu_aar_common_corner_blur"))
	Corner3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Corner3:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Corner3)
	self.Corner3 = Corner3
	local Corner2 = LUI.UIImage.new(1, 1, -32, 0, 0, 0, 0, 32)
	Corner2:setZRot(-90)
	Corner2:setImage(RegisterImage(@"uie_ui_menu_aar_common_corner_blur"))
	Corner2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Corner2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Corner2)
	self.Corner2 = Corner2
	local Corner1 = LUI.UIImage.new(0, 0, 0, 32, 0, 0, 0, 32)
	Corner1:setImage(RegisterImage(@"uie_ui_menu_aar_common_corner_blur"))
	Corner1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Corner1:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Corner1)
	self.Corner1 = Corner1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
