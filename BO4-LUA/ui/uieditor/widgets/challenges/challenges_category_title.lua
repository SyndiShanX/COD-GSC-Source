require("x64:95d614a0f80206e")
CoD.Challenges_Category_Title = InheritFrom(LUI.UIElement)
CoD.Challenges_Category_Title.__defaultWidth = 300
CoD.Challenges_Category_Title.__defaultHeight = 600
CoD.Challenges_Category_Title.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_Category_Title)
	self.id = "Challenges_Category_Title"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	local ChallengesPercentCompleteWidgetLG = CoD.Challenges_PercentCompleteWidget_LG.new(f1_arg0, f1_arg1, 0, 0, 30, 270, 0, 0, 141, 381)
	ChallengesPercentCompleteWidgetLG.Name:setText(Engine[0xF9F1239CFD921FE](0x5662A3E5DC08B87))
	ChallengesPercentCompleteWidgetLG:linkToElementModel(self, nil, false, function(model)
		ChallengesPercentCompleteWidgetLG:setModel(model, f1_arg1)
	end)
	self:addElement(ChallengesPercentCompleteWidgetLG)
	self.ChallengesPercentCompleteWidgetLG = ChallengesPercentCompleteWidgetLG
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_Category_Title.__onClose = function(f3_arg0)
	f3_arg0.ChallengesPercentCompleteWidgetLG:close()
end
