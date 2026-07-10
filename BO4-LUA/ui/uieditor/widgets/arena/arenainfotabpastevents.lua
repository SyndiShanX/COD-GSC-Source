CoD.ArenaInfoTabPastEvents = InheritFrom(LUI.UIElement)
CoD.ArenaInfoTabPastEvents.__defaultWidth = 1920
CoD.ArenaInfoTabPastEvents.__defaultHeight = 1080
CoD.ArenaInfoTabPastEvents.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaInfoTabPastEvents)
	self.id = "ArenaInfoTabPastEvents"
	self.soundSet = "none"
	local TextBox = LUI.UIText.new(0, 0, 1059.5, 1259.5, 0, 0, 448, 485)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x729851A370BBAAA))
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
