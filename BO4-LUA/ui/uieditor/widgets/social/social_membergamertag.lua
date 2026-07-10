CoD.Social_MemberGamerTag = InheritFrom(LUI.UIElement)
CoD.Social_MemberGamerTag.__defaultWidth = 406
CoD.Social_MemberGamerTag.__defaultHeight = 17
CoD.Social_MemberGamerTag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_MemberGamerTag)
	self.id = "Social_MemberGamerTag"
	self.soundSet = "default"
	local gamertag = LUI.UIText.new(0, 0, 0, 406, 0, 0, -1, 16)
	gamertag:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	gamertag:setAlpha(0.5)
	gamertag:setText("")
	gamertag:setTTF("notosans_bold")
	gamertag:setLetterSpacing(3)
	gamertag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(gamertag)
	self.gamertag = gamertag
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
