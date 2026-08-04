require("ui/uieditor/widgets/chat/chatclientchatentriesview")
CoD.ChatClientChatEntryStaticView = InheritFrom(LUI.UIElement)
CoD.ChatClientChatEntryStaticView.__defaultWidth = 508
CoD.ChatClientChatEntryStaticView.__defaultHeight = 186
CoD.ChatClientChatEntryStaticView.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientChatEntryStaticView)
	self.id = "ChatClientChatEntryStaticView"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChatClientChatEntriesView = CoD.ChatClientChatEntriesView.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0, 1, 0, 0)
	ChatClientChatEntriesView:setAlpha(0)
	self:addElement(ChatClientChatEntriesView)
	self.ChatClientChatEntriesView = ChatClientChatEntriesView
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not ChatClientStaticAllowed(f1_arg1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue() and not Engine.IsVisibilityBitSet(f1_arg1, Enum.UIVisibilityBit[@"bit_scoreboard_open"])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["ChatGlobal.StaticChatAllowed"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ChatGlobal.StaticChatAllowed",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_scoreboard_open"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_scoreboard_open"],
		})
	end, false)
	ChatClientChatEntriesView.id = "ChatClientChatEntriesView"
	self.__defaultFocus = ChatClientChatEntriesView
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.ChatClientChatEntryStaticView.__resetProperties = function(f6_arg0)
	f6_arg0.ChatClientChatEntriesView:completeAnimation()
	f6_arg0.ChatClientChatEntriesView:setAlpha(0)
end
CoD.ChatClientChatEntryStaticView.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ChatClientChatEntriesView:completeAnimation()
			f8_arg0.ChatClientChatEntriesView:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ChatClientChatEntriesView)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ChatClientChatEntriesView:completeAnimation()
			f9_arg0.ChatClientChatEntriesView:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ChatClientChatEntriesView)
		end,
	},
}
CoD.ChatClientChatEntryStaticView.__onClose = function(f10_arg0)
	f10_arg0.ChatClientChatEntriesView:close()
end
