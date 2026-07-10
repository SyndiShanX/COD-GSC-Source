require("x64:e12ddba2d13fc72")
require("x64:e20ec0420e680a")
require("x64:edc865de5fd7c3f")
require("x64:321511f84c87d83")
require("x64:14d10cc11d6ed6")
require("x64:c12ff2bdd075f2c")
require("x64:42e9560149fc926")
CoD.TabbedScoreboardRowInternal = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardRowInternal.__defaultWidth = 724
CoD.TabbedScoreboardRowInternal.__defaultHeight = 68
CoD.TabbedScoreboardRowInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardRowInternal)
	self.id = "TabbedScoreboardRowInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatBoxR = CoD.TabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 1, 1, -86, -4, 0.5, 0.5, -30, 30)
	StatBoxR:linkToElementModel(self, nil, false, function(model)
		StatBoxR:setModel(model, f1_arg1)
	end)
	StatBoxR:linkToElementModel(self, "scoreboard.col3", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StatBoxR.Value:setText(f3_local0)
		end
	end)
	self:addElement(StatBoxR)
	self.StatBoxR = StatBoxR
	local StatBoxM = CoD.TabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 1, 1, -168, -86, 0.5, 0.5, -30, 30)
	StatBoxM:linkToElementModel(self, nil, false, function(model)
		StatBoxM:setModel(model, f1_arg1)
	end)
	StatBoxM:linkToElementModel(self, "scoreboard.col2", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			StatBoxM.Value:setText(f5_local0)
		end
	end)
	self:addElement(StatBoxM)
	self.StatBoxM = StatBoxM
	local StatBoxL = CoD.TabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 1, 1, -250, -168, 0.5, 0.5, -30, 30)
	StatBoxL:linkToElementModel(self, nil, false, function(model)
		StatBoxL:setModel(model, f1_arg1)
	end)
	StatBoxL:linkToElementModel(self, "scoreboard.col1", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StatBoxL.Value:setText(f7_local0)
		end
	end)
	self:addElement(StatBoxL)
	self.StatBoxL = StatBoxL
	local StatBoxFFA = CoD.TabbedScoreboardFFAStatBox.new(f1_arg0, f1_arg1, 0, 0, 720, 802, 0, 0, 4, 64)
	StatBoxFFA:linkToElementModel(self, nil, false, function(model)
		StatBoxFFA:setModel(model, f1_arg1)
	end)
	self:addElement(StatBoxFFA)
	self.StatBoxFFA = StatBoxFFA
	local TintPlayerName = LUI.UIImage.new(0.5, 0.5, -195, 107, 0, 0, 3, 61)
	TintPlayerName:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_name_bg"))
	self:addElement(TintPlayerName)
	self.TintPlayerName = TintPlayerName
	local PlayerNameBotStripe = LUI.UIImage.new(0, 0, 165.5, 471.5, 0, 0, 58, 68)
	PlayerNameBotStripe:setAlpha(0.5)
	PlayerNameBotStripe:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_name_stripe"))
	self:addElement(PlayerNameBotStripe)
	self.PlayerNameBotStripe = PlayerNameBotStripe
	local LevelBG = LUI.UIImage.new(0.5, 0.5, -327, -283, 0, 0, 3, 61)
	LevelBG:setImage(RegisterImage(@"hash_2BF90F4B4EC33404"))
	self:addElement(LevelBG)
	self.LevelBG = LevelBG
	local selfPlayerBotStripe = CoD.TabbedScoreboardRowSelected.new(f1_arg0, f1_arg1, 0, 0, 36, 720, 0, 0, 4, 64)
	selfPlayerBotStripe:setAlpha(0)
	self:addElement(selfPlayerBotStripe)
	self.selfPlayerBotStripe = selfPlayerBotStripe
	local PlayerIcon = CoD.ScoreboardPlayerWidget.new(f1_arg0, f1_arg1, 0, 0, 80, 164, 0, 0, 4, 60)
	PlayerIcon:setAlpha(0.95)
	PlayerIcon:linkToElementModel(self, nil, false, function(model)
		PlayerIcon:setModel(model, f1_arg1)
	end)
	PlayerIcon:linkToElementModel(self, "scoreboard.characterIndex", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			PlayerIcon.PlayerIcon:setImage(RegisterImage(GetPositionDraftIconByIndex(f10_local0)))
		end
	end)
	self:addElement(PlayerIcon)
	self.PlayerIcon = PlayerIcon
	local BarBotPlayer = LUI.UIImage.new(0.5, 0.5, -284.5, -194.5, 0, 0, 58.5, 68.5)
	BarBotPlayer:setImage(RegisterImage(@"hash_1488233EAD062891"))
	self:addElement(BarBotPlayer)
	self.BarBotPlayer = BarBotPlayer
	local BotBarRank = LUI.UIImage.new(0.5, 0.5, -328.5, -280.5, 0, 0, 58.5, 68.5)
	BotBarRank:setImage(RegisterImage(@"hash_7B6282F6D5AC2104"))
	self:addElement(BotBarRank)
	self.BotBarRank = BotBarRank
	local uieBorder = CoD.uie_Border.new(f1_arg0, f1_arg1, 0, 0, 36, 720, 0, 0, 4, 60)
	uieBorder:setAlpha(0)
	self:addElement(uieBorder)
	self.uieBorder = uieBorder
	local playerPing = nil
	playerPing = LUI.UIText.new(0, 0, 171, 249, 0, 0, 42, 57)
	playerPing:setAlpha(0.75)
	playerPing:setTTF("notosans_regular")
	playerPing:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	playerPing:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	playerPing:linkToElementModel(self, "ping", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			playerPing:setText(CoD.ScoreboardUtility.UpdatePingValue(self, 0.5, self:getModel(), f11_local0))
		end
	end)
	self:addElement(playerPing)
	self.playerPing = playerPing
	local playerPingAsianLanguage = nil
	playerPingAsianLanguage = LUI.UIText.new(0, 0, 171, 249, 0, 0, 47, 57)
	playerPingAsianLanguage:setAlpha(0.75)
	playerPingAsianLanguage:setTTF("notosans_regular")
	playerPingAsianLanguage:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	playerPingAsianLanguage:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	playerPingAsianLanguage:linkToElementModel(self, "ping", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			playerPingAsianLanguage:setText(CoD.ScoreboardUtility.UpdatePingValue(self, 0.5, self:getModel(), f12_local0))
		end
	end)
	self:addElement(playerPingAsianLanguage)
	self.playerPingAsianLanguage = playerPingAsianLanguage
	local ClanAndGamerName = LUI.UIText.new(0, 0, 170, 470, 0, 0, 20, 46)
	ClanAndGamerName:setAlpha(0.8)
	ClanAndGamerName:setTTF("notosans_regular")
	ClanAndGamerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanAndGamerName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ClanAndGamerName:linkToElementModel(self, "scoreboard.playerName", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			ClanAndGamerName:setText(CoD.SocialUtility.CleanGamerTag(f13_local0))
		end
	end)
	self:addElement(ClanAndGamerName)
	self.ClanAndGamerName = ClanAndGamerName
	local Rank = CoD.TabbedScoreboardRank.new(f1_arg0, f1_arg1, 0, 0, 47, 67, 0, 0, 7, 67)
	Rank:linkToElementModel(self, nil, false, function(model)
		Rank:setModel(model, f1_arg1)
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local Line2 = LUI.UIImage.new(1, 1, -87, -86, 0, 0, 5, 59)
	Line2:setAlpha(0.03)
	self:addElement(Line2)
	self.Line2 = Line2
	local Line = LUI.UIImage.new(1, 1, -87, -86, 0, 0, 5, 59)
	Line:setAlpha(0.03)
	self:addElement(Line)
	self.Line = Line
	local Line4 = LUI.UIImage.new(1, 1, -4.5, -3.5, 0, 0, 5, 59)
	Line4:setAlpha(0.03)
	self:addElement(Line4)
	self.Line4 = Line4
	local Line3 = LUI.UIImage.new(1, 1, -169, -168, 0, 0, 5, 59)
	Line3:setAlpha(0.03)
	self:addElement(Line3)
	self.Line3 = Line3
	local VoipWaves = CoD.OnOffVoip.new(f1_arg0, f1_arg1, 0, 0, -9, 52, 0, 0, 23, 45)
	VoipWaves:setZRot(90)
	VoipWaves:linkToElementModel(self, nil, false, function(model)
		VoipWaves:setModel(model, f1_arg1)
	end)
	self:addElement(VoipWaves)
	self.VoipWaves = VoipWaves
	self:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.IsSelfOrSpectatedClient(f1_arg1, element)
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	local f1_local22 = self
	local f1_local23 = self.subscribeToModel
	local f1_local24 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local23(f1_local22, f1_local24["deadSpectator.playerIndex"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "deadSpectator.playerIndex",
		})
	end, false)
	self:linkToElementModel(self, nil, true, function(model)
		CoD.DirectorUtility.UpdateVOIPStatusForModel(self, model, "clientNum")
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local23 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuScoreboard(self, f1_arg1, f1_arg0)
	end
	f1_local23 = playerPing
	if CoD.BaseUtility.IsCurrentLanguageAsian() then
		HideWidget(f1_local23)
	end
	f1_local23 = playerPingAsianLanguage
	if not CoD.BaseUtility.IsCurrentLanguageAsian() then
		HideWidget(f1_local23)
	end
	return self
end
CoD.TabbedScoreboardRowInternal.__resetProperties = function(f20_arg0)
	f20_arg0.ClanAndGamerName:completeAnimation()
	f20_arg0.selfPlayerBotStripe:completeAnimation()
	f20_arg0.PlayerIcon:completeAnimation()
	f20_arg0.uieBorder:completeAnimation()
	f20_arg0.playerPing:completeAnimation()
	f20_arg0.playerPingAsianLanguage:completeAnimation()
	f20_arg0.ClanAndGamerName:setRGB(1, 1, 1)
	f20_arg0.selfPlayerBotStripe:setRGB(1, 1, 1)
	f20_arg0.selfPlayerBotStripe:setAlpha(0)
	f20_arg0.uieBorder:setRGB(1, 1, 1)
	f20_arg0.uieBorder:setAlpha(0)
	f20_arg0.playerPing:setRGB(1, 1, 1)
	f20_arg0.playerPingAsianLanguage:setRGB(1, 1, 1)
end
CoD.TabbedScoreboardRowInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.selfPlayerBotStripe:completeAnimation()
			f21_arg0.selfPlayerBotStripe:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.selfPlayerBotStripe)
			f21_arg0.PlayerIcon:completeAnimation()
			f21_arg0.PlayerIcon:playClip("DefaultClip")
			f21_arg0.clipFinished(f21_arg0.PlayerIcon)
			f21_arg0.ClanAndGamerName:completeAnimation()
			f21_arg0.ClanAndGamerName:setRGB(1, 1, 1)
			f21_arg0.clipFinished(f21_arg0.ClanAndGamerName)
		end,
		Focus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.selfPlayerBotStripe:beginAnimation(200)
				f22_arg0.selfPlayerBotStripe:setAlpha(1)
				f22_arg0.selfPlayerBotStripe:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.selfPlayerBotStripe:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.selfPlayerBotStripe:completeAnimation()
			f22_arg0.selfPlayerBotStripe:setAlpha(0)
			f22_local0(f22_arg0.selfPlayerBotStripe)
			f22_arg0.uieBorder:completeAnimation()
			f22_arg0.uieBorder:setRGB(1, 1, 1)
			f22_arg0.uieBorder:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.uieBorder)
			f22_arg0.ClanAndGamerName:completeAnimation()
			f22_arg0.ClanAndGamerName:setRGB(1, 1, 1)
			f22_arg0.clipFinished(f22_arg0.ClanAndGamerName)
		end,
	},
	Self = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(5)
			local f24_local0 = function(f25_arg0)
				f24_arg0.selfPlayerBotStripe:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f24_arg0.selfPlayerBotStripe:setAlpha(0)
				f24_arg0.selfPlayerBotStripe:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.selfPlayerBotStripe:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.selfPlayerBotStripe:completeAnimation()
			f24_arg0.selfPlayerBotStripe:setRGB(1, 1, 1)
			f24_arg0.selfPlayerBotStripe:setAlpha(1)
			f24_local0(f24_arg0.selfPlayerBotStripe)
			local f24_local1 = function(f26_arg0)
				f24_arg0.uieBorder:beginAnimation(200)
				f24_arg0.uieBorder:setAlpha(0.3)
				f24_arg0.uieBorder:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.uieBorder:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.uieBorder:completeAnimation()
			f24_arg0.uieBorder:setAlpha(0)
			f24_local1(f24_arg0.uieBorder)
			f24_arg0.playerPing:completeAnimation()
			f24_arg0.playerPing:setRGB(0.89, 0.64, 0)
			f24_arg0.clipFinished(f24_arg0.playerPing)
			f24_arg0.playerPingAsianLanguage:completeAnimation()
			f24_arg0.playerPingAsianLanguage:setRGB(1, 0.76, 0)
			f24_arg0.clipFinished(f24_arg0.playerPingAsianLanguage)
			f24_arg0.ClanAndGamerName:completeAnimation()
			f24_arg0.ClanAndGamerName:setRGB(1, 0.76, 0)
			f24_arg0.clipFinished(f24_arg0.ClanAndGamerName)
		end,
		Focus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(5)
			local f27_local0 = function(f28_arg0)
				f27_arg0.selfPlayerBotStripe:beginAnimation(200)
				f27_arg0.selfPlayerBotStripe:setAlpha(1)
				f27_arg0.selfPlayerBotStripe:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.selfPlayerBotStripe:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.selfPlayerBotStripe:completeAnimation()
			f27_arg0.selfPlayerBotStripe:setRGB(1, 1, 1)
			f27_arg0.selfPlayerBotStripe:setAlpha(0)
			f27_local0(f27_arg0.selfPlayerBotStripe)
			local f27_local1 = function(f29_arg0)
				f27_arg0.uieBorder:beginAnimation(200)
				f27_arg0.uieBorder:setAlpha(0)
				f27_arg0.uieBorder:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.uieBorder:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.uieBorder:completeAnimation()
			f27_arg0.uieBorder:setAlpha(0.2)
			f27_local1(f27_arg0.uieBorder)
			f27_arg0.playerPing:completeAnimation()
			f27_arg0.playerPing:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
			f27_arg0.clipFinished(f27_arg0.playerPing)
			f27_arg0.playerPingAsianLanguage:completeAnimation()
			f27_arg0.playerPingAsianLanguage:setRGB(1, 0.76, 0)
			f27_arg0.clipFinished(f27_arg0.playerPingAsianLanguage)
			f27_arg0.ClanAndGamerName:completeAnimation()
			f27_arg0.ClanAndGamerName:setRGB(1, 0.76, 0)
			f27_arg0.clipFinished(f27_arg0.ClanAndGamerName)
		end,
	},
}
CoD.TabbedScoreboardRowInternal.__onClose = function(f30_arg0)
	f30_arg0.StatBoxR:close()
	f30_arg0.StatBoxM:close()
	f30_arg0.StatBoxL:close()
	f30_arg0.StatBoxFFA:close()
	f30_arg0.selfPlayerBotStripe:close()
	f30_arg0.PlayerIcon:close()
	f30_arg0.uieBorder:close()
	f30_arg0.playerPing:close()
	f30_arg0.playerPingAsianLanguage:close()
	f30_arg0.ClanAndGamerName:close()
	f30_arg0.Rank:close()
	f30_arg0.VoipWaves:close()
end
