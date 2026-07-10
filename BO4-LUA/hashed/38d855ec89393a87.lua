CoD.CombatTrainingGameTimerBacking = InheritFrom(LUI.UIElement)
CoD.CombatTrainingGameTimerBacking.__defaultWidth = 187
CoD.CombatTrainingGameTimerBacking.__defaultHeight = 67
CoD.CombatTrainingGameTimerBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CombatTrainingGameTimerBacking)
	self.id = "CombatTrainingGameTimerBacking"
	self.soundSet = "default"
	local blur = LUI.UIImage.new(0.5, 0.5, -93.5, 93.5, 0.5, 0.5, -33.5, 33.5)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local Image = LUI.UIImage.new(0.5, 0.5, -94, 94, 0.5, 0.5, -34, 34)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.75)
	self:addElement(Image)
	self.Image = Image
	local TiledShaderImage = LUI.UIImage.new(0.5, 0.5, -93.5, 93.5, 0.5, 0.5, -33.5, 33.5)
	TiledShaderImage:setRGB(0, 0, 0)
	TiledShaderImage:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local TiledShaderImage2 = LUI.UIImage.new(0.5, 0.5, -93.5, 93.5, 0.5, 0.5, -33.5, 33.5)
	TiledShaderImage2:setRGB(0, 0, 0)
	TiledShaderImage2:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage2:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage2:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage2)
	self.TiledShaderImage2 = TiledShaderImage2
	local border = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -38, 38)
	border:setRGB(0.07, 0.07, 0.07)
	border:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_chamfer_border"))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setupNineSliceShader(18, 24)
	self:addElement(border)
	self.border = border
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
