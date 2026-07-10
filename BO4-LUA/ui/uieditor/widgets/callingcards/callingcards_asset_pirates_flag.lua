CoD.CallingCards_Asset_Pirates_Flag = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_Pirates_Flag.__defaultWidth = 10
CoD.CallingCards_Asset_Pirates_Flag.__defaultHeight = 10
CoD.CallingCards_Asset_Pirates_Flag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_Pirates_Flag)
	self.id = "CallingCards_Asset_Pirates_Flag"
	self.soundSet = "default"
	local flag = LUI.UIImage.new(0, 0, -470, 10, 0, 0, -40, 80)
	flag:setImage(RegisterImage(0x616C09C8084EE99))
	self:addElement(flag)
	self.flag = flag
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
