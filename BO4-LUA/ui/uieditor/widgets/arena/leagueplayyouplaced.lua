CoD.LeaguePlayYouPlaced = InheritFrom(LUI.UIElement)
CoD.LeaguePlayYouPlaced.__defaultWidth = 604
CoD.LeaguePlayYouPlaced.__defaultHeight = 25
CoD.LeaguePlayYouPlaced.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.LeaguePlayYouPlaced)
	self.id = "LeaguePlayYouPlaced"
	self.soundSet = "default"
	local YouPlacedText = LUI.UIText.new(0, 0, 30, 275, 0, 0, 0, 25)
	YouPlacedText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	YouPlacedText:setTTF("ttmussels_regular")
	YouPlacedText:setLetterSpacing(4)
	YouPlacedText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	YouPlacedText:linkToElementModel(self, "lastLadderRank", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			YouPlacedText:setText(ConvertToUpperString(LocalizeIntoString(0xFCF27ACCC4CD185, f2_local0)))
		end
	end)
	self:addElement(YouPlacedText)
	self.YouPlacedText = YouPlacedText
	local YouPlacedText2 = LUI.UIText.new(0, 0, 279, 574, 0, 0, 0, 25)
	YouPlacedText2:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	YouPlacedText2:setTTF("ttmussels_regular")
	YouPlacedText2:setLetterSpacing(4)
	YouPlacedText2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	YouPlacedText2:linkToElementModel(self, "lastLadderRank", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			YouPlacedText2:setText(LocalizeToUpperString(CoD.ArenaUtility.GetLadderPositionOrdinal(f3_local0)))
		end
	end)
	self:addElement(YouPlacedText2)
	self.YouPlacedText2 = YouPlacedText2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayYouPlaced.__onClose = function(f4_arg0)
	f4_arg0.YouPlacedText:close()
	f4_arg0.YouPlacedText2:close()
end
