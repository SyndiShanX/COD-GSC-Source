require("x64:656798c4531fd68")
require("x64:ed2ea2149105e13")
CoD.SprintMeterArrows = InheritFrom(LUI.UIElement)
CoD.SprintMeterArrows.__defaultWidth = 22
CoD.SprintMeterArrows.__defaultHeight = 450
CoD.SprintMeterArrows.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SprintMeterArrows)
	self.id = "SprintMeterArrows"
	self.soundSet = "default"
	local right1 = CoD.SprintMeterChevron.new(f1_arg0, f1_arg1, 0.5, 0.5, 2.5, -6.5, 1, 1, -486, -12)
	right1:setZRot(29)
	self:addElement(right1)
	self.right1 = right1
	local right2 = CoD.ThrustMeterChevronThin.new(f1_arg0, f1_arg1, 0.5, 0.5, 3, -3, 1, 1, -486, -12)
	right2:setAlpha(0)
	right2:setZRot(33)
	self:addElement(right2)
	self.right2 = right2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SprintMeterArrows.__onClose = function(f2_arg0)
	f2_arg0.right1:close()
	f2_arg0.right2:close()
end
