require("x64:729220b1154af14")
local PostLoadFunc = function(self, controller)
	self:dispatchEventToChildren({
		name = "options_refresh",
		controller = controller,
	})
	self.graphicsList.m_managedItemPriority = true
end
CoD.StartMenu_Options_PC_Graphics_Video = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_Graphics_Video.__defaultWidth = 1010
CoD.StartMenu_Options_PC_Graphics_Video.__defaultHeight = 900
CoD.StartMenu_Options_PC_Graphics_Video.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setClass(CoD.StartMenu_Options_PC_Graphics_Video)
	self.id = "StartMenu_Options_PC_Graphics_Video"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local graphicsList = LUI.UIList.new(f2_arg0, f2_arg1, 0, 0, nil, false, false, false, false)
	graphicsList:setLeftRight(0, 0, 0, 600)
	graphicsList:setTopBottom(0, 0, 0, 1500)
	graphicsList:setWidgetType(CoD.StartMenu_Options_Slider)
	graphicsList:setVerticalCount(25)
	graphicsList:setSpacing(0)
	graphicsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	graphicsList:setDataSource("OptionGraphicsDevmenu")
	self:addElement(graphicsList)
	self.graphicsList = graphicsList
	graphicsList.id = "graphicsList"
	self.__defaultFocus = graphicsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_Graphics_Video.__onClose = function(f3_arg0)
	f3_arg0.graphicsList:close()
end
