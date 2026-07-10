CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle = InheritFrom(LUI.UIElement)
CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle.__defaultWidth = 666
CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle.__defaultHeight = 18
CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle)
	self.id = "ArenaLeaguePlay_LadderSkillDivisionSubTitle"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Subdivision = LUI.UIText.new(0, 0, 0, 666, 1, 1, -18, 0)
	Subdivision:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Subdivision:setAlpha(0.5)
	Subdivision:setTTF("ttmussels_regular")
	Subdivision:setLetterSpacing(4)
	Subdivision:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Subdivision:subscribeToGlobalModel(f1_arg1, "LeaguePlayLadder", "leagueNameCode", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Subdivision:setText(LocalizeToUpperString(LocalizeIntoString(0xFB7575B725F90E9, CoD.ArenaLeaguePlayUtility.ConvertLadderNameCode(f2_local0))))
		end
	end)
	self:addElement(Subdivision)
	self.Subdivision = Subdivision
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle.__resetProperties = function(f4_arg0)
	f4_arg0.Subdivision:completeAnimation()
	f4_arg0.Subdivision:setLeftRight(0, 0, 0, 666)
	f4_arg0.Subdivision:setTopBottom(1, 1, -18, 0)
end
CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Subdivision:completeAnimation()
			f6_arg0.Subdivision:setLeftRight(0, 0, -3, 663)
			f6_arg0.Subdivision:setTopBottom(1, 1, -12, 0)
			f6_arg0.clipFinished(f6_arg0.Subdivision)
		end,
	},
}
CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle.__onClose = function(f7_arg0)
	f7_arg0.Subdivision:close()
end
