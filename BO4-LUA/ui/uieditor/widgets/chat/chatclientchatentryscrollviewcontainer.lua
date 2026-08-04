require("ui/uieditor/widgets/chat/chatclientchatentryscrollview")
require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/pc_vscrollbar")
CoD.ChatClientChatEntryScrollViewContainer = InheritFrom(LUI.UIElement)
CoD.ChatClientChatEntryScrollViewContainer.__defaultWidth = 518
CoD.ChatClientChatEntryScrollViewContainer.__defaultHeight = 300
CoD.ChatClientChatEntryScrollViewContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientChatEntryScrollViewContainer)
	self.id = "ChatClientChatEntryScrollViewContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local VScrollbar = CoD.PC_VScrollbar.new(f1_arg0, f1_arg1, 1, 1, -3, 0, 0, 1, 0, 0)
	VScrollbar:setScale(0.25, 1)
	self:addElement(VScrollbar)
	self.VScrollbar = VScrollbar
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1.06, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local ScrollView = CoD.ChatClientChatEntryScrollView.new(f1_arg0, f1_arg1, 0, 0, 0, 518, 0, 1, 0, 0)
	self:addElement(ScrollView)
	self.ScrollView = ScrollView
	VScrollbar.id = "VScrollbar"
	emptyFocusable.id = "emptyFocusable"
	ScrollView.id = "ScrollView"
	self.__defaultFocus = VScrollbar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChatClientChatEntryScrollViewContainer.__onClose = function(f2_arg0)
	f2_arg0.VScrollbar:close()
	f2_arg0.emptyFocusable:close()
	f2_arg0.ScrollView:close()
end
