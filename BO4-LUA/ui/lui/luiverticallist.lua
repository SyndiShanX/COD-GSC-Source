LUI.UIVerticalList = InheritFrom(LUI.UIElement)
LUI.UIVerticalList.id = "LUIVerticalList"
LUI.UIVerticalList.addSpacer = function(f1_arg0, f1_arg1, f1_arg2)
	local self = LUI.UIElement.new(0, 1, 0, 0, 0, 0, 0, f1_arg1)
	self:setPriority(f1_arg2)
	f1_arg0:addElement(self)
	return self
end
LUI.UIVerticalList.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7)
	self:setSpacing(f2_arg8 or 0)
	self:setClass(LUI.UIVerticalList)
	self:setupResizingUIVerticalList(f2_arg9)
	self.__ignoreFirstElement = f2_arg9
	return self
end
LUI.UIVerticalList.addElement = function(f3_arg0, f3_arg1)
	LUI.UIElement.addElement(f3_arg0, f3_arg1)
	f3_arg0:setLayoutCached(false)
end
LUI.UIVerticalList.removeElement = function(f4_arg0, f4_arg1)
	LUI.UIElement.removeElement(f4_arg0, f4_arg1)
	f4_arg0:setLayoutCached(false)
end
LUI.UIVerticalList.addElementToTop = function(f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0:getFirstChild()
	if f5_local0 ~= nil then
		LUI.UIElement.addElementBefore(f5_arg1, f5_local0)
		f5_arg0:setLayoutCached(false)
	else
		LUI.UIVerticalList.addElement(f5_arg0, f5_arg1)
	end
end
LUI.UIVerticalList.selectElementIndex = function(f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0:getFirstChild()
	local f6_local1 = 0
	while f6_local0 ~= nil do
		if f6_local0.m_focusable then
			f6_local1 = f6_local1 + 1
			if f6_local1 == f6_arg1 then
				f6_local0:processEvent({
					name = "gain_focus",
				})
			else
				f6_local0:processEvent({
					name = "lose_focus",
				})
			end
		end
		f6_local0 = f6_local0:getNextSibling()
	end
end
