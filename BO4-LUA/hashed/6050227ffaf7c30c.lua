CoD.PlayerStatsGauntlet = InheritFrom(LUI.UIElement)
CoD.PlayerStatsGauntlet.__defaultWidth = 200
CoD.PlayerStatsGauntlet.__defaultHeight = 102
CoD.PlayerStatsGauntlet.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerStatsGauntlet)
	self.id = "PlayerStatsGauntlet"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatValue = LUI.UIText.new(0, 0, 0, 200, 0, 0, 22, 98)
	StatValue:setRGB(0.69, 0.56, 0.04)
	StatValue:setText("")
	StatValue:setTTF("default")
	StatValue:setLetterSpacing(2)
	StatValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StatValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(StatValue)
	self.StatValue = StatValue
	local StatHeaderText = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 22)
	StatHeaderText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	StatHeaderText:setText("")
	StatHeaderText:setTTF("ttmussels_regular")
	StatHeaderText:setLetterSpacing(1)
	StatHeaderText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(StatHeaderText)
	self.StatHeaderText = StatHeaderText
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
