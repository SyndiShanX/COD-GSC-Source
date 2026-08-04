require("ui/uieditor/widgets/pc/notifications/pc_notif_keyprompt")
CoD.PC_Notif_keyprompt_container = InheritFrom(LUI.UIElement)
CoD.PC_Notif_keyprompt_container.__defaultWidth = 441
CoD.PC_Notif_keyprompt_container.__defaultHeight = 28
CoD.PC_Notif_keyprompt_container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 15, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.PC_Notif_keyprompt_container)
	self.id = "PC_Notif_keyprompt_container"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KeyPromptAccept = CoD.PC_Notif_keyprompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -94.5, 55.5, 0, 1, 1, 1)
	KeyPromptAccept.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_acceptinvite}]"))
	KeyPromptAccept.AcceptText:setText(LocalizeToUpperString(0x65A8932254A9933))
	self:addElement(KeyPromptAccept)
	self.KeyPromptAccept = KeyPromptAccept
	local KeyPromptDecline = CoD.PC_Notif_keyprompt.new(f1_arg0, f1_arg1, 0.5, 0.5, 70.5, 220.5, 0, 1, 1, 1)
	KeyPromptDecline.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_declineinvite}]"))
	KeyPromptDecline.AcceptText:setText(LocalizeToUpperString(0x8EAF4FB1061FDE3))
	self:addElement(KeyPromptDecline)
	self.KeyPromptDecline = KeyPromptDecline
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.PCNotificationsUtility.IsNotificationWidgetVisible(f1_arg1)
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine.GetModelForController(f1_arg1)
	f1_local4(f1_local3, f1_local5["PC.CurrentNotification.visibility"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "PC.CurrentNotification.visibility",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine.GetModelForController(f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	KeyPromptAccept.id = "KeyPromptAccept"
	KeyPromptDecline.id = "KeyPromptDecline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Notif_keyprompt_container.__onClose = function(f7_arg0)
	f7_arg0.KeyPromptAccept:close()
	f7_arg0.KeyPromptDecline:close()
end
