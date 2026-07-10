require("x64:d4c7ad7229f3df2")
require("x64:46728994d8c06c0")
require("x64:74862184d365f30")
require("x64:fd8a24ee5f0cd96")
require("x64:f0772236b235298")
require("x64:dd1e80461b1510a")
require("x64:11cbbf7f1dd6dbb")
require("x64:c049b7a5f07c1e")
CoD.StartMenu_Barracks_WL = InheritFrom(LUI.UIElement)
CoD.StartMenu_Barracks_WL.__defaultWidth = 1725
CoD.StartMenu_Barracks_WL.__defaultHeight = 780
CoD.StartMenu_Barracks_WL.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "isWZBarracks", true)
	self:setClass(CoD.StartMenu_Barracks_WL)
	self.id = "StartMenu_Barracks_WL"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressUnlocks = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 322.5, 0.5, 0.5, -336.5, 44.5)
	ProgressUnlocks:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.DisableForCurrentMilestoneOrUserContentRestricted(f1_arg1) and not IsGameTrial()
			end,
		},
	})
	ProgressUnlocks.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"uie_ui_menu_start_menu_grid"))
	ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:changeFrameWidget(CoD.ButtonFrame_WorldLeagueProgress)
	ProgressUnlocks.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeToUpperString(@"hash_24ACCE4091313402"))
	ProgressUnlocks:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ProgressUnlocks, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			OpenOverlay(self, "Prestige_PlayerLevel", controller)
			PlaySoundAlias("uin_toggle_generic")
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
	local Leaderboards = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 322.5, 0.5, 0.5, 66.5, 336.5)
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
	local StatsOverview = Leaderboards
	local CommonBgLayoutElement = Leaderboards.subscribeToModel
	local LeaguePlayMedals = Engine[@"getglobalmodel"]()
	CommonBgLayoutElement(StatsOverview, LeaguePlayMedals["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(Leaderboards, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Leaderboards.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"ui_menu_start_menu_leaderboards"))
	Leaderboards.ButtonInternal.ButtonTitle.HeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5FCAADB087BF022D"))
	Leaderboards:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Leaderboards, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			CoD.StartMenuUtility.OpenLeaderboardMain(self, menu, controller, "Leaderboard_Main")
			PlaySoundAlias("uin_toggle_generic")
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
	CommonBgLayoutElement = CoD.CommonBgLayoutElement01.new(f1_arg0, f1_arg1, 0.5, 0.5, -847.5, -703.5, 0.5, 0.5, 336.5, 372.5)
	self:addElement(CommonBgLayoutElement)
	self.CommonBgLayoutElement = CommonBgLayoutElement
	StatsOverview = CoD.Barracks_StatsOverview.new(f1_arg0, f1_arg1, 0.5, 0.5, 359.5, 836.5, 0.5, 0.5, -336.5, 340.5)
	self:addElement(StatsOverview)
	self.StatsOverview = StatsOverview
	LeaguePlayMedals = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -836.5, -367.5, 0.5, 0.5, 66.5, 336.5)
	LeaguePlayMedals.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"uie_ui_menu_start_menu_grid"))
	LeaguePlayMedals.ButtonInternal.StartMenuButtonFrame:changeFrameWidget(CoD.ButtonFrame_ArenaMedals)
	LeaguePlayMedals.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeHash(@"hash_8F69F5BDD4F7C26"))
	LeaguePlayMedals:subscribeToGlobalModel(f1_arg1, "PlayerShowcase", "medal", function(model)
		LeaguePlayMedals.ButtonInternal.ButtonTitle.NewIcon:setModel(model, f1_arg1)
	end)
	LeaguePlayMedals:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeaguePlayMedals, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			CoD.StartMenuUtility.OpenStartMenuOverlay(self, menu, controller, "Barracks_Medals")
			PlaySoundAlias("uin_toggle_generic")
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
	self:addElement(LeaguePlayMedals)
	self.LeaguePlayMedals = LeaguePlayMedals
	local LeaguePlayCareer = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -836.5, -367.5, 0.5, 0.5, -336.5, -58.5)
	LeaguePlayCareer:setAlpha(0)
	LeaguePlayCareer.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"uie_ui_menu_start_menu_grid"))
	LeaguePlayCareer.ButtonInternal.StartMenuButtonFrame:changeFrameWidget(CoD.ButtonFrame_ArenaBarracksStats)
	LeaguePlayCareer.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeHash(@"hash_6EED2099B101A416"))
	self:addElement(LeaguePlayCareer)
	self.LeaguePlayCareer = LeaguePlayCareer
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0.5, 0.5, -835.5, -366.5, 0.5, 0.5, -337.5, 33.5)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local ButtonFrameArenaBarracksStats = CoD.ButtonFrame_ArenaBarracksStats.new(f1_arg0, f1_arg1, 0.5, 0.5, -834.5, -365.5, 0.5, 0.5, -342.5, -58.5)
	self:addElement(ButtonFrameArenaBarracksStats)
	self.ButtonFrameArenaBarracksStats = ButtonFrameArenaBarracksStats
	ProgressUnlocks.id = "ProgressUnlocks"
	Leaderboards.id = "Leaderboards"
	LeaguePlayMedals.id = "LeaguePlayMedals"
	LeaguePlayCareer.id = "LeaguePlayCareer"
	self.__defaultFocus = ProgressUnlocks
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Barracks_WL.__resetProperties = function(f17_arg0)
	f17_arg0.Leaderboards:completeAnimation()
	f17_arg0.ProgressUnlocks:completeAnimation()
	f17_arg0.CommonDetailPanel2:completeAnimation()
	f17_arg0.ButtonFrameArenaBarracksStats:completeAnimation()
	f17_arg0.LeaguePlayMedals:completeAnimation()
	f17_arg0.StatsOverview:completeAnimation()
	f17_arg0.Leaderboards:setAlpha(1)
	f17_arg0.ProgressUnlocks:setAlpha(1)
	f17_arg0.CommonDetailPanel2:setAlpha(1)
	f17_arg0.ButtonFrameArenaBarracksStats:setAlpha(1)
	f17_arg0.LeaguePlayMedals:setAlpha(1)
	f17_arg0.StatsOverview:setAlpha(1)
