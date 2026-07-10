CoD.LeaguePlayIntrolLadderTitleText = InheritFrom(LUI.UIElement)
CoD.LeaguePlayIntrolLadderTitleText.__defaultWidth = 1920
CoD.LeaguePlayIntrolLadderTitleText.__defaultHeight = 48
CoD.LeaguePlayIntrolLadderTitleText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayIntrolLadderTitleText)
	self.id = "LeaguePlayIntrolLadderTitleText"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	self.CurrentSkillPlacementGlow = LUI.UIElement.createFake()
	local CurrentSkillPlacementGlowPC = nil
	CurrentSkillPlacementGlowPC = LUI.UIText.new(0, 0, 0, 1922, 0, 0, 0, 48)
	CurrentSkillPlacementGlowPC:setTTF("ttmussels_demibold")
	CurrentSkillPlacementGlowPC:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	CurrentSkillPlacementGlowPC:setShaderVector(0, 0.47, 0, 0, 0)
	CurrentSkillPlacementGlowPC:setShaderVector(1, 0.05, 0, 0, 0)
	CurrentSkillPlacementGlowPC:setShaderVector(2, 1, 1, 1, 0.28)
	CurrentSkillPlacementGlowPC:setLetterSpacing(8)
	CurrentSkillPlacementGlowPC:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CurrentSkillPlacementGlowPC:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CurrentSkillPlacementGlowPC:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlaySkillDivisionName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CurrentSkillPlacementGlowPC:setText(LocalizeToUpperString(LocalizeIntoString(0x7DF5AC7BE07BAF5, f2_local0)))
		end
	end)
	self:addElement(CurrentSkillPlacementGlowPC)
	self.CurrentSkillPlacementGlowPC = CurrentSkillPlacementGlowPC
	local CurrentSkillPlacement = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 0, 48)
	CurrentSkillPlacement:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	CurrentSkillPlacement:setTTF("ttmussels_demibold")
	CurrentSkillPlacement:setLetterSpacing(8)
	CurrentSkillPlacement:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CurrentSkillPlacement:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CurrentSkillPlacement:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlaySkillDivisionName", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CurrentSkillPlacement:setText(LocalizeToUpperString(LocalizeIntoString(0x7DF5AC7BE07BAF5, f3_local0)))
		end
	end)
	self:addElement(CurrentSkillPlacement)
	self.CurrentSkillPlacement = CurrentSkillPlacement
	self:mergeStateConditions({
		{
			stateName = "Competitor",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 1)
			end,
		},
		{
			stateName = "Advanced",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 2)
			end,
		},
		{
			stateName = "Expert",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 3)
			end,
		},
		{
			stateName = "Elite",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 4)
			end,
		},
		{
			stateName = "Master",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 5)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayIntrolLadderTitleText.__resetProperties = function(f9_arg0)
	f9_arg0.CurrentSkillPlacementGlow:completeAnimation()
	f9_arg0.CurrentSkillPlacement:completeAnimation()
	f9_arg0.CurrentSkillPlacementGlowPC:completeAnimation()
	f9_arg0.CurrentSkillPlacementGlow:setRGB(1, 1, 1)
	f9_arg0.CurrentSkillPlacementGlow:setShaderVector(0, 0.47, 0, 0, 0)
	f9_arg0.CurrentSkillPlacementGlow:setShaderVector(1, 0.05, 0, 0, 0)
	f9_arg0.CurrentSkillPlacementGlow:setShaderVector(2, 1, 1, 1, 0.35)
	f9_arg0.CurrentSkillPlacement:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f9_arg0.CurrentSkillPlacementGlowPC:setRGB(1, 1, 1)
	f9_arg0.CurrentSkillPlacementGlowPC:setShaderVector(0, 0.47, 0, 0, 0)
	f9_arg0.CurrentSkillPlacementGlowPC:setShaderVector(1, 0.05, 0, 0, 0)
	f9_arg0.CurrentSkillPlacementGlowPC:setShaderVector(2, 1, 1, 1, 0.28)
