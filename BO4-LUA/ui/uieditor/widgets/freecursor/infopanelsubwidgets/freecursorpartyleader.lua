CoD.freeCursorPartyLeader = InheritFrom(LUI.UIElement)
CoD.freeCursorPartyLeader.__defaultWidth = 369
CoD.freeCursorPartyLeader.__defaultHeight = 24
CoD.freeCursorPartyLeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorPartyLeader)
	self.id = "freeCursorPartyLeader"
	self.soundSet = "default"
	local LeaderBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -12, 12)
	LeaderBacking2:setRGB(ColorSet.PartyFriendlyBlue.r, ColorSet.PartyFriendlyBlue.g, ColorSet.PartyFriendlyBlue.b)
	self:addElement(LeaderBacking2)
	self.LeaderBacking2 = LeaderBacking2
	local PartyLeaderStar = LUI.UIImage.new(0.5, 0.5, -182, -170, 0, 0, 5, 17)
	PartyLeaderStar:setImage(RegisterImage(@"menu_mp_weapon_lvl_star"))
	self:addElement(PartyLeaderStar)
	self.PartyLeaderStar = PartyLeaderStar
	local PartyLeaderText = LUI.UIText.new(0, 0, 17.5, 217.5, 0, 0, -1, 23)
	PartyLeaderText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7E45EC82F587BDD1"))
	PartyLeaderText:setTTF("default")
	PartyLeaderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PartyLeaderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PartyLeaderText)
	self.PartyLeaderText = PartyLeaderText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
