CoD.FE_FocusBarContainer = InheritFrom(LUI.UIElement)
CoD.FE_FocusBarContainer.__defaultWidth = 144
CoD.FE_FocusBarContainer.__defaultHeight = 12
CoD.FE_FocusBarContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_FocusBarContainer)
	self.id = "FE_FocusBarContainer"
	self.soundSet = "default"
	local FEFocusBarSolid = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -6, 6)
	FEFocusBarSolid:setRGB(0, 0, 0)
	FEFocusBarSolid:setAlpha(0.7)
	FEFocusBarSolid:setImage(RegisterImage("uie_t7_menu_frontend_barfocussolidfull"))
	FEFocusBarSolid:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	FEFocusBarSolid:setShaderVector(0, 0, 0, 0, 0)
	FEFocusBarSolid:setupNineSliceShader(6, 6)
	self:addElement(FEFocusBarSolid)
	self.FEFocusBarSolid = FEFocusBarSolid
	local FEFocusBarAdd = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -6, 6)
	FEFocusBarAdd:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	FEFocusBarAdd:setAlpha(0.99)
	FEFocusBarAdd:setImage(RegisterImage("uie_t7_menu_frontend_barfocusfull"))
	FEFocusBarAdd:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	FEFocusBarAdd:setShaderVector(0, 0, 0, 0, 0)
	FEFocusBarAdd:setupNineSliceShader(6, 6)
	self:addElement(FEFocusBarAdd)
	self.FEFocusBarAdd = FEFocusBarAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
