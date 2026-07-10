require("x64:2675595fa323085")
CoD.WilcardSelect_PC_EmptyFocusable = InheritFrom(LUI.UIElement)
CoD.WilcardSelect_PC_EmptyFocusable.__defaultWidth = 4640
CoD.WilcardSelect_PC_EmptyFocusable.__defaultHeight = 1530
CoD.WilcardSelect_PC_EmptyFocusable.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WilcardSelect_PC_EmptyFocusable)
	self.id = "WilcardSelect_PC_EmptyFocusable"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	local EmptyFocusableBottom = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 450, 450)
	self:addElement(EmptyFocusableBottom)
	self.EmptyFocusableBottom = EmptyFocusableBottom
	local EmptyFocusableRight = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 1.5, 400, 400, 0, 0, 0, 450)
	self:addElement(EmptyFocusableRight)
	self.EmptyFocusableRight = EmptyFocusableRight
	local EmptyFocusableLeft = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -2320, -400, 0, 0, 0, 450)
	self:addElement(EmptyFocusableLeft)
	self.EmptyFocusableLeft = EmptyFocusableLeft
	EmptyFocusableBottom.id = "EmptyFocusableBottom"
	EmptyFocusableRight.id = "EmptyFocusableRight"
	EmptyFocusableLeft.id = "EmptyFocusableLeft"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WilcardSelect_PC_EmptyFocusable.__onClose = function(f2_arg0)
	f2_arg0.EmptyFocusableBottom:close()
	f2_arg0.EmptyFocusableRight:close()
	f2_arg0.EmptyFocusableLeft:close()
end
