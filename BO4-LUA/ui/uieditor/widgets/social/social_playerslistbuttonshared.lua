require("ui/uieditor/widgets/social/social_partymembericonlarge")
require("ui/uieditor/widgets/social/social_playerslistbutton_trial")
require("ui/uieditor/widgets/social/social_playerslistrankinfo")
require("ui/uieditor/widgets/pc/directorlobbyclanandmembernamecontainerpc")
CoD.Social_PlayersListButtonShared = InheritFrom(LUI.UIElement)
CoD.Social_PlayersListButtonShared.__defaultWidth = 474
CoD.Social_PlayersListButtonShared.__defaultHeight = 40
CoD.Social_PlayersListButtonShared.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PlayersListButtonShared)
	self.id = "Social_PlayersListButtonShared"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EmptyBacking2 = LUI.UIImage.new(0, 1, 14, 14, 0, 1, 0, 0)
	EmptyBacking2:setRGB(0, 0, 0)
	self:addElement(EmptyBacking2)
	self.EmptyBacking2 = EmptyBacking2
	local TeamColorBacking = LUI.UIImage.new(0, 1.01, 14, 14, 0, 1.19, -4, -4)
	TeamColorBacking:setAlpha(0.5)
	TeamColorBacking:setImage(RegisterImage("uie_ui_menu_cac_text_bg01"))
	TeamColorBacking.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			TeamColorBacking:setRGB(CoD.TeamUtility.GetTeamFactionColor(f2_local0))
		end
	end
	TeamColorBacking:linkToElementModel(self, "team", true, TeamColorBacking.__Color)
	TeamColorBacking.__Color_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.team
		end
		if f3_local0 then
			TeamColorBacking.__Color(f3_local0)
		end
	end
	self:addElement(TeamColorBacking)
	self.TeamColorBacking = TeamColorBacking
	local OnOffBacking = LUI.UIImage.new(0, 1.01, 14, 14, 0, 1.19, -4, -4)
	OnOffBacking:setAlpha(0)
	OnOffBacking:setImage(RegisterImage("uie_ui_menu_cac_text_bg01"))
	OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(OnOffBacking)
	self.OnOffBacking = OnOffBacking
	local Border = LUI.UIImage.new(0, 1, 14, 14, 0, 1, 0, 0)
	Border:setRGB(0.47, 0.47, 0.47)
	Border:setAlpha(0)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_161FE85EDD9F1ED1"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setShaderVector(1, 0, 0, 0, 0)
	Border:setupNineSliceShader(1, 1)
	self:addElement(Border)
	self.Border = Border
	local emblemBg = LUI.UIImage.new(0, 0, 14, 54, 0, 1, 0, 0)
	emblemBg:setRGB(0, 0, 0)
	emblemBg:setAlpha(0.95)
	self:addElement(emblemBg)
	self.emblemBg = emblemBg
	local rankicon = LUI.UIImage.new(0, 0, 14, 53, 0, 0, -1, 38)
	rankicon:setAlpha(0)
	rankicon:linkToElementModel(self, "rankIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			rankicon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(rankicon)
	self.rankicon = rankicon
	local emblem = LUI.UIImage.new(0, 0, 14, 54, 0.5, 0.5, -20, 20)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f5_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local f1_local8 = nil
	self.membername = LUI.UIElement.createFake()
	local f1_local9 = nil
	self.joinable = LUI.UIElement.createFake()
	local trial = CoD.Social_PlayersListButton_Trial.new(f1_arg0, f1_arg1, 1, 1, -117.5, -90.5, 0.5, 0.5, -13.5, 13.5)
	trial:linkToElementModel(self, nil, false, function(model)
		trial:setModel(model, f1_arg1)
	end)
	self:addElement(trial)
	self.trial = trial
	local SocialPartyMemberIconLarge0 = CoD.Social_PartyMemberIconLarge.new(f1_arg0, f1_arg1, 1, 1, -5, 4, 0, 1, 0, 0)
	SocialPartyMemberIconLarge0:mergeStateConditions({
		{
			stateName = "PartyMemberTopOrMiddle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPartyMemberTopOrMiddle")
			end,
		},
		{
			stateName = "PartyMember",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "OtherPartyMemberTopOrMiddle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isOtherMemberTopOrMiddle")
			end,
		},
		{
			stateName = "OtherPartyMember",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isOtherMember")
			end,
		},
	})
	SocialPartyMemberIconLarge0:linkToElementModel(SocialPartyMemberIconLarge0, "isPartyMemberTopOrMiddle", true, function(model)
		f1_arg0:updateElementState(SocialPartyMemberIconLarge0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isPartyMemberTopOrMiddle",
		})
	end)
	SocialPartyMemberIconLarge0:linkToElementModel(SocialPartyMemberIconLarge0, "isOtherMemberTopOrMiddle", true, function(model)
		f1_arg0:updateElementState(SocialPartyMemberIconLarge0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOtherMemberTopOrMiddle",
		})
	end)
	SocialPartyMemberIconLarge0:linkToElementModel(SocialPartyMemberIconLarge0, "isOtherMember", true, function(model)
		f1_arg0:updateElementState(SocialPartyMemberIconLarge0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOtherMember",
		})
	end)
	self:addElement(SocialPartyMemberIconLarge0)
	self.SocialPartyMemberIconLarge0 = SocialPartyMemberIconLarge0
	local Plus = LUI.UIImage.new(0.5, 0.5, -12, 12, 0.5, 0.5, -12.5, 11.5)
	Plus:setRGB(0.53, 0.53, 0.53)
	Plus:setAlpha(0)
	Plus:setImage(RegisterImage("uie_ui_menu_cac_plus"))
	self:addElement(Plus)
	self.Plus = Plus
	local SocialPlayersListRankInfo = CoD.Social_PlayersListRankInfo.new(f1_arg0, f1_arg1, 1, 1, -79.5, -22.5, 0, 0, 1.5, 37.5)
	SocialPlayersListRankInfo:linkToElementModel(self, "rankInfo", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			SocialPlayersListRankInfo:setModel(f14_local0, f1_arg1)
		end
	end)
	self:addElement(SocialPlayersListRankInfo)
	self.SocialPlayersListRankInfo = SocialPlayersListRankInfo
	local membernamePC = nil
	membernamePC = CoD.DirectorLobbyClanAndMemberNameContainerPC.new(f1_arg0, f1_arg1, 0, 0, 62, 358, 0, 0, 9.5, 30.5)
	membernamePC:linkToElementModel(self, nil, false, function(model)
		membernamePC:setModel(model, f1_arg1)
	end)
	self:addElement(membernamePC)
	self.membernamePC = membernamePC
	local f1_local15 = TeamColorBacking
	local f1_local16 = TeamColorBacking.subscribeToModel
	local f1_local17 = Engine.GetGlobalModel()
	f1_local16(f1_local15, f1_local17["MapVote.mapVoteGameModeNext"], TeamColorBacking.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "OfflinePC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "primaryPresence", Enum.PresencePrimary[@"presence_primary_offline"]) and IsPC()
			end,
		},
		{
			stateName = "LeaderboardsChecked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.leaderboardsPlayerListActive")
			end,
		},
		{
			stateName = "LeaderboardsUncheckable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.leaderboardsPlayerListActive")
			end,
		},
		{
			stateName = "LeaderboardsUnchecked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.leaderboardsPlayerListActive")
			end,
		},
		{
			stateName = "OnlinePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				local f21_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY)
				if f21_local0 then
					if not IsPC() then
						f21_local0 = not IsLobbyNetworkModeLAN()
					else
						f21_local0 = false
					end
				end
				return f21_local0
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "xuid", Engine.StringToXUIDDecimal("0"))
			end,
		},
		{
			stateName = "Offline",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "primaryPresence", Enum.PresencePrimary[@"presence_primary_offline"])
			end,
		},
		{
			stateName = "OnlineButNotOurGame",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "presence", Enum[@"presencetitle"][@"hash_7A2184EBB293AF2D"])
			end,
		},
		{
			stateName = "Online",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "primaryPresence", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "primaryPresence",
		})
	end)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine.GetGlobalModel()
	f1_local16(f1_local15, f1_local17["socialRoot.leaderboardsPlayerListActive"], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "socialRoot.leaderboardsPlayerListActive",
		})
	end, false)
	self:linkToElementModel(self, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine.GetGlobalModel()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	self:linkToElementModel(self, "presence", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "presence",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PlayersListButtonShared.__resetProperties = function(f32_arg0)
	f32_arg0.OnOffBacking:completeAnimation()
	f32_arg0.TeamColorBacking:completeAnimation()
	f32_arg0.membername:completeAnimation()
	f32_arg0.emblem:completeAnimation()
	f32_arg0.SocialPlayersListRankInfo:completeAnimation()
	f32_arg0.joinable:completeAnimation()
	f32_arg0.Plus:completeAnimation()
	f32_arg0.rankicon:completeAnimation()
	f32_arg0.emblemBg:completeAnimation()
	f32_arg0.Border:completeAnimation()
	f32_arg0.SocialPartyMemberIconLarge0:completeAnimation()
	f32_arg0.OnOffBacking:setRGB(1, 1, 1)
	f32_arg0.OnOffBacking:setAlpha(0)
	f32_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f32_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
	f32_arg0.TeamColorBacking:setAlpha(0.5)
	f32_arg0.membername:setRGB(1, 1, 1)
	f32_arg0.membername:setAlpha(1)
	f32_arg0.emblem:setAlpha(1)
	f32_arg0.SocialPlayersListRankInfo:setAlpha(1)
	f32_arg0.joinable:setAlpha(1)
	f32_arg0.Plus:setAlpha(0)
	f32_arg0.rankicon:setAlpha(0)
	f32_arg0.emblemBg:setAlpha(0.95)
	f32_arg0.Border:setAlpha(0)
	f32_arg0.SocialPartyMemberIconLarge0:setAlpha(1)
end
CoD.Social_PlayersListButtonShared.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
		end,
	},
	OfflinePC = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(4)
			f34_arg0.TeamColorBacking:completeAnimation()
			f34_arg0.TeamColorBacking:setAlpha(0.2)
			f34_arg0.clipFinished(f34_arg0.TeamColorBacking)
			f34_arg0.OnOffBacking:completeAnimation()
			f34_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
			f34_arg0.OnOffBacking:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.OnOffBacking)
			f34_arg0.emblem:completeAnimation()
			f34_arg0.emblem:setAlpha(0.2)
			f34_arg0.clipFinished(f34_arg0.emblem)
			f34_arg0.membername:completeAnimation()
			f34_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f34_arg0.membername:setAlpha(0.2)
			f34_arg0.clipFinished(f34_arg0.membername)
			f34_arg0.SocialPlayersListRankInfo:completeAnimation()
			f34_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f34_arg0.clipFinished(f34_arg0.SocialPlayersListRankInfo)
		end,
		Focus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(4)
			f35_arg0.TeamColorBacking:completeAnimation()
			f35_arg0.TeamColorBacking:setAlpha(0.2)
			f35_arg0.clipFinished(f35_arg0.TeamColorBacking)
			f35_arg0.OnOffBacking:completeAnimation()
			f35_arg0.OnOffBacking:setAlpha(0.5)
			f35_arg0.clipFinished(f35_arg0.OnOffBacking)
			f35_arg0.emblem:completeAnimation()
			f35_arg0.emblem:setAlpha(0.5)
			f35_arg0.clipFinished(f35_arg0.emblem)
			f35_arg0.membername:completeAnimation()
			f35_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f35_arg0.membername:setAlpha(0.5)
			f35_arg0.clipFinished(f35_arg0.membername)
			f35_arg0.SocialPlayersListRankInfo:completeAnimation()
			f35_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f35_arg0.clipFinished(f35_arg0.SocialPlayersListRankInfo)
		end,
		GainFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(4)
			f36_arg0.TeamColorBacking:completeAnimation()
			f36_arg0.TeamColorBacking:setAlpha(0.2)
			f36_arg0.clipFinished(f36_arg0.TeamColorBacking)
			local f36_local0 = function(f37_arg0)
				f36_arg0.OnOffBacking:beginAnimation(100)
				f36_arg0.OnOffBacking:setRGB(1, 1, 1)
				f36_arg0.OnOffBacking:setAlpha(0.5)
				f36_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.OnOffBacking:completeAnimation()
			f36_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
			f36_arg0.OnOffBacking:setAlpha(0)
			f36_local0(f36_arg0.OnOffBacking)
			local f36_local1 = function(f38_arg0)
				f36_arg0.emblem:beginAnimation(100)
				f36_arg0.emblem:setAlpha(0.5)
				f36_arg0.emblem:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.emblem:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.emblem:completeAnimation()
			f36_arg0.emblem:setAlpha(0.2)
			f36_local1(f36_arg0.emblem)
			local f36_local2 = function(f39_arg0)
				f36_arg0.membername:beginAnimation(100)
				f36_arg0.membername:setAlpha(0.5)
				f36_arg0.membername:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.membername:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.membername:completeAnimation()
			f36_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f36_arg0.membername:setAlpha(0.2)
			f36_local2(f36_arg0.membername)
			f36_arg0.SocialPlayersListRankInfo:completeAnimation()
			f36_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f36_arg0.clipFinished(f36_arg0.SocialPlayersListRankInfo)
		end,
		LoseFocus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(4)
			f40_arg0.TeamColorBacking:completeAnimation()
			f40_arg0.TeamColorBacking:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.TeamColorBacking)
			local f40_local0 = function(f41_arg0)
				f40_arg0.OnOffBacking:beginAnimation(100)
				f40_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
				f40_arg0.OnOffBacking:setAlpha(0)
				f40_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.OnOffBacking:completeAnimation()
			f40_arg0.OnOffBacking:setRGB(1, 1, 1)
			f40_arg0.OnOffBacking:setAlpha(0.5)
			f40_local0(f40_arg0.OnOffBacking)
			local f40_local1 = function(f42_arg0)
				f40_arg0.emblem:beginAnimation(100)
				f40_arg0.emblem:setAlpha(0.2)
				f40_arg0.emblem:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.emblem:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.emblem:completeAnimation()
			f40_arg0.emblem:setAlpha(0.5)
			f40_local1(f40_arg0.emblem)
			local f40_local2 = function(f43_arg0)
				f40_arg0.membername:beginAnimation(100)
				f40_arg0.membername:setAlpha(0.2)
				f40_arg0.membername:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.membername:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.membername:completeAnimation()
			f40_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f40_arg0.membername:setAlpha(0.5)
			f40_local2(f40_arg0.membername)
			f40_arg0.SocialPlayersListRankInfo:completeAnimation()
			f40_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f40_arg0.clipFinished(f40_arg0.SocialPlayersListRankInfo)
		end,
		ActiveAndFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(4)
			f44_arg0.TeamColorBacking:completeAnimation()
			f44_arg0.TeamColorBacking:setAlpha(0.2)
			f44_arg0.clipFinished(f44_arg0.TeamColorBacking)
			f44_arg0.OnOffBacking:completeAnimation()
			f44_arg0.OnOffBacking:setAlpha(0.7)
			f44_arg0.clipFinished(f44_arg0.OnOffBacking)
			f44_arg0.emblem:completeAnimation()
			f44_arg0.emblem:setAlpha(0.5)
			f44_arg0.clipFinished(f44_arg0.emblem)
			f44_arg0.membername:completeAnimation()
			f44_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f44_arg0.membername:setAlpha(0.5)
			f44_arg0.clipFinished(f44_arg0.membername)
			f44_arg0.SocialPlayersListRankInfo:completeAnimation()
			f44_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f44_arg0.clipFinished(f44_arg0.SocialPlayersListRankInfo)
		end,
		Active = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(4)
			f45_arg0.TeamColorBacking:completeAnimation()
			f45_arg0.TeamColorBacking:setAlpha(0.2)
			f45_arg0.clipFinished(f45_arg0.TeamColorBacking)
			f45_arg0.OnOffBacking:completeAnimation()
			f45_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
			f45_arg0.OnOffBacking:setAlpha(0.5)
			f45_arg0.clipFinished(f45_arg0.OnOffBacking)
			f45_arg0.emblem:completeAnimation()
			f45_arg0.emblem:setAlpha(0.5)
			f45_arg0.clipFinished(f45_arg0.emblem)
			f45_arg0.membername:completeAnimation()
			f45_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f45_arg0.membername:setAlpha(0.5)
			f45_arg0.clipFinished(f45_arg0.membername)
			f45_arg0.SocialPlayersListRankInfo:completeAnimation()
			f45_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f45_arg0.clipFinished(f45_arg0.SocialPlayersListRankInfo)
		end,
		GainActiveAndFocus = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(4)
			f46_arg0.TeamColorBacking:completeAnimation()
			f46_arg0.TeamColorBacking:setAlpha(0.2)
			f46_arg0.clipFinished(f46_arg0.TeamColorBacking)
			local f46_local0 = function(f47_arg0)
				f46_arg0.OnOffBacking:beginAnimation(100)
				f46_arg0.OnOffBacking:setRGB(1, 1, 1)
				f46_arg0.OnOffBacking:setAlpha(0.7)
				f46_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.OnOffBacking:completeAnimation()
			f46_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
			f46_arg0.OnOffBacking:setAlpha(0.5)
			f46_local0(f46_arg0.OnOffBacking)
			local f46_local1 = function(f48_arg0)
				f46_arg0.emblem:beginAnimation(100)
				f46_arg0.emblem:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.emblem:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.emblem:completeAnimation()
			f46_arg0.emblem:setAlpha(0.5)
			f46_local1(f46_arg0.emblem)
			local f46_local2 = function(f49_arg0)
				f46_arg0.membername:beginAnimation(100)
				f46_arg0.membername:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.membername:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.membername:completeAnimation()
			f46_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f46_arg0.membername:setAlpha(0.5)
			f46_local2(f46_arg0.membername)
			f46_arg0.SocialPlayersListRankInfo:completeAnimation()
			f46_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f46_arg0.clipFinished(f46_arg0.SocialPlayersListRankInfo)
		end,
		LoseActiveAndFocus = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(4)
			local f50_local0 = function(f51_arg0)
				f50_arg0.TeamColorBacking:beginAnimation(100)
				f50_arg0.TeamColorBacking:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.TeamColorBacking:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.TeamColorBacking:completeAnimation()
			f50_arg0.TeamColorBacking:setAlpha(0.2)
			f50_local0(f50_arg0.TeamColorBacking)
			local f50_local1 = function(f52_arg0)
				f50_arg0.OnOffBacking:beginAnimation(100)
				f50_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
				f50_arg0.OnOffBacking:setAlpha(0.5)
				f50_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.OnOffBacking:completeAnimation()
			f50_arg0.OnOffBacking:setRGB(1, 1, 1)
			f50_arg0.OnOffBacking:setAlpha(0.7)
			f50_local1(f50_arg0.OnOffBacking)
			local f50_local2 = function(f53_arg0)
				f50_arg0.emblem:beginAnimation(100)
				f50_arg0.emblem:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.emblem:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.emblem:completeAnimation()
			f50_arg0.emblem:setAlpha(0.5)
			f50_local2(f50_arg0.emblem)
			local f50_local3 = function(f54_arg0)
				f50_arg0.membername:beginAnimation(100)
				f50_arg0.membername:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.membername:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.membername:completeAnimation()
			f50_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f50_arg0.membername:setAlpha(0.5)
			f50_local3(f50_arg0.membername)
			f50_arg0.SocialPlayersListRankInfo:completeAnimation()
			f50_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f50_arg0.clipFinished(f50_arg0.SocialPlayersListRankInfo)
		end,
		LoseActive = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(4)
			f55_arg0.TeamColorBacking:completeAnimation()
			f55_arg0.TeamColorBacking:setAlpha(0.2)
			f55_arg0.clipFinished(f55_arg0.TeamColorBacking)
			local f55_local0 = function(f56_arg0)
				f55_arg0.OnOffBacking:beginAnimation(100)
				f55_arg0.OnOffBacking:setAlpha(0)
				f55_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.OnOffBacking:completeAnimation()
			f55_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
			f55_arg0.OnOffBacking:setAlpha(0.5)
			f55_local0(f55_arg0.OnOffBacking)
			local f55_local1 = function(f57_arg0)
				f55_arg0.emblem:beginAnimation(100)
				f55_arg0.emblem:setAlpha(0.2)
				f55_arg0.emblem:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.emblem:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.emblem:completeAnimation()
			f55_arg0.emblem:setAlpha(0.5)
			f55_local1(f55_arg0.emblem)
			local f55_local2 = function(f58_arg0)
				f55_arg0.membername:beginAnimation(100)
				f55_arg0.membername:setAlpha(0.2)
				f55_arg0.membername:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.membername:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.membername:completeAnimation()
			f55_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f55_arg0.membername:setAlpha(0.5)
			f55_local2(f55_arg0.membername)
			f55_arg0.SocialPlayersListRankInfo:completeAnimation()
			f55_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f55_arg0.clipFinished(f55_arg0.SocialPlayersListRankInfo)
		end,
		ActiveAndFocusToActive = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(4)
			f59_arg0.TeamColorBacking:completeAnimation()
			f59_arg0.TeamColorBacking:setAlpha(0.2)
			f59_arg0.clipFinished(f59_arg0.TeamColorBacking)
			local f59_local0 = function(f60_arg0)
				f59_arg0.OnOffBacking:beginAnimation(100)
				f59_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
				f59_arg0.OnOffBacking:setAlpha(0.5)
				f59_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
			end
			f59_arg0.OnOffBacking:completeAnimation()
			f59_arg0.OnOffBacking:setRGB(1, 1, 1)
			f59_arg0.OnOffBacking:setAlpha(0.7)
			f59_local0(f59_arg0.OnOffBacking)
			f59_arg0.emblem:completeAnimation()
			f59_arg0.emblem:setAlpha(0.5)
			f59_arg0.clipFinished(f59_arg0.emblem)
			f59_arg0.membername:completeAnimation()
			f59_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f59_arg0.membername:setAlpha(0.5)
			f59_arg0.clipFinished(f59_arg0.membername)
			f59_arg0.SocialPlayersListRankInfo:completeAnimation()
			f59_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f59_arg0.clipFinished(f59_arg0.SocialPlayersListRankInfo)
		end,
		ActiveToActiveAndFocus = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(4)
			f61_arg0.TeamColorBacking:completeAnimation()
			f61_arg0.TeamColorBacking:setAlpha(0.2)
			f61_arg0.clipFinished(f61_arg0.TeamColorBacking)
			local f61_local0 = function(f62_arg0)
				f61_arg0.OnOffBacking:beginAnimation(100)
				f61_arg0.OnOffBacking:setRGB(1, 1, 1)
				f61_arg0.OnOffBacking:setAlpha(0.7)
				f61_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.OnOffBacking:completeAnimation()
			f61_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
			f61_arg0.OnOffBacking:setAlpha(0.5)
			f61_local0(f61_arg0.OnOffBacking)
			f61_arg0.emblem:completeAnimation()
			f61_arg0.emblem:setAlpha(0.5)
			f61_arg0.clipFinished(f61_arg0.emblem)
			f61_arg0.membername:completeAnimation()
			f61_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f61_arg0.membername:setAlpha(0.5)
			f61_arg0.clipFinished(f61_arg0.membername)
			f61_arg0.SocialPlayersListRankInfo:completeAnimation()
			f61_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f61_arg0.clipFinished(f61_arg0.SocialPlayersListRankInfo)
		end,
	},
	LeaderboardsChecked = {
		DefaultClip = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(2)
			f63_arg0.TeamColorBacking:completeAnimation()
			f63_arg0.TeamColorBacking:setAlpha(0.5)
			f63_arg0.clipFinished(f63_arg0.TeamColorBacking)
			local f63_local0 = function(f64_arg0)
				f63_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f63_arg0.OnOffBacking:setAlpha(0.25)
				f63_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
				f63_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
			end
			f63_arg0.OnOffBacking:completeAnimation()
			f63_arg0.OnOffBacking:setAlpha(0.5)
			f63_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f63_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f63_local0(f63_arg0.OnOffBacking)
			f63_arg0.joinable:completeAnimation()
			f63_arg0.joinable:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.joinable)
		end,
		Focus = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(2)
			f65_arg0.TeamColorBacking:completeAnimation()
			f65_arg0.TeamColorBacking:setAlpha(0.5)
			f65_arg0.clipFinished(f65_arg0.TeamColorBacking)
			local f65_local0 = function(f66_arg0)
				f65_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f65_arg0.OnOffBacking:setAlpha(0.5)
				f65_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
				f65_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.OnOffBacking:completeAnimation()
			f65_arg0.OnOffBacking:setAlpha(0.25)
			f65_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f65_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
			f65_local0(f65_arg0.OnOffBacking)
		end,
	},
	LeaderboardsUncheckable = {
		DefaultClip = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(0)
			f67_arg0.joinable:completeAnimation()
			f67_arg0.joinable:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.joinable)
		end,
	},
	LeaderboardsUnchecked = {
		DefaultClip = function(f68_arg0, f68_arg1)
			f68_arg0:__resetProperties()
			f68_arg0:setupElementClipCounter(2)
			f68_arg0.TeamColorBacking:completeAnimation()
			f68_arg0.TeamColorBacking:setAlpha(0.5)
			f68_arg0.clipFinished(f68_arg0.TeamColorBacking)
			local f68_local0 = function(f69_arg0)
				f68_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f68_arg0.OnOffBacking:setAlpha(0.25)
				f68_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
				f68_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
			end
			f68_arg0.OnOffBacking:completeAnimation()
			f68_arg0.OnOffBacking:setAlpha(0.5)
			f68_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f68_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f68_local0(f68_arg0.OnOffBacking)
			f68_arg0.joinable:completeAnimation()
			f68_arg0.joinable:setAlpha(0)
			f68_arg0.clipFinished(f68_arg0.joinable)
		end,
		Focus = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(2)
			f70_arg0.TeamColorBacking:completeAnimation()
			f70_arg0.TeamColorBacking:setAlpha(0.5)
			f70_arg0.clipFinished(f70_arg0.TeamColorBacking)
			local f70_local0 = function(f71_arg0)
				f70_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f70_arg0.OnOffBacking:setAlpha(0.5)
				f70_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
				f70_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.OnOffBacking:completeAnimation()
			f70_arg0.OnOffBacking:setAlpha(0.25)
			f70_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f70_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
			f70_local0(f70_arg0.OnOffBacking)
		end,
	},
	OnlinePC = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(2)
			f72_arg0.TeamColorBacking:completeAnimation()
			f72_arg0.TeamColorBacking:setAlpha(0.5)
			f72_arg0.clipFinished(f72_arg0.TeamColorBacking)
			f72_arg0.OnOffBacking:completeAnimation()
			f72_arg0.OnOffBacking:setAlpha(0.25)
			f72_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f72_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
			f72_arg0.clipFinished(f72_arg0.OnOffBacking)
		end,
		Focus = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(2)
			f73_arg0.TeamColorBacking:completeAnimation()
			f73_arg0.TeamColorBacking:setAlpha(0.5)
			f73_arg0.clipFinished(f73_arg0.TeamColorBacking)
			f73_arg0.OnOffBacking:completeAnimation()
			f73_arg0.OnOffBacking:setAlpha(0.5)
			f73_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f73_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f73_arg0.clipFinished(f73_arg0.OnOffBacking)
		end,
		LoseFocus = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(2)
			f74_arg0.TeamColorBacking:completeAnimation()
			f74_arg0.TeamColorBacking:setAlpha(0.5)
			f74_arg0.clipFinished(f74_arg0.TeamColorBacking)
			local f74_local0 = function(f75_arg0)
				f74_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f74_arg0.OnOffBacking:setAlpha(0.25)
				f74_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
				f74_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
			end
			f74_arg0.OnOffBacking:completeAnimation()
			f74_arg0.OnOffBacking:setAlpha(0.5)
			f74_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f74_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f74_local0(f74_arg0.OnOffBacking)
		end,
		GainFocus = function(f76_arg0, f76_arg1)
			f76_arg0:__resetProperties()
			f76_arg0:setupElementClipCounter(2)
			f76_arg0.TeamColorBacking:completeAnimation()
			f76_arg0.TeamColorBacking:setAlpha(0.5)
			f76_arg0.clipFinished(f76_arg0.TeamColorBacking)
			local f76_local0 = function(f77_arg0)
				f76_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f76_arg0.OnOffBacking:setAlpha(0.5)
				f76_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
				f76_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f76_arg0.clipInterrupted)
				f76_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f76_arg0.clipFinished)
			end
			f76_arg0.OnOffBacking:completeAnimation()
			f76_arg0.OnOffBacking:setAlpha(0.25)
			f76_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f76_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
			f76_local0(f76_arg0.OnOffBacking)
		end,
		ActiveAndFocus = function(f78_arg0, f78_arg1)
			f78_arg0:__resetProperties()
			f78_arg0:setupElementClipCounter(2)
			f78_arg0.TeamColorBacking:completeAnimation()
			f78_arg0.TeamColorBacking:setAlpha(0.5)
			f78_arg0.clipFinished(f78_arg0.TeamColorBacking)
			f78_arg0.OnOffBacking:completeAnimation()
			f78_arg0.OnOffBacking:setAlpha(0.7)
			f78_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f78_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f78_arg0.clipFinished(f78_arg0.OnOffBacking)
		end,
		GainActiveAndFocus = function(f79_arg0, f79_arg1)
			f79_arg0:__resetProperties()
			f79_arg0:setupElementClipCounter(2)
			f79_arg0.TeamColorBacking:completeAnimation()
			f79_arg0.TeamColorBacking:setAlpha(0.5)
			f79_arg0.clipFinished(f79_arg0.TeamColorBacking)
			local f79_local0 = function(f80_arg0)
				f79_arg0.OnOffBacking:beginAnimation(100)
				f79_arg0.OnOffBacking:setAlpha(0.7)
				f79_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
			end
			f79_arg0.OnOffBacking:completeAnimation()
			f79_arg0.OnOffBacking:setAlpha(0.5)
			f79_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f79_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f79_local0(f79_arg0.OnOffBacking)
		end,
		Active = function(f81_arg0, f81_arg1)
			f81_arg0:__resetProperties()
			f81_arg0:setupElementClipCounter(2)
			f81_arg0.TeamColorBacking:completeAnimation()
			f81_arg0.TeamColorBacking:setAlpha(0.5)
			f81_arg0.clipFinished(f81_arg0.TeamColorBacking)
			f81_arg0.OnOffBacking:completeAnimation()
			f81_arg0.OnOffBacking:setAlpha(0.5)
			f81_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f81_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f81_arg0.clipFinished(f81_arg0.OnOffBacking)
		end,
		LoseActive = function(f82_arg0, f82_arg1)
			f82_arg0:__resetProperties()
			f82_arg0:setupElementClipCounter(2)
			f82_arg0.TeamColorBacking:completeAnimation()
			f82_arg0.TeamColorBacking:setAlpha(0.5)
			f82_arg0.clipFinished(f82_arg0.TeamColorBacking)
			local f82_local0 = function(f83_arg0)
				f82_arg0.OnOffBacking:beginAnimation(100)
				f82_arg0.OnOffBacking:setAlpha(0.25)
				f82_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
				f82_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f82_arg0.clipInterrupted)
				f82_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f82_arg0.clipFinished)
			end
			f82_arg0.OnOffBacking:completeAnimation()
			f82_arg0.OnOffBacking:setAlpha(0.5)
			f82_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f82_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f82_local0(f82_arg0.OnOffBacking)
		end,
		ActiveAndFocusToActive = function(f84_arg0, f84_arg1)
			f84_arg0:__resetProperties()
			f84_arg0:setupElementClipCounter(2)
			local f84_local0 = function(f85_arg0)
				f84_arg0.TeamColorBacking:beginAnimation(100)
				f84_arg0.TeamColorBacking:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.TeamColorBacking:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
			end
			f84_arg0.TeamColorBacking:completeAnimation()
			f84_arg0.TeamColorBacking:setAlpha(0.5)
			f84_local0(f84_arg0.TeamColorBacking)
			local f84_local1 = function(f86_arg0)
				f84_arg0.OnOffBacking:beginAnimation(100)
				f84_arg0.OnOffBacking:setAlpha(0.5)
				f84_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
			end
			f84_arg0.OnOffBacking:completeAnimation()
			f84_arg0.OnOffBacking:setAlpha(0.7)
			f84_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f84_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f84_local1(f84_arg0.OnOffBacking)
		end,
		ActiveToActiveAndFocus = function(f87_arg0, f87_arg1)
			f87_arg0:__resetProperties()
			f87_arg0:setupElementClipCounter(2)
			local f87_local0 = function(f88_arg0)
				f87_arg0.TeamColorBacking:beginAnimation(100)
				f87_arg0.TeamColorBacking:registerEventHandler("interrupted_keyframe", f87_arg0.clipInterrupted)
				f87_arg0.TeamColorBacking:registerEventHandler("transition_complete_keyframe", f87_arg0.clipFinished)
			end
			f87_arg0.TeamColorBacking:completeAnimation()
			f87_arg0.TeamColorBacking:setAlpha(0.5)
			f87_local0(f87_arg0.TeamColorBacking)
			local f87_local1 = function(f89_arg0)
				f87_arg0.OnOffBacking:beginAnimation(100)
				f87_arg0.OnOffBacking:setAlpha(0.7)
				f87_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f87_arg0.clipInterrupted)
				f87_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f87_arg0.clipFinished)
			end
			f87_arg0.OnOffBacking:completeAnimation()
			f87_arg0.OnOffBacking:setAlpha(0.5)
			f87_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f87_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f87_local1(f87_arg0.OnOffBacking)
		end,
		LoseActiveAndFocus = function(f90_arg0, f90_arg1)
			f90_arg0:__resetProperties()
			f90_arg0:setupElementClipCounter(2)
			local f90_local0 = function(f91_arg0)
				f90_arg0.TeamColorBacking:beginAnimation(100)
				f90_arg0.TeamColorBacking:registerEventHandler("interrupted_keyframe", f90_arg0.clipInterrupted)
				f90_arg0.TeamColorBacking:registerEventHandler("transition_complete_keyframe", f90_arg0.clipFinished)
			end
			f90_arg0.TeamColorBacking:completeAnimation()
			f90_arg0.TeamColorBacking:setAlpha(0.5)
			f90_local0(f90_arg0.TeamColorBacking)
			local f90_local1 = function(f92_arg0)
				f90_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f90_arg0.OnOffBacking:setAlpha(0.5)
				f90_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f90_arg0.clipInterrupted)
				f90_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f90_arg0.clipFinished)
			end
			f90_arg0.OnOffBacking:completeAnimation()
			f90_arg0.OnOffBacking:setAlpha(0.7)
			f90_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f90_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f90_local1(f90_arg0.OnOffBacking)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f93_arg0, f93_arg1)
			f93_arg0:__resetProperties()
			f93_arg0:setupElementClipCounter(8)
			f93_arg0.TeamColorBacking:completeAnimation()
			f93_arg0.TeamColorBacking:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.TeamColorBacking)
			f93_arg0.Border:completeAnimation()
			f93_arg0.Border:setAlpha(0.7)
			f93_arg0.clipFinished(f93_arg0.Border)
			f93_arg0.emblemBg:completeAnimation()
			f93_arg0.emblemBg:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.emblemBg)
			f93_arg0.rankicon:completeAnimation()
			f93_arg0.rankicon:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.rankicon)
			f93_arg0.emblem:completeAnimation()
			f93_arg0.emblem:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.emblem)
			f93_arg0.membername:completeAnimation()
			f93_arg0.membername:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.membername)
			f93_arg0.joinable:completeAnimation()
			f93_arg0.joinable:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.joinable)
			f93_arg0.SocialPartyMemberIconLarge0:completeAnimation()
			f93_arg0.SocialPartyMemberIconLarge0:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.SocialPartyMemberIconLarge0)
			f93_arg0.Plus:completeAnimation()
			f93_arg0.Plus:setAlpha(0.7)
			f93_arg0.clipFinished(f93_arg0.Plus)
			f93_arg0.SocialPlayersListRankInfo:completeAnimation()
			f93_arg0.SocialPlayersListRankInfo:setAlpha(0)
			f93_arg0.clipFinished(f93_arg0.SocialPlayersListRankInfo)
		end,
		Focus = function(f94_arg0, f94_arg1)
			f94_arg0:__resetProperties()
			f94_arg0:setupElementClipCounter(7)
			f94_arg0.TeamColorBacking:completeAnimation()
			f94_arg0.TeamColorBacking:setAlpha(0)
			f94_arg0.clipFinished(f94_arg0.TeamColorBacking)
			f94_arg0.Border:completeAnimation()
			f94_arg0.Border:setAlpha(1)
			f94_arg0.clipFinished(f94_arg0.Border)
			f94_arg0.emblemBg:completeAnimation()
			f94_arg0.emblemBg:setAlpha(0)
			f94_arg0.clipFinished(f94_arg0.emblemBg)
			f94_arg0.rankicon:completeAnimation()
			f94_arg0.rankicon:setAlpha(0)
			f94_arg0.clipFinished(f94_arg0.rankicon)
			f94_arg0.emblem:completeAnimation()
			f94_arg0.emblem:setAlpha(0)
			f94_arg0.clipFinished(f94_arg0.emblem)
			f94_arg0.membername:completeAnimation()
			f94_arg0.membername:setAlpha(0)
			f94_arg0.clipFinished(f94_arg0.membername)
			f94_arg0.Plus:completeAnimation()
			f94_arg0.Plus:setAlpha(1)
			f94_arg0.clipFinished(f94_arg0.Plus)
			f94_arg0.SocialPlayersListRankInfo:completeAnimation()
			f94_arg0.SocialPlayersListRankInfo:setAlpha(0)
			f94_arg0.clipFinished(f94_arg0.SocialPlayersListRankInfo)
		end,
	},
	Empty = {
		DefaultClip = function(f95_arg0, f95_arg1)
			f95_arg0:__resetProperties()
			f95_arg0:setupElementClipCounter(6)
			f95_arg0.TeamColorBacking:completeAnimation()
			f95_arg0.TeamColorBacking:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.TeamColorBacking)
			f95_arg0.emblemBg:completeAnimation()
			f95_arg0.emblemBg:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.emblemBg)
			f95_arg0.rankicon:completeAnimation()
			f95_arg0.rankicon:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.rankicon)
			f95_arg0.emblem:completeAnimation()
			f95_arg0.emblem:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.emblem)
			f95_arg0.membername:completeAnimation()
			f95_arg0.membername:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.membername)
			f95_arg0.joinable:completeAnimation()
			f95_arg0.joinable:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.joinable)
			f95_arg0.SocialPartyMemberIconLarge0:completeAnimation()
			f95_arg0.SocialPartyMemberIconLarge0:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.SocialPartyMemberIconLarge0)
			f95_arg0.SocialPlayersListRankInfo:completeAnimation()
			f95_arg0.SocialPlayersListRankInfo:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.SocialPlayersListRankInfo)
		end,
	},
	Offline = {
		DefaultClip = function(f96_arg0, f96_arg1)
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter(4)
			f96_arg0.TeamColorBacking:completeAnimation()
			f96_arg0.TeamColorBacking:setAlpha(0.2)
			f96_arg0.clipFinished(f96_arg0.TeamColorBacking)
			f96_arg0.OnOffBacking:completeAnimation()
			f96_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
			f96_arg0.OnOffBacking:setAlpha(0.5)
			f96_arg0.clipFinished(f96_arg0.OnOffBacking)
			f96_arg0.emblem:completeAnimation()
			f96_arg0.emblem:setAlpha(0.5)
			f96_arg0.clipFinished(f96_arg0.emblem)
			f96_arg0.membername:completeAnimation()
			f96_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f96_arg0.membername:setAlpha(0.2)
			f96_arg0.clipFinished(f96_arg0.membername)
			f96_arg0.SocialPlayersListRankInfo:completeAnimation()
			f96_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f96_arg0.clipFinished(f96_arg0.SocialPlayersListRankInfo)
		end,
		Focus = function(f97_arg0, f97_arg1)
			f97_arg0:__resetProperties()
			f97_arg0:setupElementClipCounter(4)
			f97_arg0.TeamColorBacking:completeAnimation()
			f97_arg0.TeamColorBacking:setAlpha(0.2)
			f97_arg0.clipFinished(f97_arg0.TeamColorBacking)
			f97_arg0.OnOffBacking:completeAnimation()
			f97_arg0.OnOffBacking:setRGB(0.56, 0.56, 0.56)
			f97_arg0.OnOffBacking:setAlpha(1)
			f97_arg0.clipFinished(f97_arg0.OnOffBacking)
			f97_arg0.emblem:completeAnimation()
			f97_arg0.emblem:setAlpha(0.5)
			f97_arg0.clipFinished(f97_arg0.emblem)
			f97_arg0.membername:completeAnimation()
			f97_arg0.membername:setRGB(0.53, 0.53, 0.53)
			f97_arg0.membername:setAlpha(0.5)
			f97_arg0.clipFinished(f97_arg0.membername)
			f97_arg0.SocialPlayersListRankInfo:completeAnimation()
			f97_arg0.SocialPlayersListRankInfo:setAlpha(0.5)
			f97_arg0.clipFinished(f97_arg0.SocialPlayersListRankInfo)
		end,
	},
	OnlineButNotOurGame = {
		DefaultClip = function(f98_arg0, f98_arg1)
			f98_arg0:__resetProperties()
			f98_arg0:setupElementClipCounter(3)
			f98_arg0.TeamColorBacking:completeAnimation()
			f98_arg0.TeamColorBacking:setAlpha(0.2)
			f98_arg0.clipFinished(f98_arg0.TeamColorBacking)
			f98_arg0.OnOffBacking:completeAnimation()
			f98_arg0.OnOffBacking:setAlpha(0.12)
			f98_arg0.clipFinished(f98_arg0.OnOffBacking)
			f98_arg0.emblem:completeAnimation()
			f98_arg0.emblem:setAlpha(0.2)
			f98_arg0.clipFinished(f98_arg0.emblem)
			f98_arg0.membername:completeAnimation()
			f98_arg0.membername:setAlpha(0.6)
			f98_arg0.clipFinished(f98_arg0.membername)
		end,
		Focus = function(f99_arg0, f99_arg1)
			f99_arg0:__resetProperties()
			f99_arg0:setupElementClipCounter(3)
			f99_arg0.TeamColorBacking:completeAnimation()
			f99_arg0.TeamColorBacking:setAlpha(0.2)
			f99_arg0.clipFinished(f99_arg0.TeamColorBacking)
			f99_arg0.OnOffBacking:completeAnimation()
			f99_arg0.OnOffBacking:setAlpha(0.5)
			f99_arg0.OnOffBacking:setShaderVector(0, 1.5, 0, 0, 0)
			f99_arg0.clipFinished(f99_arg0.OnOffBacking)
			f99_arg0.emblem:completeAnimation()
			f99_arg0.emblem:setAlpha(0.5)
			f99_arg0.clipFinished(f99_arg0.emblem)
			f99_arg0.membername:completeAnimation()
			f99_arg0.membername:setAlpha(0.75)
			f99_arg0.clipFinished(f99_arg0.membername)
		end,
	},
	Online = {
		DefaultClip = function(f100_arg0, f100_arg1)
			f100_arg0:__resetProperties()
			f100_arg0:setupElementClipCounter(2)
			f100_arg0.TeamColorBacking:completeAnimation()
			f100_arg0.TeamColorBacking:setAlpha(0.5)
			f100_arg0.clipFinished(f100_arg0.TeamColorBacking)
			local f100_local0 = function(f101_arg0)
				f100_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f100_arg0.OnOffBacking:setAlpha(0.25)
				f100_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
				f100_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
			end
			f100_arg0.OnOffBacking:completeAnimation()
			f100_arg0.OnOffBacking:setAlpha(0.5)
			f100_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f100_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
			f100_local0(f100_arg0.OnOffBacking)
		end,
		Focus = function(f102_arg0, f102_arg1)
			f102_arg0:__resetProperties()
			f102_arg0:setupElementClipCounter(2)
			f102_arg0.TeamColorBacking:completeAnimation()
			f102_arg0.TeamColorBacking:setAlpha(0.5)
			f102_arg0.clipFinished(f102_arg0.TeamColorBacking)
			local f102_local0 = function(f103_arg0)
				f102_arg0.OnOffBacking:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f102_arg0.OnOffBacking:setAlpha(0.5)
				f102_arg0.OnOffBacking:setShaderVector(0, 2, 0, 0, 0)
				f102_arg0.OnOffBacking:registerEventHandler("interrupted_keyframe", f102_arg0.clipInterrupted)
				f102_arg0.OnOffBacking:registerEventHandler("transition_complete_keyframe", f102_arg0.clipFinished)
			end
			f102_arg0.OnOffBacking:completeAnimation()
			f102_arg0.OnOffBacking:setAlpha(0.25)
			f102_arg0.OnOffBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f102_arg0.OnOffBacking:setShaderVector(0, 1, 0, 0, 0)
			f102_local0(f102_arg0.OnOffBacking)
		end,
	},
}
CoD.Social_PlayersListButtonShared.__onClose = function(f104_arg0)
	f104_arg0.TeamColorBacking:close()
	f104_arg0.rankicon:close()
	f104_arg0.emblem:close()
	f104_arg0.membername:close()
	f104_arg0.joinable:close()
	f104_arg0.trial:close()
	f104_arg0.SocialPartyMemberIconLarge0:close()
	f104_arg0.SocialPlayersListRankInfo:close()
	f104_arg0.membernamePC:close()
end
