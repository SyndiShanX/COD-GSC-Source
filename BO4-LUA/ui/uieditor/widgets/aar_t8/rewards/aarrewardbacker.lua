require("x64:1128ed000805fc9")
CoD.AARRewardBacker = InheritFrom(LUI.UIElement)
CoD.AARRewardBacker.__defaultWidth = 412
CoD.AARRewardBacker.__defaultHeight = 772
CoD.AARRewardBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardBacker)
	self.id = "AARRewardBacker"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 20, 0)
	SceneBlur:setRGB(0.02, 0.02, 0.02)
	SceneBlur:setAlpha(0.9)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0.9, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 20, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local ButtonBottomBracket9Slice2 = LUI.UIImage.new(0, 0, -6, 418, 0, 0, 14, 26)
	ButtonBottomBracket9Slice2:setAlpha(0.16)
	ButtonBottomBracket9Slice2:setZRot(180)
	ButtonBottomBracket9Slice2:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_bottom_line"))
	ButtonBottomBracket9Slice2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonBottomBracket9Slice2:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomBracket9Slice2:setupNineSliceShader(120, 12)
	self:addElement(ButtonBottomBracket9Slice2)
	self.ButtonBottomBracket9Slice2 = ButtonBottomBracket9Slice2
	local DiagonalBarTop = CoD.AARPlayerReward_DiagonalHeaderInternal.new(f1_arg0, f1_arg1, 0, 0, 56.5, 356.5, 0, 0, 2, 10)
	DiagonalBarTop:setScale(1.38, 1.38)
	self:addElement(DiagonalBarTop)
	self.DiagonalBarTop = DiagonalBarTop
	local ButtonBottomBracket9Slice = LUI.UIImage.new(0, 0, -6, 418, 1, 1, -6, 6)
	ButtonBottomBracket9Slice:setAlpha(0.16)
	ButtonBottomBracket9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_bottom_line"))
	ButtonBottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonBottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomBracket9Slice:setupNineSliceShader(120, 12)
	self:addElement(ButtonBottomBracket9Slice)
	self.ButtonBottomBracket9Slice = ButtonBottomBracket9Slice
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARRewardBacker.__onClose = function(f2_arg0)
	f2_arg0.DiagonalBarTop:close()
end
