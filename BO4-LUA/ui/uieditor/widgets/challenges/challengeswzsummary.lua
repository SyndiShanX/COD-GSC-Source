require("x64:29a877a9ba25493")
require("x64:2d9e73f9b9cfe91")
require("x64:8bdf1ce4d590e4f")
require("x64:66445678590dbdb")
require("x64:c7e896ee4bc3f8")
CoD.ChallengesWZSummary = InheritFrom(LUI.UIElement)
CoD.ChallengesWZSummary.__defaultWidth = 1740
CoD.ChallengesWZSummary.__defaultHeight = 780
CoD.ChallengesWZSummary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesWZSummary)
	self.id = "ChallengesWZSummary"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NearCompletionButton = CoD.Challenges_Summary_NearCompletionButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, 587.5, 0.5, 0.5, 78, 358)
	NearCompletionButton:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(NearCompletionButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		OpenPopup(self, "Challenges_NearCompletion", controller, nil)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(NearCompletionButton)
	self.NearCompletionButton = NearCompletionButton
	local ChallengesTotalMasterProgress = CoD.Challenges_TotalMasterProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, 587.5, 0.5, 0.5, -344, -244)
	ChallengesTotalMasterProgress:subscribeToGlobalModel(f1_arg1, "MasterCallingCard", nil, function(model)
		ChallengesTotalMasterProgress:setModel(model, f1_arg1)
	end)
	ChallengesTotalMasterProgress:subscribeToGlobalModel(f1_arg1, "MasterCallingCard", nil, function(model)
		ChallengesTotalMasterProgress.MasterCallingCardIcon:setModel(model, f1_arg1)
	end)
	self:addElement(ChallengesTotalMasterProgress)
	self.ChallengesTotalMasterProgress = ChallengesTotalMasterProgress
	local CategoryList = CoD.ChallengesSummaryCategoryList_WZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, 587.5, 0.5, 0.5, -207.5, 17.5)
	self:addElement(CategoryList)
	self.CategoryList = CategoryList
	local TrialWidget = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, 219.5, 0.5, 0.5, -383, -348)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
		{
			stateName = "ShownLarge",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
	})
	TrialWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5134CAB251C3EE69"))
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	NearCompletionButton.id = "NearCompletionButton"
	ChallengesTotalMasterProgress.id = "ChallengesTotalMasterProgress"
	CategoryList.id = "CategoryList"
	self.__defaultFocus = CategoryList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	f1_local5 = ChallengesTotalMasterProgress
	CoD.ChallengesUtility.SetTotalMasterInfo(f1_arg1)
	return self
end
CoD.ChallengesWZSummary.__resetProperties = function(f9_arg0)
	f9_arg0.ChallengesTotalMasterProgress:completeAnimation()
	f9_arg0.NearCompletionButton:completeAnimation()
	f9_arg0.ChallengesTotalMasterProgress:setAlpha(1)
	f9_arg0.NearCompletionButton:setAlpha(1)
end
CoD.ChallengesWZSummary.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(149)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.NearCompletionButton:beginAnimation(300)
				f10_arg0.NearCompletionButton:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.NearCompletionButton:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.NearCompletionButton:completeAnimation()
			f10_arg0.NearCompletionButton:setAlpha(0)
			f10_local0(f10_arg0.NearCompletionButton)
			local f10_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(150)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.ChallengesTotalMasterProgress:beginAnimation(50)
				f10_arg0.ChallengesTotalMasterProgress:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ChallengesTotalMasterProgress:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f10_arg0.ChallengesTotalMasterProgress:completeAnimation()
			f10_arg0.ChallengesTotalMasterProgress:setAlpha(0)
			f10_local1(f10_arg0.ChallengesTotalMasterProgress)
		end,
	},
}
CoD.ChallengesWZSummary.__onClose = function(f15_arg0)
	f15_arg0.NearCompletionButton:close()
	f15_arg0.ChallengesTotalMasterProgress:close()
	f15_arg0.CategoryList:close()
	f15_arg0.TrialWidget:close()
end
