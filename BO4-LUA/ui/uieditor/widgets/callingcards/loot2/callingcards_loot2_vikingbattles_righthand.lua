CoD.callingcards_loot2_vikingbattles_righthand = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_vikingbattles_righthand.__defaultWidth = 10
CoD.callingcards_loot2_vikingbattles_righthand.__defaultHeight = 10
CoD.callingcards_loot2_vikingbattles_righthand.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_vikingbattles_righthand)
	self.id = "callingcards_loot2_vikingbattles_righthand"
	self.soundSet = "default"
	local character02righthand = LUI.UIImage.new(0, 0, -35, 245, 0, 0, -81, 39)
	character02righthand:setZRot(25)
	character02righthand:setImage(RegisterImage(0x975B68E32089D71))
	self:addElement(character02righthand)
	self.character02righthand = character02righthand
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
