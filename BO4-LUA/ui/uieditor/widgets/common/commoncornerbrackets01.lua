CoD.CommonCornerBrackets01 = InheritFrom(LUI.UIElement)
CoD.CommonCornerBrackets01.__defaultWidth = 40
CoD.CommonCornerBrackets01.__defaultHeight = 40
CoD.CommonCornerBrackets01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonCornerBrackets01)
	self.id = "CommonCornerBrackets01"
	self.soundSet = "none"
	local CommonCornerBracket01TR = LUI.UIImage.new(1, 1, -20, 0, 0, 0, 0, 20)
	CommonCornerBracket01TR:setZRot(-90)
	CommonCornerBracket01TR:setImage(RegisterImage(@"uie_hud_common_corner_bracket01"))
	self:addElement(CommonCornerBracket01TR)
	self.CommonCornerBracket01TR = CommonCornerBracket01TR
	local CommonCornerBracket01TL = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	CommonCornerBracket01TL:setImage(RegisterImage(@"uie_hud_common_corner_bracket01"))
	self:addElement(CommonCornerBracket01TL)
	self.CommonCornerBracket01TL = CommonCornerBracket01TL
	local CommonCornerBracket01BR = LUI.UIImage.new(1, 1, -20, 0, 1, 1, -20, 0)
	CommonCornerBracket01BR:setZRot(180)
	CommonCornerBracket01BR:setImage(RegisterImage(@"uie_hud_common_corner_bracket01"))
	self:addElement(CommonCornerBracket01BR)
	self.CommonCornerBracket01BR = CommonCornerBracket01BR
	local CommonCornerBracket01BL = LUI.UIImage.new(0, 0, 0, 20, 1, 1, -20, 0)
	CommonCornerBracket01BL:setZRot(90)
	CommonCornerBracket01BL:setImage(RegisterImage(@"uie_hud_common_corner_bracket01"))
	self:addElement(CommonCornerBracket01BL)
	self.CommonCornerBracket01BL = CommonCornerBracket01BL
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
