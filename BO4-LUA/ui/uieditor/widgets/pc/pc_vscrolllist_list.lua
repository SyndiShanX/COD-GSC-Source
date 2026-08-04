require("ui/uieditor/widgets/startmenu/startmenu_options_slider")
CoD.PC_VScrollList_List = InheritFrom(LUI.UIElement)
CoD.PC_VScrollList_List.__defaultWidth = 1000
CoD.PC_VScrollList_List.__defaultHeight = 1080
CoD.PC_VScrollList_List.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_VScrollList_List)
	self.id = "PC_VScrollList_List"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local View = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, true)
	View:setLeftRight(0, 1, 0, 0)
	View:setTopBottom(0, 0, 0, 618)
	View:setAutoScaleContent(true)
	View:setWidgetType(CoD.StartMenu_Options_Slider)
	View:setVerticalCount(10)
	View:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(View, "setDataSource", function(element, controller)
		CoD.PCWidgetUtility.ScrollVerticalTo(self, 0)
	end)
	self:addElement(View)
	self.View = View
	View.id = "View"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.PCWidgetUtility.PrepareScrollView(self, f1_arg1, f1_arg0)
	return self
end
CoD.PC_VScrollList_List.__onClose = function(f3_arg0)
	f3_arg0.View:close()
end
