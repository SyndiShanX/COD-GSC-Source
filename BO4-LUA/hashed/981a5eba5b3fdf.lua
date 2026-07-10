require("x64:8e42b7d307aadbf")
require("x64:62adff09117f331")
CoD.ButtonFrame_WorldLeagueProgress = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_WorldLeagueProgress.__defaultWidth = 647
CoD.ButtonFrame_WorldLeagueProgress.__defaultHeight = 381
CoD.ButtonFrame_WorldLeagueProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_WorldLeagueProgress)
	self.id = "ButtonFrame_WorldLeagueProgress"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local ArenaRankWidget = CoD.ArenaRankWidget.new(f1_arg0, f1_arg1, 0, 0, 117.5, 373.5, 0, 0, 81.5, 337.5)
	ArenaRankWidget:subscribeToGlobalModel(f1_arg1, "LeaguePlay", nil, function(model)
		ArenaRankWidget:setModel(model, f1_arg1)
	end)
	ArenaRankWidget:linkToElementModel(self, "leaguePlayFirestreakIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ArenaRankWidget.ArenaRankWidgetInternal.FireStreakIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(ArenaRankWidget)
	self.ArenaRankWidget = ArenaRankWidget
	local RankNumber = LUI.UIText.new(0.5, 0.5, 6, 206, 0, 0, 86.5, 116.5)
	RankNumber:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	RankNumber:setText(LocalizeToUpperString(0x3370355189B42A7))
	RankNumber:setTTF("ttmussels_regular")
	RankNumber:setLetterSpacing(4)
	RankNumber:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RankNumber:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(RankNumber)
	self.RankNumber = RankNumber
	local RankText = LUI.UIText.new(0.5, 0.5, 36, 176, 0.5, 0.5, -60, 60)
	RankText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	RankText:setTTF("0arame_mono_stencil")
	RankText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RankText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RankText:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayRank", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RankText:setText(f4_local0)
		end
	end)
	self:addElement(RankText)
	self.RankText = RankText
	local ArenaRubies = CoD.ArenaRubies.new(f1_arg0, f1_arg1, 0.5, 0.5, 36, 176, 0, 0, 258.5, 332.5)
	self:addElement(ArenaRubies)
	self.ArenaRubies = ArenaRubies
	local DivisionSkillIcon = LUI.UIImage.new(0, 0, 125.5, 365.5, 0, 0, 89.5, 329.5)
	DivisionSkillIcon:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlaySkillDivisionBannerLarge", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DivisionSkillIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(DivisionSkillIcon)
	self.DivisionSkillIcon = DivisionSkillIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_WorldLeagueProgress.__onClose = function(f6_arg0)
	f6_arg0.ArenaRankWidget:close()
	f6_arg0.RankText:close()
	f6_arg0.ArenaRubies:close()
	f6_arg0.DivisionSkillIcon:close()
end
