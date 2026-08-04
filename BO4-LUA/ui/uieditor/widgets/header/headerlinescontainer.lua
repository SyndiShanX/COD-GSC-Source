CoD.HeaderLinesContainer = InheritFrom(LUI.UIElement)
CoD.HeaderLinesContainer.__defaultWidth = 2120
CoD.HeaderLinesContainer.__defaultHeight = 112
CoD.HeaderLinesContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HeaderLinesContainer)
	self.id = "HeaderLinesContainer"
	self.soundSet = "default"
	local BackingGraySmallLeft = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 110, 112)
	self:addElement(BackingGraySmallLeft)
	self.BackingGraySmallLeft = BackingGraySmallLeft
	local BackingGrayMediumLeft = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 108)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
