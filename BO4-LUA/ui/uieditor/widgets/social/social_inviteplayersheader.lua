require("x64:c45396f7013b2c4")
require("x64:6d513f0593e71df")
require("x64:4e00e02e26a9da7")
require("x64:a9b9965f6f12714")
require("x64:73c1bd047bb93f1")
CoD.Social_InvitePlayersHeader = InheritFrom(LUI.UIElement)
CoD.Social_InvitePlayersHeader.__defaultWidth = 687
CoD.Social_InvitePlayersHeader.__defaultHeight = 169
CoD.Social_InvitePlayersHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_InvitePlayersHeader)
	self.id = "Social_InvitePlayersHeader"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local presence2 = CoD.Social_InfoPane_Presence.new(f1_arg0, f1_arg1, 0.5, 0.5, -343.5, -43.5, 0, 0, 75.5, 107.5)
	presence2:setAlpha(0.8)
	presence2:linkToElementModel(self, nil, false, function(model)
		presence2:setModel(model, f1_arg1)
	end)
	self:addElement(presence2)
	self.presence2 = presence2
	local party = CoD.Social_InfoPane_Party.new(f1_arg0, f1_arg1, 0.5, 0.5, 119.5, 343.5, 0, 0, 0, 169)
	party:linkToElementModel(self, nil, false, function(model)
		party:setModel(model, f1_arg1)
	end)
	self:addElement(party)
	self.party = party
	local CornerLineBRAnim4 = CoD.Social_PlayerCard.new(f1_arg0, f1_arg1, 0.5, 0.5, -343.5, 23.5, 0, 0, 0, 65)
	CornerLineBRAnim4:linkToElementModel(self, "identityBadge", false, function(model)
		CornerLineBRAnim4:setModel(model, f1_arg1)
	end)
	self:addElement(CornerLineBRAnim4)
	self.CornerLineBRAnim4 = CornerLineBRAnim4
	local rankIconAndRank = CoD.CommonRankIconAndRankVertical.new(f1_arg0, f1_arg1, 0.5, 0.5, 33.5, 72.5, 0, 0, 6, 65)
	rankIconAndRank:linkToElementModel(self, "rankInfo", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			rankIconAndRank:setModel(f5_local0, f1_arg1)
		end
	end)
	self:addElement(rankIconAndRank)
	self.rankIconAndRank = rankIconAndRank
	local rubiesUnlocked = CoD.ArenaProgressionRubies.new(f1_arg0, f1_arg1, 0, 0, 346, 486, 0, 0, 52.5, 126.5)
	rubiesUnlocked:mergeStateConditions({
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
	rubiesUnlocked:setScale(0.8, 0.8)
	rubiesUnlocked:linkToElementModel(self, nil, false, function(model)
		rubiesUnlocked:setModel(model, f1_arg1)
	end)
	rubiesUnlocked:linkToElementModel(self, nil, false, function(model)
		rubiesUnlocked.threeRubyLayout:setModel(model, f1_arg1)
	end)
	rubiesUnlocked:linkToElementModel(self, nil, false, function(model)
		rubiesUnlocked.fourRubyLayout:setModel(model, f1_arg1)
	end)
	rubiesUnlocked:linkToElementModel(self, nil, false, function(model)
		rubiesUnlocked.fiveRubyLayout:setModel(model, f1_arg1)
	end)
	self:addElement(rubiesUnlocked)
	self.rubiesUnlocked = rubiesUnlocked
	self:mergeStateConditions({
		{
			stateName = "NoPlayersOnline",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "SocialRoot", "visibleCount", 0)
			end,
		},
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.SocialRoot.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.visibleCount, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "visibleCount",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	party.id = "party"
	CornerLineBRAnim4.id = "CornerLineBRAnim4"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_InvitePlayersHeader.__resetProperties = function(f16_arg0)
	f16_arg0.rubiesUnlocked:completeAnimation()
	f16_arg0.party:completeAnimation()
	f16_arg0.presence2:completeAnimation()
	f16_arg0.rankIconAndRank:completeAnimation()
	f16_arg0.CornerLineBRAnim4:completeAnimation()
	f16_arg0.rubiesUnlocked:setAlpha(1)
	f16_arg0.party:setAlpha(1)
	f16_arg0.presence2:setAlpha(0.8)
	f16_arg0.rankIconAndRank:setAlpha(1)
	f16_arg0.CornerLineBRAnim4:setAlpha(1)
end
CoD.Social_InvitePlayersHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.rubiesUnlocked:completeAnimation()
			f17_arg0.rubiesUnlocked:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.rubiesUnlocked)
		end,
	},
	NoPlayersOnline = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(5)
			f18_arg0.presence2:completeAnimation()
			f18_arg0.presence2:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.presence2)
			f18_arg0.party:completeAnimation()
			f18_arg0.party:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.party)
			f18_arg0.CornerLineBRAnim4:completeAnimation()
			f18_arg0.CornerLineBRAnim4:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.CornerLineBRAnim4)
			f18_arg0.rankIconAndRank:completeAnimation()
			f18_arg0.rankIconAndRank:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.rankIconAndRank)
			f18_arg0.rubiesUnlocked:completeAnimation()
			f18_arg0.rubiesUnlocked:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.rubiesUnlocked)
		end,
	},
	Arena = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.rubiesUnlocked:completeAnimation()
			f19_arg0.rubiesUnlocked:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.rubiesUnlocked)
		end,
	},
}
CoD.Social_InvitePlayersHeader.__onClose = function(f20_arg0)
	f20_arg0.presence2:close()
	f20_arg0.party:close()
	f20_arg0.CornerLineBRAnim4:close()
	f20_arg0.rankIconAndRank:close()
	f20_arg0.rubiesUnlocked:close()
end
