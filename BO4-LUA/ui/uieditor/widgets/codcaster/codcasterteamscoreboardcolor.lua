CoD.codcasterTeamscoreboardColor = InheritFrom(LUI.UIElement)
CoD.codcasterTeamscoreboardColor.__defaultWidth = 180
CoD.codcasterTeamscoreboardColor.__defaultHeight = 104
CoD.codcasterTeamscoreboardColor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcasterTeamscoreboardColor)
	self.id = "codcasterTeamscoreboardColor"
	self.soundSet = "default"
	local DarkBase = LUI.UIImage.new(0, 0, 0, 180, 0, 0, 0, 104)
	DarkBase:setAlpha(0.9)
	DarkBase:setImage(RegisterImage(@"hash_4E346B5B8A0516D3"))
	self:addElement(DarkBase)
	self.DarkBase = DarkBase
	local teamlogo = LUI.UIImage.new(0, 0, -4.5, 73.5, 0, 0, 24.5, 102.5)
	self:addElement(teamlogo)
	self.teamlogo = teamlogo
	local score = LUI.UIText.new(0, 0, 64, 176, 0, 0, 39.5, 93.5)
	score:setRGB(0, 0, 0)
	score:setAlpha(0.75)
	score:setText(999)
	score:setTTF("0arame_mono_stencil")
	score:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	score:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(score)
	self.score = score
	local score2 = LUI.UIText.new(0, 0, 68, 174, 0, 0, 39.5, 93.5)
	score2:setText(999)
	score2:setTTF("0arame_mono_stencil")
	score2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	score2:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(score2)
	self.score2 = score2
	local TeamnameShadow = LUI.UIText.new(0, 0, 10, 120, 0, 0, 8, 26)
	TeamnameShadow:setRGB(0, 0, 0)
	TeamnameShadow:setTTF("notosans_bold")
	TeamnameShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamnameShadow:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	TeamnameShadow:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionDisplayName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamnameShadow:setText(f2_local0)
		end
	end)
	self:addElement(TeamnameShadow)
	self.TeamnameShadow = TeamnameShadow
	local Teamname = LUI.UIText.new(0, 0, 10, 120, 0, 0, 7, 25)
	Teamname:setTTF("notosans_bold")
	Teamname:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Teamname:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Teamname:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionDisplayName", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Teamname:setText(f3_local0)
		end
	end)
	self:addElement(Teamname)
	self.Teamname = Teamname
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.codcasterTeamscoreboardColor.__onClose = function(f4_arg0)
	f4_arg0.TeamnameShadow:close()
	f4_arg0.Teamname:close()
end
