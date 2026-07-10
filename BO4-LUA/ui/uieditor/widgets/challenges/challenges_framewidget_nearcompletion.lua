require("x64:5e92c71fe0e5747")
require("x64:79fe6ac43673588")
require("x64:2b8d81769d76c17")
CoD.Challenges_FrameWidget_NearCompletion = InheritFrom(LUI.UIElement)
CoD.Challenges_FrameWidget_NearCompletion.__defaultWidth = 1620
CoD.Challenges_FrameWidget_NearCompletion.__defaultHeight = 780
CoD.Challenges_FrameWidget_NearCompletion.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_FrameWidget_NearCompletion)
	self.id = "Challenges_FrameWidget_NearCompletion"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local NearCompletionList = LUI.UIList.new(f1_arg0, f1_arg1, 14, 0, nil, false, false, false, false)
	NearCompletionList:setLeftRight(0, 0, 0, 1100)
	NearCompletionList:setTopBottom(0.5, 0.5, -410, 516)
	NearCompletionList:setScale(0.95, 0.95)
	NearCompletionList:setWidgetType(CoD.ChallengesNearCompletionWidget)
	NearCompletionList:setVerticalCount(10)
	NearCompletionList:setSpacing(14)
	NearCompletionList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NearCompletionList:setDataSource("ChallengesNearCompletionList")
	self:addElement(NearCompletionList)
	self.NearCompletionList = NearCompletionList
	local DesBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 1, 1, -525, 0, 0, 0, -20, 900)
	DesBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(DesBG)
	self.DesBG = DesBG
	local ChallengesCallingCardProfiler = CoD.Challenges_CallingCardProfiler.new(f1_arg0, f1_arg1, 1, 1, -520, -3, 0, 0, 0, 879)
	self:addElement(ChallengesCallingCardProfiler)
	self.ChallengesCallingCardProfiler = ChallengesCallingCardProfiler
	ChallengesCallingCardProfiler:linkToElementModel(NearCompletionList, nil, false, function(model)
		ChallengesCallingCardProfiler:setModel(model, f1_arg1)
	end)
	NearCompletionList.id = "NearCompletionList"
	ChallengesCallingCardProfiler.id = "ChallengesCallingCardProfiler"
	self.__defaultFocus = NearCompletionList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_FrameWidget_NearCompletion.__onClose = function(f3_arg0)
	f3_arg0.ChallengesCallingCardProfiler:close()
	f3_arg0.NearCompletionList:close()
	f3_arg0.DesBG:close()
end
