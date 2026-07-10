require("x64:f00a10fc8301da2")
require("x64:e52af63508c530e")
require("x64:f47bdbf2bcaddaf")
require("x64:92738f467653f32")
require("x64:797033da1e8f2cb")
require("x64:d1bb2b99fadfab6")
CoD.AARScoreboardTab = InheritFrom(LUI.UIElement)
CoD.AARScoreboardTab.__defaultWidth = 1920
CoD.AARScoreboardTab.__defaultHeight = 800
CoD.AARScoreboardTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARScoreboardTab)
	self.id = "AARScoreboardTab"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0, 0, -40, 1960, 0, 0, 51, 887)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local TabbedScoreboardScores = CoD.TabbedScoreboardScores.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 76, 869)
	TabbedScoreboardScores:mergeStateConditions({
		{
			stateName = "VisibleFFA",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES) and CoD.AARUtility.IsGameTypeTeamFFA(f1_arg1)
			end,
		},
	})
	local AARScoreboardHeader = TabbedScoreboardScores
	local NemesisList = TabbedScoreboardScores.subscribeToModel
	local AARTabHeader = Engine[@"getmodelforcontroller"](f1_arg1)
	NemesisList(AARScoreboardHeader, AARTabHeader["scoreboardInfo.activeTab"], function(f3_arg0)
		f1_arg0:updateElementState(TabbedScoreboardScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	self:addElement(TabbedScoreboardScores)
	self.TabbedScoreboardScores = TabbedScoreboardScores
	NemesisList = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	NemesisList:setLeftRight(0, 0, 1697, 1847)
	NemesisList:setTopBottom(0, 0, 304, 694)
	NemesisList:setWidgetType(CoD.AARNemesis)
	NemesisList:setVerticalCount(6)
	NemesisList:setSpacing(6)
	NemesisList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NemesisList:setDataSource("AARKillStats")
	self:addElement(NemesisList)
	self.NemesisList = NemesisList
	AARScoreboardHeader = CoD.AARScoreboardHeader.new(f1_arg0, f1_arg1, 0, 0, 235, 1685, 0, 0, 67, 237)
	AARScoreboardHeader:linkToElementModel(self, nil, false, function(model)
		AARScoreboardHeader:setModel(model, f1_arg1)
	end)
	self:addElement(AARScoreboardHeader)
	self.AARScoreboardHeader = AARScoreboardHeader
	AARTabHeader = CoD.AARTabHeader.new(f1_arg0, f1_arg1, 0, 0, 235, 735, 0, 0, 94, 214)
	AARTabHeader:setAlpha(0)
	AARTabHeader.TabTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/stats"))
	AARTabHeader:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", nil, function(model)
		AARTabHeader:setModel(model, f1_arg1)
	end)
	self:addElement(AARTabHeader)
	self.AARTabHeader = AARTabHeader
	local AARScoreboardSafeArea = CoD.AARScoreboardSafeArea.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 133, 933)
	self:addElement(AARScoreboardSafeArea)
	self.AARScoreboardSafeArea = AARScoreboardSafeArea
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SCOREBOARD)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["AAR.activeTab"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	TabbedScoreboardScores.id = "TabbedScoreboardScores"
	NemesisList.id = "NemesisList"
	self.__defaultFocus = TabbedScoreboardScores
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	f1_local8 = NemesisList
	SetElementProperty(f1_local8, "enemyTeam", true)
	CoD.GridAndListUtility.SortListByControllerModelKeys(f1_arg1, f1_local8, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2")
	SizeToSafeArea(AARScoreboardSafeArea, f1_arg1)
	return self
end
CoD.AARScoreboardTab.__resetProperties = function(f8_arg0)
	f8_arg0.TabbedScoreboardScores:completeAnimation()
	f8_arg0.AARScoreboardHeader:completeAnimation()
	f8_arg0.AARTabHeader:completeAnimation()
	f8_arg0.NemesisList:completeAnimation()
	f8_arg0.AarMpBacking:completeAnimation()
	f8_arg0.AARScoreboardSafeArea:completeAnimation()
	f8_arg0.TabbedScoreboardScores:setAlpha(1)
	f8_arg0.AARScoreboardHeader:setAlpha(1)
	f8_arg0.AARTabHeader:setAlpha(0)
	f8_arg0.NemesisList:setAlpha(1)
	f8_arg0.AarMpBacking:setAlpha(1)
	f8_arg0.AARScoreboardSafeArea:setAlpha(1)
end
CoD.AARScoreboardTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(6)
			f9_arg0.AarMpBacking:completeAnimation()
			f9_arg0.AarMpBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AarMpBacking)
			f9_arg0.TabbedScoreboardScores:completeAnimation()
			f9_arg0.TabbedScoreboardScores:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TabbedScoreboardScores)
			f9_arg0.NemesisList:completeAnimation()
			f9_arg0.NemesisList:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.NemesisList)
			f9_arg0.AARScoreboardHeader:completeAnimation()
			f9_arg0.AARScoreboardHeader:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AARScoreboardHeader)
			f9_arg0.AARTabHeader:completeAnimation()
			f9_arg0.AARTabHeader:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AARTabHeader)
			f9_arg0.AARScoreboardSafeArea:completeAnimation()
			f9_arg0.AARScoreboardSafeArea:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AARScoreboardSafeArea)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			local f10_local0 = function(f11_arg0)
				f10_arg0.AarMpBacking:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f10_arg0.AarMpBacking:setAlpha(1)
				f10_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.AarMpBacking:completeAnimation()
			f10_arg0.AarMpBacking:setAlpha(0)
			f10_local0(f10_arg0.AarMpBacking)
			local f10_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(149)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.TabbedScoreboardScores:beginAnimation(200)
				f10_arg0.TabbedScoreboardScores:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.TabbedScoreboardScores:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f10_arg0.TabbedScoreboardScores:completeAnimation()
			f10_arg0.TabbedScoreboardScores:setAlpha(0)
			f10_local1(f10_arg0.TabbedScoreboardScores)
			local f10_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(99)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.NemesisList:beginAnimation(250)
				f10_arg0.NemesisList:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.NemesisList:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f10_arg0.NemesisList:completeAnimation()
			f10_arg0.NemesisList:setAlpha(0)
			f10_local2(f10_arg0.NemesisList)
			local f10_local3 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.AARScoreboardHeader:beginAnimation(150)
				f10_arg0.AARScoreboardHeader:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.AARScoreboardHeader:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f10_arg0.AARScoreboardHeader:completeAnimation()
			f10_arg0.AARScoreboardHeader:setAlpha(0)
			f10_local3(f10_arg0.AARScoreboardHeader)
			local f10_local4 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.AARScoreboardSafeArea:beginAnimation(350)
				f10_arg0.AARScoreboardSafeArea:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.AARScoreboardSafeArea:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f10_arg0.AARScoreboardSafeArea:completeAnimation()
			f10_arg0.AARScoreboardSafeArea:setAlpha(0)
			f10_local4(f10_arg0.AARScoreboardSafeArea)
		end,
	},
}
CoD.AARScoreboardTab.__onClose = function(f20_arg0)
	f20_arg0.AarMpBacking:close()
	f20_arg0.TabbedScoreboardScores:close()
	f20_arg0.NemesisList:close()
	f20_arg0.AARScoreboardHeader:close()
	f20_arg0.AARTabHeader:close()
	f20_arg0.AARScoreboardSafeArea:close()
end
