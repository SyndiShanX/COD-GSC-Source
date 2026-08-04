require("ui/uieditor/widgets/pc_notif")
CoD.PC_Notif_Container = InheritFrom(LUI.UIElement)
CoD.PC_Notif_Container.__defaultWidth = 450
CoD.PC_Notif_Container.__defaultHeight = 100
CoD.PC_Notif_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PCUtility.StartAddingSticky(f1_arg0, self)
	CoD.PCNotificationsUtility.PreSetupNotificationWidget(self, f1_arg0, f1_arg1)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.PC_Notif_Container)
	self.id = "PC_Notif_Container"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PCNotif = nil
	PCNotif = CoD.PC_Notif.new(f1_arg0, f1_arg1, 0.5, 0.5, -225, 225, 0, 0, 0, 100)
	self:addElement(PCNotif)
	self.PCNotif = PCNotif
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.PCNotificationsUtility.IsNotificationWidgetVisible(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["PC.CurrentNotification.visibility"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "PC.CurrentNotification.visibility",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsSelfInState(self, "Invisible") and IsElementPropertyValue(self, "__wasOpen", true) then
			PlayClip(self, "Out", controller)
			SetElementProperty(self, "__wasOpen", false)
			SetLoseFocusToSelf(self, controller)
		elseif IsInDefaultState(element) then
			PlayClip(self, "In", controller)
			SetElementProperty(self, "__wasOpen", true)
		end
	end)
	if CoD.isPC then
		PCNotif.id = "PCNotif"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.PCNotificationsUtility.PrepareNotificationContainer(self, f1_arg1, f1_arg0, self.PCNotif)
	DisableKeyboardNavigationByElement(self)
	CoD.PCUtility.StopAddingSticky(f1_arg0)
	return self
end
CoD.PC_Notif_Container.__resetProperties = function(f5_arg0)
	f5_arg0.PCNotif:completeAnimation()
	f5_arg0.PCNotif:setLeftRight(0.5, 0.5, -225, 225)
	f5_arg0.PCNotif:setAlpha(1)
end
CoD.PC_Notif_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.PCNotif:completeAnimation()
			f6_arg0.PCNotif:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.PCNotif)
		end,
		In = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.PCNotif:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_both"])
				f7_arg0.PCNotif:setLeftRight(0.5, 0.5, -225, 225)
				f7_arg0.PCNotif:setAlpha(1)
				f7_arg0.PCNotif:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.PCNotif:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.PCNotif:completeAnimation()
			f7_arg0.PCNotif:setLeftRight(0.5, 0.5, -175, 275)
			f7_arg0.PCNotif:setAlpha(0)
			f7_local0(f7_arg0.PCNotif)
		end,
	},
	Invisible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.PCNotif:completeAnimation()
			f9_arg0.PCNotif:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PCNotif)
		end,
		Out = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.PCNotif:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_both"])
				f10_arg0.PCNotif:setLeftRight(0.5, 0.5, -205, 245)
				f10_arg0.PCNotif:setAlpha(0)
				f10_arg0.PCNotif:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.PCNotif:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.PCNotif:completeAnimation()
			f10_arg0.PCNotif:setLeftRight(0.5, 0.5, -225, 225)
			f10_arg0.PCNotif:setAlpha(1)
			f10_local0(f10_arg0.PCNotif)
		end,
	},
}
CoD.PC_Notif_Container.__onClose = function(f12_arg0)
	f12_arg0.PCNotif:close()
end
