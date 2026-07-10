CoD.TextBackingCommonWithBlur = InheritFrom(LUI.UIElement)
CoD.TextBackingCommonWithBlur.__defaultWidth = 60
CoD.TextBackingCommonWithBlur.__defaultHeight = 60
CoD.TextBackingCommonWithBlur.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TextBackingCommonWithBlur)
	self.id = "TextBackingCommonWithBlur"
	self.soundSet = "default"
	local BlurBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBG:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBG)
	self.BlurBG = BlurBG
	local Base = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Base:setRGB(0, 0, 0)
	Base:setAlpha(0.97)
	self:addElement(Base)
	self.Base = Base
	local PipBL = LUI.UIImage.new(0, 0, -4, 4, 1, 1, -4, 4)
	PipBL:setImage(RegisterImage(@"uie_hud_common_corner_pip"))
	PipBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipBL)
	self.PipBL = PipBL
	local PipTL = LUI.UIImage.new(0, 0, -4, 4, 0, 0, -4, 4)
	PipTL:setImage(RegisterImage(@"uie_hud_common_corner_pip"))
	PipTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipTL)
	self.PipTL = PipTL
	local PipTR = LUI.UIImage.new(1, 1, -4, 4, 0, 0, -4, 4)
	PipTR:setImage(RegisterImage(@"uie_hud_common_corner_pip"))
	PipTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipTR)
	self.PipTR = PipTR
	local PipBR = LUI.UIImage.new(1, 1, -4, 4, 1, 1, -4, 4)
	PipBR:setImage(RegisterImage(@"uie_hud_common_corner_pip"))
	PipBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipBR)
	self.PipBR = PipBR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
