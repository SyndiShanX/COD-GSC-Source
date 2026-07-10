CoD.callingcards_loot2_circusclown_leftarm = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_circusclown_leftarm.__defaultWidth = 10
CoD.callingcards_loot2_circusclown_leftarm.__defaultHeight = 10
CoD.callingcards_loot2_circusclown_leftarm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_circusclown_leftarm)
	self.id = "callingcards_loot2_circusclown_leftarm"
	self.soundSet = "default"
	local leftarm = LUI.UIImage.new(0, 0, -8, 120, 0, 0, -15, 65)
	leftarm:setImage(RegisterImage(@"uie_ui_menu_callingcards_circusclown_leftarm"))
	self:addElement(leftarm)
	self.leftarm = leftarm
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
