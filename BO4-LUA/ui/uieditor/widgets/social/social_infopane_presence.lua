CoD.Social_InfoPane_Presence = InheritFrom(LUI.UIElement)
CoD.Social_InfoPane_Presence.__defaultWidth = 300
CoD.Social_InfoPane_Presence.__defaultHeight = 32
CoD.Social_InfoPane_Presence.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_InfoPane_Presence)
	self.id = "Social_InfoPane_Presence"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local presenceIcon = LUI.UIImage.new(0, 0, 1, 31, 0.5, 0.5, -15, 15)
	presenceIcon:linkToElementModel(self, "presence", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			presenceIcon:setImage(RegisterImage(CoD.SocialUtility.PresenceToIcon(f2_local0)))
		end
	end)
	self:addElement(presenceIcon)
	self.presenceIcon = presenceIcon
	local activityString = LUI.UIText.new(0, 0.88, 35, 35, 0.5, 0.5, 2, 16)
	activityString:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	activityString:setScale(LanguageOverrideNumberForScale("korean", 0.75, LanguageOverrideNumberForScale("chinese", 0.75, 1, 1)))
	activityString:setTTF("dinnext_regular")
	activityString:setLetterSpacing(1)
	activityString:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	activityString:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	activityString:linkToElementModel(self, "presenceString", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			activityString:setText(PlatformPresenceToLocalizedString(f3_local0))
		end
	end)
	self:addElement(activityString)
	self.activityString = activityString
	local presenceString = LUI.UIText.new(0, 0, 35, 300, 0.5, 0.5, -16, 2)
	presenceString:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	presenceString:setScale(LanguageOverrideNumberForScale("korean", 0.75, LanguageOverrideNumberForScale("chinese", 0.75, 1, 1)))
	presenceString:setTTF("ttmussels_regular")
	presenceString:setLetterSpacing(2)
	presenceString:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	presenceString:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	presenceString:linkToElementModel(self, "presence", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			presenceString:setText(LocalizeToUpperString(PresenceToModeString(f4_local0)))
		end
	end)
	self:addElement(presenceString)
	self.presenceString = presenceString
	local platformPresenceScroller = LUI.UIText.new(0, 0, 566, 810, 0.5, 0.5, -9, 9)
	platformPresenceScroller:setRGB(0.7, 0.7, 0.7)
	platformPresenceScroller:setAlpha(0)
	platformPresenceScroller:setTTF("dinnext_regular")
	platformPresenceScroller:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	platformPresenceScroller:linkToElementModel(self, "platformPresence", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			platformPresenceScroller:setText(PlatformPresenceToLocalizedString(f5_local0))
		end
	end)
	self:addElement(platformPresenceScroller)
	self.platformPresenceScroller = platformPresenceScroller
	self:mergeStateConditions({
		{
			stateName = "ShowPlatformPresence",
			condition = function(menu, element, event)
				return not IsInTitle(self, f1_arg1)
			end,
		},
		{
			stateName = "DefaultState_Chinese",
			condition = function(menu, element, event)
				return IsCurrentLanguageTraditionalChinese()
			end,
		},
	})
	self:linkToElementModel(self, "presence", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "presence",
		})
	end)
	self:linkToElementModel(self, "activity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "activity",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.Social_InfoPane_Presence.__resetProperties = function(f10_arg0)
	f10_arg0.platformPresenceScroller:completeAnimation()
	f10_arg0.presenceIcon:completeAnimation()
	f10_arg0.presenceString:completeAnimation()
	f10_arg0.activityString:completeAnimation()
	f10_arg0.platformPresenceScroller:setAlpha(0)
	f10_arg0.presenceIcon:setAlpha(1)
	f10_arg0.presenceString:setAlpha(1)
	f10_arg0.activityString:setLeftRight(0, 0.88, 35, 35)
	f10_arg0.activityString:setTopBottom(0.5, 0.5, 2, 16)
end
CoD.Social_InfoPane_Presence.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	ShowPlatformPresence = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.presenceIcon:completeAnimation()
			f12_arg0.presenceIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.presenceIcon)
			f12_arg0.activityString:completeAnimation()
			f12_arg0.activityString:setLeftRight(-0.08, 0.81, 35, 35)
			f12_arg0.clipFinished(f12_arg0.activityString)
			f12_arg0.presenceString:completeAnimation()
			f12_arg0.presenceString:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.presenceString)
			f12_arg0.platformPresenceScroller:completeAnimation()
			f12_arg0.platformPresenceScroller:setAlpha(0.5)
			f12_arg0.clipFinished(f12_arg0.platformPresenceScroller)
		end,
	},
	DefaultState_Chinese = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.activityString:completeAnimation()
			f13_arg0.activityString:setTopBottom(0.5, 0.5, 5, 23)
			f13_arg0.clipFinished(f13_arg0.activityString)
		end,
	},
}
CoD.Social_InfoPane_Presence.__onClose = function(f14_arg0)
	f14_arg0.presenceIcon:close()
	f14_arg0.activityString:close()
	f14_arg0.presenceString:close()
	f14_arg0.platformPresenceScroller:close()
end
