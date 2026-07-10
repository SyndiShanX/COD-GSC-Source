require("x64:e579fbd66fb7e11")
require("x64:7631da4ee57d7b6")
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsList = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsList.__defaultWidth = 674
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsList.__defaultHeight = 535
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsList)
	self.id = "StartMenu_Options_PC_GraphicsOptions_SubOptionsList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	List:setLeftRight(0, 0, 0, 810)
	List:setTopBottom(0, 0, 0, 755)
	List:setWidgetType(CoD.CyclingList)
	List:setVerticalCount(11)
	List:setSpacing(4)
	List:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	List:setVerticalScrollbar(CoD.verticalScrollbar)
	List:setDataSource("OptionGraphicsVideo")
	List:registerEventHandler("gain_list_focus", function(element, event)
		local f2_local0 = nil
		SetMenuState(f1_arg0, "MovedLeft", f1_arg1)
		return f2_local0
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
CoD.StartMenu_Options_PC_GraphicsOptions_SubOptionsList.__onClose = function(f3_arg0)
	f3_arg0.List:close()
end
