CoD.StartMenuOptionsMainFrame = InheritFrom(LUI.UIElement)
CoD.StartMenuOptionsMainFrame.__defaultWidth = 168
CoD.StartMenuOptionsMainFrame.__defaultHeight = 168
CoD.StartMenuOptionsMainFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenuOptionsMainFrame)
	self.id = "StartMenuOptionsMainFrame"
	self.soundSet = "default"
	local strokeBot = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 0)
	self:addElement(strokeBot)
	self.strokeBot = strokeBot
	local strokeTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	self:addElement(strokeTop)
	self.strokeTop = strokeTop
	local strokeLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 1, 0, 0)
	self:addElement(strokeLeft)
	self.strokeLeft = strokeLeft
	local strokeRight = LUI.UIImage.new(1, 1, -1, 0, 0, 1, 0, 0)
	self:addElement(strokeRight)
	self.strokeRight = strokeRight
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
