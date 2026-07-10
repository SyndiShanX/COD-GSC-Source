CoD.callingcards_loot2_warriorcreatures_tail = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_warriorcreatures_tail.__defaultWidth = 10
CoD.callingcards_loot2_warriorcreatures_tail.__defaultHeight = 10
CoD.callingcards_loot2_warriorcreatures_tail.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_warriorcreatures_tail)
	self.id = "callingcards_loot2_warriorcreatures_tail"
	self.soundSet = "default"
	local tail = LUI.UIImage.new(0, 0, -15, 153, 0, 0, -159, 41)
	tail:setImage(RegisterImage(0xC8207A7BDEEB0A1))
	self:addElement(tail)
	self.tail = tail
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