end
CoD.StartMenu_Barracks_WL.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(6)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(160)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f18_arg0.clipFinished(element, event)
					end)
				end
				f18_arg0.ProgressUnlocks:beginAnimation(160)
				f18_arg0.ProgressUnlocks:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.ProgressUnlocks:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.ProgressUnlocks:completeAnimation()
			f18_arg0.ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f18_arg0.ProgressUnlocks:setAlpha(0)
			f18_local0(f18_arg0.ProgressUnlocks)
			local f18_local1 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(160)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f18_arg0.clipFinished(element, event)
					end)
				end
				f18_arg0.Leaderboards:beginAnimation(160)
				f18_arg0.Leaderboards:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Leaderboards:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f18_arg0.Leaderboards:completeAnimation()
			f18_arg0.Leaderboards.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f18_arg0.Leaderboards:setAlpha(0)
			f18_local1(f18_arg0.Leaderboards)
			local f18_local2 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(190)
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.StatsOverview:beginAnimation(320)
				f18_arg0.StatsOverview:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.StatsOverview:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f18_arg0.StatsOverview:completeAnimation()
			f18_arg0.StatsOverview:setAlpha(0)
			f18_local2(f18_arg0.StatsOverview)
			local f18_local3 = function(f27_arg0)
				f18_arg0.LeaguePlayMedals:beginAnimation(160)
				f18_arg0.LeaguePlayMedals:setAlpha(1)
				f18_arg0.LeaguePlayMedals:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.LeaguePlayMedals:registerEventHandler("transition_complete_keyframe", function(element, event)
					f18_arg0.clipFinished(element, event)
				end)
			end
			f18_arg0.LeaguePlayMedals:completeAnimation()
			f18_arg0.LeaguePlayMedals.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f18_arg0.LeaguePlayMedals:setAlpha(0)
			f18_local3(f18_arg0.LeaguePlayMedals)
			local f18_local4 = function(f29_arg0)
				f18_arg0.CommonDetailPanel2:beginAnimation(160)
				f18_arg0.CommonDetailPanel2:setAlpha(1)
				f18_arg0.CommonDetailPanel2:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.CommonDetailPanel2:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.CommonDetailPanel2:completeAnimation()
			f18_arg0.CommonDetailPanel2:setAlpha(0)
			f18_local4(f18_arg0.CommonDetailPanel2)
			local f18_local5 = function(f30_arg0)
				f18_arg0.ButtonFrameArenaBarracksStats:beginAnimation(160)
				f18_arg0.ButtonFrameArenaBarracksStats:setAlpha(1)
				f18_arg0.ButtonFrameArenaBarracksStats:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.ButtonFrameArenaBarracksStats:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.ButtonFrameArenaBarracksStats:completeAnimation()
			f18_arg0.ButtonFrameArenaBarracksStats:setAlpha(0)
			f18_local5(f18_arg0.ButtonFrameArenaBarracksStats)
		end,
	},
}
CoD.StartMenu_Barracks_WL.__onClose = function(f31_arg0)
	f31_arg0.ProgressUnlocks:close()
	f31_arg0.Leaderboards:close()
	f31_arg0.CommonBgLayoutElement:close()
	f31_arg0.StatsOverview:close()
	f31_arg0.LeaguePlayMedals:close()
	f31_arg0.LeaguePlayCareer:close()
	f31_arg0.CommonDetailPanel2:close()
	f31_arg0.ButtonFrameArenaBarracksStats:close()
end
