require("x64:d4c7ad7229f3df2")
require("x64:98c9e4ec10473c2")
require("x64:7ade4fcc6d1f5c6")
require("x64:eeba57f916954d1")
require("x64:fee3cb6102ad77d")
require("x64:d739459598d1b6a")
require("x64:b24e10c14d11c50")
require("x64:c049b7a5f07c1e")
CoD.StartMenu_Barracks_ZM = InheritFrom(LUI.UIElement)
CoD.StartMenu_Barracks_ZM.__defaultWidth = 1725
CoD.StartMenu_Barracks_ZM.__defaultHeight = 780
CoD.StartMenu_Barracks_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("AutoEvents.cycled")
	self:setClass(CoD.StartMenu_Barracks_ZM)
	self.id = "StartMenu_Barracks_ZM"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressUnlocks = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 322.5, 0.5, 0.5, -344, 38)
	ProgressUnlocks.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"uie_ui_menu_start_menu_grid"))
	ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:changeFrameWidget(CoD.ButtonFrame_Progress)
	ProgressUnlocks.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeToUpperString(@"menu/progress_unlocks"))
	ProgressUnlocks:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ProgressUnlocks, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Prestige_PlayerLevel", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ProgressUnlocks)
	self.ProgressUnlocks = ProgressUnlocks
	local StatsOverview = CoD.Barracks_StatsOverview_ZM.new(f1_arg0, f1_arg1, 0.5, 0.5, 359.5, 836.5, 0.5, 0.5, -344, 348)
	self:addElement(StatsOverview)
	self.StatsOverview = StatsOverview
	local Leaderboards = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 322.5, 0.5, 0.5, 79, 348)
	Leaderboards:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("ui_hideLeaderboards")
			end,
		},
		{
			stateName = "OnlineOnly",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
		{
			stateName = "ComingSoon",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local ZMCallingsWidget = Leaderboards
	local lockedIcon = Leaderboards.subscribeToModel
	local ZMSpecialEventWidget = Engine[@"getglobalmodel"]()
	lockedIcon(ZMCallingsWidget, ZMSpecialEventWidget["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(Leaderboards, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Leaderboards.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"ui_menu_start_menu_leaderboards"))
	Leaderboards.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeHash(@"hash_5FCAADB087BF022D"))
	Leaderboards:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Leaderboards, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.StartMenuUtility.OpenLeaderboardMain(self, menu, controller, "Leaderboard_Main")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Leaderboards)
	self.Leaderboards = Leaderboards
	lockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -626, -578, 0.5, 0.5, -169.5, -121.5)
	lockedIcon:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	lockedIcon:setAlpha(0)
	lockedIcon.lockedIcon:setAlpha(0.5)
	self:addElement(lockedIcon)
	self.lockedIcon = lockedIcon
	ZMCallingsWidget = CoD.ZMCallingsWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -836.5, -359.5, 0.5, 0.5, -344, 38)
	ZMCallingsWidget:mergeStateConditions({
		{
			stateName = "DailyCallingSmall",
			condition = function(menu, element, event)
				return IsIntDvarNonZero("zm_active_daily_calling") and CoD.BaseUtility.IsSelfInState(self, "SpecialEvent")
			end,
		},
	})
	self:addElement(ZMCallingsWidget)
	self.ZMCallingsWidget = ZMCallingsWidget
	ZMSpecialEventWidget = CoD.ZMSpecialEventWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -836.5, -359.5, 0.5, 0.5, 79, 461)
	self:addElement(ZMSpecialEventWidget)
	self.ZMSpecialEventWidget = ZMSpecialEventWidget
	local BarracksGauntletStatsZM = CoD.Barracks_GauntletStats_ZM.new(f1_arg0, f1_arg1, 0.5, 0.5, -836.5, -359.5, 0.5, 0.5, -344, 348)
	BarracksGauntletStatsZM:subscribeToGlobalModel(f1_arg1, "ZMBarracksTrialStats", nil, function(model)
		BarracksGauntletStatsZM:setModel(model, f1_arg1)
	end)
	self:addElement(BarracksGauntletStatsZM)
	self.BarracksGauntletStatsZM = BarracksGauntletStatsZM
	self:mergeStateConditions({
		{
			stateName = "SpecialEvent",
			condition = function(menu, element, event)
				return IsIntDvarNonZero("zm_active_event_calling") and IsBooleanDvarSet("daily_callings_enabled_zm")
			end,
		},
		{
			stateName = "DailyCalling",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("daily_callings_enabled_zm")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f16_arg2, f16_arg3, f16_arg4)
		UpdateElementState(self, "ZMCallingsWidget", controller)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "AutoEvents.cycled", function(model)
		local f17_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	ProgressUnlocks.id = "ProgressUnlocks"
	Leaderboards.id = "Leaderboards"
	ZMCallingsWidget.id = "ZMCallingsWidget"
	ZMSpecialEventWidget.id = "ZMSpecialEventWidget"
	self.__defaultFocus = ProgressUnlocks
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Barracks_ZM.__resetProperties = function(f18_arg0)
	f18_arg0.StatsOverview:completeAnimation()
	f18_arg0.Leaderboards:completeAnimation()
	f18_arg0.ProgressUnlocks:completeAnimation()
	f18_arg0.lockedIcon:completeAnimation()
	f18_arg0.ZMSpecialEventWidget:completeAnimation()
	f18_arg0.ZMCallingsWidget:completeAnimation()
	f18_arg0.BarracksGauntletStatsZM:completeAnimation()
	f18_arg0.StatsOverview:setAlpha(1)
	f18_arg0.Leaderboards:setAlpha(1)
	f18_arg0.ProgressUnlocks:setAlpha(1)
	f18_arg0.lockedIcon:setAlpha(0)
	f18_arg0.ZMSpecialEventWidget:setTopBottom(0.5, 0.5, 79, 461)
	f18_arg0.ZMSpecialEventWidget:setAlpha(1)
	f18_arg0.ZMCallingsWidget:setTopBottom(0.5, 0.5, -344, 38)
	f18_arg0.ZMCallingsWidget:setAlpha(1)
	f18_arg0.BarracksGauntletStatsZM:setAlpha(1)
end
CoD.StartMenu_Barracks_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(7)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(160)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f19_arg0.clipFinished(element, event)
					end)
				end
				f19_arg0.ProgressUnlocks:beginAnimation(160)
				f19_arg0.ProgressUnlocks:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ProgressUnlocks:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.ProgressUnlocks:completeAnimation()
			f19_arg0.ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f19_arg0.ProgressUnlocks:setAlpha(0)
			f19_local0(f19_arg0.ProgressUnlocks)
			local f19_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(150)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.StatsOverview:beginAnimation(350)
				f19_arg0.StatsOverview:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.StatsOverview:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f19_arg0.StatsOverview:completeAnimation()
			f19_arg0.StatsOverview:setAlpha(0)
			f19_local1(f19_arg0.StatsOverview)
			local f19_local2 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(160)
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f19_arg0.clipFinished(element, event)
					end)
				end
				f19_arg0.Leaderboards:beginAnimation(160)
				f19_arg0.Leaderboards:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Leaderboards:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f19_arg0.Leaderboards:completeAnimation()
			f19_arg0.Leaderboards.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f19_arg0.Leaderboards:setAlpha(0)
			f19_local2(f19_arg0.Leaderboards)
			local f19_local3 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(150)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.lockedIcon:beginAnimation(50)
				f19_arg0.lockedIcon:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.lockedIcon:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f19_arg0.lockedIcon:completeAnimation()
			f19_arg0.lockedIcon:setAlpha(0)
			f19_local3(f19_arg0.lockedIcon)
			f19_arg0.ZMCallingsWidget:completeAnimation()
			f19_arg0.ZMCallingsWidget:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ZMCallingsWidget)
			f19_arg0.ZMSpecialEventWidget:completeAnimation()
			f19_arg0.ZMSpecialEventWidget:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ZMSpecialEventWidget)
			local f19_local4 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(150)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.BarracksGauntletStatsZM:beginAnimation(50)
				f19_arg0.BarracksGauntletStatsZM:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.BarracksGauntletStatsZM:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f19_arg0.BarracksGauntletStatsZM:completeAnimation()
			f19_arg0.BarracksGauntletStatsZM:setAlpha(0)
			f19_local4(f19_arg0.BarracksGauntletStatsZM)
		end,
	},
	SpecialEvent = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(7)
			local f32_local0 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(160)
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f32_arg0.clipFinished(element, event)
					end)
				end
				f32_arg0.ProgressUnlocks:beginAnimation(160)
				f32_arg0.ProgressUnlocks:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ProgressUnlocks:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f32_arg0.ProgressUnlocks:completeAnimation()
			f32_arg0.ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f32_arg0.ProgressUnlocks:setAlpha(0)
			f32_local0(f32_arg0.ProgressUnlocks)
			local f32_local1 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(150)
					f37_arg0:setAlpha(1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.StatsOverview:beginAnimation(350)
				f32_arg0.StatsOverview:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.StatsOverview:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f32_arg0.StatsOverview:completeAnimation()
			f32_arg0.StatsOverview:setAlpha(0)
			f32_local1(f32_arg0.StatsOverview)
			local f32_local2 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(160)
					f39_arg0:setAlpha(1)
					f39_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f32_arg0.clipFinished(element, event)
					end)
				end
				f32_arg0.Leaderboards:beginAnimation(160)
				f32_arg0.Leaderboards:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.Leaderboards:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f32_arg0.Leaderboards:completeAnimation()
			f32_arg0.Leaderboards.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f32_arg0.Leaderboards:setAlpha(0)
			f32_local2(f32_arg0.Leaderboards)
			local f32_local3 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(150)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.lockedIcon:beginAnimation(50)
				f32_arg0.lockedIcon:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.lockedIcon:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f32_arg0.lockedIcon:completeAnimation()
			f32_arg0.lockedIcon:setAlpha(0)
			f32_local3(f32_arg0.lockedIcon)
			local f32_local4 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					f44_arg0:beginAnimation(150)
					f44_arg0:setAlpha(1)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.ZMCallingsWidget:beginAnimation(50)
				f32_arg0.ZMCallingsWidget:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ZMCallingsWidget:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f32_arg0.ZMCallingsWidget:completeAnimation()
			f32_arg0.ZMCallingsWidget:setTopBottom(0.5, 0.5, 79, 461)
			f32_arg0.ZMCallingsWidget:setAlpha(0)
			f32_local4(f32_arg0.ZMCallingsWidget)
			local f32_local5 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					f46_arg0:beginAnimation(150)
					f46_arg0:setAlpha(1)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.ZMSpecialEventWidget:beginAnimation(50)
				f32_arg0.ZMSpecialEventWidget:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ZMSpecialEventWidget:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f32_arg0.ZMSpecialEventWidget:completeAnimation()
			f32_arg0.ZMSpecialEventWidget:setTopBottom(0.5, 0.5, -344, 38)
			f32_arg0.ZMSpecialEventWidget:setAlpha(0)
			f32_local5(f32_arg0.ZMSpecialEventWidget)
			f32_arg0.BarracksGauntletStatsZM:completeAnimation()
			f32_arg0.BarracksGauntletStatsZM:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.BarracksGauntletStatsZM)
		end,
	},
	DailyCalling = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(7)
			local f47_local0 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					f49_arg0:beginAnimation(160)
					f49_arg0:setAlpha(1)
					f49_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f47_arg0.clipFinished(element, event)
					end)
				end
				f47_arg0.ProgressUnlocks:beginAnimation(160)
				f47_arg0.ProgressUnlocks:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.ProgressUnlocks:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f47_arg0.ProgressUnlocks:completeAnimation()
			f47_arg0.ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f47_arg0.ProgressUnlocks:setAlpha(0)
			f47_local0(f47_arg0.ProgressUnlocks)
			local f47_local1 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(150)
					f52_arg0:setAlpha(1)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
				end
				f47_arg0.StatsOverview:beginAnimation(350)
				f47_arg0.StatsOverview:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.StatsOverview:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f47_arg0.StatsOverview:completeAnimation()
			f47_arg0.StatsOverview:setAlpha(0)
			f47_local1(f47_arg0.StatsOverview)
			local f47_local2 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					f54_arg0:beginAnimation(160)
					f54_arg0:setAlpha(1)
					f54_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f47_arg0.clipFinished(element, event)
					end)
				end
				f47_arg0.Leaderboards:beginAnimation(160)
				f47_arg0.Leaderboards:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.Leaderboards:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f47_arg0.Leaderboards:completeAnimation()
			f47_arg0.Leaderboards.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f47_arg0.Leaderboards:setAlpha(0)
			f47_local2(f47_arg0.Leaderboards)
			local f47_local3 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					f57_arg0:beginAnimation(150)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
				end
				f47_arg0.lockedIcon:beginAnimation(50)
				f47_arg0.lockedIcon:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.lockedIcon:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f47_arg0.lockedIcon:completeAnimation()
			f47_arg0.lockedIcon:setAlpha(0)
			f47_local3(f47_arg0.lockedIcon)
			local f47_local4 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					f59_arg0:beginAnimation(150)
					f59_arg0:setAlpha(1)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
				end
				f47_arg0.ZMCallingsWidget:beginAnimation(50)
				f47_arg0.ZMCallingsWidget:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.ZMCallingsWidget:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f47_arg0.ZMCallingsWidget:completeAnimation()
			f47_arg0.ZMCallingsWidget:setAlpha(0)
			f47_local4(f47_arg0.ZMCallingsWidget)
			local f47_local5 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					f61_arg0:beginAnimation(150)
					f61_arg0:setAlpha(1)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
				end
				f47_arg0.ZMSpecialEventWidget:beginAnimation(50)
				f47_arg0.ZMSpecialEventWidget:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.ZMSpecialEventWidget:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f47_arg0.ZMSpecialEventWidget:completeAnimation()
			f47_arg0.ZMSpecialEventWidget:setAlpha(0)
			f47_local5(f47_arg0.ZMSpecialEventWidget)
			f47_arg0.BarracksGauntletStatsZM:completeAnimation()
			f47_arg0.BarracksGauntletStatsZM:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.BarracksGauntletStatsZM)
		end,
	},
}
CoD.StartMenu_Barracks_ZM.__onClose = function(f62_arg0)
	f62_arg0.ProgressUnlocks:close()
	f62_arg0.StatsOverview:close()
	f62_arg0.Leaderboards:close()
	f62_arg0.lockedIcon:close()
	f62_arg0.ZMCallingsWidget:close()
	f62_arg0.ZMSpecialEventWidget:close()
	f62_arg0.BarracksGauntletStatsZM:close()
end
