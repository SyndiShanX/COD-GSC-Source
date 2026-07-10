require("x64:fb040b6277a38ba")
CoD.LobbyProcessQueueDebug = InheritFrom(LUI.UIElement)
CoD.LobbyProcessQueueDebug.__defaultWidth = 500
CoD.LobbyProcessQueueDebug.__defaultHeight = 1009
CoD.LobbyProcessQueueDebug.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LobbyProcessQueueDebug)
	self.id = "LobbyProcessQueueDebug"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local List = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, true)
	List:setLeftRight(0, 0, 0, 1119)
	List:setTopBottom(0, 0, 0, 658)
	List:setWidgetType(CoD.LobbyProcessQueueDebugItem)
	List:setVerticalCount(30)
	List:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	List:setDataSource("LobbyProcessQueueInfo")
	self:addElement(List)
	self.List = List
	List.id = "List"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LobbyProcessQueueDebug.__onClose = function(f2_arg0)
	f2_arg0.List:close()
end
