CoD.Social_InfoPane_Presence_JoinableIcon = InheritFrom(LUI.UIElement)
CoD.Social_InfoPane_Presence_JoinableIcon.__defaultWidth = 238
CoD.Social_InfoPane_Presence_JoinableIcon.__defaultHeight = 36
CoD.Social_InfoPane_Presence_JoinableIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_InfoPane_Presence_JoinableIcon)
	self.id = "Social_InfoPane_Presence_JoinableIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local joinableIcon = LUI.UIImage.new(0, 0, 0, 32, 0.5, 0.5, -16, 16)
	joinableIcon:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	joinableIcon:setImage(RegisterImage(@"uie_t7_menu_frontend_iconjoinable"))
	joinableIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(joinableIcon)
	self.joinableIcon = joinableIcon
	local notjoinableText = LUI.UIText.new(0, 1, 6, -6, 0.5, 0.5, -8, 10)
	notjoinableText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	notjoinableText:setAlpha(0)
	notjoinableText:setScale(LanguageOverrideNumber("japanese", 0.9, 1, 1))
	notjoinableText:setText(LocalizeToUpperString(@"hash_634F5097A432DED7"))
	notjoinableText:setTTF("dinnext_regular")
	notjoinableText:setLetterSpacing(2)
	notjoinableText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	notjoinableText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(notjoinableText)
	self.notjoinableText = notjoinableText
	local joinableText = LUI.UIText.new(0, 0, 36, 236, 0.5, 0.5, -7, 11)
	joinableText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	joinableText:setScale(LanguageOverrideNumber("japanese", 0.9, 1, 1))
	joinableText:setText(LocalizeToUpperString(@"hash_46AA4BA2A90A62C5"))
	joinableText:setTTF("dinnext_regular")
	joinableText:setLetterSpacing(2)
	joinableText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	joinableText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(joinableText)
	self.joinableText = joinableText
	self:mergeStateConditions({
		{
			stateName = "LobbyLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.lobbyLockedIn")
			end,
		},
		{
			stateName = "HideJoinButton",
			condition = function(menu, element, event)
				return PropertyIsTrue(self, "hideJoinButton")
			end,
		},
		{
			stateName = "JoinableLimited",
			condition = function(menu, element, event)
				local f4_local0 = CoD.SocialUtility.IsPartyMissingDLCFriendUsing(f1_arg1, element)
				if f4_local0 then
					f4_local0 = IsPC()
					if f4_local0 then
						f4_local0 = not CoD.SocialUtility.IsPartyMissingDLCFriendRequires(f1_arg1, element)
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "NotJoinable",
			condition = function(menu, element, event)
				return not IsJoinable(element, f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyLockedIn"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyLockedIn",
		})
	end, false)
	self:linkToElementModel(self, " playlist", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = " playlist",
		})
	end)
	self:linkToElementModel(self, "mapId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "mapId",
		})
	end)
	self:linkToElementModel(self, "lobbyDLCBits", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lobbyDLCBits",
		})
	end)
	self:linkToElementModel(self, "joinable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "joinable",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_InfoPane_Presence_JoinableIcon.__resetProperties = function(f11_arg0)
	f11_arg0.joinableText:completeAnimation()
	f11_arg0.joinableIcon:completeAnimation()
	f11_arg0.notjoinableText:completeAnimation()
	f11_arg0.joinableText:setAlpha(1)
	f11_arg0.joinableIcon:setAlpha(1)
	f11_arg0.notjoinableText:setAlpha(0)
end
CoD.Social_InfoPane_Presence_JoinableIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	LobbyLocked = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.joinableIcon:completeAnimation()
			f13_arg0.joinableIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.joinableIcon)
			f13_arg0.joinableText:completeAnimation()
			f13_arg0.joinableText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.joinableText)
		end,
	},
	HideJoinButton = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.joinableIcon:completeAnimation()
			f14_arg0.joinableIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.joinableIcon)
			f14_arg0.joinableText:completeAnimation()
			f14_arg0.joinableText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.joinableText)
		end,
	},
	JoinableLimited = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.joinableIcon:completeAnimation()
			f15_arg0.joinableIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.joinableIcon)
			f15_arg0.joinableText:completeAnimation()
			f15_arg0.joinableText:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.joinableText)
		end,
	},
	NotJoinable = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.joinableIcon:completeAnimation()
			f16_arg0.joinableIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.joinableIcon)
			f16_arg0.notjoinableText:completeAnimation()
			f16_arg0.notjoinableText:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.notjoinableText)
			f16_arg0.joinableText:completeAnimation()
			f16_arg0.joinableText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.joinableText)
		end,
	},
}
