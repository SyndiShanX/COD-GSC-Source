CoD.ChatClientChatEntryPlayerName = InheritFrom(LUI.UIElement)
CoD.ChatClientChatEntryPlayerName.__defaultWidth = 112
CoD.ChatClientChatEntryPlayerName.__defaultHeight = 27
CoD.ChatClientChatEntryPlayerName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientChatEntryPlayerName)
	self.id = "ChatClientChatEntryPlayerName"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setAlpha(0)
	self:addElement(background)
	self.background = background
	self:mergeStateConditions({
		{
			stateName = "Selectable",
			condition = function(menu, element, event)
				return ChatClientCurrentChatIsActive(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["ChatGlobal.inGameChatActive"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "ChatGlobal.inGameChatActive",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["ChatGlobal.MenuChatInActiveMode"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ChatGlobal.MenuChatInActiveMode",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["ChatGlobal.Event"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ChatGlobal.Event",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f6_arg2, f6_arg3, f6_arg4)
		CoD.PCWidgetUtility.UpdateChatPlayerName(self, controller)
	end)
	self:linkToElementModel(self, "displayName", true, function(model)
		local f7_local0 = self
		CoD.PCWidgetUtility.UpdateChatPlayerName(self, f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.PCWidgetUtility.SetupLeftClickableChatPlayerName(self, f1_arg1, f1_arg0)
	return self
end
CoD.ChatClientChatEntryPlayerName.__resetProperties = function(f8_arg0)
	f8_arg0.background:completeAnimation()
	f8_arg0.background:setRGB(1, 1, 1)
	f8_arg0.background:setAlpha(0)
end
CoD.ChatClientChatEntryPlayerName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Selectable = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		Over = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.background:beginAnimation(5500)
				f11_arg0.background:setAlpha(0.4)
				f11_arg0.background:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.background:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.background:completeAnimation()
			f11_arg0.background:setRGB(0.55, 0.55, 0.55)
			f11_arg0.background:setAlpha(0.6)
			f11_local0(f11_arg0.background)
		end,
		Focus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.background:beginAnimation(100)
				f13_arg0.background:setAlpha(0.4)
				f13_arg0.background:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.background:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.background:completeAnimation()
			f13_arg0.background:setRGB(0.51, 0.51, 0.51)
			f13_arg0.background:setAlpha(0)
			f13_local0(f13_arg0.background)
		end,
	},
}
