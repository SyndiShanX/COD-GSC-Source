CoD.DirectorSelectButtonLinesSecondary = InheritFrom(LUI.UIElement)
CoD.DirectorSelectButtonLinesSecondary.__defaultWidth = 288
CoD.DirectorSelectButtonLinesSecondary.__defaultHeight = 214
CoD.DirectorSelectButtonLinesSecondary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorSelectButtonLinesSecondary)
	self.id = "DirectorSelectButtonLinesSecondary"
	self.soundSet = "default"
	local BottomLine = LUI.UIImage.new(0, 1, -6, 6, 1, 1, -6, 6)
	BottomLine:setImage(RegisterImage(0x55942079F1B70E6))
	BottomLine:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomLine:setShaderVector(0, 0, 0, 0, 0)
	BottomLine:setupNineSliceShader(120, 12)
	self:addElement(BottomLine)
	self.BottomLine = BottomLine
	local TopLine = LUI.UIImage.new(0, 1, -6, 6, 0, 0, -7, 13)
	TopLine:setImage(RegisterImage(0x8CF59E909B72947))
	TopLine:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	TopLine:setShaderVector(0, 0, 0, 0, 0)
	TopLine:setupNineSliceShader(120, 10)
	self:addElement(TopLine)
	self.TopLine = TopLine
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
