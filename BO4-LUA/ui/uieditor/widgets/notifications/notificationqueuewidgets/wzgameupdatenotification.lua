require("x64:92371d2c5786619")
CoD.WZGameUpdateNotification = InheritFrom(LUI.UIElement)
CoD.WZGameUpdateNotification.__defaultWidth = 500
CoD.WZGameUpdateNotification.__defaultHeight = 48
CoD.WZGameUpdateNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZGameUpdateNotification)
	self.id = "WZGameUpdateNotification"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NotificationText = LUI.UIText.new(0.5, 0.5, -230, 230, 0, 0, 4.5, 43.5)
	NotificationText:setTTF("ttmussels_regular")
	NotificationText:setLetterSpacing(4)
	NotificationText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NotificationText:setBackingType(1)
	NotificationText:setBackingWidget(CoD.PrematchCountdown_Backing, f1_arg0, f1_arg1)
	NotificationText:setBackingAlpha(0.8)
	NotificationText:setBackingXPadding(60)
	NotificationText:setBackingYPadding(15)
	NotificationText:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NotificationText:setText(f2_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(NotificationText, "setText", function(element, controller)
		ScaleWidgetToLabelCentered(self, element, 20)
	end)
	self:addElement(NotificationText)
	self.NotificationText = NotificationText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.NotificationUtility.InitGameUpdateNotification(self, f1_arg1)
	return self
end
CoD.WZGameUpdateNotification.__resetProperties = function(f4_arg0)
	f4_arg0.NotificationText:completeAnimation()
	f4_arg0.NotificationText:setAlpha(1)
end
CoD.WZGameUpdateNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.NotificationText:completeAnimation()
			f5_arg0.NotificationText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.NotificationText)
		end,
		StartNotification = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.NotificationText:beginAnimation(200)
				f6_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.NotificationText:completeAnimation()
			f6_arg0.NotificationText:setAlpha(0)
			f6_local0(f6_arg0.NotificationText)
		end,
		TimeUp = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.NotificationText:beginAnimation(400, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f9_arg0.NotificationText:setAlpha(0)
				f9_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.NotificationText:completeAnimation()
			f9_arg0.NotificationText:setAlpha(1)
			f9_local0(f9_arg0.NotificationText)
		end,
	},
}
CoD.WZGameUpdateNotification.__onClose = function(f11_arg0)
	f11_arg0.NotificationText:close()
end
