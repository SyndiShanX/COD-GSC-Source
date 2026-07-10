CoD.CoDPointPrice = InheritFrom(LUI.UIElement)
CoD.CoDPointPrice.__defaultWidth = 313
CoD.CoDPointPrice.__defaultHeight = 32
CoD.CoDPointPrice.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CoDPointPrice)
	self.id = "CoDPointPrice"
	self.soundSet = "default"
	local AmountText = LUI.UIText.new(0, 0, 0, 103, 0, 0, -2, 34)
	AmountText:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	AmountText:setTTF("ttmussels_demibold")
	AmountText:setLetterSpacing(1)
	AmountText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AmountText:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AmountText:setText(LocalizeHash(f2_local0))
		end
	end)
	self:addElement(AmountText)
	self.AmountText = AmountText
	local CoDPointsText = LUI.UIText.new(0, 0, 113, 313, 0, 0, 5, 27)
	CoDPointsText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CoDPointsText:setText(Engine[0xF9F1239CFD921FE](0x93582834683FCC5))
	CoDPointsText:setTTF("ttmussels_demibold")
	CoDPointsText:setLetterSpacing(2)
	CoDPointsText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(CoDPointsText)
	self.CoDPointsText = CoDPointsText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CoDPointPrice.__onClose = function(f3_arg0)
	f3_arg0.AmountText:close()
end
