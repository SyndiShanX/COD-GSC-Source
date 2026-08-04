CoD.ChatClientInputTextBoxField = InheritFrom(LUI.UIElement)
CoD.ChatClientInputTextBoxField.__defaultWidth = 250
CoD.ChatClientInputTextBoxField.__defaultHeight = 25
CoD.ChatClientInputTextBoxField.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientInputTextBoxField)
	self.id = "ChatClientInputTextBoxField"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 0, 0, 250, 0, 0, 0, 21)
	TextBox:setTTF("notosans_regular")
	TextBox:setLetterSpacing(1)
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	TextBox:subscribeToGlobalModel(f1_arg1, "ChatGlobal", "InputText", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(f2_local0)
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "NoChannelsAvailable",
			condition = function(menu, element, event)
				return not ChatClientInputEnabled(f1_arg1)
			end,
		},
		{
			stateName = "ChattingIngame",
			condition = function(menu, element, event)
				return IsInGame() and ChatClientIsChatting(f1_arg1)
			end,
		},
		{
			stateName = "IngameChatActivated",
			condition = function(menu, element, event)
				return IsInGame() and ChatClientInGameChatIsActive(f1_arg1)
			end,
		},
		{
			stateName = "DefaultStateIngame",
			condition = function(menu, element, event)
				return IsInGame()
			end,
		},
		{
			stateName = "Chatting",
			condition = function(menu, element, event)
				return ChatClientIsChatting(f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["ChatGlobal.Event"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "ChatGlobal.Event",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["ChatGlobal.inGameChatActive"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "ChatGlobal.inGameChatActive",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.BaseUtility.SetUseStencil(self)
	CoD.PCUtility.SetHandleMouse(self, true)
	f1_local3 = TextBox
	CoD.PCUtility.SetupEditControlChat(self, f1_arg1, f1_arg0, "chatInputtext")
	CoD.PCUtility.MakeEditControlChat(self, f1_arg1, 290, 60)
	DisableModelStringReplacement(f1_local3)
	return self
end
CoD.ChatClientInputTextBoxField.__resetProperties = function(f11_arg0)
	f11_arg0.TextBox:completeAnimation()
	f11_arg0.TextBox:setRGB(1, 1, 1)
	f11_arg0.TextBox:setAlpha(1)
end
CoD.ChatClientInputTextBoxField.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.TextBox:completeAnimation()
			f12_arg0.TextBox:setAlpha(0.75)
			f12_arg0.clipFinished(f12_arg0.TextBox)
		end,
		Focus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.TextBox:completeAnimation()
			f13_arg0.TextBox:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
			f13_arg0.clipFinished(f13_arg0.TextBox)
		end,
		InputFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.TextBox:completeAnimation()
			f14_arg0.TextBox:setAlpha(0.75)
			f14_arg0.clipFinished(f14_arg0.TextBox)
		end,
		Over = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.TextBox:completeAnimation()
			f15_arg0.TextBox:setAlpha(0.75)
			f15_arg0.clipFinished(f15_arg0.TextBox)
		end,
	},
	NoChannelsAvailable = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.TextBox:completeAnimation()
			f16_arg0.TextBox:setAlpha(0.75)
			f16_arg0.clipFinished(f16_arg0.TextBox)
		end,
	},
	ChattingIngame = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.TextBox:completeAnimation()
			f17_arg0.TextBox:setRGB(1, 1, 1)
			f17_arg0.TextBox:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.TextBox)
		end,
		InputFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.TextBox:completeAnimation()
			f18_arg0.TextBox:setAlpha(0.75)
			f18_arg0.clipFinished(f18_arg0.TextBox)
		end,
	},
	IngameChatActivated = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.TextBox:completeAnimation()
			f19_arg0.TextBox:setRGB(1, 1, 1)
			f19_arg0.TextBox:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.TextBox)
		end,
		InputFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.TextBox:completeAnimation()
			f20_arg0.TextBox:setAlpha(0.75)
			f20_arg0.clipFinished(f20_arg0.TextBox)
		end,
		Focus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.TextBox:completeAnimation()
			f21_arg0.TextBox:setAlpha(0.75)
			f21_arg0.clipFinished(f21_arg0.TextBox)
		end,
	},
	DefaultStateIngame = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.TextBox:completeAnimation()
			f22_arg0.TextBox:setAlpha(0.75)
			f22_arg0.clipFinished(f22_arg0.TextBox)
		end,
		Focus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.TextBox:completeAnimation()
			f23_arg0.TextBox:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
			f23_arg0.clipFinished(f23_arg0.TextBox)
		end,
		InputFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.TextBox:completeAnimation()
			f24_arg0.TextBox:setAlpha(0.75)
			f24_arg0.clipFinished(f24_arg0.TextBox)
		end,
		Over = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.TextBox:completeAnimation()
			f25_arg0.TextBox:setAlpha(0.75)
			f25_arg0.clipFinished(f25_arg0.TextBox)
		end,
	},
	Chatting = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.TextBox:completeAnimation()
			f27_arg0.TextBox:setAlpha(0.75)
			f27_arg0.clipFinished(f27_arg0.TextBox)
		end,
	},
}
CoD.ChatClientInputTextBoxField.__onClose = function(f28_arg0)
	f28_arg0.TextBox:close()
end
