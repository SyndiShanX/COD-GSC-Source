require("x64:8e42b7d307aadbf")
CoD.ButtonFrame_ArenaBarracksStats_Firstplace = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_ArenaBarracksStats_Firstplace.__defaultWidth = 443
CoD.ButtonFrame_ArenaBarracksStats_Firstplace.__defaultHeight = 124
CoD.ButtonFrame_ArenaBarracksStats_Firstplace.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_ArenaBarracksStats_Firstplace)
	self.id = "ButtonFrame_ArenaBarracksStats_Firstplace"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaRankWidget = CoD.ArenaRankWidget.new(f1_arg0, f1_arg1, 0, 0, 147.5, 227.5, 0, 0, 22, 102)
	ArenaRankWidget:linkToElementModel(self, nil, false, function(model)
		ArenaRankWidget:setModel(model, f1_arg1)
	end)
	ArenaRankWidget:linkToElementModel(self, "leaguePlayFirestreakIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ArenaRankWidget.ArenaRankWidgetInternal.FireStreakIcon:setImage(RegisterImage(CoD.PlayerStatsUtility.GetFirestreakIcon(f1_arg0, f3_local0)))
		end
	end)
	self:addElement(ArenaRankWidget)
	self.ArenaRankWidget = ArenaRankWidget
	local StatsValue = LUI.UIText.new(0, 0, 232, 441, 0, 0, 39.5, 84.5)
	StatsValue:setRGB(0.69, 0.56, 0.04)
	StatsValue:setText(CoD.PlayerStatsUtility.GetArenaBarracksStat(f1_arg0, 0xF1E9335197F661, 0xDC602053653B486, 5589))
	StatsValue:setTTF("ttmussels_demibold")
	StatsValue:setLetterSpacing(2)
	StatsValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StatsValue:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(StatsValue)
	self.StatsValue = StatsValue
	local FirstPlaceTitle = LUI.UIText.new(0, 0, 4, 441, 0, 0, 1, 18)
	FirstPlaceTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FirstPlaceTitle:setAlpha(0.7)
	FirstPlaceTitle:setText(Engine[0xF9F1239CFD921FE](0x4916FF71F124343))
	FirstPlaceTitle:setTTF("ttmussels_regular")
	FirstPlaceTitle:setLetterSpacing(1)
	FirstPlaceTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	FirstPlaceTitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(FirstPlaceTitle)
	self.FirstPlaceTitle = FirstPlaceTitle
	local DivisionSkillIcon = LUI.UIImage.new(0, 0, 147.5, 227.5, 0, 0, 21.5, 101.5)
	DivisionSkillIcon:linkToElementModel(self, "leaguePlaySkillDivisionBanner", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DivisionSkillIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(DivisionSkillIcon)
	self.DivisionSkillIcon = DivisionSkillIcon
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "firstPlaceCount", 1)
			end,
		},
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	self:linkToElementModel(self, "firstPlaceCount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "firstPlaceCount",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_ArenaBarracksStats_Firstplace.__resetProperties = function(f8_arg0)
	f8_arg0.ArenaRankWidget:completeAnimation()
	f8_arg0.StatsValue:completeAnimation()
	f8_arg0.FirstPlaceTitle:completeAnimation()
	f8_arg0.ArenaRankWidget:setAlpha(1)
	f8_arg0.StatsValue:setAlpha(1)
	f8_arg0.FirstPlaceTitle:setTopBottom(0, 0, 1, 18)
	f8_arg0.FirstPlaceTitle:setAlpha(0.7)
end
CoD.ButtonFrame_ArenaBarracksStats_Firstplace.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hide = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.ArenaRankWidget:completeAnimation()
			f10_arg0.ArenaRankWidget:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ArenaRankWidget)
			f10_arg0.StatsValue:completeAnimation()
			f10_arg0.StatsValue:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.StatsValue)
			f10_arg0.FirstPlaceTitle:completeAnimation()
			f10_arg0.FirstPlaceTitle:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FirstPlaceTitle)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.FirstPlaceTitle:completeAnimation()
			f11_arg0.FirstPlaceTitle:setTopBottom(0, 0, 8, 20)
			f11_arg0.clipFinished(f11_arg0.FirstPlaceTitle)
		end,
	},
}
CoD.ButtonFrame_ArenaBarracksStats_Firstplace.__onClose = function(f12_arg0)
	f12_arg0.ArenaRankWidget:close()
	f12_arg0.DivisionSkillIcon:close()
end
