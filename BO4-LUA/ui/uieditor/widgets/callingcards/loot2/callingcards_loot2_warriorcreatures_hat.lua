CoD.callingcards_loot2_warriorcreatures_hat = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_warriorcreatures_hat.__defaultWidth = 10
CoD.callingcards_loot2_warriorcreatures_hat.__defaultHeight = 10
CoD.callingcards_loot2_warriorcreatures_hat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_warriorcreatures_hat)
	self.id = "callingcards_loot2_warriorcreatures_hat"
	self.soundSet = "default"
	local hat = LUI.UIImage.new(0, 0, -7, 121, 0, 0, -2, 70)
	hat:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_hat"))
	self:addElement(hat)
	self.hat = hat
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
