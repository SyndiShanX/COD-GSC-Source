CoD.HealthBarWidget = InheritFrom(LUI.UIElement)
CoD.HealthBarWidget.__defaultWidth = 152
CoD.HealthBarWidget.__defaultHeight = 12
CoD.HealthBarWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBarWidget)
	self.id = "HealthBarWidget"
	self.soundSet = "default"
	local HealthBackground = LUI.UIImage.new(0.5, 0.5, -76, 76, 0, 0, 0, 12)
	HealthBackground:setRGB(0.37, 0.4, 0.44)
	HealthBackground:setImage(RegisterImage(0x75CDE8BCCBD6F24))
	HealthBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0xBEEFD90021D3628))
	HealthBackground:setShaderVector(0, 0, 0, 0, 0)
	HealthBackground:setShaderVector(1, 4, 1, 0, 0)
	HealthBackground:setShaderVector(2, 0, 1, 0, 1)
	HealthBackground:setupNineSliceShader(6, 6)
	self:addElement(HealthBackground)
	self.HealthBackground = HealthBackground
	local WoundBar = LUI.UIImage.new(0.5, 0.5, -75, 75, 0.5, 0.5, -1, 1)
	WoundBar:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	WoundBar:setShaderVector(0, 0, 1, 0, 0)
	WoundBar:setShaderVector(1, 0, 0, 0, 0)
	WoundBar:setShaderVector(2, 0, 1, 0, 0)
	WoundBar:setShaderVector(3, 0, 0, 0, 0)
	WoundBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(WoundBar)
	self.WoundBar = WoundBar
	local CleanseBarBG = LUI.UIImage.new(0.5, 0.5, -76, 76, -0.07, -0.07, 0.5, 13.5)
	CleanseBarBG:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	CleanseBarBG:setImage(RegisterImage(0x75961ABECF3E11A))
	CleanseBarBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x7E89392B94A41DE))
	CleanseBarBG:setShaderVector(0, 0, 0, 0, 0)
	CleanseBarBG:setShaderVector(1, 4, 1, 0, 0)
	CleanseBarBG:setShaderVector(2, 0, 1, 0, 1)
	CleanseBarBG:setupNineSliceShader(6, 6)
	self:addElement(CleanseBarBG)
	self.CleanseBarBG = CleanseBarBG
	local HealthFill = LUI.UIImage.new(0.5, 0.5, -76, 76, 0, 0, 0, 12)
	HealthFill:setRGB(0.92, 0.92, 0.92)
	HealthFill:setImage(RegisterImage(0x700B275CC09FEF2))
	HealthFill:setMaterial(LUI.UIImage.GetCachedMaterial(0xBEEFD90021D3628))
	HealthFill:setShaderVector(0, 0, 0, 0, 0)
	HealthFill:setShaderVector(1, 4, 1, 0, 0)
	HealthFill:setShaderVector(2, 0, 1, 0, 1)
	HealthFill:setupNineSliceShader(6, 6)
	self:addElement(HealthFill)
	self.HealthFill = HealthFill
	local CleanseBar = LUI.UIImage.new(0.5, 0.5, -76, 76, 0, 0, 0, 12)
	CleanseBar:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	CleanseBar:setImage(RegisterImage(0x700B275CC09FEF2))
	CleanseBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x7E89392B94A41DE))
	CleanseBar:setShaderVector(0, 0, 0, 0, 0)
	CleanseBar:setShaderVector(1, 4, 1, 0, 0)
	CleanseBar:setShaderVector(2, 0, 1, 0, 1)
	CleanseBar:setupNineSliceShader(6, 6)
	self:addElement(CleanseBar)
	self.CleanseBar = CleanseBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
