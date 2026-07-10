CoD.Social_NoFriends = InheritFrom(LUI.UIElement)
CoD.Social_NoFriends.__defaultWidth = 1920
CoD.Social_NoFriends.__defaultHeight = 1080
CoD.Social_NoFriends.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_NoFriends)
	self.id = "Social_NoFriends"
	self.soundSet = "ChooseDecal"
	local noFriends = LUI.UIText.new(0, 0, 210, 1710, 0, 0, 526, 554)
	noFriends:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	noFriends:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_BAA9A79FE50F45E"))
	noFriends:setTTF("dinnext_regular")
	noFriends:setLetterSpacing(3)
	noFriends:setLineSpacing(8)
	noFriends:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	noFriends:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(noFriends)
	self.noFriends = noFriends
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
