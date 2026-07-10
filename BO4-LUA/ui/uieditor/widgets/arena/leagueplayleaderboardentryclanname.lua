CoD.LeaguePlayLeaderboardEntryClanName = InheritFrom(LUI.UIElement)
CoD.LeaguePlayLeaderboardEntryClanName.__defaultWidth = 363
CoD.LeaguePlayLeaderboardEntryClanName.__defaultHeight = 30
CoD.LeaguePlayLeaderboardEntryClanName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.LeaguePlayLeaderboardEntryClanName)
	self.id = "LeaguePlayLeaderboardEntryClanName"
	self.soundSet = "default"
	local ClanTag = LUI.UIText.new(0, 0, 0, 100, 0, 0, 0, 30)
	ClanTag:setAlpha(0.8)
	ClanTag:setTTF("notosans_regular")
	ClanTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ClanTag:linkToElementModel(self, "clantag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClanTag:setText(f2_local0)
		end
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	local Name = LUI.UIText.new(0, 0, 105, 468, 0, 0, 0, 30)
	Name:setAlpha(0.8)
	Name:setTTF("notosans_regular")
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Name:linkToElementModel(self, "gamertag", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(f3_local0)
		end
	end)
	self:addElement(Name)
	self.Name = Name
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayLeaderboardEntryClanName.__onClose = function(f4_arg0)
	f4_arg0.ClanTag:close()
	f4_arg0.Name:close()
end
