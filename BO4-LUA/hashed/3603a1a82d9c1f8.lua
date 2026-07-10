require("x64:29187ea00d726c3")
CoD.Prestige_LevelProgress_Rank = InheritFrom(LUI.UIElement)
CoD.Prestige_LevelProgress_Rank.__defaultWidth = 554
CoD.Prestige_LevelProgress_Rank.__defaultHeight = 25
CoD.Prestige_LevelProgress_Rank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.Prestige_LevelProgress_Rank)
	self.id = "Prestige_LevelProgress_Rank"
	self.soundSet = "default"
	local RankName = LUI.UIText.new(0, 0, 0, 277, 0, 0, 0, 25)
	RankName:setRGB(0.92, 0.92, 0.92)
	RankName:setAlpha(0.5)
	RankName:setTTF("ttmussels_demibold")
	RankName:setLetterSpacing(2)
	RankName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RankName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	RankName:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RankName:setText(ToUpper(CoD.PrestigeUtility.GetPrestigeMenuRankTitle(f1_arg0, f2_local0)))
		end
	end)
	self:addElement(RankName)
	self.RankName = RankName
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0.5, 0.5, 4, 28, 0, 0, 0, 25)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local RankTitle = LUI.UIText.new(0, 0, 309, 586, 0, 0, 0, 25)
	RankTitle:setRGB(0.92, 0.92, 0.92)
	RankTitle:setAlpha(0.5)
	RankTitle:setTTF("ttmussels_demibold")
	RankTitle:setLetterSpacing(2)
	RankTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RankTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	RankTitle:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RankTitle:setText(CoD.PlayerStatsUtility.GetLevelString(f1_arg0, f3_local0))
		end
	end)
	self:addElement(RankTitle)
	self.RankTitle = RankTitle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_LevelProgress_Rank.__onClose = function(f4_arg0)
	f4_arg0.RankName:close()
	f4_arg0.VerticalListSpacer3:close()
	f4_arg0.RankTitle:close()
end
