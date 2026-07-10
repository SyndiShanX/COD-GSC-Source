require("x64:19c1945d2e472b0")
CoD.ContractDetailsPanelBacker = InheritFrom(LUI.UIElement)
CoD.ContractDetailsPanelBacker.__defaultWidth = 776
CoD.ContractDetailsPanelBacker.__defaultHeight = 727
CoD.ContractDetailsPanelBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractDetailsPanelBacker)
	self.id = "ContractDetailsPanelBacker"
	self.soundSet = "default"
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Background = LUI.UIImage.new(0, 1, 1, -1, 0, 1, 1, -1)
	Background:setAlpha(0.02)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	Background:setShaderVector(0, 1, 0, 0, 0)
	Background:setShaderVector(1, 0, 0, 0, 0)
	Background:setShaderVector(2, 1, 0, 0, 0)
	Background:setShaderVector(3, 0, 0, 0, 0)
	Background:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking:setAlpha(0.15)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local ButtonTopLine9Slice2 = LUI.UIImage.new(0, 0, -5, 781, 0, 0, -6, 14)
	ButtonTopLine9Slice2:setAlpha(0.25)
	ButtonTopLine9Slice2:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	ButtonTopLine9Slice2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonTopLine9Slice2:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice2:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice2)
	self.ButtonTopLine9Slice2 = ButtonTopLine9Slice2
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 0, -5, 781, 1, 1, -7, 13)
	ButtonTopLine9Slice:setAlpha(0.25)
	ButtonTopLine9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractDetailsPanelBacker.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
end
