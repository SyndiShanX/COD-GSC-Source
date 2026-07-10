require("x64:ea5bc03da1b4195")
require("x64:3296460d046f335")
require("x64:96ce1eeb95b7136")
require("x64:fa77b4b9e7997ad")
CoD.ArenaEventProgressButton = InheritFrom(LUI.UIElement)
CoD.ArenaEventProgressButton.__defaultWidth = 382
CoD.ArenaEventProgressButton.__defaultHeight = 70
CoD.ArenaEventProgressButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaEventProgressButton)
	self.id = "ArenaEventProgressButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaEventProgressButtonInternal2 = CoD.ArenaEventProgressButtonInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -191, 191, 0.5, 0.5, -35, 35)
	local f1_local2 = ArenaEventProgressButtonInternal2
	local f1_local3 = ArenaEventProgressButtonInternal2.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyPlaylist.name"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local2 = ArenaEventProgressButtonInternal2
	f1_local3 = ArenaEventProgressButtonInternal2.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local2 = ArenaEventProgressButtonInternal2
	f1_local3 = ArenaEventProgressButtonInternal2.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["LeaguePlayLadder.entityLadderRank"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ArenaEventProgressButtonInternal2:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ArenaEventProgressButtonInternal2, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730]) and not CoD.ArenaLeaguePlayUtility.HasPlayerCompletedPlacementMatches(controller) then
			PlaySoundAlias("uin_press_generic")
			SetLoseFocusToSelf(self, controller)
			OpenOverlay(self, "ArenaSkillEvaluationPlacementMenu", controller)
			return true
		elseif CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730]) and IsSelfInState(self, "EventActive") and CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, controller) then
			PlaySoundAlias("uin_press_generic")
			SetLoseFocusToSelf(self, controller)
			CoD.ArenaLeaguePlayUtility.ForceRefreshLadder(menu, controller)
			OpenOverlay(self, "LeaguePlayLeaderboardMenu", controller)
			return true
		elseif AlwaysFalse() then
			PlaySoundAlias("uin_press_generic")
			SetLoseFocusToSelf(self, controller)
			OpenOverlay(self, "ArenaGauntletProgressionDetails", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730]) and not CoD.ArenaLeaguePlayUtility.HasPlayerCompletedPlacementMatches(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730]) and IsSelfInState(self, "EventActive") and CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ArenaEventProgressButtonInternal2)
	self.ArenaEventProgressButtonInternal2 = ArenaEventProgressButtonInternal2
	self:mergeStateConditions({
		{
			stateName = "EventActive",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730]) and CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, f1_arg1)
			end,
		},
		{
			stateName = "NoEvent",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyPlaylist.name"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["LeaguePlayLadder.entityLadderRank"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LeaguePlayLadder.entityLadderRank",
		})
	end, false)
	ArenaEventProgressButtonInternal2.id = "ArenaEventProgressButtonInternal2"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventProgressButton.__resetProperties = function(f13_arg0)
	f13_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
	f13_arg0.ArenaEventProgressButtonInternal2:setScale(1, 1)
end
CoD.ArenaEventProgressButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f15_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
			f15_arg0.clipFinished(f15_arg0.ArenaEventProgressButtonInternal2)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.ArenaEventProgressButtonInternal2:beginAnimation(200)
				f16_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
				f16_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f16_arg0.ArenaEventProgressButtonInternal2:setScale(1, 1)
			f16_local0(f16_arg0.ArenaEventProgressButtonInternal2)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.ArenaEventProgressButtonInternal2:beginAnimation(100)
				f18_arg0.ArenaEventProgressButtonInternal2:setScale(1, 1)
				f18_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f18_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
			f18_local0(f18_arg0.ArenaEventProgressButtonInternal2)
		end,
	},
	EventActive = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f21_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.ArenaEventProgressButtonInternal2)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.ArenaEventProgressButtonInternal2:beginAnimation(200)
				f22_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
				f22_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f22_arg0.ArenaEventProgressButtonInternal2:setScale(1, 1)
			f22_local0(f22_arg0.ArenaEventProgressButtonInternal2)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.ArenaEventProgressButtonInternal2:beginAnimation(100)
				f24_arg0.ArenaEventProgressButtonInternal2:setScale(1, 1)
				f24_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f24_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
			f24_local0(f24_arg0.ArenaEventProgressButtonInternal2)
		end,
	},
	NoEvent = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f27_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
			f27_arg0.clipFinished(f27_arg0.ArenaEventProgressButtonInternal2)
		end,
		GainChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.ArenaEventProgressButtonInternal2:beginAnimation(200)
				f28_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
				f28_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f28_arg0.ArenaEventProgressButtonInternal2:setScale(1, 1)
			f28_local0(f28_arg0.ArenaEventProgressButtonInternal2)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.ArenaEventProgressButtonInternal2:beginAnimation(100)
				f30_arg0.ArenaEventProgressButtonInternal2:setScale(1, 1)
				f30_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.ArenaEventProgressButtonInternal2:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.ArenaEventProgressButtonInternal2:completeAnimation()
			f30_arg0.ArenaEventProgressButtonInternal2:setScale(1.05, 1.05)
			f30_local0(f30_arg0.ArenaEventProgressButtonInternal2)
		end,
	},
}
CoD.ArenaEventProgressButton.__onClose = function(f32_arg0)
	f32_arg0.ArenaEventProgressButtonInternal2:close()
end
