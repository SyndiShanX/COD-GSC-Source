CoD.LeaguePlayListTextBox = InheritFrom(LUI.UIElement)
CoD.LeaguePlayListTextBox.__defaultWidth = 300
CoD.LeaguePlayListTextBox.__defaultHeight = 21
CoD.LeaguePlayListTextBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayListTextBox)
	self.id = "LeaguePlayListTextBox"
	self.soundSet = "none"
	local DisplayText = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 21)
	DisplayText:setRGB(0.92, 0.92, 0.92)
	DisplayText:setTTF("ttmussels_regular")
	DisplayText:setLetterSpacing(2)
	DisplayText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DisplayText:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DisplayText:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(DisplayText)
	self.DisplayText = DisplayText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayListTextBox.__onClose = function(f3_arg0)
	f3_arg0.DisplayText:close()
end
