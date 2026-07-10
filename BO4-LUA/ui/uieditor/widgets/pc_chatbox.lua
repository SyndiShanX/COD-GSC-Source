CoD.PC_ChatBox = InheritFrom(LUI.UIElement)
CoD.PC_ChatBox.__defaultWidth = 400
CoD.PC_ChatBox.__defaultHeight = 300
CoD.PC_ChatBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_ChatBox)
	self.id = "PC_ChatBox"
	self.soundSet = "none"
	local TestImage = LUI.UIImage.new(0, 0, 119.5, 247.5, 0, 0, 86, 214)
	self:addElement(TestImage)
	self.TestImage = TestImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
