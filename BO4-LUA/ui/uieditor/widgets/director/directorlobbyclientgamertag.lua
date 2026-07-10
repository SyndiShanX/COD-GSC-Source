require("x64:21d9e7c270adcd0")
require("x64:29187ea00d726c3")
CoD.DirectorLobbyClientGamertag = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyClientGamertag.__defaultWidth = 296
CoD.DirectorLobbyClientGamertag.__defaultHeight = 33
CoD.DirectorLobbyClientGamertag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.DirectorLobbyClientGamertag)
	self.id = "DirectorLobbyClientGamertag"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MaskBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MaskBacking:setRGB(0.11, 0.11, 0.11)
	MaskBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_381EEB1F96D4BE0A"))
	MaskBacking:setShaderVector(0, 0, 0.6, 0, 0)
	self:addElement(MaskBacking)
	self.MaskBacking = MaskBacking
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, -65.5, -56.5, 0, 0, -7.5, 43.5)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local LeagueRankNumber = LUI.UIText.new(0, 0, -52.5, 46.5, 0, 0, 3.5, 29.5)
	LeagueRankNumber:setAlpha(0)
	LeagueRankNumber:setTTF("default")
	LeagueRankNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LeagueRankNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LeagueRankNumber.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			LeagueRankNumber:setText(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankFromXuid(f2_local0))
		end
	end
	LeagueRankNumber:linkToElementModel(self, "xuid", true, LeagueRankNumber.__String_Reference)
	LeagueRankNumber.__String_Reference_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.xuid
		end
		if f3_local0 then
			LeagueRankNumber.__String_Reference(f3_local0)
		end
	end
	self:addElement(LeagueRankNumber)
	self.LeagueRankNumber = LeagueRankNumber
	local ArenaRankIcon = CoD.ArenaDirectorLobbyRankIcon.new(f1_arg0, f1_arg1, 0, 0, 50.5, 94.5, 0, 0, -5.5, 38.5)
	ArenaRankIcon:setAlpha(0)
	ArenaRankIcon:linkToElementModel(self, nil, false, function(model)
		ArenaRankIcon:setModel(model, f1_arg1)
	end)
	self:addElement(ArenaRankIcon)
	self.ArenaRankIcon = ArenaRankIcon
	local RankNumber = LUI.UIText.new(0.5, 0.5, -49.5, 49.5, 0, 0, 5, 31)
	RankNumber:setTTF("0arame_mono_stencil")
	RankNumber:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RankNumber.__Color = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			RankNumber:setRGB(CoD.DirectorUtility.GetColorForDisplayRankText(f5_local0))
		end
	end
	RankNumber:linkToElementModel(self, "rankInfo", true, function(model, f6_arg1)
		if f6_arg1["__RankNumber.__Color_rankInfo->isParagon"] then
			f6_arg1:removeSubscription(f6_arg1["__RankNumber.__Color_rankInfo->isParagon"])
			f6_arg1["__RankNumber.__Color_rankInfo->isParagon"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.isParagon
		end
		if model then
			f6_arg1["__RankNumber.__Color_rankInfo->isParagon"] = f6_arg1:subscribeToModel(model, RankNumber.__Color)
		end
	end)
	RankNumber.__String_Reference = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			RankNumber:setText(f7_local0)
		end
	end
	RankNumber:linkToElementModel(self, "rankInfo", true, function(model, f8_arg1)
		if f8_arg1["__RankNumber.__String_Reference_rankInfo->displayRank"] then
			f8_arg1:removeSubscription(f8_arg1["__RankNumber.__String_Reference_rankInfo->displayRank"])
			f8_arg1["__RankNumber.__String_Reference_rankInfo->displayRank"] = nil
		end
		if model then
			local f8_local0 = model:get()
			local f8_local1 = model:get()
			model = f8_local0 and f8_local1.displayRank
		end
		if model then
			f8_arg1["__RankNumber.__String_Reference_rankInfo->displayRank"] = f8_arg1:subscribeToModel(model, RankNumber.__String_Reference)
		end
	end)
	self:addElement(RankNumber)
	self.RankNumber = RankNumber
	local RankIcon = LUI.UIImage.new(0, 0, 201.5, 245.5, 0, 0, -5, 39)
	RankIcon.__Image = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			RankIcon:setImage(RegisterImage(CoD.RankUtility.GetXUIDRankIconForCurrentMode(f9_local0)))
		end
	end
	RankIcon:linkToElementModel(self, "xuid", true, RankIcon.__Image)
	RankIcon.__Image_FullPath = function()
		local f10_local0 = self:getModel()
		if f10_local0 then
			f10_local0 = self:getModel()
			f10_local0 = f10_local0.xuid
		end
		if f10_local0 then
			RankIcon.__Image(f10_local0)
		end
	end
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local Gamertag = LUI.UIText.new(0.5, 0.5, 101.5, 200.5, 0, 0, 4, 30)
	Gamertag:setTTF("notosans_regular")
	Gamertag:setLetterSpacing(1)
	Gamertag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Gamertag:linkToElementModel(self, "xuid", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Gamertag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUID(f11_local0))
		end
	end)
	Gamertag.__String_Reference = function(f12_arg0)
		local f12_local0 = f12_arg0:get()
		if f12_local0 ~= nil then
			Gamertag:setText(CoD.SocialUtility.CleanGamerTag(PrependClanTagToHostname(self:getModel(), f12_local0)))
		end
	end
	Gamertag:linkToElementModel(self, "gamertag", true, Gamertag.__String_Reference)
	Gamertag.__String_Reference_FullPath = function()
		local f13_local0 = self:getModel()
		if f13_local0 then
			f13_local0 = self:getModel()
			f13_local0 = f13_local0.gamertag
		end
		if f13_local0 then
			Gamertag.__String_Reference(f13_local0)
		end
	end
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 352.5, 361.5, 0, 0, -8.5, 42.5)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local f1_local9 = LeagueRankNumber
	local f1_local10 = LeagueRankNumber.subscribeToModel
	local f1_local11 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.lobbyNav, LeagueRankNumber.__String_Reference_FullPath)
	f1_local9 = LeagueRankNumber
	f1_local10 = LeagueRankNumber.subscribeToModel
	f1_local11 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11["privateClient.update"], LeagueRankNumber.__String_Reference_FullPath)
	f1_local9 = LeagueRankNumber
	f1_local10 = LeagueRankNumber.subscribeToModel
	f1_local11 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11["gameClient.update"], LeagueRankNumber.__String_Reference_FullPath)
	f1_local9 = LeagueRankNumber
	f1_local10 = LeagueRankNumber.subscribeToModel
	f1_local11 = Engine[@"getglobalmodel"]()
	f1_local10(f1_local9, f1_local11["PartyPrivacy.privacy"], LeagueRankNumber.__String_Reference_FullPath)
	f1_local9 = RankIcon
	f1_local10 = RankIcon.subscribeToModel
	f1_local11 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.lobbyNav, RankIcon.__Image_FullPath)
	f1_local9 = RankIcon
	f1_local10 = RankIcon.subscribeToModel
	f1_local11 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11["privateClient.update"], RankIcon.__Image_FullPath)
	f1_local9 = RankIcon
	f1_local10 = RankIcon.subscribeToModel
	f1_local11 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11["gameClient.update"], RankIcon.__Image_FullPath)
	f1_local9 = RankIcon
	f1_local10 = RankIcon.subscribeToModel
	f1_local11 = Engine[@"getglobalmodel"]()
	f1_local10(f1_local9, f1_local11["PartyPrivacy.privacy"], RankIcon.__Image_FullPath)
	Gamertag:linkToElementModel(self, "clantag", true, Gamertag.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "gamertag")
			end,
		},
		{
			stateName = "offline",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
		{
			stateName = "customGames",
			condition = function(menu, element, event)
				return IsCustomLobby()
			end,
		},
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	self:linkToElementModel(self, "gamertag", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamertag",
		})
	end)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getglobalmodel"]()
	f1_local10(f1_local9, f1_local11["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbyClientGamertag.__resetProperties = function(f20_arg0)
	f20_arg0.VerticalListSpacer2:completeAnimation()
	f20_arg0.Gamertag:completeAnimation()
	f20_arg0.RankIcon:completeAnimation()
	f20_arg0.RankNumber:completeAnimation()
	f20_arg0.LeagueRankNumber:completeAnimation()
	f20_arg0.VerticalListSpacer:completeAnimation()
	f20_arg0.MaskBacking:completeAnimation()
	f20_arg0.ArenaRankIcon:completeAnimation()
	f20_arg0.VerticalListSpacer2:setAlpha(1)
	f20_arg0.Gamertag:setAlpha(1)
	f20_arg0.RankIcon:setLeftRight(0, 0, 201.5, 245.5)
	f20_arg0.RankIcon:setAlpha(1)
	f20_arg0.RankNumber:setLeftRight(0.5, 0.5, -49.5, 49.5)
	f20_arg0.RankNumber:setAlpha(1)
	f20_arg0.LeagueRankNumber:setLeftRight(0, 0, -52.5, 46.5)
	f20_arg0.LeagueRankNumber:setTopBottom(0, 0, 3.5, 29.5)
	f20_arg0.LeagueRankNumber:setAlpha(0)
	f20_arg0.VerticalListSpacer:setAlpha(1)
	f20_arg0.MaskBacking:setAlpha(1)
	f20_arg0.ArenaRankIcon:setLeftRight(0, 0, 50.5, 94.5)
	f20_arg0.ArenaRankIcon:setTopBottom(0, 0, -5.5, 38.5)
	f20_arg0.ArenaRankIcon:setAlpha(0)
end
CoD.DirectorLobbyClientGamertag.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(7)
			f22_arg0.MaskBacking:completeAnimation()
			f22_arg0.MaskBacking:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.MaskBacking)
			f22_arg0.VerticalListSpacer:completeAnimation()
			f22_arg0.VerticalListSpacer:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.VerticalListSpacer)
			f22_arg0.LeagueRankNumber:completeAnimation()
			f22_arg0.LeagueRankNumber:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.LeagueRankNumber)
			f22_arg0.RankNumber:completeAnimation()
			f22_arg0.RankNumber:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.RankNumber)
			f22_arg0.RankIcon:completeAnimation()
			f22_arg0.RankIcon:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.RankIcon)
			f22_arg0.Gamertag:completeAnimation()
			f22_arg0.Gamertag:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Gamertag)
			f22_arg0.VerticalListSpacer2:completeAnimation()
			f22_arg0.VerticalListSpacer2:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.VerticalListSpacer2)
		end,
	},
	offline = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.RankNumber:completeAnimation()
			f23_arg0.RankNumber:setLeftRight(0.5, 0.5, -75.5, -75.5)
			f23_arg0.RankNumber:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RankNumber)
			f23_arg0.RankIcon:completeAnimation()
			f23_arg0.RankIcon:setLeftRight(0, 0, 148, 148)
			f23_arg0.RankIcon:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RankIcon)
		end,
	},
	customGames = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.RankNumber:completeAnimation()
			f24_arg0.RankNumber:setLeftRight(0.5, 0.5, -75.5, -75.5)
			f24_arg0.RankNumber:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.RankNumber)
			f24_arg0.RankIcon:completeAnimation()
			f24_arg0.RankIcon:setLeftRight(0, 0, 148, 148)
			f24_arg0.RankIcon:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.RankIcon)
		end,
	},
	Arena = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			f25_arg0.LeagueRankNumber:completeAnimation()
			f25_arg0.LeagueRankNumber:setLeftRight(0, 0, 51, 150)
			f25_arg0.LeagueRankNumber:setTopBottom(0, 0, 4, 30)
			f25_arg0.LeagueRankNumber:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.LeagueRankNumber)
			f25_arg0.ArenaRankIcon:completeAnimation()
			f25_arg0.ArenaRankIcon:setLeftRight(0, 0, -1, 43)
			f25_arg0.ArenaRankIcon:setTopBottom(0, 0, -5.5, 38.5)
			f25_arg0.ArenaRankIcon:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.ArenaRankIcon)
			f25_arg0.RankNumber:completeAnimation()
			f25_arg0.RankNumber:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RankNumber)
			f25_arg0.RankIcon:completeAnimation()
			f25_arg0.RankIcon:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RankIcon)
		end,
	},
}
CoD.DirectorLobbyClientGamertag.__onClose = function(f26_arg0)
	f26_arg0.VerticalListSpacer:close()
	f26_arg0.LeagueRankNumber:close()
	f26_arg0.ArenaRankIcon:close()
	f26_arg0.RankNumber:close()
	f26_arg0.RankIcon:close()
	f26_arg0.Gamertag:close()
	f26_arg0.VerticalListSpacer2:close()
end
