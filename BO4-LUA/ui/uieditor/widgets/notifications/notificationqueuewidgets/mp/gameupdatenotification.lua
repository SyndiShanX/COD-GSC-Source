CoD.GameUpdateNotification = InheritFrom(LUI.UIElement)
CoD.GameUpdateNotification.__defaultWidth = 500
CoD.GameUpdateNotification.__defaultHeight = 48
CoD.GameUpdateNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameUpdateNotification)
	self.id = "GameUpdateNotification"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.21, 0.21, 0.21)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local NotificationText = LUI.UIText.new(0.5, 0.5, -230, 230, 0, 0, 4.5, 43.5)
	NotificationText:setTTF("ttmussels_regular")
	NotificationText:setLetterSpacing(4)
	NotificationText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NotificationText:setBackingType(2)
	NotificationText:setBackingColor(0, 0, 0)
	NotificationText:setBackingAlpha(0.8)
	NotificationText:setBackingXPadding(14)
	NotificationText:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NotificationText:setRGB(f2_local0)
		end
	end)
	NotificationText:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			NotificationText:setText(f3_local0)
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
	local f1_local3 = self
	CoD.NotificationUtility.InitGameUpdateNotification(self, f1_arg1)
	return self
end
CoD.GameUpdateNotification.__resetProperties = function(f5_arg0)
	f5_arg0.NotificationText:completeAnimation()
	f5_arg0.Backing:completeAnimation()
	f5_arg0.NotificationText:setAlpha(1)
	f5_arg0.Backing:setLeftRight(0, 1, 0, 0)
	f5_arg0.Backing:setAlpha(0.5)
end
CoD.GameUpdateNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Backing)
			f6_arg0.NotificationText:completeAnimation()
			f6_arg0.NotificationText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NotificationText)
		end,
		StartNotification = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Backing:beginAnimation(200)
				f7_arg0.Backing:setLeftRight(0, 1, 0, 0)
				f7_arg0.Backing:setAlpha(0.5)
				f7_arg0.Backing:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Backing:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setLeftRight(0.5, 0.5, 0, 0)
			f7_arg0.Backing:setAlpha(0)
			f7_local0(f7_arg0.Backing)
			local f7_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(200)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.NotificationText:beginAnimation(200)
				f7_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f7_arg0.NotificationText:completeAnimation()
			f7_arg0.NotificationText:setAlpha(0)
			f7_local1(f7_arg0.NotificationText)
		end,
		TimeUp = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(200)
					f13_arg0:setLeftRight(0.5, 0.5, 0, 0)
					f13_arg0:setAlpha(0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.Backing:beginAnimation(200)
				f11_arg0.Backing:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Backing:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setLeftRight(0, 1, 0, 0)
			f11_arg0.Backing:setAlpha(0.5)
			f11_local0(f11_arg0.Backing)
			local f11_local1 = function(f14_arg0)
				f11_arg0.NotificationText:beginAnimation(200)
				f11_arg0.NotificationText:setAlpha(0)
				f11_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.NotificationText:completeAnimation()
			f11_arg0.NotificationText:setAlpha(1)
			f11_local1(f11_arg0.NotificationText)
		end,
	},
}
CoD.GameUpdateNotification.__onClose = function(f15_arg0)
	f15_arg0.NotificationText:close()
end
