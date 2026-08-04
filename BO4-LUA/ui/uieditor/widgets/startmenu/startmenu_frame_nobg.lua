CoD.StartMenu_frame_noBG = InheritFrom(LUI.UIElement)
CoD.StartMenu_frame_noBG.__defaultWidth = 450
CoD.StartMenu_frame_noBG.__defaultHeight = 210
CoD.StartMenu_frame_noBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_frame_noBG)
	self.id = "StartMenu_frame_noBG"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setAlpha(0)
	Image:setImage(RegisterImage("uie_t7_menu_cac_buttonboxlrgstrokefull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	Image:setShaderVector(0, 0, 0, 0.37, 0.37)
	Image:setupNineSliceShader(24, 24)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
