require("x64:8152599b218d335")
require("x64:51d9e3b6bd42646")
require("x64:b3521b0bb0fc510")
require("x64:2675595fa323085")
CoD.FrontendChatClient = InheritFrom(LUI.UIElement)
CoD.FrontendChatClient.__defaultWidth = 540
CoD.FrontendChatClient.__defaultHeight = 290
CoD.FrontendChatClient.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FrontendChatClient)
	self.id = "FrontendChatClient"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local FrontendChatBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FrontendChatBG:setImage(RegisterImage(@"hash_6FECB0E0003975BA"))
	self:addElement(FrontendChatBG)
	self.FrontendChatBG = FrontendChatBG
	local InputText = CoD.ChatClientInputTextBox.new(f1_arg0, f1_arg1, 0.03, 0.03, -6, 514, 0.97, 0.97, -30, 0)
	InputText:subscribeToGlobalModel(f1_arg1, "ChatGlobal", nil, function(model)
		InputText:setModel(model, f1_arg1)
	end)
	InputText:subscribeToGlobalModel(f1_arg1, "ChatGlobal", "Event", function(model)
		CoD.PCUtility.ChatClientInputTextFieldUpdatePrompt(self, InputText, f1_arg1)
	end)
	self:addElement(InputText)
	self.InputText = InputText
	local ChatClientChatEntryScrollViewContainer = CoD.ChatClientChatEntryScrollViewContainer.new(f1_arg0, f1_arg1, 0.03, 0.03, -2, 516, 0.07, 0.07, 1.5, 212.5)
	self:addElement(ChatClientChatEntryScrollViewContainer)
	self.ChatClientChatEntryScrollViewContainer = ChatClientChatEntryScrollViewContainer
	local FiltersButton = CoD.ChatClientFilterButton.new(f1_arg0, f1_arg1, 0.99, 0.99, -125, 0, 0.02, 0.02, 0, 25)
	FiltersButton:setAlpha(0)
	self:addElement(FiltersButton)
	self.FiltersButton = FiltersButton
	self:mergeStateConditions({
		{
			stateName = "Chatting",
			condition = function(menu, element, event)
				return ChatClientIsAvailable(self, element, f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["ChatGlobal.Event"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ChatGlobal.Event",
		})
	end, false)
	emptyFocusable.id = "emptyFocusable"
	InputText.id = "InputText"
	ChatClientChatEntryScrollViewContainer.id = "ChatClientChatEntryScrollViewContainer"
	FiltersButton.id = "FiltersButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.PCWidgetUtility.PrepareChatVScrollWidget(self, f1_arg1, f1_arg0, self.ChatClientChatEntryScrollViewContainer)
	return self
end
CoD.FrontendChatClient.__resetProperties = function(f6_arg0)
	f6_arg0.InputText:completeAnimation()
	f6_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
	f6_arg0.emptyFocusable:completeAnimation()
	f6_arg0.InputText:setAlpha(1)
	f6_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(1)
	f6_arg0.emptyFocusable:setAlpha(1)
end
CoD.FrontendChatClient.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.InputText:completeAnimation()
			f7_arg0.InputText:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.InputText)
		end,
	},
	Chatting = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.emptyFocusable:completeAnimation()
			f8_arg0.emptyFocusable:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.emptyFocusable)
			f8_arg0.InputText:completeAnimation()
			f8_arg0.InputText:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.InputText)
			f8_arg0.ChatClientChatEntryScrollViewContainer:completeAnimation()
			f8_arg0.ChatClientChatEntryScrollViewContainer:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.ChatClientChatEntryScrollViewContainer)
		end,
	},
}
CoD.FrontendChatClient.__onClose = function(f9_arg0)
	f9_arg0.emptyFocusable:close()
	f9_arg0.InputText:close()
	f9_arg0.ChatClientChatEntryScrollViewContainer:close()
	f9_arg0.FiltersButton:close()
end
