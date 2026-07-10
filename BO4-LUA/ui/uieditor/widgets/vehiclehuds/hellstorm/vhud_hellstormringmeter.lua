CoD.vhud_HellstormRingMeter = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormRingMeter.__defaultWidth = 832
CoD.vhud_HellstormRingMeter.__defaultHeight = 832
CoD.vhud_HellstormRingMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormRingMeter)
	self.id = "vhud_HellstormRingMeter"
	self.soundSet = "default"
	local L1 = LUI.UIImage.new(0, 0, 0, 416, 0, 0, 0, 832)
	L1:setImage(RegisterImage(0xBF72B2CA288F8F))
	self:addElement(L1)
	self.L1 = L1
	local L2 = LUI.UIImage.new(0, 0, 832, 416, 0, 0, 0, 832)
	L2:setImage(RegisterImage(0xBF72B2CA288F8F))
	self:addElement(L2)
	self.L2 = L2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
