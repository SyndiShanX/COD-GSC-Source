require("x64:d4c7ad7229f3df2")
require("x64:74862184d365f30")
require("x64:d98a55959ac548a")
require("x64:3d51979d6407e61")
require("x64:68e609e1323d006")
require("x64:c049b7a5f07c1e")
CoD.StartMenu_Barracks_WZ = InheritFrom(LUI.UIElement)
CoD.StartMenu_Barracks_WZ.__defaultWidth = 1725
CoD.StartMenu_Barracks_WZ.__defaultHeight = 780
CoD.StartMenu_Barracks_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "isWZBarracks", true)
	self:setClass(CoD.StartMenu_Barracks_WZ)
	self.id = "StartMenu_Barracks_WZ"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressUnlocks = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 322.5, 0.5, 0.5, -336.5, 44.5)
	ProgressUnlocks.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(0xCB7B28E1ED13921))
	ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:changeFrameWidget(CoD.ButtonFrame_MeritRecord)
	ProgressUnlocks.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeToUpperString(0x226E947798C9490))
	ProgressUnlocks:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ProgressUnlocks, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			OpenOverlay(self, "Prestige_PlayerLevel", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ProgressUnlocks)
	self.ProgressUnlocks = ProgressUnlocks
	local Leaderboards = CoD.StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, -324.5, 322.5, 0.5, 0.5, 69, 339)
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
	local CommonBgLayoutElement = Leaderboards
	local StatsOverview = Leaderboards.subscribeToModel
	local WinRecordContainer = Engine[0x8DF2E5447F384B9]()
	StatsOverview(CommonBgLayoutElement, WinRecordContainer["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(Leaderboards, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Leaderboards.ButtonInternal.ImageContainer.ImageContainer:setImage(RegisterImage(0x225DF4C37296C0B))
	Leaderboards.ButtonInternal.ButtonTitle.HeaderText:setText(LocalizeHash(0xFCAADB087BF022D))
	Leaderboards:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Leaderboards, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsInDefaultState(element) then
			CoD.StartMenuUtility.OpenLeaderboardMain(self, menu, controller, "Leaderboard_Main")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsInDefaultState(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Leaderboards)
	self.Leaderboards = Leaderboards
	StatsOverview = CoD.Barracks_StatsOverview_WZ.new(f1_arg0, f1_arg1, 0.5, 0.5, 359.5, 836.5, 0.5, 0.5, -336.5, 340.5)
	self:addElement(StatsOverview)
	self.StatsOverview = StatsOverview
	CommonBgLayoutElement = CoD.CommonBgLayoutElement01.new(f1_arg0, f1_arg1, 0.5, 0.5, -847.5, -703.5, 0.5, 0.5, 336.5, 372.5)
	self:addElement(CommonBgLayoutElement)
	self.CommonBgLayoutElement = CommonBgLayoutElement
	WinRecordContainer = CoD.StartMenu_Barracks_WZ_WinRecordContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -836.5, -359.5, 0.5, 0.5, -337.5, 339.5)
	self:addElement(WinRecordContainer)
	self.WinRecordContainer = WinRecordContainer
	ProgressUnlocks.id = "ProgressUnlocks"
	Leaderboards.id = "Leaderboards"
	WinRecordContainer.id = "WinRecordContainer"
	self.__defaultFocus = ProgressUnlocks
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Barracks_WZ.__resetProperties = function(f12_arg0)
	f12_arg0.WinRecordContainer:completeAnimation()
	f12_arg0.StatsOverview:completeAnimation()
	f12_arg0.Leaderboards:completeAnimation()
	f12_arg0.ProgressUnlocks:completeAnimation()
	f12_arg0.WinRecordContainer:setAlpha(1)
	f12_arg0.StatsOverview:setAlpha(1)
	f12_arg0.Leaderboards:setAlpha(1)
	f12_arg0.ProgressUnlocks:setAlpha(1)
end
CoD.StartMenu_Barracks_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(160)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f13_arg0.clipFinished(element, event)
					end)
				end
				f13_arg0.ProgressUnlocks:beginAnimation(160)
				f13_arg0.ProgressUnlocks:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ProgressUnlocks:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.ProgressUnlocks:completeAnimation()
			f13_arg0.ProgressUnlocks.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f13_arg0.ProgressUnlocks:setAlpha(0)
			f13_local0(f13_arg0.ProgressUnlocks)
			local f13_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(160)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f13_arg0.clipFinished(element, event)
					end)
				end
				f13_arg0.Leaderboards:beginAnimation(160)
				f13_arg0.Leaderboards:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Leaderboards:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f13_arg0.Leaderboards:completeAnimation()
			f13_arg0.Leaderboards.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f13_arg0.Leaderboards:setAlpha(0)
			f13_local1(f13_arg0.Leaderboards)
			local f13_local2 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(150)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.StatsOverview:beginAnimation(350)
				f13_arg0.StatsOverview:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.StatsOverview:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f13_arg0.StatsOverview:completeAnimation()
			f13_arg0.StatsOverview:setAlpha(0)
			f13_local2(f13_arg0.StatsOverview)
			local f13_local3 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(150)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.WinRecordContainer:beginAnimation(50)
				f13_arg0.WinRecordContainer:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.WinRecordContainer:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f13_arg0.WinRecordContainer:completeAnimation()
			f13_arg0.WinRecordContainer:setAlpha(0)
			f13_local3(f13_arg0.WinRecordContainer)
		end,
	},
}
CoD.StartMenu_Barracks_WZ.__onClose = function(f24_arg0)
	f24_arg0.ProgressUnlocks:close()
	f24_arg0.Leaderboards:close()
	f24_arg0.StatsOverview:close()
	f24_arg0.CommonBgLayoutElement:close()
	f24_arg0.WinRecordContainer:close()
end
