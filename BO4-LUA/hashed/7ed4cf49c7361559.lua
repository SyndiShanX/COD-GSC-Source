CoD.ReservesRerollCard = InheritFrom(LUI.UIElement)
CoD.ReservesRerollCard.__defaultWidth = 352
CoD.ReservesRerollCard.__defaultHeight = 672
CoD.ReservesRerollCard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesRerollCard)
	self.id = "ReservesRerollCard"
	self.soundSet = "default"
	local CardReroll = LUI.UIImage.new(0.5, 0.5, -176, 176, 0.5, 0.5, -336, 336)
	CardReroll:setImage(RegisterImage(@"hash_D8F8FCB06C30D6F"))
	self:addElement(CardReroll)
	self.CardReroll = CardReroll
	local RerollText = LUI.UIText.new(0.5, 0.5, -145, 145, 0, 0, 112.5, 147.5)
	RerollText:setRGB(1, 0.89, 0.45)
	RerollText:setText(LocalizeToUpperString(@"mpui/reroll"))
	RerollText:setTTF("default")
	RerollText:setLetterSpacing(2)
	RerollText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RerollText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RerollText)
	self.RerollText = RerollText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
