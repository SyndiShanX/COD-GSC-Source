require("x64:20ba1a9425eadbf")
CoD.FrontendChatClientContainer = InheritFrom(LUI.UIElement)
CoD.FrontendChatClientContainer.__defaultWidth = 540
CoD.FrontendChatClientContainer.__defaultHeight = 290
CoD.FrontendChatClientContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PCUtility.StartAddingSticky(f1_arg0, self)
	CoD.PCUtility.PreSetupMenuChat(self, f1_arg0, f1_arg1)
	self:setClass(CoD.FrontendChatClientContainer)
	self.id = "FrontendChatClientContainer"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChatClient = CoD.FrontendChatClient.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ChatClient)
	self.ChatClient = ChatClient
	self:mergeStateConditions({
		{
			stateName = "Offline",
			condition = function(menu, element, event)
				return not CoD.PCUtility.IsBGSEnabled()
			end,
		},
		{
			stateName = "PassiveMode",
			condition = function(menu, element, event)
				return not CoD.PCUtility.MenuChatIsActive(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["ChatGlobal.ChatAvailableInMenuEvent"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ChatGlobal.ChatAvailableInMenuEvent",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["ChatGlobal.MenuChatInActiveMode"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ChatGlobal.MenuChatInActiveMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f6_arg2, f6_arg3, f6_arg4)
		CoD.FreeCursorUtility.RetriggerCursorPosition(f1_arg0, controller)
		ClearRecordedFocusIfFocusAncestor(f1_arg0, controller, self.ChatClient)
		ClearRecordedInputFocusIfInputFocusAncestor(f1_arg0, controller, self.ChatClient)
	end)
	ChatClient.id = "ChatClient"
	self.__defaultFocus = ChatClient
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.PCUtility.StopAddingSticky(f1_arg0)
	return self
end
CoD.FrontendChatClientContainer.__resetProperties = function(f7_arg0)
	f7_arg0.ChatClient:completeAnimation()
	f7_arg0.ChatClient:setAlpha(1)
end
CoD.FrontendChatClientContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Offline = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ChatClient:completeAnimation()
			f9_arg0.ChatClient:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ChatClient)
		end,
	},
	PassiveMode = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ChatClient:completeAnimation()
			f10_arg0.ChatClient:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ChatClient)
		end,
	},
}
CoD.FrontendChatClientContainer.__onClose = function(f11_arg0)
	f11_arg0.ChatClient:close()
end
