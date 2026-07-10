CoD.ThrustMeterChevronThin = InheritFrom(LUI.UIElement)
CoD.ThrustMeterChevronThin.__defaultWidth = 6
CoD.ThrustMeterChevronThin.__defaultHeight = 343
CoD.ThrustMeterChevronThin.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ThrustMeterChevronThin)
	self.id = "ThrustMeterChevronThin"
	self.soundSet = "default"
	local leftChevron1 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -9, -3)
	leftChevron1:setImage(RegisterImage(@"hash_3FCD786C55017617"))
	self:addElement(leftChevron1)
	self.leftChevron1 = leftChevron1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
