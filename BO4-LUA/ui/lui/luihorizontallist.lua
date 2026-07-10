LUI.UIHorizontalList = {}
local f0_local0 = function(f1_arg0, f1_arg1, f1_arg2)
	local self = LUI.UIElement.new(0, 0, 0, f1_arg1, 0, 1, 0, 0)
	self:setPriority(f1_arg2)
	f1_arg0:addElement(self)
	return self
end
LUI.UIHorizontalList.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7)
	self:setSpacing(f2_arg8)
	self.id = "LUIHorizontalList"
	self:setupResizingUIHorizontalList(f2_arg9)
	self.addSpacer = f0_local0
	self.addElement = LUI.UIHorizontalList.AddElement
	self.removeElement = LUI.UIHorizontalList.RemoveElement
	self.__ignoreFirstElement = f2_arg9
	return self
end
LUI.UIHorizontalList.AddElement = function(f3_arg0, f3_arg1)
	LUI.UIElement.addElement(f3_arg0, f3_arg1)
	f3_arg0:setLayoutCached(false)
end
LUI.UIHorizontalList.RemoveElement = function(f4_arg0, f4_arg1)
	LUI.UIElement.removeElement(f4_arg0, f4_arg1)
	f4_arg0:setLayoutCached(false)
end
