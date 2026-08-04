CoD.callingcards_loot2_vikingbattles_blood01 = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_vikingbattles_blood01.__defaultWidth = 10
CoD.callingcards_loot2_vikingbattles_blood01.__defaultHeight = 10
CoD.callingcards_loot2_vikingbattles_blood01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_vikingbattles_blood01)
	self.id = "callingcards_loot2_vikingbattles_blood01"
	self.soundSet = "default"
	local blood01 = LUI.UIImage.new(0, 0, -319, -7, 0, 0, -226, 38)
	blood01:setImage(RegisterImage("uie_ui_menu_callingcards_vikingbattles_blood1"))
	self:addElement(blood01)
	self.blood01 = blood01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
