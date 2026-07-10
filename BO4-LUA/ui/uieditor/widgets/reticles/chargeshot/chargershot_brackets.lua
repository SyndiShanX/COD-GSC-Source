CoD.ChargerShot_Brackets = InheritFrom(LUI.UIElement)
CoD.ChargerShot_Brackets.__defaultWidth = 1210
CoD.ChargerShot_Brackets.__defaultHeight = 873
CoD.ChargerShot_Brackets.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargerShot_Brackets)
	self.id = "ChargerShot_Brackets"
	self.soundSet = "ChooseDecal"
	local CornerBraquets = LUI.UIImage.new(0.5, 0.5, -605, -497, 0.5, 0.5, -436, -328)
	CornerBraquets:setRGB(1, 0.85, 0.07)
	CornerBraquets:setAlpha(0.5)
	CornerBraquets:setScale(0.7, 0.7)
	CornerBraquets:setImage(RegisterImage(@"uie_t7_hud_chargeshot_braquets"))
	self:addElement(CornerBraquets)
	self.CornerBraquets = CornerBraquets
	local CornerBraquets0 = LUI.UIImage.new(0.5, 0.5, 498, 606, 0.5, 0.5, -436, -328)
	CornerBraquets0:setRGB(1, 0.85, 0.07)
	CornerBraquets0:setAlpha(0.5)
	CornerBraquets0:setZRot(-90)
	CornerBraquets0:setScale(0.7, 0.7)
	CornerBraquets0:setImage(RegisterImage(@"uie_t7_hud_chargeshot_braquets"))
	self:addElement(CornerBraquets0)
	self.CornerBraquets0 = CornerBraquets0
	local CornerBraquets1 = LUI.UIImage.new(0.5, 0.5, -605, -497, 0.5, 0.5, 328, 436)
	CornerBraquets1:setRGB(1, 0.85, 0.07)
	CornerBraquets1:setAlpha(0.5)
	CornerBraquets1:setZRot(90)
	CornerBraquets1:setScale(0.7, 0.7)
	CornerBraquets1:setImage(RegisterImage(@"uie_t7_hud_chargeshot_braquets"))
	self:addElement(CornerBraquets1)
	self.CornerBraquets1 = CornerBraquets1
	local CornerBraquets10 = LUI.UIImage.new(0.5, 0.5, 498, 606, 0.5, 0.5, 328, 436)
	CornerBraquets10:setRGB(1, 0.85, 0.07)
	CornerBraquets10:setAlpha(0.5)
	CornerBraquets10:setZRot(180)
	CornerBraquets10:setScale(0.7, 0.7)
	CornerBraquets10:setImage(RegisterImage(@"uie_t7_hud_chargeshot_braquets"))
	self:addElement(CornerBraquets10)
	self.CornerBraquets10 = CornerBraquets10
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
