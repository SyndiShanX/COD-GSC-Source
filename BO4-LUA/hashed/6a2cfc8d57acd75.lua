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
	AnsweredTitle:setText(Engine[0xF9F1239CFD921FE](0xD3AA9D75B7F2051))
	AnsweredTitle:setTTF("ttmussels_regular")
	AnsweredTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AnsweredTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(AnsweredTitle)
	self.AnsweredTitle = AnsweredTitle
	local AnsweredSubTitle = LUI.UIText.new(0.5, 0.5, -305, 305, 0.5, 0.5, 19.5, 46.5)
	AnsweredSubTitle:setText(Engine[0xF9F1239CFD921FE](0x83EF070079A176B))
	AnsweredSubTitle:setTTF("dinnext_regular")
	AnsweredSubTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AnsweredSubTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(AnsweredSubTitle)
	self.AnsweredSubTitle = AnsweredSubTitle
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
