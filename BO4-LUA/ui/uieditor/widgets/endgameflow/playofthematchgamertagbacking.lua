CoD.PlayOfTheMatchGamertagBacking = InheritFrom(LUI.UIElement)
CoD.PlayOfTheMatchGamertagBacking.__defaultWidth = 1088
CoD.PlayOfTheMatchGamertagBacking.__defaultHeight = 125
CoD.PlayOfTheMatchGamertagBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayOfTheMatchGamertagBacking)
	self.id = "PlayOfTheMatchGamertagBacking"
	self.soundSet = "default"
	local TextBackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextBackingBlur:setRGB(0, 0, 0)
	TextBackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	TextBackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(TextBackingBlur)
	self.TextBackingBlur = TextBackingBlur
	local TextBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextBacking:setRGB(0, 0, 0)
	TextBacking:setAlpha(0.9)
	TextBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	TextBacking:setShaderVector(0, 0, 1, 0, 0)
	TextBacking:setShaderVector(1, 0, 0, 0, 0)
	TextBacking:setShaderVector(2, 0, 1, 0, 0)
	TextBacking:setShaderVector(3, 0, 0, 0, 0)
	TextBacking:setShaderVector(4, 1, 0.05, 1, 0)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local DotPattern = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DotPattern:setAlpha(0.15)
	DotPattern:setImage(RegisterImage(@"hash_2D876FDDB0C64D93"))
	DotPattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	DotPattern:setShaderVector(0, 0, 1, 0, 0)
	DotPattern:setShaderVector(1, 0, 0, 0, 0)
	DotPattern:setShaderVector(2, 0, 1, 0, 0)
	DotPattern:setShaderVector(3, 0, 0, 0, 0)
	DotPattern:setShaderVector(4, 1, 0.05, 1, 0)
	self:addElement(DotPattern)
	self.DotPattern = DotPattern
	local DotTL = LUI.UIImage.new(0, 0, 0, 2, 0, 0, 0, 2)
	self:addElement(DotTL)
	self.DotTL = DotTL
	local DotBL = LUI.UIImage.new(0, 0, 0, 2, 1, 1, -2, 0)
	self:addElement(DotBL)
	self.DotBL = DotBL
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
