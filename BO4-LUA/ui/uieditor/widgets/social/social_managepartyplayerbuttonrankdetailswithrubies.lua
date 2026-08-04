require("ui/uieditor/widgets/arena/arenaprogressionrubies")
require("ui/uieditor/widgets/social/social_managepartyplayerbuttonrankdetails")
CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies = InheritFrom(LUI.UIElement)
CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies.__defaultWidth = 40
CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies.__defaultHeight = 62
CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies)
	self.id = "Social_ManagePartyPlayerButtonRankDetailsWithRubies"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local rankIcon = CoD.Social_ManagePartyPlayerButtonRankDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.5, 0.5, -31, 31)
	rankIcon:subscribeToGlobalModel(f1_arg1, "SocialPlayerInfo", nil, function(model)
		rankIcon:setModel(model, f1_arg1)
	end)
	self:addElement(rankIcon)
	self.rankIcon = rankIcon
	local rubiesUnlocked = CoD.ArenaProgressionRubies.new(f1_arg0, f1_arg1, 0, 0, 54, 194, 0, 0, -4.5, 69.5)
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
	rubiesUnlocked:setScale(0.5, 0.5)
	rubiesUnlocked:subscribeToGlobalModel(f1_arg1, "SocialPlayerInfo", nil, function(model)
		rubiesUnlocked:setModel(model, f1_arg1)
	end)
	rubiesUnlocked:subscribeToGlobalModel(f1_arg1, "SocialPlayerInfo", nil, function(model)
		rubiesUnlocked.threeRubyLayout:setModel(model, f1_arg1)
	end)
	rubiesUnlocked:subscribeToGlobalModel(f1_arg1, "SocialPlayerInfo", nil, function(model)
		rubiesUnlocked.fourRubyLayout:setModel(model, f1_arg1)
	end)
	rubiesUnlocked:subscribeToGlobalModel(f1_arg1, "SocialPlayerInfo", nil, function(model)
		rubiesUnlocked.fiveRubyLayout:setModel(model, f1_arg1)
	end)
	self:addElement(rubiesUnlocked)
	self.rubiesUnlocked = rubiesUnlocked
	self:mergeStateConditions({
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.Arena)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine.GetGlobalModel()
	f1_local4(f1_local3, f1_local5["lobbyRoot.rankMode"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.rankMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies.__resetProperties = function(f11_arg0)
	f11_arg0.rubiesUnlocked:completeAnimation()
	f11_arg0.rubiesUnlocked:setAlpha(1)
end
CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.rubiesUnlocked:completeAnimation()
			f12_arg0.rubiesUnlocked:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.rubiesUnlocked)
		end,
	},
	Arena = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.rubiesUnlocked:completeAnimation()
			f13_arg0.rubiesUnlocked:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.rubiesUnlocked)
		end,
	},
}
CoD.Social_ManagePartyPlayerButtonRankDetailsWithRubies.__onClose = function(f14_arg0)
	f14_arg0.rankIcon:close()
	f14_arg0.rubiesUnlocked:close()
end
