require("ui/uieditor/widgets/chat/chatclientchatentry")
CoD.ChatClientEntryContainer = InheritFrom(LUI.UIElement)
CoD.ChatClientEntryContainer.__defaultWidth = 508
CoD.ChatClientEntryContainer.__defaultHeight = 27
CoD.ChatClientEntryContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientEntryContainer)
	self.id = "ChatClientEntryContainer"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ChatClientChatEntry = CoD.ChatClientChatEntry.new(f1_arg0, f1_arg1, 0, 0, 0, 495, 0.5, 0.5, -13.5, 13.5)
	ChatClientChatEntry:linkToElementModel(self, nil, false, function(model)
		ChatClientChatEntry:setModel(model, f1_arg1)
	end)
	self:addElement(ChatClientChatEntry)
	self.ChatClientChatEntry = ChatClientChatEntry
	ChatClientChatEntry.id = "ChatClientChatEntry"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChatClientEntryContainer.__onClose = function(f3_arg0)
	f3_arg0.ChatClientChatEntry:close()
end
