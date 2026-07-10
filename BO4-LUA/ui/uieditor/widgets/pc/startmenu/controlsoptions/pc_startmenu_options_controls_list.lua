require("x64:e579fbd66fb7e11")
require("x64:baff2229992d7b6")
CoD.PC_StartMenu_Options_Controls_List = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_List.__defaultWidth = 695
CoD.PC_StartMenu_Options_Controls_List.__defaultHeight = 633
CoD.PC_StartMenu_Options_Controls_List.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_List)
	self.id = "PC_StartMenu_Options_Controls_List"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	List:setLeftRight(0, 0, 0, 810)
	List:setTopBottom(0, 0, 0, 893)
	List:setWidgetType(CoD.CyclingList)
	List:setVerticalCount(13)
	List:setSpacing(4)
	List:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	List:setVerticalScrollbar(CoD.PC_VScrollbar)
	List:registerEventHandler("gain_list_focus", function(element, event)
		local f2_local0 = nil
		SetMenuState(f1_arg0, "MovedLeft", f1_arg1)
		SetElementState(self, self.List, f1_arg1, "Test")
		return f2_local0
	end)
	List:registerEventHandler("lose_list_focus", function(element, event)
		local f3_local0 = nil
		SetElementState(self, self.List, f1_arg1, "DefaultState")
		return f3_local0
	end)
	self:addElement(List)
	self.List = List
	List.id = "List"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_List.__onClose = function(f4_arg0)
	f4_arg0.List:close()
end
