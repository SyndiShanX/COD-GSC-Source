CoD.ArenaLeaguePlay_LadderSkillDivisionTitle = InheritFrom(LUI.UIElement)
CoD.ArenaLeaguePlay_LadderSkillDivisionTitle.__defaultWidth = 669
CoD.ArenaLeaguePlay_LadderSkillDivisionTitle.__defaultHeight = 52
CoD.ArenaLeaguePlay_LadderSkillDivisionTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaLeaguePlay_LadderSkillDivisionTitle)
	self.id = "ArenaLeaguePlay_LadderSkillDivisionTitle"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SkillDivisionString = LUI.UIText.new(0, 0, 0, 669, 0, 0, 0, 50)
	SkillDivisionString:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	SkillDivisionString:setTTF("ttmussels_demibold")
	SkillDivisionString:setLetterSpacing(6)
	SkillDivisionString:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SkillDivisionString:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SkillDivisionString:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlaySkillDivisionName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SkillDivisionString:setText(LocalizeToUpperString(LocalizeHash(f2_local0)))
		end
	end)
	self:addElement(SkillDivisionString)
	self.SkillDivisionString = SkillDivisionString
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
CoD.ArenaLeaguePlay_LadderSkillDivisionTitle.__resetProperties = function(f4_arg0)
	f4_arg0.SkillDivisionString:completeAnimation()
	f4_arg0.SkillDivisionString:setTopBottom(0, 0, 0, 50)
end
CoD.ArenaLeaguePlay_LadderSkillDivisionTitle.__clipsPerState = {
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
			f6_arg0.SkillDivisionString:completeAnimation()
			f6_arg0.SkillDivisionString:setTopBottom(0, 0, 7, 45)
			f6_arg0.clipFinished(f6_arg0.SkillDivisionString)
		end,
	},
}
CoD.ArenaLeaguePlay_LadderSkillDivisionTitle.__onClose = function(f7_arg0)
	f7_arg0.SkillDivisionString:close()
end
