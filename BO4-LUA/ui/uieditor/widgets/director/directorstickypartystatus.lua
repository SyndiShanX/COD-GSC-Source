CoD.DirectorStickyPartyStatus = InheritFrom(LUI.UIElement)
CoD.DirectorStickyPartyStatus.__defaultWidth = 200
CoD.DirectorStickyPartyStatus.__defaultHeight = 24
CoD.DirectorStickyPartyStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorStickyPartyStatus)
	self.id = "DirectorStickyPartyStatus"
	self.soundSet = "none"
	local TextBox = LUI.UIText.new(0, 0, 0, 200, 0, 0, 4, 24)
	TextBox:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](StickyPartyStatusToString(@"hash_2D1FA62620BF6CEF")))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
