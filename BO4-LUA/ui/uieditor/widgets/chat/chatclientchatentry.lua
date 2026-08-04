require("ui/uieditor/widgets/chat/chatclientchatentrylineoftext")
require("ui/uieditor/widgets/chat/chatclientchatentryplayername")
CoD.ChatClientChatEntry = InheritFrom(LUI.UIElement)
CoD.ChatClientChatEntry.__defaultWidth = 508
CoD.ChatClientChatEntry.__defaultHeight = 27
CoD.ChatClientChatEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientChatEntry)
	self.id = "ChatClientChatEntry"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local ChatClientChatEntryLineOfText = CoD.ChatClientChatEntryLineOfText.new(f1_arg0, f1_arg1, 0, 0, 0, 508, 0, 0, 0, 21)
	ChatClientChatEntryLineOfText:linkToElementModel(self, nil, false, function(model)
		ChatClientChatEntryLineOfText:setModel(model, f1_arg1)
	end)
	self:addElement(ChatClientChatEntryLineOfText)
	self.ChatClientChatEntryLineOfText = ChatClientChatEntryLineOfText
	local ChatClientChatEntryPlayerName = CoD.ChatClientChatEntryPlayerName.new(f1_arg0, f1_arg1, 0, 0, 0, 112, 0, 0, 3.5, 23.5)
	ChatClientChatEntryPlayerName:linkToElementModel(self, nil, false, function(model)
		ChatClientChatEntryPlayerName:setModel(model, f1_arg1)
	end)
	self:addElement(ChatClientChatEntryPlayerName)
	self.ChatClientChatEntryPlayerName = ChatClientChatEntryPlayerName
	self:mergeStateConditions({
		{
			stateName = "InGame",
			condition = function(menu, element, event)
				local f4_local0 = IsInGame()
				if f4_local0 then
					f4_local0 = Engine.IsVisibilityBitSet(f1_arg1, Enum.UIVisibilityBit[@"bit_hud_visible"])
					if f4_local0 then
						f4_local0 = not ChatClientCurrentChatIsActive(f1_arg1)
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "InGameChatting",
			condition = function(menu, element, event)
				return IsInGame() and Engine.IsVisibilityBitSet(f1_arg1, Enum.UIVisibilityBit[@"bit_hud_visible"])
			end,
		},
		{
			stateName = "FadeOut",
			condition = function(menu, element, event)
				return not ChatClientCurrentChatIsActive(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local4, f1_local6["ChatGlobal.inGameChatActive"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "ChatGlobal.inGameChatActive",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local4, f1_local6["ChatGlobal.MenuChatInActiveMode"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "ChatGlobal.MenuChatInActiveMode",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local4, f1_local6["ChatGlobal.Event"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "ChatGlobal.Event",
		})
	end, false)
	ChatClientChatEntryPlayerName.id = "ChatClientChatEntryPlayerName"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.PCWidgetUtility.SetupChatLineWidget(self)
	DisableModelStringReplacement(self.ChatClientChatEntryLineOfText)
	CoD.PCWidgetUtility.SetupRightClickableChatPlayerNameParent(self, f1_arg1, f1_arg0)
	return self
end
CoD.ChatClientChatEntry.__resetProperties = function(f11_arg0)
	f11_arg0.Background:completeAnimation()
	f11_arg0.ChatClientChatEntryPlayerName:completeAnimation()
	f11_arg0.ChatClientChatEntryLineOfText:completeAnimation()
	f11_arg0.Background:setAlpha(0)
	f11_arg0.ChatClientChatEntryPlayerName:setAlpha(1)
	f11_arg0.ChatClientChatEntryLineOfText:setAlpha(1)
end
CoD.ChatClientChatEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	InGame = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.Background:completeAnimation()
			f13_arg0.Background:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Background)
			local f13_local0 = function(f14_arg0)
				f14_arg0:beginAnimation(2500)
				f14_arg0:setAlpha(0)
				f14_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ChatClientChatEntryLineOfText:beginAnimation(7500)
			f13_arg0.ChatClientChatEntryLineOfText:setAlpha(1)
			f13_arg0.ChatClientChatEntryLineOfText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
			f13_arg0.ChatClientChatEntryLineOfText:registerEventHandler("transition_complete_keyframe", f13_local0)
			f13_arg0.ChatClientChatEntryPlayerName:completeAnimation()
			f13_arg0.ChatClientChatEntryPlayerName:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ChatClientChatEntryPlayerName)
		end,
	},
	InGameChatting = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.Background:completeAnimation()
			f15_arg0.Background:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Background)
		end,
	},
	FadeOut = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.Background:completeAnimation()
			f16_arg0.Background:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Background)
			local f16_local0 = function(f17_arg0)
				f17_arg0:beginAnimation(2500)
				f17_arg0:setAlpha(0)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.ChatClientChatEntryLineOfText:beginAnimation(7500)
			f16_arg0.ChatClientChatEntryLineOfText:setAlpha(1)
			f16_arg0.ChatClientChatEntryLineOfText:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
			f16_arg0.ChatClientChatEntryLineOfText:registerEventHandler("transition_complete_keyframe", f16_local0)
			f16_arg0.ChatClientChatEntryPlayerName:beginAnimation(7500)
			f16_arg0.ChatClientChatEntryPlayerName:setAlpha(0)
			f16_arg0.ChatClientChatEntryPlayerName:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
			f16_arg0.ChatClientChatEntryPlayerName:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
		end,
	},
}
CoD.ChatClientChatEntry.__onClose = function(f18_arg0)
	f18_arg0.ChatClientChatEntryLineOfText:close()
	f18_arg0.ChatClientChatEntryPlayerName:close()
end
