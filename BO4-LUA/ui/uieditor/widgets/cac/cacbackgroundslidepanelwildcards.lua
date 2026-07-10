CoD.CACBackgroundSlidePanelWildcards = InheritFrom(LUI.UIElement)
CoD.CACBackgroundSlidePanelWildcards.__defaultWidth = 1920
CoD.CACBackgroundSlidePanelWildcards.__defaultHeight = 622
CoD.CACBackgroundSlidePanelWildcards.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CACBackgroundSlidePanelWildcards)
	self.id = "CACBackgroundSlidePanelWildcards"
	self.soundSet = "default"
	local BackgroundBlur = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -622, 2)
	BackgroundBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackgroundBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackgroundBlur)
	self.BackgroundBlur = BackgroundBlur
	local background4 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -622, 2)
	background4:setRGB(0, 0, 0)
	background4:setAlpha(0.6)
	self:addElement(background4)
	self.background4 = background4
	local background3 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -622, 2)
	background3:setRGB(0, 0, 0)
	background3:setAlpha(0.2)
	self:addElement(background3)
	self.background3 = background3
	local background1 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -622, 2)
	background1:setRGB(0, 0, 0)
	background1:setAlpha(0.2)
	self:addElement(background1)
	self.background1 = background1
	local background2 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -622, 2)
	background2:setRGB(0, 0, 0)
	background2:setAlpha(0.1)
	background2:setZoom(2)
	self:addElement(background2)
	self.background2 = background2
	local BackgroundGlow = LUI.UIImage.new(-0.5, 1.5, 0, 0, 1, 1, -622, 0)
	BackgroundGlow:setRGB(0, 0, 0)
	BackgroundGlow:setZoom(2)
	BackgroundGlow:setImage(RegisterImage(0x418AFBD55D4236F))
	self:addElement(BackgroundGlow)
	self.BackgroundGlow = BackgroundGlow
	local GrainBGPattern = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -622, 2)
	GrainBGPattern:setAlpha(0.25)
	GrainBGPattern:setZoom(2)
	GrainBGPattern:setImage(RegisterImage(0xB666F49E61F417C))
	GrainBGPattern:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GrainBGPattern:setShaderVector(0, 0, 0, 0, 0)
	GrainBGPattern:setupNineSliceShader(256, 256)
	self:addElement(GrainBGPattern)
	self.GrainBGPattern = GrainBGPattern
	local TriangleBGPattern01 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -622, 0)
	TriangleBGPattern01:setAlpha(0.04)
	TriangleBGPattern01:setZoom(2)
	TriangleBGPattern01:setImage(RegisterImage(0x59DE271312E12EA))
	TriangleBGPattern01:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TriangleBGPattern01:setShaderVector(0, 0, 0, 0, 0)
	TriangleBGPattern01:setupNineSliceShader(256, 256)
	self:addElement(TriangleBGPattern01)
	self.TriangleBGPattern01 = TriangleBGPattern01
	local TopBar = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, -1, 2)
	TopBar:setAlpha(0.2)
	TopBar:setZoom(2)
	TopBar:setImage(RegisterImage(0x42BCCF45B82FBED))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(TopBar)
	self.TopBar = TopBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
