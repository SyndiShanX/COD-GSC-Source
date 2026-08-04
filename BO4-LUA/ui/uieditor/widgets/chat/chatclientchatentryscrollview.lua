require("ui/uieditor/widgets/chat/chatclientchatentriesview")
CoD.ChatClientChatEntryScrollView = InheritFrom(LUI.UIElement)
CoD.ChatClientChatEntryScrollView.__defaultWidth = 508
CoD.ChatClientChatEntryScrollView.__defaultHeight = 300
CoD.ChatClientChatEntryScrollView.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientChatEntryScrollView)
	self.id = "ChatClientChatEntryScrollView"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local View = CoD.ChatClientChatEntriesView.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 300)
	self:addElement(View)
	self.View = View
	View.id = "View"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.PCWidgetUtility.PrepareScrollView(self, f1_arg1, f1_arg0)
	CoD.PCWidgetUtility.AnchorScrollViewToBottom(self, f1_arg1)
	return self
end
CoD.ChatClientChatEntryScrollView.__onClose = function(f2_arg0)
	f2_arg0.View:close()
end
