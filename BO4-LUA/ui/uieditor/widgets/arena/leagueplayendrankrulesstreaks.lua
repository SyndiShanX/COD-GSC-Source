CoD.leaguePlayEndRankRulesStreaks = InheritFrom(LUI.UIElement)
CoD.leaguePlayEndRankRulesStreaks.__defaultWidth = 150
CoD.leaguePlayEndRankRulesStreaks.__defaultHeight = 182
CoD.leaguePlayEndRankRulesStreaks.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.leaguePlayEndRankRulesStreaks)
	self.id = "leaguePlayEndRankRulesStreaks"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FireStreakIcon = LUI.UIImage.new(0, 0, -181, 331, 0, 0, -181, 331)
	FireStreakIcon:setScale(0.46, 0.46)
	FireStreakIcon:setImage(RegisterImage(0x39CD2A8412A4F6))
	FireStreakIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	FireStreakIcon:setShaderVector(0, 4, 4, 0, 0)
	FireStreakIcon:setShaderVector(1, 8, 0, 0, 0)
	self:addElement(FireStreakIcon)
	self.FireStreakIcon = FireStreakIcon
	local StreakIcon = LUI.UIImage.new(0, 0, 0, 150, 0, 0, 0, 150)
	StreakIcon:setImage(RegisterImage(0x7FDAA868DA4CB7))
	self:addElement(StreakIcon)
	self.StreakIcon = StreakIcon
	local FirstWin = LUI.UIText.new(0, 0, 2.5, 147.5, 0, 0, 139.5, 160.5)
	FirstWin:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FirstWin:setText(Engine[0xF9F1239CFD921FE](0x1077F3C2B4F6F3C))
	FirstWin:setTTF("ttmussels_demibold")
	FirstWin:setLetterSpacing(1)
	FirstWin:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	FirstWin:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(FirstWin)
	self.FirstWin = FirstWin
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.leaguePlayEndRankRulesStreaks.__resetProperties = function(f3_arg0)
	f3_arg0.FirstWin:completeAnimation()
	f3_arg0.FirstWin:setTopBottom(0, 0, 139.5, 160.5)
end
CoD.leaguePlayEndRankRulesStreaks.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.FirstWin:completeAnimation()
			f5_arg0.FirstWin:setTopBottom(0, 0, 144, 158)
			f5_arg0.clipFinished(f5_arg0.FirstWin)
		end,
	},
}
