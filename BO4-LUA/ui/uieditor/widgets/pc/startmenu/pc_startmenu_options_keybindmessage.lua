require("ui/uieditor/widgets/pc/startmenu/pc_startmenu_options_keybindmessage_background")
require("ui/uieditor/widgets/pc/startmenu/pc_startmenu_options_keybindmessage_text")
CoD.PC_StartMenu_Options_KeybindMessage = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_KeybindMessage.__defaultWidth = 1920
CoD.PC_StartMenu_Options_KeybindMessage.__defaultHeight = 86
CoD.PC_StartMenu_Options_KeybindMessage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_KeybindMessage)
	self.id = "PC_StartMenu_Options_KeybindMessage"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.PC_StartMenu_Options_KeybindMessage_Background.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Background:mergeStateConditions({
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowErrorMessage(self, f1_arg1)
			end,
		},
		{
			stateName = "Binding",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsBindingKey(self, f1_arg1)
			end,
		},
		{
			stateName = "Success",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowPastKeybind(self, f1_arg1)
			end,
		},
		{
			stateName = "Warning",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowWarningMessage(self, f1_arg1)
			end,
		},
		{
			stateName = "Recording",
			condition = function(menu, element, event)
				return CoD.PCOptionsUtility.IsRecordingLoopBack(f1_arg1)
			end,
		},
	})
	local f1_local2 = Background
	local KeybindMessage = Background.subscribeToModel
	local f1_local4 = DataSources.KeybindMessages.getModel(f1_arg1)
	KeybindMessage(f1_local2, f1_local4.showErrorMessage, function(f7_arg0)
		f1_arg0:updateElementState(Background, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "showErrorMessage",
		})
	end, false)
	f1_local2 = Background
	KeybindMessage = Background.subscribeToModel
	f1_local4 = DataSources.KeybindMessages.getModel(f1_arg1)
	KeybindMessage(f1_local2, f1_local4.isBindingKey, function(f8_arg0)
		f1_arg0:updateElementState(Background, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "isBindingKey",
		})
	end, false)
	f1_local2 = Background
	KeybindMessage = Background.subscribeToModel
	f1_local4 = DataSources.KeybindMessages.getModel(f1_arg1)
	KeybindMessage(f1_local2, f1_local4.showPastKeybind, function(f9_arg0)
		f1_arg0:updateElementState(Background, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "showPastKeybind",
		})
	end, false)
	f1_local2 = Background
	KeybindMessage = Background.subscribeToModel
	f1_local4 = DataSources.KeybindMessages.getModel(f1_arg1)
	KeybindMessage(f1_local2, f1_local4.showWarningMessage, function(f10_arg0)
		f1_arg0:updateElementState(Background, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "showWarningMessage",
		})
	end, false)
	f1_local2 = Background
	KeybindMessage = Background.subscribeToModel
	f1_local4 = Engine.GetGlobalModel()
	KeybindMessage(f1_local2, f1_local4["SpeakingEnergy.isRecording"], function(f11_arg0)
		f1_arg0:updateElementState(Background, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "SpeakingEnergy.isRecording",
		})
	end, false)
	self:addElement(Background)
	self.Background = Background
	KeybindMessage = CoD.PC_StartMenu_Options_KeybindMessage_Text.new(f1_arg0, f1_arg1, 0.5, 0.5, -76, 124, 0.5, 0.5, -9.5, 15.5)
	KeybindMessage:mergeStateConditions({
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowErrorMessage(self, f1_arg1)
			end,
		},
		{
			stateName = "Binding",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsBindingKey(self, f1_arg1)
			end,
		},
		{
			stateName = "Success",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowPastKeybind(self, f1_arg1)
			end,
		},
		{
			stateName = "Warning",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowWarningMessage(self, f1_arg1)
			end,
		},
		{
			stateName = "Recording",
			condition = function(menu, element, event)
				return CoD.PCOptionsUtility.IsRecordingLoopBack(f1_arg1)
			end,
		},
	})
	f1_local4 = KeybindMessage
	f1_local2 = KeybindMessage.subscribeToModel
	local f1_local5 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.showErrorMessage, function(f17_arg0)
		f1_arg0:updateElementState(KeybindMessage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "showErrorMessage",
		})
	end, false)
	f1_local4 = KeybindMessage
	f1_local2 = KeybindMessage.subscribeToModel
	f1_local5 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.isBindingKey, function(f18_arg0)
		f1_arg0:updateElementState(KeybindMessage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "isBindingKey",
		})
	end, false)
	f1_local4 = KeybindMessage
	f1_local2 = KeybindMessage.subscribeToModel
	f1_local5 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.showPastKeybind, function(f19_arg0)
		f1_arg0:updateElementState(KeybindMessage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "showPastKeybind",
		})
	end, false)
	f1_local4 = KeybindMessage
	f1_local2 = KeybindMessage.subscribeToModel
	f1_local5 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.showWarningMessage, function(f20_arg0)
		f1_arg0:updateElementState(KeybindMessage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "showWarningMessage",
		})
	end, false)
	f1_local4 = KeybindMessage
	f1_local2 = KeybindMessage.subscribeToModel
	f1_local5 = Engine.GetGlobalModel()
	f1_local2(f1_local4, f1_local5["SpeakingEnergy.isRecording"], function(f21_arg0)
		f1_arg0:updateElementState(KeybindMessage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "SpeakingEnergy.isRecording",
		})
	end, false)
	self:addElement(KeybindMessage)
	self.KeybindMessage = KeybindMessage
	self:mergeStateConditions({
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowErrorMessage(self, f1_arg1)
			end,
		},
		{
			stateName = "Binding",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsBindingKey(self, f1_arg1)
			end,
		},
		{
			stateName = "Success",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowPastKeybind(self, f1_arg1)
			end,
		},
		{
			stateName = "Warning",
			condition = function(menu, element, event)
				return CoD.PCUtility.ShowWarningMessage(self, f1_arg1)
			end,
		},
		{
			stateName = "Recording",
			condition = function(menu, element, event)
				return CoD.PCOptionsUtility.IsRecordingLoopBack(f1_arg1)
			end,
		},
	})
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.showErrorMessage, function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "showErrorMessage",
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.isBindingKey, function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "isBindingKey",
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.showPastKeybind, function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "showPastKeybind",
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.showWarningMessage, function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "showWarningMessage",
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine.GetGlobalModel()
	f1_local2(f1_local4, f1_local5["SpeakingEnergy.isRecording"], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "SpeakingEnergy.isRecording",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_KeybindMessage.__resetProperties = function(f32_arg0)
	f32_arg0.KeybindMessage:completeAnimation()
	f32_arg0.Background:completeAnimation()
	f32_arg0.KeybindMessage:setLeftRight(0.5, 0.5, -76, 124)
	f32_arg0.KeybindMessage:setAlpha(1)
	f32_arg0.Background:setAlpha(1)
end
CoD.PC_StartMenu_Options_KeybindMessage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.KeybindMessage:completeAnimation()
			f33_arg0.KeybindMessage:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.KeybindMessage)
		end,
	},
	Error = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.KeybindMessage:completeAnimation()
			f34_arg0.KeybindMessage:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.KeybindMessage)
		end,
	},
	Binding = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.Background:completeAnimation()
			f35_arg0.Background:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.Background)
			f35_arg0.KeybindMessage:completeAnimation()
			f35_arg0.KeybindMessage:setLeftRight(0.5, 0.5, -100, 100)
			f35_arg0.clipFinished(f35_arg0.KeybindMessage)
		end,
	},
	Success = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.KeybindMessage:completeAnimation()
			f36_arg0.KeybindMessage:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.KeybindMessage)
		end,
	},
	Warning = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			f37_arg0.KeybindMessage:completeAnimation()
			f37_arg0.KeybindMessage:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.KeybindMessage)
		end,
	},
	Recording = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.KeybindMessage:completeAnimation()
			f38_arg0.KeybindMessage:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.KeybindMessage)
		end,
	},
}
CoD.PC_StartMenu_Options_KeybindMessage.__onClose = function(f39_arg0)
	f39_arg0.Background:close()
	f39_arg0.KeybindMessage:close()
end
