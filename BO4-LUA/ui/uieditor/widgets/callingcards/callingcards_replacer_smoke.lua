CoD.CallingCards_replacer_smoke = InheritFrom(LUI.UIElement)
CoD.CallingCards_replacer_smoke.__defaultWidth = 10
CoD.CallingCards_replacer_smoke.__defaultHeight = 10
CoD.CallingCards_replacer_smoke.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_replacer_smoke)
	self.id = "CallingCards_replacer_smoke"
	self.soundSet = "default"
	local smoke = LUI.UIImage.new(0, 0, -40, 456, 0, 0, -202, 38)
	smoke:setImage(RegisterImage(0xF63B04BC0AA5720))
	self:addElement(smoke)
	self.smoke = smoke
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
