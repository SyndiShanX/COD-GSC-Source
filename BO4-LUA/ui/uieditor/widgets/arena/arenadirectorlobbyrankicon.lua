CoD.ArenaDirectorLobbyRankIcon = InheritFrom(LUI.UIElement)
CoD.ArenaDirectorLobbyRankIcon.__defaultWidth = 44
CoD.ArenaDirectorLobbyRankIcon.__defaultHeight = 44
CoD.ArenaDirectorLobbyRankIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaDirectorLobbyRankIcon)
	self.id = "ArenaDirectorLobbyRankIcon"
	self.soundSet = "none"
	local fireStreak = LUI.UIImage.new(0, 0, -20, 64, 0, 0, -20, 64)
	fireStreak:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	fireStreak:setShaderVector(0, 4, 4, 0, 0)
	fireStreak:setShaderVector(1, 8, 0, 0, 0)
	fireStreak:linkToElementModel(self, "xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			fireStreak:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetPlayerFireStreak(f2_local0)))
		end
	end)
	self:addElement(fireStreak)
	self.fireStreak = fireStreak
	local LeagueRankIcon = LUI.UIImage.new(0, 0, 0, 44, 0, 0, 0, 44)
	LeagueRankIcon.__Image = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			LeagueRankIcon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSmallRankIconFromXuid(f3_local0)))
		end
	end
	LeagueRankIcon:linkToElementModel(self, "xuid", true, LeagueRankIcon.__Image)
	LeagueRankIcon.__Image_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.xuid
		end
		if f4_local0 then
			LeagueRankIcon.__Image(f4_local0)
		end
	end
	self:addElement(LeagueRankIcon)
	self.LeagueRankIcon = LeagueRankIcon
	local f1_local3 = LeagueRankIcon
	local f1_local4 = LeagueRankIcon.subscribeToModel
	local f1_local5 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.lobbyNav, LeagueRankIcon.__Image_FullPath)
	f1_local3 = LeagueRankIcon
	f1_local4 = LeagueRankIcon.subscribeToModel
	f1_local5 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5["privateClient.update"], LeagueRankIcon.__Image_FullPath)
	f1_local3 = LeagueRankIcon
	f1_local4 = LeagueRankIcon.subscribeToModel
	f1_local5 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5["gameClient.update"], LeagueRankIcon.__Image_FullPath)
	f1_local3 = LeagueRankIcon
	f1_local4 = LeagueRankIcon.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["PartyPrivacy.privacy"], LeagueRankIcon.__Image_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaDirectorLobbyRankIcon.__onClose = function(f5_arg0)
	f5_arg0.fireStreak:close()
	f5_arg0.LeagueRankIcon:close()
end
