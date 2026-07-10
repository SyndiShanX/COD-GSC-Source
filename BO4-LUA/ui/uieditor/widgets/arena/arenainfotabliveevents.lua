CoD.ArenaInfoTabLiveEvents = InheritFrom(LUI.UIElement)
CoD.ArenaInfoTabLiveEvents.__defaultWidth = 1920
CoD.ArenaInfoTabLiveEvents.__defaultHeight = 1080
CoD.ArenaInfoTabLiveEvents.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaInfoTabLiveEvents)
	self.id = "ArenaInfoTabLiveEvents"
	self.soundSet = "none"
	local TextBox = LUI.UIText.new(0, 0, 1059.5, 1259.5, 0, 0, 448, 485)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_24567DF5804DC2CC"))
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
