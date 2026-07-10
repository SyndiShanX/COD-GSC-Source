require("x64:1c1299b38cb2e0e")
require("x64:dd90405b817027f")
require("x64:fa31663b3b7e3c1")
CoD.CodCasterAnnouncementFeed = InheritFrom(LUI.UIElement)
CoD.CodCasterAnnouncementFeed.__defaultWidth = 394
CoD.CodCasterAnnouncementFeed.__defaultHeight = 24
CoD.CodCasterAnnouncementFeed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterAnnouncementFeed)
	self.id = "CodCasterAnnouncementFeed"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AnnouncementImageBackground = CoD.Codcaster_annoncement_bg.new(f1_arg0, f1_arg1, 0, 0, -33, 427, 0, 0, 20, 52)
	AnnouncementImageBackground:setAlpha(0)
	self:addElement(AnnouncementImageBackground)
	self.AnnouncementImageBackground = AnnouncementImageBackground
	local AnnouncementImageHighlightLeft = CoD.Codcaster_AnnouncementHighlight.new(f1_arg0, f1_arg1, 0, 0, -17, 46, 0, 0, 23, 51)
	AnnouncementImageHighlightLeft:setAlpha(0)
	self:addElement(AnnouncementImageHighlightLeft)
	self.AnnouncementImageHighlightLeft = AnnouncementImageHighlightLeft
	local AnnouncementImageHighlightRight = CoD.Codcaster_AnnouncementHighlight.new(f1_arg0, f1_arg1, 0, 0, 349, 412, 0, 0, 23, 51)
	AnnouncementImageHighlightRight:setAlpha(0)
	AnnouncementImageHighlightRight:setYRot(180)
	self:addElement(AnnouncementImageHighlightRight)
	self.AnnouncementImageHighlightRight = AnnouncementImageHighlightRight
	local AnnouncementFeedText = CoD.CodCasterAnnouncementFeedText.new(f1_arg0, f1_arg1, 0, 0, -105.5, 499.5, 0, 0, 29, 44)
	AnnouncementFeedText:setAlpha(0)
	self:addElement(AnnouncementFeedText)
	self.AnnouncementFeedText = AnnouncementFeedText
	self:mergeStateConditions({
		{
			stateName = "HiddenDueToDS",
			condition = function(menu, element, event)
				return not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_teamscore", 1)
			end,
		},
		{
			stateName = "HiddenDueToDS2",
			condition = function(menu, element, event)
				return not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_notification_announcements", 1)
			end,
		},
		{
			stateName = "HiddenDueToQS",
			condition = function(menu, element, event)
				return not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerlist", 1)
			end,
		},
		{
			stateName = "HiddenDueToScoreboard",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "NoRoundAndLives",
			condition = function(menu, element, event)
				local f6_local0
				if not CoD.HUDUtility.ShouldShowTeamLives(f1_arg1) and not IsGametypeSettingsValue("roundLimit", 3) then
					f6_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("ctf")
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.profileSettingsUpdated, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self.__on_menuOpened_self = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		UpdateSelfElementState(f9_arg2, self, f9_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.CodCasterUtility.PostLoad(self, f1_arg1)
	return self
end
CoD.CodCasterAnnouncementFeed.__resetProperties = function(f11_arg0)
	f11_arg0.AnnouncementImageBackground:completeAnimation()
	f11_arg0.AnnouncementImageHighlightLeft:completeAnimation()
	f11_arg0.AnnouncementImageHighlightRight:completeAnimation()
	f11_arg0.AnnouncementFeedText:completeAnimation()
	f11_arg0.AnnouncementImageBackground:setTopBottom(0, 0, 20, 52)
	f11_arg0.AnnouncementImageBackground:setAlpha(0)
	f11_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, 23, 51)
	f11_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
	f11_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, 23, 51)
	f11_arg0.AnnouncementImageHighlightRight:setAlpha(0)
	f11_arg0.AnnouncementFeedText:setTopBottom(0, 0, 29, 44)
	f11_arg0.AnnouncementFeedText:setAlpha(0)
end
CoD.CodCasterAnnouncementFeed.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.AnnouncementImageBackground:completeAnimation()
			f12_arg0.AnnouncementImageBackground:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.AnnouncementImageBackground)
			f12_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f12_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.AnnouncementImageHighlightLeft)
			f12_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f12_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.AnnouncementImageHighlightRight)
		end,
		OnTeam1 = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				f13_arg0.AnnouncementImageBackground:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f13_arg0.AnnouncementImageBackground:setTopBottom(0, 0, 20, 52)
				f13_arg0.AnnouncementImageBackground:setAlpha(1)
				f13_arg0.AnnouncementImageBackground:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.AnnouncementImageBackground:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.AnnouncementImageBackground:completeAnimation()
			f13_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -4, 28)
			f13_arg0.AnnouncementImageBackground:setAlpha(0)
			f13_local0(f13_arg0.AnnouncementImageBackground)
			local f13_local1 = function(f15_arg0)
				f13_arg0.AnnouncementImageHighlightLeft:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f13_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, 23, 51)
				f13_arg0.AnnouncementImageHighlightLeft:setAlpha(1)
				f13_arg0.AnnouncementImageHighlightLeft:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.AnnouncementImageHighlightLeft:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f13_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, -1, 27)
			f13_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f13_local1(f13_arg0.AnnouncementImageHighlightLeft)
			local f13_local2 = function(f16_arg0)
				f13_arg0.AnnouncementFeedText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f13_arg0.AnnouncementFeedText:setTopBottom(0, 0, 30, 45)
				f13_arg0.AnnouncementFeedText:setAlpha(1)
				f13_arg0.AnnouncementFeedText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.AnnouncementFeedText:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.AnnouncementFeedText:completeAnimation()
			f13_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
			f13_arg0.AnnouncementFeedText:setAlpha(0)
			f13_local2(f13_arg0.AnnouncementFeedText)
		end,
		OnTeam2 = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			local f17_local0 = function(f18_arg0)
				f17_arg0.AnnouncementImageBackground:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f17_arg0.AnnouncementImageBackground:setTopBottom(0, 0, 20, 52)
				f17_arg0.AnnouncementImageBackground:setAlpha(1)
				f17_arg0.AnnouncementImageBackground:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.AnnouncementImageBackground:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.AnnouncementImageBackground:completeAnimation()
			f17_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -4, 28)
			f17_arg0.AnnouncementImageBackground:setAlpha(0)
			f17_local0(f17_arg0.AnnouncementImageBackground)
			local f17_local1 = function(f19_arg0)
				f17_arg0.AnnouncementImageHighlightRight:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f17_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, 23, 51)
				f17_arg0.AnnouncementImageHighlightRight:setAlpha(1)
				f17_arg0.AnnouncementImageHighlightRight:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.AnnouncementImageHighlightRight:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f17_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, -1, 27)
			f17_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f17_local1(f17_arg0.AnnouncementImageHighlightRight)
			local f17_local2 = function(f20_arg0)
				f17_arg0.AnnouncementFeedText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f17_arg0.AnnouncementFeedText:setTopBottom(0, 0, 30, 45)
				f17_arg0.AnnouncementFeedText:setAlpha(1)
				f17_arg0.AnnouncementFeedText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.AnnouncementFeedText:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.AnnouncementFeedText:completeAnimation()
			f17_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
			f17_arg0.AnnouncementFeedText:setAlpha(0)
			f17_local2(f17_arg0.AnnouncementFeedText)
		end,
		OffTeam1 = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				f21_arg0.AnnouncementImageBackground:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f21_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -4, 28)
				f21_arg0.AnnouncementImageBackground:setAlpha(0)
				f21_arg0.AnnouncementImageBackground:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.AnnouncementImageBackground:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.AnnouncementImageBackground:completeAnimation()
			f21_arg0.AnnouncementImageBackground:setTopBottom(0, 0, 20, 52)
			f21_arg0.AnnouncementImageBackground:setAlpha(1)
			f21_local0(f21_arg0.AnnouncementImageBackground)
			local f21_local1 = function(f23_arg0)
				f21_arg0.AnnouncementImageHighlightLeft:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f21_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, -1, 27)
				f21_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
				f21_arg0.AnnouncementImageHighlightLeft:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.AnnouncementImageHighlightLeft:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f21_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, 23, 51)
			f21_arg0.AnnouncementImageHighlightLeft:setAlpha(1)
			f21_local1(f21_arg0.AnnouncementImageHighlightLeft)
			local f21_local2 = function(f24_arg0)
				f21_arg0.AnnouncementFeedText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f21_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
				f21_arg0.AnnouncementFeedText:setAlpha(0)
				f21_arg0.AnnouncementFeedText:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.AnnouncementFeedText:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.AnnouncementFeedText:completeAnimation()
			f21_arg0.AnnouncementFeedText:setTopBottom(0, 0, 30, 45)
			f21_arg0.AnnouncementFeedText:setAlpha(1)
			f21_local2(f21_arg0.AnnouncementFeedText)
		end,
		OffTeam2 = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			local f25_local0 = function(f26_arg0)
				f25_arg0.AnnouncementImageBackground:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f25_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -4, 28)
				f25_arg0.AnnouncementImageBackground:setAlpha(0)
				f25_arg0.AnnouncementImageBackground:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.AnnouncementImageBackground:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.AnnouncementImageBackground:completeAnimation()
			f25_arg0.AnnouncementImageBackground:setTopBottom(0, 0, 20, 52)
			f25_arg0.AnnouncementImageBackground:setAlpha(1)
			f25_local0(f25_arg0.AnnouncementImageBackground)
			local f25_local1 = function(f27_arg0)
				f25_arg0.AnnouncementImageHighlightRight:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f25_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, -1, 27)
				f25_arg0.AnnouncementImageHighlightRight:setAlpha(0)
				f25_arg0.AnnouncementImageHighlightRight:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.AnnouncementImageHighlightRight:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f25_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, 23, 51)
			f25_arg0.AnnouncementImageHighlightRight:setAlpha(1)
			f25_local1(f25_arg0.AnnouncementImageHighlightRight)
			local f25_local2 = function(f28_arg0)
				f25_arg0.AnnouncementFeedText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f25_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
				f25_arg0.AnnouncementFeedText:setAlpha(0)
				f25_arg0.AnnouncementFeedText:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.AnnouncementFeedText:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.AnnouncementFeedText:completeAnimation()
			f25_arg0.AnnouncementFeedText:setTopBottom(0, 0, 30, 45)
			f25_arg0.AnnouncementFeedText:setAlpha(1)
			f25_local2(f25_arg0.AnnouncementFeedText)
		end,
	},
	HiddenDueToDS = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(4)
			f29_arg0.AnnouncementImageBackground:completeAnimation()
			f29_arg0.AnnouncementImageBackground:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.AnnouncementImageBackground)
			f29_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f29_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.AnnouncementImageHighlightLeft)
			f29_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f29_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.AnnouncementImageHighlightRight)
			f29_arg0.AnnouncementFeedText:completeAnimation()
			f29_arg0.AnnouncementFeedText:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.AnnouncementFeedText)
		end,
	},
	HiddenDueToDS2 = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.AnnouncementImageBackground:completeAnimation()
			f30_arg0.AnnouncementImageBackground:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.AnnouncementImageBackground)
			f30_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f30_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.AnnouncementImageHighlightLeft)
			f30_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f30_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.AnnouncementImageHighlightRight)
		end,
	},
	HiddenDueToQS = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.AnnouncementImageBackground:completeAnimation()
			f31_arg0.AnnouncementImageBackground:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.AnnouncementImageBackground)
			f31_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f31_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.AnnouncementImageHighlightLeft)
			f31_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f31_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.AnnouncementImageHighlightRight)
		end,
	},
	HiddenDueToScoreboard = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(3)
			f32_arg0.AnnouncementImageBackground:completeAnimation()
			f32_arg0.AnnouncementImageBackground:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.AnnouncementImageBackground)
			f32_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f32_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.AnnouncementImageHighlightLeft)
			f32_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f32_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.AnnouncementImageHighlightRight)
		end,
	},
	NoRoundAndLives = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(4)
			f33_arg0.AnnouncementImageBackground:completeAnimation()
			f33_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -5, 27)
			f33_arg0.AnnouncementImageBackground:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.AnnouncementImageBackground)
			f33_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f33_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, -2, 26)
			f33_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.AnnouncementImageHighlightLeft)
			f33_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f33_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, -2, 26)
			f33_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.AnnouncementImageHighlightRight)
			f33_arg0.AnnouncementFeedText:completeAnimation()
			f33_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
			f33_arg0.clipFinished(f33_arg0.AnnouncementFeedText)
		end,
		OnTeam1 = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(3)
			local f34_local0 = function(f35_arg0)
				f34_arg0.AnnouncementImageBackground:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f34_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -5, 27)
				f34_arg0.AnnouncementImageBackground:setAlpha(1)
				f34_arg0.AnnouncementImageBackground:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.AnnouncementImageBackground:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.AnnouncementImageBackground:completeAnimation()
			f34_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -29, 3)
			f34_arg0.AnnouncementImageBackground:setAlpha(0)
			f34_local0(f34_arg0.AnnouncementImageBackground)
			local f34_local1 = function(f36_arg0)
				f34_arg0.AnnouncementImageHighlightLeft:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f34_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, -2, 26)
				f34_arg0.AnnouncementImageHighlightLeft:setAlpha(1)
				f34_arg0.AnnouncementImageHighlightLeft:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.AnnouncementImageHighlightLeft:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f34_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, -26, 2)
			f34_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f34_local1(f34_arg0.AnnouncementImageHighlightLeft)
			local f34_local2 = function(f37_arg0)
				f34_arg0.AnnouncementFeedText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f34_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
				f34_arg0.AnnouncementFeedText:setAlpha(1)
				f34_arg0.AnnouncementFeedText:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.AnnouncementFeedText:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.AnnouncementFeedText:completeAnimation()
			f34_arg0.AnnouncementFeedText:setTopBottom(0, 0, -20, -5)
			f34_arg0.AnnouncementFeedText:setAlpha(0)
			f34_local2(f34_arg0.AnnouncementFeedText)
		end,
		OnTeam2 = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(3)
			local f38_local0 = function(f39_arg0)
				f38_arg0.AnnouncementImageBackground:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -5, 27)
				f38_arg0.AnnouncementImageBackground:setAlpha(1)
				f38_arg0.AnnouncementImageBackground:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.AnnouncementImageBackground:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.AnnouncementImageBackground:completeAnimation()
			f38_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -30, 2)
			f38_arg0.AnnouncementImageBackground:setAlpha(0)
			f38_local0(f38_arg0.AnnouncementImageBackground)
			local f38_local1 = function(f40_arg0)
				f38_arg0.AnnouncementImageHighlightRight:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, -2, 26)
				f38_arg0.AnnouncementImageHighlightRight:setAlpha(1)
				f38_arg0.AnnouncementImageHighlightRight:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.AnnouncementImageHighlightRight:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f38_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, -27, 1)
			f38_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f38_local1(f38_arg0.AnnouncementImageHighlightRight)
			local f38_local2 = function(f41_arg0)
				f38_arg0.AnnouncementFeedText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f38_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
				f38_arg0.AnnouncementFeedText:setAlpha(1)
				f38_arg0.AnnouncementFeedText:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.AnnouncementFeedText:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.AnnouncementFeedText:completeAnimation()
			f38_arg0.AnnouncementFeedText:setTopBottom(0, 0, -20, -5)
			f38_arg0.AnnouncementFeedText:setAlpha(0)
			f38_local2(f38_arg0.AnnouncementFeedText)
		end,
		OffTeam1 = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(3)
			local f42_local0 = function(f43_arg0)
				f42_arg0.AnnouncementImageBackground:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f42_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -29, 3)
				f42_arg0.AnnouncementImageBackground:setAlpha(0)
				f42_arg0.AnnouncementImageBackground:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.AnnouncementImageBackground:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.AnnouncementImageBackground:completeAnimation()
			f42_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -5, 27)
			f42_arg0.AnnouncementImageBackground:setAlpha(1)
			f42_local0(f42_arg0.AnnouncementImageBackground)
			local f42_local1 = function(f44_arg0)
				f42_arg0.AnnouncementImageHighlightLeft:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f42_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, -26, 2)
				f42_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
				f42_arg0.AnnouncementImageHighlightLeft:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.AnnouncementImageHighlightLeft:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f42_arg0.AnnouncementImageHighlightLeft:setTopBottom(0, 0, -2, 26)
			f42_arg0.AnnouncementImageHighlightLeft:setAlpha(1)
			f42_local1(f42_arg0.AnnouncementImageHighlightLeft)
			local f42_local2 = function(f45_arg0)
				f42_arg0.AnnouncementFeedText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f42_arg0.AnnouncementFeedText:setTopBottom(0, 0, -20, -5)
				f42_arg0.AnnouncementFeedText:setAlpha(0)
				f42_arg0.AnnouncementFeedText:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.AnnouncementFeedText:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.AnnouncementFeedText:completeAnimation()
			f42_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
			f42_arg0.AnnouncementFeedText:setAlpha(1)
			f42_local2(f42_arg0.AnnouncementFeedText)
		end,
		OffTeam2 = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(3)
			local f46_local0 = function(f47_arg0)
				f46_arg0.AnnouncementImageBackground:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f46_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -30, 2)
				f46_arg0.AnnouncementImageBackground:setAlpha(0)
				f46_arg0.AnnouncementImageBackground:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.AnnouncementImageBackground:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.AnnouncementImageBackground:completeAnimation()
			f46_arg0.AnnouncementImageBackground:setTopBottom(0, 0, -5, 27)
			f46_arg0.AnnouncementImageBackground:setAlpha(1)
			f46_local0(f46_arg0.AnnouncementImageBackground)
			local f46_local1 = function(f48_arg0)
				f46_arg0.AnnouncementImageHighlightRight:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f46_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, -27, 1)
				f46_arg0.AnnouncementImageHighlightRight:setAlpha(0)
				f46_arg0.AnnouncementImageHighlightRight:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.AnnouncementImageHighlightRight:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f46_arg0.AnnouncementImageHighlightRight:setTopBottom(0, 0, -2, 26)
			f46_arg0.AnnouncementImageHighlightRight:setAlpha(1)
			f46_local1(f46_arg0.AnnouncementImageHighlightRight)
			local f46_local2 = function(f49_arg0)
				f46_arg0.AnnouncementFeedText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f46_arg0.AnnouncementFeedText:setTopBottom(0, 0, -20, -5)
				f46_arg0.AnnouncementFeedText:setAlpha(0)
				f46_arg0.AnnouncementFeedText:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.AnnouncementFeedText:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.AnnouncementFeedText:completeAnimation()
			f46_arg0.AnnouncementFeedText:setTopBottom(0, 0, 5, 20)
			f46_arg0.AnnouncementFeedText:setAlpha(1)
			f46_local2(f46_arg0.AnnouncementFeedText)
		end,
	},
	Hidden = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(3)
			f50_arg0.AnnouncementImageBackground:completeAnimation()
			f50_arg0.AnnouncementImageBackground:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.AnnouncementImageBackground)
			f50_arg0.AnnouncementImageHighlightLeft:completeAnimation()
			f50_arg0.AnnouncementImageHighlightLeft:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.AnnouncementImageHighlightLeft)
			f50_arg0.AnnouncementImageHighlightRight:completeAnimation()
			f50_arg0.AnnouncementImageHighlightRight:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.AnnouncementImageHighlightRight)
		end,
	},
}
CoD.CodCasterAnnouncementFeed.__onClose = function(f51_arg0)
	f51_arg0.__on_close_removeOverrides()
	f51_arg0.AnnouncementImageBackground:close()
	f51_arg0.AnnouncementImageHighlightLeft:close()
	f51_arg0.AnnouncementImageHighlightRight:close()
	f51_arg0.AnnouncementFeedText:close()
end
