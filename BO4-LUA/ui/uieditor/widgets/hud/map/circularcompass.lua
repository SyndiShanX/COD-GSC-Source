CoD.CircularCompass = InheritFrom(LUI.UIElement)
CoD.CircularCompass.__defaultWidth = 330
CoD.CircularCompass.__defaultHeight = 330
CoD.CircularCompass.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CircularCompass)
	self.id = "CircularCompass"
	self.soundSet = "default"
	local RingCompass = LUI.UIImage.new(0.5, 0.5, -166, 166, 0.5, 0.5, -166, 166)
	RingCompass:setImage(RegisterImage(0xBEFBE481A16E2F9))
	RingCompass:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(RingCompass)
	self.RingCompass = RingCompass
	local f1_local2 = nil
	self.microtext = LUI.UIElement.createFake()
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
