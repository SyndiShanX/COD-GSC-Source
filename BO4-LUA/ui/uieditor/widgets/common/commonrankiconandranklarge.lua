require("x64:c45396f7013b2c4")
CoD.CommonRankIconAndRankLarge = InheritFrom(LUI.UIElement)
CoD.CommonRankIconAndRankLarge.__defaultWidth = 349
CoD.CommonRankIconAndRankLarge.__defaultHeight = 135
CoD.CommonRankIconAndRankLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonRankIconAndRankLarge)
	self.id = "CommonRankIconAndRankLarge"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arenaRubiesUnlocked = CoD.ArenaProgressionRubies.new(f1_arg0, f1_arg1, 0, 0, 215, 355, 0, 0, 46.5, 120.5)
	arenaRubiesUnlocked:mergeStateConditions({
		{
			stateName = "FourRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRankRubyRequirementEqualValue(element, "arenaRank", 4)
			end,
		},
		{
			stateName = "FiveRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRankRubyRequirementEqualValue(element, "arenaRank", 5)
			end,
		},
	})
	arenaRubiesUnlocked:linkToElementModel(self, nil, false, function(model)
		arenaRubiesUnlocked.threeRubyLayout:setModel(model, f1_arg1)
	end)
	arenaRubiesUnlocked:linkToElementModel(self, nil, false, function(model)
		arenaRubiesUnlocked.fourRubyLayout:setModel(model, f1_arg1)
	end)
	arenaRubiesUnlocked:linkToElementModel(self, nil, false, function(model)
		arenaRubiesUnlocked.fiveRubyLayout:setModel(model, f1_arg1)
	end)
	self:addElement(arenaRubiesUnlocked)
	self.arenaRubiesUnlocked = arenaRubiesUnlocked
	local arenaFlameStreak = LUI.UIImage.new(0, 0, -54, 186, 0, 0, -52.5, 187.5)
	arenaFlameStreak:setAlpha(0)
	arenaFlameStreak:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	arenaFlameStreak:setShaderVector(0, 4, 4, 0, 0)
	arenaFlameStreak:setShaderVector(1, 8, 0, 0, 0)
	arenaFlameStreak.__Image = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			arenaFlameStreak:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetFirestreakFromSocialPlayerInfo(self, f7_local0)))
		end
	end
	arenaFlameStreak:linkToElementModel(self, "arenaLeaguePlayFirstSubdivisionRankStreak", true, arenaFlameStreak.__Image)
	arenaFlameStreak.__Image_FullPath = function()
		local f8_local0 = self:getModel()
		if f8_local0 then
			f8_local0 = self:getModel()
			f8_local0 = f8_local0.arenaLeaguePlayFirstSubdivisionRankStreak
		end
		if f8_local0 then
			arenaFlameStreak.__Image(f8_local0)
		end
	end
	self:addElement(arenaFlameStreak)
	self.arenaFlameStreak = arenaFlameStreak
	local arenaRankSkillDivisionIcon = LUI.UIImage.new(0, 0, 2, 130, 0, 0, 3.5, 131.5)
	arenaRankSkillDivisionIcon:linkToElementModel(self, "skillDivisionIcon", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			arenaRankSkillDivisionIcon:setImage(RegisterImage(f9_local0))
		end
	end)
	self:addElement(arenaRankSkillDivisionIcon)
	self.arenaRankSkillDivisionIcon = arenaRankSkillDivisionIcon
	local rankText = LUI.UIText.new(0, 0, 142, 342, 0, 0, 48.5, 124.5)
	rankText:setTTF("0arame_mono_stencil")
	rankText:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	rankText:setShaderVector(0, 1, 0, 0, 0)
	rankText:setShaderVector(1, 0, 0, 0, 0)
	rankText:setShaderVector(2, 0.3, 0.3, 0.2, 0.2)
	rankText:setLetterSpacing(2)
	rankText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rankText:linkToElementModel(self, "isParagon", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			rankText:setRGB(CoD.DirectorUtility.GetColorForDisplayRankText(f10_local0))
		end
	end)
	rankText:linkToElementModel(self, "displayRank", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			rankText:setText(f11_local0)
		end
	end)
	self:addElement(rankText)
	self.rankText = rankText
	local rankName = LUI.UIText.new(0, 0.57, 145, 145, 0, 0, 32, 50)
	rankName:setRGB(0.92, 0.92, 0.92)
	rankName:setAlpha(0.5)
	rankName:setTTF("ttmussels_regular")
	rankName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	rankName:setShaderVector(0, 1, 0, 0, 0)
	rankName:setShaderVector(1, 0, 0, 0, 0)
	rankName:setShaderVector(2, 0, 0, 0, 0.5)
	rankName:setLetterSpacing(1)
	rankName:setLineSpacing(1)
	rankName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rankName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	rankName:linkToElementModel(self, "rankTitle", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			rankName:setText(LocalizeToUpperString(f12_local0))
		end
	end)
	self:addElement(rankName)
	self.rankName = rankName
	local rank = LUI.UIText.new(-0, 0.57, 145, 145, 0, 0, 32, 50)
	rank:setRGB(0.92, 0.92, 0.92)
	rank:setAlpha(0)
	rank:setText(LocalizeToUpperString(0x3370355189B42A7))
	rank:setTTF("ttmussels_regular")
	rank:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	rank:setShaderVector(0, 1, 0, 0, 0)
	rank:setShaderVector(1, 0, 0, 0, 0)
	rank:setShaderVector(2, 0, 0, 0, 0.5)
	rank:setLetterSpacing(1)
	rank:setLineSpacing(1)
	rank:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rank:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(rank)
	self.rank = rank
	local rankIcon = LUI.UIImage.new(0, 0, 2, 130, 0, 0, 3.5, 131.5)
	rankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			rankIcon:setImage(RegisterImage(GetRankIconLarge(f13_local0)))
		end
	end)
	self:addElement(rankIcon)
	self.rankIcon = rankIcon
	arenaFlameStreak:linkToElementModel(self, "arenaLeaguePlayPoints", true, arenaFlameStreak.__Image_FullPath)
	self:mergeStateConditions({
		{
			stateName = "VisibleArena",
			condition = function(menu, element, event)
				return CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.Arena)
			end,
		},
		{
			stateName = "VisibleOther",
			condition = function(menu, element, event)
				return not CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.None)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.rankMode"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.rankMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonRankIconAndRankLarge.__resetProperties = function(f17_arg0)
	f17_arg0.rankIcon:completeAnimation()
	f17_arg0.rankText:completeAnimation()
	f17_arg0.rankName:completeAnimation()
	f17_arg0.arenaRubiesUnlocked:completeAnimation()
	f17_arg0.arenaFlameStreak:completeAnimation()
	f17_arg0.arenaRankSkillDivisionIcon:completeAnimation()
	f17_arg0.rank:completeAnimation()
	f17_arg0.rankIcon:setAlpha(1)
	f17_arg0.rankText:setAlpha(1)
	f17_arg0.rankName:setAlpha(0.5)
	f17_arg0.arenaRubiesUnlocked:setAlpha(1)
	f17_arg0.arenaFlameStreak:setAlpha(0)
	f17_arg0.arenaRankSkillDivisionIcon:setAlpha(1)
	f17_arg0.rank:setAlpha(0)
end
CoD.CommonRankIconAndRankLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(7)
			f18_arg0.arenaRubiesUnlocked:completeAnimation()
			f18_arg0.arenaRubiesUnlocked:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.arenaRubiesUnlocked)
			f18_arg0.arenaFlameStreak:completeAnimation()
			f18_arg0.arenaFlameStreak:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.arenaFlameStreak)
			f18_arg0.arenaRankSkillDivisionIcon:completeAnimation()
			f18_arg0.arenaRankSkillDivisionIcon:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.arenaRankSkillDivisionIcon)
			f18_arg0.rankText:completeAnimation()
			f18_arg0.rankText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.rankText)
			f18_arg0.rankName:completeAnimation()
			f18_arg0.rankName:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.rankName)
			f18_arg0.rank:completeAnimation()
			f18_arg0.rank:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.rank)
			f18_arg0.rankIcon:completeAnimation()
			f18_arg0.rankIcon:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.rankIcon)
		end,
	},
	VisibleArena = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(7)
			f19_arg0.arenaRubiesUnlocked:completeAnimation()
			f19_arg0.arenaRubiesUnlocked:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.arenaRubiesUnlocked)
			f19_arg0.arenaFlameStreak:completeAnimation()
			f19_arg0.arenaFlameStreak:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.arenaFlameStreak)
			f19_arg0.arenaRankSkillDivisionIcon:completeAnimation()
			f19_arg0.arenaRankSkillDivisionIcon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.arenaRankSkillDivisionIcon)
			f19_arg0.rankText:completeAnimation()
			f19_arg0.rankText:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.rankText)
			f19_arg0.rankName:completeAnimation()
			f19_arg0.rankName:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.rankName)
			f19_arg0.rank:completeAnimation()
			f19_arg0.rank:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.rank)
			f19_arg0.rankIcon:completeAnimation()
			f19_arg0.rankIcon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.rankIcon)
		end,
	},
	VisibleOther = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.arenaRubiesUnlocked:completeAnimation()
			f20_arg0.arenaRubiesUnlocked:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.arenaRubiesUnlocked)
			f20_arg0.arenaFlameStreak:completeAnimation()
			f20_arg0.arenaFlameStreak:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.arenaFlameStreak)
			f20_arg0.arenaRankSkillDivisionIcon:completeAnimation()
			f20_arg0.arenaRankSkillDivisionIcon:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.arenaRankSkillDivisionIcon)
		end,
	},
}
CoD.CommonRankIconAndRankLarge.__onClose = function(f21_arg0)
	f21_arg0.arenaRubiesUnlocked:close()
	f21_arg0.arenaFlameStreak:close()
	f21_arg0.arenaRankSkillDivisionIcon:close()
	f21_arg0.rankText:close()
	f21_arg0.rankName:close()
	f21_arg0.rankIcon:close()
end
