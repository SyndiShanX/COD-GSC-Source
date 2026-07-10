CoD.AARSubStat = InheritFrom(LUI.UIElement)
CoD.AARSubStat.__defaultWidth = 400
CoD.AARSubStat.__defaultHeight = 21
CoD.AARSubStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.AARSubStat)
	self.id = "AARSubStat"
	self.soundSet = "none"
	local ScoreLabel = LUI.UIText.new(0, 0, 0, 231, 0, 0, 0, 21)
	ScoreLabel:setRGB(0.9, 0.89, 0.78)
	ScoreLabel:setText(Engine[0xF9F1239CFD921FE](0x2E07839FFD3A082))
	ScoreLabel:setTTF("dinnext_regular")
	ScoreLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ScoreLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ScoreLabel)
	self.ScoreLabel = ScoreLabel
	local Score = LUI.UIText.new(0, 0, 241, 419, 0, 0, 0, 21)
	Score:setRGB(0.9, 0.89, 0.78)
	Score:setTTF("dinnext_regular")
	Score:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Score:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Score:linkToElementModel(self, "objectiveScore", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Score:setText(f2_local0)
		end
	end)
	self:addElement(Score)
	self.Score = Score
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSubStat.__onClose = function(f3_arg0)
	f3_arg0.Score:close()
end
