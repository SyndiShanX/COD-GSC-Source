CoD.ScoreboardGameStatusScoresBacking = InheritFrom(LUI.UIElement)
CoD.ScoreboardGameStatusScoresBacking.__defaultWidth = 1920
CoD.ScoreboardGameStatusScoresBacking.__defaultHeight = 150
CoD.ScoreboardGameStatusScoresBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardGameStatusScoresBacking)
	self.id = "ScoreboardGameStatusScoresBacking"
	self.soundSet = "default"
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 150)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local BlurTint02 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 150)
	BlurTint02:setRGB(0.1, 0.1, 0.1)
	BlurTint02:setAlpha(0.7)
	self:addElement(BlurTint02)
	self.BlurTint02 = BlurTint02
	local BlurTint01 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 12)
	BlurTint01:setRGB(0, 0, 0)
	BlurTint01:setAlpha(0.3)
	self:addElement(BlurTint01)
	self.BlurTint01 = BlurTint01
	local TintBottomHero = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 12, 112)
	TintBottomHero:setRGB(0, 0, 0)
	TintBottomHero:setAlpha(0.5)
	self:addElement(TintBottomHero)
	self.TintBottomHero = TintBottomHero
	local TintBarHero = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 119, 125)
	TintBarHero:setRGB(0, 0, 0)
	TintBarHero:setAlpha(0.26)
	self:addElement(TintBarHero)
	self.TintBarHero = TintBarHero
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
