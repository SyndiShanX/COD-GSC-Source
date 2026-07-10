require("x64:29a877a9ba25493")
require("x64:2d9e73f9b9cfe91")
require("x64:8bdf1ce4d590e4f")
require("x64:49bc5f065cf35fd")
CoD.Challenges_MP_Summary = InheritFrom(LUI.UIElement)
CoD.Challenges_MP_Summary.__defaultWidth = 1740
CoD.Challenges_MP_Summary.__defaultHeight = 780
CoD.Challenges_MP_Summary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_MP_Summary)
	self.id = "Challenges_MP_Summary"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NearCompletionButton = CoD.Challenges_Summary_NearCompletionButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, 587.5, 0.5, 0.5, 78, 358)
	NearCompletionButton:subscribeToGlobalModel(f1_arg1, "ChallengesMPCategoryStats", "mp", function(model)
		NearCompletionButton:setModel(model, f1_arg1)
	end)
	NearCompletionButton:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(NearCompletionButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "AllChallengesComplete") then
			PlaySoundAlias("uin_toggle_generic")
			OpenPopup(self, "Challenges_NearCompletion", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "AllChallengesComplete") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(NearCompletionButton)
	self.NearCompletionButton = NearCompletionButton
	local ChallengesTotalMasterProgress = CoD.Challenges_TotalMasterProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, 587.5, 0.5, 0.5, -352, -252)
	ChallengesTotalMasterProgress:subscribeToGlobalModel(f1_arg1, "MasterCallingCard", nil, function(model)
		ChallengesTotalMasterProgress:setModel(model, f1_arg1)
	end)
	ChallengesTotalMasterProgress:subscribeToGlobalModel(f1_arg1, "MasterCallingCard", nil, function(model)
		ChallengesTotalMasterProgress.MasterCallingCardIcon:setModel(model, f1_arg1)
	end)
	self:addElement(ChallengesTotalMasterProgress)
	self.ChallengesTotalMasterProgress = ChallengesTotalMasterProgress
	local CategoryList = CoD.ChallengesSummaryCategoryList.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, 587.5, 0.5, 0.5, -207.5, 17.5)
	self:addElement(CategoryList)
	self.CategoryList = CategoryList
	NearCompletionButton.id = "NearCompletionButton"
	ChallengesTotalMasterProgress.id = "ChallengesTotalMasterProgress"
	CategoryList.id = "CategoryList"
	self.__defaultFocus = CategoryList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	f1_local4 = ChallengesTotalMasterProgress
	CoD.ChallengesUtility.SetTotalMasterInfo(f1_arg1)
	return self
end
CoD.Challenges_MP_Summary.__resetProperties = function(f8_arg0)
	f8_arg0.CategoryList:completeAnimation()
	f8_arg0.ChallengesTotalMasterProgress:completeAnimation()
	f8_arg0.NearCompletionButton:completeAnimation()
	f8_arg0.CategoryList:setAlpha(1)
	f8_arg0.ChallengesTotalMasterProgress:setAlpha(1)
	f8_arg0.NearCompletionButton:setAlpha(1)
end
CoD.Challenges_MP_Summary.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(149)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.NearCompletionButton:beginAnimation(300)
				f9_arg0.NearCompletionButton:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.NearCompletionButton:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.NearCompletionButton:completeAnimation()
			f9_arg0.NearCompletionButton:setAlpha(0)
			f9_local0(f9_arg0.NearCompletionButton)
			local f9_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(150)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.ChallengesTotalMasterProgress:beginAnimation(50)
				f9_arg0.ChallengesTotalMasterProgress:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ChallengesTotalMasterProgress:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f9_arg0.ChallengesTotalMasterProgress:completeAnimation()
			f9_arg0.ChallengesTotalMasterProgress:setAlpha(0)
			f9_local1(f9_arg0.ChallengesTotalMasterProgress)
			local f9_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(150)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.CategoryList:beginAnimation(50)
				f9_arg0.CategoryList:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.CategoryList:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f9_arg0.CategoryList:completeAnimation()
			f9_arg0.CategoryList:setAlpha(0)
			f9_local2(f9_arg0.CategoryList)
		end,
	},
}
CoD.Challenges_MP_Summary.__onClose = function(f16_arg0)
	f16_arg0.NearCompletionButton:close()
	f16_arg0.ChallengesTotalMasterProgress:close()
	f16_arg0.CategoryList:close()
end
