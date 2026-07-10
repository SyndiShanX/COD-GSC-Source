require("x64:15909c3f8633dba")
CoD.ChallengesNotification = InheritFrom(LUI.UIElement)
CoD.ChallengesNotification.__defaultWidth = 522
CoD.ChallengesNotification.__defaultHeight = 375
CoD.ChallengesNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesNotification)
	self.id = "ChallengesNotification"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local image = LUI.UIImage.new(0.5, 0.5, -96, 96, 0, 0, 57, 249)
	self:addElement(image)
	self.image = image
	local Text = LUI.UIText.new(0.5, 0.5, -306, 306, 0, 0, 267, 312)
	Text:setTTF("ttmussels_demibold")
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(Text, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWrapped(self, element, 40, 40)
	end)
	self:addElement(Text)
	self.Text = Text
	local WeaponLevelUpNotificationFooterLabel01 = CoD.WeaponLevelUpNotification_FooterLabel01.new(f1_arg0, f1_arg1, 0.5, 0.5, -96, 96, 0, 0, 312, 360)
	self:addElement(WeaponLevelUpNotificationFooterLabel01)
	self.WeaponLevelUpNotificationFooterLabel01 = WeaponLevelUpNotificationFooterLabel01
	self.image:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			image:setImage(RegisterImage(f3_local0))
		end
	end)
	self.Text:linkToElementModel(self, "title", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Text:setText(f4_local0)
		end
	end)
	self.WeaponLevelUpNotificationFooterLabel01:linkToElementModel(self, "color", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			WeaponLevelUpNotificationFooterLabel01.WeaponLevelUpNotificationFooterBacking:setRGB(f5_local0)
		end
	end)
	self.WeaponLevelUpNotificationFooterLabel01:linkToElementModel(self, "subtitle", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			WeaponLevelUpNotificationFooterLabel01.SubText:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesNotification.__resetProperties = function(f7_arg0)
	f7_arg0.Text:completeAnimation()
	f7_arg0.image:completeAnimation()
	f7_arg0.Text:setAlpha(1)
	f7_arg0.image:setAlpha(1)
end
CoD.ChallengesNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.image:beginAnimation(300)
				f8_arg0.image:setAlpha(1)
				f8_arg0.image:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.image:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.image:completeAnimation()
			f8_arg0.image:setAlpha(0)
			f8_local0(f8_arg0.image)
			local f8_local1 = function(f10_arg0)
				f8_arg0.Text:beginAnimation(300)
				f8_arg0.Text:setAlpha(1)
				f8_arg0.Text:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Text:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Text:completeAnimation()
			f8_arg0.Text:setAlpha(0)
			f8_local1(f8_arg0.Text)
		end,
		TimeUp = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.image:beginAnimation(300)
				f11_arg0.image:setAlpha(0)
				f11_arg0.image:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.image:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.image:completeAnimation()
			f11_arg0.image:setAlpha(1)
			f11_local0(f11_arg0.image)
			local f11_local1 = function(f13_arg0)
				f11_arg0.Text:beginAnimation(300)
				f11_arg0.Text:setAlpha(0)
				f11_arg0.Text:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Text:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Text:completeAnimation()
			f11_arg0.Text:setAlpha(1)
			f11_local1(f11_arg0.Text)
		end,
	},
}
CoD.ChallengesNotification.__onClose = function(f14_arg0)
	f14_arg0.image:close()
	f14_arg0.Text:close()
	f14_arg0.WeaponLevelUpNotificationFooterLabel01:close()
end
