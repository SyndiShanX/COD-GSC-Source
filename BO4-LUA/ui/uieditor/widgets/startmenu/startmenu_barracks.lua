require("x64:d4c7ad7229f3df2")
require("x64:74862184d365f30")
require("x64:fd8a24ee5f0cd96")
require("x64:6a9e291ea0e48da")
require("x64:b24e10c14d11c50")
require("x64:c049b7a5f07c1e")
CoD.StartMenu_Barracks = InheritFrom(LUI.UIElement)
CoD.StartMenu_Barracks.__defaultWidth = 1725
CoD.StartMenu_Barracks.__defaultHeight = 780
CoD.StartMenu_Barracks.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Barracks)
	self.id = "StartMenu_Barracks"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonBgLayoutElement = CoD.CommonBgLayoutElement01.new(f1_arg0, f1_arg1, 0.5, 0.5, -847.5, -703.5, 0.5, 0.5, 336.5, 372.5)
	self:addElement(CommonBgLayoutElement)
	self.CommonBgLayoutElement = CommonBgLayoutElement
	local StatsOverview = CoD.Barracks_StatsOverview.new(f1_arg0, f1_arg1, 0.5, 0.5, 359.5, 836.5, 0.5, 0.5, -336.5, 340.5)
	self:addElement(StatsOverview)
	self.StatsOverview = StatsOverview
	local Leaderboards = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 322.5, 0.5, 0.5, 68.5, 338.5)
	Leaderboards:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("ui_hideLeaderboards")
			end,
		},
		{
			stateName = "ComingSoon",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	local Medals = Leaderboards
	local ProgressUnlocks = Leaderboards.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	ProgressUnlocks(Medals, f1_local6["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(Leaderboards, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Leaderboards.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"ui_menu_start_menu_leaderboards"))
	Leaderboards.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeHash(@"hash_5FCAADB087BF022D"))
	Leaderboards:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
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
	ProgressUnlocks = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 322.5, 0.5, 0.5, -336.5, 44.5)
	ProgressUnlocks.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"uie_ui_menu_start_menu_grid"))
	ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:changeFrameWidget(CoD.ButtonFrame_Progress)
	ProgressUnlocks.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeToUpperString(@"menu/progress_unlocks"))
	ProgressUnlocks:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
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
	Medals = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -836.5, -367.5, 0.5, 0.5, -336.5, 338.5)
	Medals.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(@"uie_ui_menu_start_menu_grid"))
	Medals.ButtonInternal.StartMenuButtonFrame:changeFrameWidget(CoD.ButtonFrame_Medal)
	Medals.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeHash(@"hash_8F69F5BDD4F7C26"))
	Medals:subscribeToGlobalModel(f1_arg1, "PlayerShowcase", "medal", function(model)
		Medals.ButtonInternal.ButtonTitle.NewIcon:setModel(model, f1_arg1)
	end)
	Medals:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Medals, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
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
	self:addElement(Medals)
	self.Medals = Medals
	Leaderboards.id = "Leaderboards"
	ProgressUnlocks.id = "ProgressUnlocks"
	Medals.id = "Medals"
	self.__defaultFocus = ProgressUnlocks
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Barracks.__resetProperties = function(f15_arg0)
	f15_arg0.Medals:completeAnimation()
	f15_arg0.ProgressUnlocks:completeAnimation()
	f15_arg0.Leaderboards:completeAnimation()
	f15_arg0.StatsOverview:completeAnimation()
	f15_arg0.Medals:setAlpha(1)
	f15_arg0.ProgressUnlocks:setAlpha(1)
	f15_arg0.Leaderboards:setAlpha(1)
	f15_arg0.StatsOverview:setAlpha(1)
end
CoD.StartMenu_Barracks.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(150)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.StatsOverview:beginAnimation(350)
				f16_arg0.StatsOverview:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.StatsOverview:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.StatsOverview:completeAnimation()
			f16_arg0.StatsOverview:setAlpha(0)
			f16_local0(f16_arg0.StatsOverview)
			local f16_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(160)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f16_arg0.clipFinished(element, event)
					end)
				end
				f16_arg0.Leaderboards:beginAnimation(160)
				f16_arg0.Leaderboards:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Leaderboards:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f16_arg0.Leaderboards:completeAnimation()
			f16_arg0.Leaderboards.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f16_arg0.Leaderboards:setAlpha(0)
			f16_local1(f16_arg0.Leaderboards)
			local f16_local2 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(160)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f16_arg0.clipFinished(element, event)
					end)
				end
				f16_arg0.ProgressUnlocks:beginAnimation(160)
				f16_arg0.ProgressUnlocks:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ProgressUnlocks:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f16_arg0.ProgressUnlocks:completeAnimation()
			f16_arg0.ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f16_arg0.ProgressUnlocks:setAlpha(0)
			f16_local2(f16_arg0.ProgressUnlocks)
			local f16_local3 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(150)
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f16_arg0.clipFinished(element, event)
					end)
				end
				f16_arg0.Medals:beginAnimation(50)
				f16_arg0.Medals:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Medals:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f16_arg0.Medals:completeAnimation()
			f16_arg0.Medals.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f16_arg0.Medals:setAlpha(0)
			f16_local3(f16_arg0.Medals)
		end,
	},
}
CoD.StartMenu_Barracks.__onClose = function(f28_arg0)
	f28_arg0.CommonBgLayoutElement:close()
	f28_arg0.StatsOverview:close()
	f28_arg0.Leaderboards:close()
	f28_arg0.ProgressUnlocks:close()
	f28_arg0.Medals:close()
end
