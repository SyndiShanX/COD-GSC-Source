require("ui/uieditor/widgets/chat/chatcliententrycontainer")
require("ui/uieditor/widgets/emptyfocusable")
CoD.ChatClientChatEntriesView = InheritFrom(LUI.UIElement)
CoD.ChatClientChatEntriesView.__defaultWidth = 508
CoD.ChatClientChatEntriesView.__defaultHeight = 300
CoD.ChatClientChatEntriesView.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Bottom)
	self:setClass(CoD.ChatClientChatEntriesView)
	self.id = "ChatClientChatEntriesView"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ChatEntry1 = CoD.ChatClientEntryContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 300)
	ChatEntry1:setAlpha(0)
	self:addElement(ChatEntry1)
	self.ChatEntry1 = ChatEntry1
	local emptyFocusableToDeleteOnPostLoad = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0, 0, 0, 0, 0, 0)
	self:addElement(emptyFocusableToDeleteOnPostLoad)
	self.emptyFocusableToDeleteOnPostLoad = emptyFocusableToDeleteOnPostLoad
	ChatEntry1.id = "ChatEntry1"
	emptyFocusableToDeleteOnPostLoad.id = "emptyFocusableToDeleteOnPostLoad"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.PCWidgetUtility.SetupChatEntriesView(self, f1_arg0, f1_arg1, 50)
	ReplaceElementWithFake(self, "emptyFocusableToDeleteOnPostLoad")
	return self
end
CoD.ChatClientChatEntriesView.__onClose = function(f2_arg0)
	f2_arg0.ChatEntry1:close()
	f2_arg0.emptyFocusableToDeleteOnPostLoad:close()
end
