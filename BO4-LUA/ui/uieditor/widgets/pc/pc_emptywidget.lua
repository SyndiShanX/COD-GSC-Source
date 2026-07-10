CoD.PC_EmptyWidget = InheritFrom(LUI.UIElement)
CoD.PC_EmptyWidget.__defaultWidth = 750
CoD.PC_EmptyWidget.__defaultHeight = 10
CoD.PC_EmptyWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_EmptyWidget)
	self.id = "PC_EmptyWidget"
	self.soundSet = "none"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 60)
	Image:setAlpha(0)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
