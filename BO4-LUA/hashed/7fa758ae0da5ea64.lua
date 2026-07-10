CoD.SurveyTexts = InheritFrom(LUI.UIElement)
CoD.SurveyTexts.__defaultWidth = 651
CoD.SurveyTexts.__defaultHeight = 147
CoD.SurveyTexts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 15, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.SurveyTexts)
	self.id = "SurveyTexts"
	self.soundSet = "default"
	local QuestionText = LUI.UIText.new(0, 0, 0, 651, 0, 0, 0, 37)
	QuestionText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	QuestionText:setTTF("ttmussels_regular")
	QuestionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	QuestionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	QuestionText:linkToElementModel(self, "questionText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			QuestionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(QuestionText)
	self.QuestionText = QuestionText
	local QuestionSubText = LUI.UIText.new(0, 0, 0, 651, 0, 0, 52, 79)
	QuestionSubText:setTTF("dinnext_regular")
	QuestionSubText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	QuestionSubText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	QuestionSubText:linkToElementModel(self, "questionSubText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			QuestionSubText:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(QuestionSubText)
	self.QuestionSubText = QuestionSubText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SurveyTexts.__onClose = function(f4_arg0)
	f4_arg0.QuestionText:close()
	f4_arg0.QuestionSubText:close()
end
