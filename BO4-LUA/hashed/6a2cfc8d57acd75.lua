CoD.SurveyThanks = InheritFrom(LUI.UIElement)
CoD.SurveyThanks.__defaultWidth = 610
CoD.SurveyThanks.__defaultHeight = 75
CoD.SurveyThanks.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 12, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.SurveyThanks)
	self.id = "SurveyThanks"
	self.soundSet = "default"
	local AnsweredTitle = LUI.UIText.new(0.5, 0.5, -305, 305, 0.5, 0.5, -37.5, 7.5)
	AnsweredTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	AnsweredTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4D3AA9D75B7F2051"))
	AnsweredTitle:setTTF("ttmussels_regular")
	AnsweredTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AnsweredTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AnsweredTitle)
	self.AnsweredTitle = AnsweredTitle
	local AnsweredSubTitle = LUI.UIText.new(0.5, 0.5, -305, 305, 0.5, 0.5, 19.5, 46.5)
	AnsweredSubTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_283EF070079A176B"))
	AnsweredSubTitle:setTTF("dinnext_regular")
	AnsweredSubTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AnsweredSubTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AnsweredSubTitle)
	self.AnsweredSubTitle = AnsweredSubTitle
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
