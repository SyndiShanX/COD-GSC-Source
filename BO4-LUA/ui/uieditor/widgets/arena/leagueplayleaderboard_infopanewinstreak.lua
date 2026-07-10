require("x64:29187ea00d726c3")
CoD.LeaguePlayLeaderboard_InfoPaneWinStreak = InheritFrom(LUI.UIElement)
CoD.LeaguePlayLeaderboard_InfoPaneWinStreak.__defaultWidth = 327
CoD.LeaguePlayLeaderboard_InfoPaneWinStreak.__defaultHeight = 33
CoD.LeaguePlayLeaderboard_InfoPaneWinStreak.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 1, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.LeaguePlayLeaderboard_InfoPaneWinStreak)
	self.id = "LeaguePlayLeaderboard_InfoPaneWinStreak"
	self.soundSet = "default"
	local WinStreakTitle = LUI.UIText.new(0, 0, 0, 200, 0, 0, 7.5, 25.5)
	WinStreakTitle:setRGB(0.92, 0.92, 0.92)
	WinStreakTitle:setAlpha(0.5)
	WinStreakTitle:setText(LocalizeToUpperString(0x2FE120FB4927971))
	WinStreakTitle:setTTF("ttmussels_regular")
	WinStreakTitle:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	WinStreakTitle:setShaderVector(0, 1, 0, 0, 0)
	WinStreakTitle:setShaderVector(1, 0, 0, 0, 0)
	WinStreakTitle:setShaderVector(2, 0, 0, 0, 0)
	WinStreakTitle:setLetterSpacing(1)
	WinStreakTitle:setLineSpacing(1)
	WinStreakTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(WinStreakTitle)
	self.WinStreakTitle = WinStreakTitle
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 201, 226, 0, 0, 0, 33)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local WinStreak = LUI.UIText.new(0, 0, 235, 464, 0, 0, 0, 33)
	WinStreak:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	WinStreak:setTTF("0arame_mono_stencil")
	WinStreak:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WinStreak:linkToElementModel(self, "xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WinStreak:setText(CoD.ArenaLeaguePlayUtility.GetPlayerBestCurrentEventGameStreakFromXuid(f2_local0))
		end
	end)
	self:addElement(WinStreak)
	self.WinStreak = WinStreak
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayLeaderboard_InfoPaneWinStreak.__onClose = function(f3_arg0)
	f3_arg0.VerticalListSpacer:close()
	f3_arg0.WinStreak:close()
end
