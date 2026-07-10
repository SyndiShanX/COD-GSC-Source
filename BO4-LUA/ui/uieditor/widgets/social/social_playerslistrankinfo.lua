CoD.Social_PlayersListRankInfo = InheritFrom(LUI.UIElement)
CoD.Social_PlayersListRankInfo.__defaultWidth = 57
CoD.Social_PlayersListRankInfo.__defaultHeight = 36
CoD.Social_PlayersListRankInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PlayersListRankInfo)
	self.id = "Social_PlayersListRankInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local rankText = LUI.UIText.new(0, 0, -41, 16, 0, 0, 8, 29)
	rankText:setAlpha(0)
	rankText:setTTF("0arame_mono_stencil")
	rankText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	rankText:linkToElementModel(self, "isParagon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			rankText:setRGB(CoD.DirectorUtility.GetColorForDisplayRankText(f2_local0))
		end
	end)
	rankText:linkToElementModel(self, "displayRank", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			rankText:setText(f3_local0)
		end
	end)
	self:addElement(rankText)
	self.rankText = rankText
	local rankIcon = LUI.UIImage.new(0, 0, 21, 57, 0, 0, 0, 36)
	rankIcon:setAlpha(0)
	rankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			rankIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(rankIcon)
	self.rankIcon = rankIcon
	local arenaRankSkillDivisionIcon = LUI.UIImage.new(0, 0, 21, 57, 0, 0, 0, 36)
	arenaRankSkillDivisionIcon:setAlpha(0)
	arenaRankSkillDivisionIcon:linkToElementModel(self, "skillDivisionIcon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			arenaRankSkillDivisionIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(arenaRankSkillDivisionIcon)
	self.arenaRankSkillDivisionIcon = arenaRankSkillDivisionIcon
	self:mergeStateConditions({
		{
			stateName = "ArenaVisible",
			condition = function(menu, element, event)
				return CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.Arena)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.None)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.rankMode"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.rankMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PlayersListRankInfo.__resetProperties = function(f9_arg0)
	f9_arg0.arenaRankSkillDivisionIcon:completeAnimation()
	f9_arg0.rankIcon:completeAnimation()
	f9_arg0.rankText:completeAnimation()
	f9_arg0.arenaRankSkillDivisionIcon:setAlpha(0)
	f9_arg0.rankIcon:setAlpha(0)
	f9_arg0.rankText:setAlpha(0)
end
CoD.Social_PlayersListRankInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.arenaRankSkillDivisionIcon:completeAnimation()
			f10_arg0.arenaRankSkillDivisionIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.arenaRankSkillDivisionIcon)
		end,
	},
	ArenaVisible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.rankText:completeAnimation()
			f11_arg0.rankText:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.rankText)
			f11_arg0.rankIcon:completeAnimation()
			f11_arg0.rankIcon:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.rankIcon)
			f11_arg0.arenaRankSkillDivisionIcon:completeAnimation()
			f11_arg0.arenaRankSkillDivisionIcon:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.arenaRankSkillDivisionIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.rankText:completeAnimation()
			f12_arg0.rankText:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.rankText)
			f12_arg0.rankIcon:completeAnimation()
			f12_arg0.rankIcon:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.rankIcon)
			f12_arg0.arenaRankSkillDivisionIcon:completeAnimation()
			f12_arg0.arenaRankSkillDivisionIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.arenaRankSkillDivisionIcon)
		end,
	},
}
CoD.Social_PlayersListRankInfo.__onClose = function(f13_arg0)
	f13_arg0.rankText:close()
	f13_arg0.rankIcon:close()
	f13_arg0.arenaRankSkillDivisionIcon:close()
end
