CoD.FooterButton_TooltipBG = InheritFrom(LUI.UIElement)
CoD.FooterButton_TooltipBG.__defaultWidth = 226
CoD.FooterButton_TooltipBG.__defaultHeight = 48
CoD.FooterButton_TooltipBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButton_TooltipBG)
	self.id = "FooterButton_TooltipBG"
	self.soundSet = "default"
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bg:setRGB(0.18, 0.16, 0.16)
	self:addElement(bg)
	self.bg = bg
	local BorderButton = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BorderButton:setAlpha(0.3)
	BorderButton:setImage(RegisterImage("uie_tooltipborder_9s"))
	BorderButton:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	BorderButton:setShaderVector(0, 0, 0, 0, 0)
	BorderButton:setupNineSliceShader(12, 12)
	self:addElement(BorderButton)
	self.BorderButton = BorderButton
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
