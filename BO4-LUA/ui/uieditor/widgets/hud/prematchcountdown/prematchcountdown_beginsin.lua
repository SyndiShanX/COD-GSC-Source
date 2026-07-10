require("x64:92371d2c5786619")
CoD.PrematchCountdown_BeginsIn = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_BeginsIn.__defaultWidth = 1200
CoD.PrematchCountdown_BeginsIn.__defaultHeight = 48
CoD.PrematchCountdown_BeginsIn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown_BeginsIn)
	self.id = "PrematchCountdown_BeginsIn"
	self.soundSet = "default"
	local MatchText = LUI.UIText.new(0.5, 0.5, -600, 600, 0.5, 0.5, -19.5, 19.5)
	MatchText:setAlpha(0.95)
	MatchText:setText(LocalizeToUpperString(0x8E58CC95DB34427))
	MatchText:setTTF("ttmussels_regular")
	MatchText:setLetterSpacing(3)
	MatchText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MatchText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	MatchText:setBackingType(1)
	MatchText:setBackingWidget(CoD.PrematchCountdown_Backing, f1_arg0, f1_arg1)
	MatchText:setBackingXPadding(60)
	MatchText:setBackingYPadding(15)
	self:addElement(MatchText)
	self.MatchText = MatchText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