end
CoD.LeaguePlayIntrolLadderTitleText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
			f10_arg0.CurrentSkillPlacementGlow:completeAnimation()
			f10_arg0.CurrentSkillPlacementGlow:setShaderVector(0, 0.47, 0, 0, 0)
			f10_arg0.CurrentSkillPlacementGlow:setShaderVector(1, 0.05, 0, 0, 0)
			f10_arg0.CurrentSkillPlacementGlow:setShaderVector(2, 1, 1, 1, 0)
			f10_arg0.clipFinished(f10_arg0.CurrentSkillPlacementGlow)
		end,
	},
	Competitor = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Advanced = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.CurrentSkillPlacementGlow:completeAnimation()
			f12_arg0.CurrentSkillPlacementGlow:setShaderVector(0, 0.95, 0, 0, 0)
			f12_arg0.CurrentSkillPlacementGlow:setShaderVector(1, -0.1, 0, 0, 0)
			f12_arg0.CurrentSkillPlacementGlow:setShaderVector(2, 1.1, 0.58, 0, 0.28)
			f12_arg0.clipFinished(f12_arg0.CurrentSkillPlacementGlow)
			f12_arg0.CurrentSkillPlacementGlowPC:completeAnimation()
			f12_arg0.CurrentSkillPlacementGlowPC:setShaderVector(0, 0.95, 0, 0, 0)
			f12_arg0.CurrentSkillPlacementGlowPC:setShaderVector(1, -0.1, 0, 0, 0)
			f12_arg0.CurrentSkillPlacementGlowPC:setShaderVector(2, 1.1, 0.58, 0, 0.28)
			f12_arg0.clipFinished(f12_arg0.CurrentSkillPlacementGlowPC)
			f12_arg0.CurrentSkillPlacement:completeAnimation()
			f12_arg0.CurrentSkillPlacement:setRGB(0.98, 0.86, 0.09)
			f12_arg0.clipFinished(f12_arg0.CurrentSkillPlacement)
		end,
	},
	Expert = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.CurrentSkillPlacementGlow:completeAnimation()
			f13_arg0.CurrentSkillPlacementGlow:setShaderVector(0, 0.95, 0, 0, 0)
			f13_arg0.CurrentSkillPlacementGlow:setShaderVector(1, -0.1, 0, 0, 0)
			f13_arg0.CurrentSkillPlacementGlow:setShaderVector(2, 0.2, 1, 0, 0.28)
			f13_arg0.clipFinished(f13_arg0.CurrentSkillPlacementGlow)
			f13_arg0.CurrentSkillPlacementGlowPC:completeAnimation()
			f13_arg0.CurrentSkillPlacementGlowPC:setShaderVector(0, 0.95, 0, 0, 0)
			f13_arg0.CurrentSkillPlacementGlowPC:setShaderVector(1, -0.1, 0, 0, 0)
			f13_arg0.CurrentSkillPlacementGlowPC:setShaderVector(2, 0.2, 1, 0, 0.28)
			f13_arg0.clipFinished(f13_arg0.CurrentSkillPlacementGlowPC)
			f13_arg0.CurrentSkillPlacement:completeAnimation()
			f13_arg0.CurrentSkillPlacement:setRGB(0.32, 0.8, 0.1)
			f13_arg0.clipFinished(f13_arg0.CurrentSkillPlacement)
		end,
	},
	Elite = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.CurrentSkillPlacementGlow:completeAnimation()
			f14_arg0.CurrentSkillPlacementGlow:setShaderVector(0, 0.95, 0, 0, 0)
			f14_arg0.CurrentSkillPlacementGlow:setShaderVector(1, -0.1, 0, 0, 0)
			f14_arg0.CurrentSkillPlacementGlow:setShaderVector(2, 1, 1, 1, 0.28)
			f14_arg0.clipFinished(f14_arg0.CurrentSkillPlacementGlow)
			f14_arg0.CurrentSkillPlacementGlowPC:completeAnimation()
			f14_arg0.CurrentSkillPlacementGlowPC:setShaderVector(0, 0.95, 0, 0, 0)
			f14_arg0.CurrentSkillPlacementGlowPC:setShaderVector(1, -0.1, 0, 0, 0)
			f14_arg0.CurrentSkillPlacementGlowPC:setShaderVector(2, 1, 1, 1, 0.28)
			f14_arg0.clipFinished(f14_arg0.CurrentSkillPlacementGlowPC)
			f14_arg0.CurrentSkillPlacement:completeAnimation()
			f14_arg0.CurrentSkillPlacement:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f14_arg0.clipFinished(f14_arg0.CurrentSkillPlacement)
		end,
	},
	Master = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.CurrentSkillPlacementGlow:completeAnimation()
			f15_arg0.CurrentSkillPlacementGlow:setRGB(0.4, 0.05, 0.31)
			f15_arg0.CurrentSkillPlacementGlow:setShaderVector(0, 0.95, 0, 0, 0)
			f15_arg0.CurrentSkillPlacementGlow:setShaderVector(1, -0.1, 0, 0, 0)
			f15_arg0.CurrentSkillPlacementGlow:setShaderVector(2, 1.36, 0.42, 1, 0.28)
			f15_arg0.clipFinished(f15_arg0.CurrentSkillPlacementGlow)
			f15_arg0.CurrentSkillPlacementGlowPC:completeAnimation()
			f15_arg0.CurrentSkillPlacementGlowPC:setRGB(0.4, 0.05, 0.31)
			f15_arg0.CurrentSkillPlacementGlowPC:setShaderVector(0, 0.95, 0, 0, 0)
			f15_arg0.CurrentSkillPlacementGlowPC:setShaderVector(1, -0.1, 0, 0, 0)
			f15_arg0.CurrentSkillPlacementGlowPC:setShaderVector(2, 1.36, 0.42, 1, 0.28)
			f15_arg0.clipFinished(f15_arg0.CurrentSkillPlacementGlowPC)
			f15_arg0.CurrentSkillPlacement:completeAnimation()
			f15_arg0.CurrentSkillPlacement:setRGB(0.64, 0.13, 0.69)
			f15_arg0.clipFinished(f15_arg0.CurrentSkillPlacement)
		end,
	},
}
CoD.LeaguePlayIntrolLadderTitleText.__onClose = function(f16_arg0)
	f16_arg0.CurrentSkillPlacementGlow:close()
	f16_arg0.CurrentSkillPlacementGlowPC:close()
	f16_arg0.CurrentSkillPlacement:close()
end
