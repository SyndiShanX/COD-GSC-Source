require("x64:46728994d8c06c0")
require("x64:c193277e26ccdf1")
require("x64:eb5f71d1692cef1")
require("x64:a7a38124f34a3d3")
require("x64:38c11a77e96e48c")
CoD.TabbedScoreboardScoresFFA = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardScoresFFA.__defaultWidth = 1454
CoD.TabbedScoreboardScoresFFA.__defaultHeight = 618
CoD.TabbedScoreboardScoresFFA.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "Clients.clientCount")
	CoD.ScoreboardUtility.InitScoreboardSortKey(f1_arg1)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "hudItems.reEvalScoreboard")
	self:setClass(CoD.TabbedScoreboardScoresFFA)
	self.id = "TabbedScoreboardScoresFFA"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 2, 1452, 0, 0, 0, 616)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local TiledBGR = CoD.CommonHUDTiledBackground01.new(f1_arg0, f1_arg1, 0, 0, 2, 1452, 0, 0, 0, 617)
	self:addElement(TiledBGR)
	self.TiledBGR = TiledBGR
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 51.5, 570.5, 0, 0, 50, 565)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local FFATeamScores = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	FFATeamScores:setLeftRight(0, 0, 637, 1321)
	FFATeamScores:setTopBottom(0, 0, 58, 580)
	FFATeamScores:setWidgetType(CoD.TabbedScoreboardRowRight)
	FFATeamScores:setVerticalCount(8)
	FFATeamScores:setSpacing(6)
	FFATeamScores:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FFATeamScores:setVerticalCounter(CoD.verticalCounter)
	FFATeamScores:setDataSource("Clients")
	local SpecialistRight = FFATeamScores
	local TopBarRight01 = FFATeamScores.subscribeToModel
	local RankHashtagRight = Engine[@"getmodelforcontroller"](f1_arg1)
	TopBarRight01(SpecialistRight, RankHashtagRight.forceScoreboard, function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SpecialistRight = FFATeamScores
	TopBarRight01 = FFATeamScores.subscribeToModel
	RankHashtagRight = Engine[@"getmodelforcontroller"](f1_arg1)
	TopBarRight01(SpecialistRight, RankHashtagRight["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	SpecialistRight = FFATeamScores
	TopBarRight01 = FFATeamScores.subscribeToModel
	RankHashtagRight = Engine[@"getmodelforcontroller"](f1_arg1)
	TopBarRight01(SpecialistRight, RankHashtagRight["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	FFATeamScores:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.ScoreboardUtility.SetCurrentFocusedClient(element, f1_arg1)
		return f5_local0
	end)
	FFATeamScores:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FFATeamScores, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if ScoreboardVisible(controller) then
			CoD.ScoreboardUtility.ToggleClientMute(element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if ScoreboardVisible(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FFATeamScores, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if ScoreboardVisible(controller) and IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if ScoreboardVisible(controller) and IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(FFATeamScores)
	self.FFATeamScores = FFATeamScores
	TopBarRight01 = LUI.UIImage.new(0, 0, 634, 1326, 0, 0, 48, 60)
	TopBarRight01:setImage(RegisterImage(@"hash_4414B157493C31E2"))
	self:addElement(TopBarRight01)
	self.TopBarRight01 = TopBarRight01
	SpecialistRight = LUI.UIText.new(0, 0, 679, 1075, 0, 0, 27.5, 42.5)
	SpecialistRight:setRGB(0.7, 0.7, 0.7)
	SpecialistRight:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_E5960B3E0AF9188"))
	SpecialistRight:setTTF("0arame_mono_stencil")
	SpecialistRight:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(SpecialistRight)
	self.SpecialistRight = SpecialistRight
	RankHashtagRight = LUI.UIText.new(0, 0, 639, 681, 0, 0, 27.5, 42.5)
	RankHashtagRight:setRGB(0.7, 0.7, 0.7)
	RankHashtagRight:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/hashtag"))
	RankHashtagRight:setTTF("0arame_mono_stencil")
	RankHashtagRight:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RankHashtagRight:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RankHashtagRight)
	self.RankHashtagRight = RankHashtagRight
	local EnemyHeaders = CoD.TabbedScoreboardColHeaders.new(f1_arg0, f1_arg1, 0, 0, 1075, 1321, 0, 0, 15, 55)
	self:addElement(EnemyHeaders)
	self.EnemyHeaders = EnemyHeaders
	local TopPlayerPoints = LUI.UIText.new(0, 0, 211, 411, 0.5, 0.5, -242.5, -170.5)
	TopPlayerPoints:setTTF("ttmussels_demibold")
	TopPlayerPoints:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TopPlayerPoints:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TopPlayerPoints:subscribeToGlobalModel(f1_arg1, "FFALeader", "points", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			TopPlayerPoints:setText(f11_local0)
		end
	end)
	self:addElement(TopPlayerPoints)
	self.TopPlayerPoints = TopPlayerPoints
	local TopPlayerName = LUI.UIText.new(0, 0, 51, 571, 0.5, 0.5, -170.5, -133.5)
	TopPlayerName:setTTF("notosans_regular")
	TopPlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TopPlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TopPlayerName:subscribeToGlobalModel(f1_arg1, "FFALeader", "name", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			TopPlayerName:setText(CoD.SocialUtility.CleanGamerTag(f12_local0))
		end
	end)
	self:addElement(TopPlayerName)
	self.TopPlayerName = TopPlayerName
	local TopPlayerEmblem = LUI.UIImage.new(0, 0, 146, 476, 0.5, 0.5, -94.5, 235.5)
	TopPlayerEmblem:subscribeToGlobalModel(f1_arg1, "FFALeader", "clientNum", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			TopPlayerEmblem:setupPlayerEmblemByXUID(GetClientGameLobbyXUIDForClientNumString(f13_local0))
		end
	end)
	self:addElement(TopPlayerEmblem)
	self.TopPlayerEmblem = TopPlayerEmblem
	local BGDotPatternLarge2 = LUI.UIImage.new(0, 0, 62.5, 559.5, 0, 0, 193.5, 197.5)
	BGDotPatternLarge2:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	BGDotPatternLarge2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	BGDotPatternLarge2:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge2:setupNineSliceShader(16, 4)
	self:addElement(BGDotPatternLarge2)
	self.BGDotPatternLarge2 = BGDotPatternLarge2
	self:mergeStateConditions({
		{
			stateName = "NoPlayers",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("scoreboard.team1.count", 0) and CoD.ModelUtility.IsGlobalModelValueEqualTo("scoreboard.team2.count", 0)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
			end,
		},
	})
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[@"getglobalmodel"]()
	f1_local14(f1_local13, f1_local15["scoreboard.team1.count"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "scoreboard.team1.count",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getglobalmodel"]()
	f1_local14(f1_local13, f1_local15["scoreboard.team2.count"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "scoreboard.team2.count",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local14(f1_local13, f1_local15["scoreboardInfo.activeTab"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f19_arg2, f19_arg3, f19_arg4)
		if IsSelfInState(self, "Visible") then
			CoD.BaseUtility.EnableNavigation(self)
			CoD.BaseUtility.EnableNavigation(self.FFATeamScores)
		else
			CoD.BaseUtility.DisableNavigation(self)
			CoD.BaseUtility.DisableNavigation(self.FFATeamScores)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Clients.clientCount", function(model)
		local f20_local0 = self
		if not IsGametypeTeambased() then
			CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.FFATeamScores, 25)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "scoreboard.team1.count", function(model)
		local f21_local0 = self
		if not IsGametypeTeambased() then
			CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.FFATeamScores, 25)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "scoreboard.team2.count", function(model)
		local f22_local0 = self
		if not IsGametypeTeambased() then
			CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.FFATeamScores, 25)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.reEvalScoreboard", function(model)
		local f23_local0 = self
		if not IsGametypeTeambased() then
			CoD.GridAndListUtility.UpdateDataSourceNextFrame(self.FFATeamScores, 25)
		end
	end)
	FFATeamScores.id = "FFATeamScores"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local14 = self
	SetFocusToElement(self, "FFATeamScores", f1_arg1)
	CoD.CodCasterUtility.ForceListDataSourceUpdate(f1_arg1, self.FFATeamScores)
	CoD.ScoreboardUtility.SetupResetToLocalPlayerSubscription(self, self.FFATeamScores, f1_arg1)
	f1_local14 = FFATeamScores
	if not IsInGame() then
		SetElementProperty(f1_local14, "showHealthBar", false)
		SetElementProperty(f1_local14, "ffaTeam", true)
		CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local14, f1_arg1)
		CoD.GridAndListUtility.SortListByControllerModelKeys(f1_arg1, f1_local14, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	else
		SetElementProperty(f1_local14, "showHealthBar", false)
		SetElementProperty(f1_local14, "ffaTeam", true)
		CoD.GridAndListUtility.AddListUpDownNavigation(f1_arg0, self.FFATeamScores, f1_arg1)
		CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local14, f1_arg1)
		CoD.GridAndListUtility.SortListByControllerModelKeys(f1_arg1, f1_local14, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	end
	return self
end
CoD.TabbedScoreboardScoresFFA.__resetProperties = function(f24_arg0)
	f24_arg0.FFATeamScores:completeAnimation()
	f24_arg0.Blur:completeAnimation()
	f24_arg0.TopBarRight01:completeAnimation()
	f24_arg0.EnemyHeaders:completeAnimation()
	f24_arg0.RankHashtagRight:completeAnimation()
	f24_arg0.SpecialistRight:completeAnimation()
	f24_arg0.TopPlayerPoints:completeAnimation()
	f24_arg0.TopPlayerName:completeAnimation()
	f24_arg0.TopPlayerEmblem:completeAnimation()
	f24_arg0.FFATeamScores:setAlpha(1)
	f24_arg0.Blur:setAlpha(1)
	f24_arg0.TopBarRight01:setAlpha(1)
	f24_arg0.EnemyHeaders:setAlpha(1)
	f24_arg0.RankHashtagRight:setAlpha(1)
	f24_arg0.SpecialistRight:setAlpha(1)
	f24_arg0.TopPlayerPoints:setAlpha(1)
	f24_arg0.TopPlayerName:setAlpha(1)
	f24_arg0.TopPlayerEmblem:setAlpha(1)
end
CoD.TabbedScoreboardScoresFFA.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(8)
			f25_arg0.Blur:completeAnimation()
			f25_arg0.Blur:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Blur)
			f25_arg0.FFATeamScores:completeAnimation()
			f25_arg0.FFATeamScores:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.FFATeamScores)
			f25_arg0.TopBarRight01:completeAnimation()
			f25_arg0.TopBarRight01:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.TopBarRight01)
			f25_arg0.SpecialistRight:completeAnimation()
			f25_arg0.SpecialistRight:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.SpecialistRight)
			f25_arg0.RankHashtagRight:completeAnimation()
			f25_arg0.RankHashtagRight:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RankHashtagRight)
			f25_arg0.EnemyHeaders:completeAnimation()
			f25_arg0.EnemyHeaders:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.EnemyHeaders)
			f25_arg0.TopPlayerPoints:completeAnimation()
			f25_arg0.TopPlayerPoints:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.TopPlayerPoints)
			f25_arg0.TopPlayerName:completeAnimation()
			f25_arg0.TopPlayerName:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.TopPlayerName)
		end,
	},
	NoPlayers = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.TopPlayerEmblem:completeAnimation()
			f26_arg0.TopPlayerEmblem:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.TopPlayerEmblem)
		end,
	},
	Visible = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.TabbedScoreboardScoresFFA.__onClose = function(f28_arg0)
	f28_arg0.TiledBGR:close()
	f28_arg0.CommonDetailPanel2:close()
	f28_arg0.FFATeamScores:close()
	f28_arg0.EnemyHeaders:close()
	f28_arg0.TopPlayerPoints:close()
	f28_arg0.TopPlayerName:close()
	f28_arg0.TopPlayerEmblem:close()
end
