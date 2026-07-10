CoD.BackgroundPattern03 = InheritFrom(LUI.UIElement)
CoD.BackgroundPattern03.__defaultWidth = 120
CoD.BackgroundPattern03.__defaultHeight = 48
CoD.BackgroundPattern03.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BackgroundPattern03)
	self.id = "BackgroundPattern03"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Pattern = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Pattern:setImage(RegisterImage(@"uie_t7_menu_pattern_01"))
	Pattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	Pattern:setShaderVector(0, 2.5, 1, 0, 0)
	Pattern:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(Pattern)
	self.Pattern = Pattern
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
