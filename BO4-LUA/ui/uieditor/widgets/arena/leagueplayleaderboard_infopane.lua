require("x64:f0229e4dd8ebd15")
CoD.LeaguePlayLeaderboard_InfoPane = InheritFrom(LUI.UIElement)
CoD.LeaguePlayLeaderboard_InfoPane.__defaultWidth = 1920
CoD.LeaguePlayLeaderboard_InfoPane.__defaultHeight = 1080
CoD.LeaguePlayLeaderboard_InfoPane.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ArenaUtility.InitLadderListLoadedModel(f1_arg1)
	self:setClass(CoD.LeaguePlayLeaderboard_InfoPane)
	self.id = "LeaguePlayLeaderboard_InfoPane"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaInfoWidget = CoD.ArenaInfoWidget.new(f1_arg0, f1_arg1, 0, 0, 1287, 1636, 0, 0, 268, 903)
	ArenaInfoWidget:linkToElementModel(self, "xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ArenaInfoWidget.arenaFlameStreak:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetPlayerFireStreak(f2_local0)))
		end
	end)
	ArenaInfoWidget:linkToElementModel(self, "xuid", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ArenaInfoWidget.Icon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankIconFromXuid(f3_local0)))
		end
	end)
	ArenaInfoWidget.SkillIcon.__SkillIcon_Image = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			ArenaInfoWidget.SkillIcon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSkillDivisionIconFromXuid(f4_local0)))
		end
	end
	ArenaInfoWidget:linkToElementModel(self, "xuid", true, ArenaInfoWidget.SkillIcon.__SkillIcon_Image)
	ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.xuid
		end
		if f5_local0 then
			ArenaInfoWidget.SkillIcon.__SkillIcon_Image(f5_local0)
		end
	end
	ArenaInfoWidget.Rank.__xuid = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			ArenaInfoWidget.Rank:setText(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankFromXuid(f6_local0))
		end
	end
	ArenaInfoWidget:linkToElementModel(self, "xuid", true, ArenaInfoWidget.Rank.__xuid)
	ArenaInfoWidget.Rank.__xuid_FullPath = function()
		local f7_local0 = self:getModel()
		if f7_local0 then
			f7_local0 = self:getModel()
			f7_local0 = f7_local0.xuid
		end
		if f7_local0 then
			ArenaInfoWidget.Rank.__xuid(f7_local0)
		end
	end
	ArenaInfoWidget:linkToElementModel(self, "xuid", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ArenaInfoWidget.WinStreak.WinStreak:setText(CoD.ArenaLeaguePlayUtility.GetPlayerBestCurrentEventGameStreakFromXuid(f8_local0))
		end
	end)
	ArenaInfoWidget:linkToElementModel(self, "xuid", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ArenaInfoWidget.Emblem:setupPlayerEmblemByXUID(f9_local0)
		end
	end)
	ArenaInfoWidget:linkToElementModel(self, "identityBadge", false, function(model)
		ArenaInfoWidget.CallingCard:setModel(model, f1_arg1)
	end)
	ArenaInfoWidget:linkToElementModel(self, "gamertag", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ArenaInfoWidget.Name:setText(f11_local0)
		end
	end)
	self:addElement(ArenaInfoWidget)
	self.ArenaInfoWidget = ArenaInfoWidget
	local f1_local2 = ArenaInfoWidget
	local f1_local3 = ArenaInfoWidget.subscribeToModel
	local f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.lobbyNav, ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath)
	f1_local2 = ArenaInfoWidget
	f1_local3 = ArenaInfoWidget.subscribeToModel
	f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4["privateClient.update"], ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath)
	f1_local2 = ArenaInfoWidget
	f1_local3 = ArenaInfoWidget.subscribeToModel
	f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4["gameClient.update"], ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath)
	f1_local2 = ArenaInfoWidget
	f1_local3 = ArenaInfoWidget.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["PartyPrivacy.privacy"], ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath)
	f1_local2 = ArenaInfoWidget
	f1_local3 = ArenaInfoWidget.subscribeToModel
	f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.lobbyNav, ArenaInfoWidget.Rank.__xuid_FullPath)
	f1_local2 = ArenaInfoWidget
	f1_local3 = ArenaInfoWidget.subscribeToModel
	f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4["privateClient.update"], ArenaInfoWidget.Rank.__xuid_FullPath)
	f1_local2 = ArenaInfoWidget
	f1_local3 = ArenaInfoWidget.subscribeToModel
	f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4["gameClient.update"], ArenaInfoWidget.Rank.__xuid_FullPath)
	f1_local2 = ArenaInfoWidget
	f1_local3 = ArenaInfoWidget.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["PartyPrivacy.privacy"], ArenaInfoWidget.Rank.__xuid_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LeaguePlayLadderMemberList", "allXuidInfoLoaded", true) and CoD.ModelUtility.IsGlobalDataSourceModelValueNil(f1_arg1, "LeaguePlayLadder", "leagueNameCode")
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.LeaguePlayLadderMemberList.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.allXuidInfoLoaded, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "allXuidInfoLoaded",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.LeaguePlayLadder.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.leagueNameCode, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "leagueNameCode",
		})
	end, false)
	self.__on_menuOpened_self = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = self
		CoD.ArenaLeaguePlayUtility.FillRubyList(self, self.RubiesList)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:linkToElementModel(self, "identityBadge.xuid", true, function(model)
		local f16_local0 = self
		UpdateElementState(self, "RubiesList", f1_arg1)
	end)
	ArenaInfoWidget.id = "ArenaInfoWidget"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayLeaderboard_InfoPane.__resetProperties = function(f18_arg0)
	f18_arg0.ArenaInfoWidget:completeAnimation()
	f18_arg0.ArenaInfoWidget:setAlpha(1)
end
CoD.LeaguePlayLeaderboard_InfoPane.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	Error = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.ArenaInfoWidget:completeAnimation()
			f20_arg0.ArenaInfoWidget:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ArenaInfoWidget)
		end,
	},
}
CoD.LeaguePlayLeaderboard_InfoPane.__onClose = function(f21_arg0)
	f21_arg0.__on_close_removeOverrides()
	f21_arg0.ArenaInfoWidget:close()
end
