require("x64:b0810588c9ad0b8")
require("x64:d93d55bb6418607")
CoD.PC_StartMenu_Options_List = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_List.__defaultWidth = 694
CoD.PC_StartMenu_Options_List.__defaultHeight = 633
CoD.PC_StartMenu_Options_List.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_List)
	self.id = "PC_StartMenu_Options_List"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ScrollList = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ScrollList.ScrollView.View:setWidgetType(CoD.PC_StartMenu_Options_Controls_KeyBinder)
	ScrollList.ScrollView.View:setSpacing(12)
	self:addElement(ScrollList)
	self.ScrollList = ScrollList
	ScrollList.id = "ScrollList"
	self.__defaultFocus = ScrollList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CheckDefaultPCFocus(self.ScrollList, f1_arg0, f1_arg1)
	f1_local2 = ScrollList
	CoD.PCWidgetUtility.PrepareOptionScreenListCache(f1_local2, f1_arg1, f1_arg0)
	CoD.PCWidgetUtility.SetMouseWheelScrollUnit(f1_local2, 75)
	return self
end
CoD.PC_StartMenu_Options_List.__onClose = function(f2_arg0)
	f2_arg0.ScrollList:close()
end
