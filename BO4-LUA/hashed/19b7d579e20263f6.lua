CoD.GameEndScore_HeaderBarMid = InheritFrom(LUI.UIElement)
CoD.GameEndScore_HeaderBarMid.__defaultWidth = 1656
CoD.GameEndScore_HeaderBarMid.__defaultHeight = 80
CoD.GameEndScore_HeaderBarMid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_HeaderBarMid)
	self.id = "GameEndScore_HeaderBarMid"
	self.soundSet = "default"
	local BackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBlur:setRGB(0, 0, 0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local BaseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BaseBacking:setRGB(0, 0, 0)
	BaseBacking:setAlpha(0.93)
	self:addElement(BaseBacking)
	self.BaseBacking = BaseBacking
	local Grid = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	Grid:setRGB(0, 0, 0)
	Grid:setAlpha(0.5)
	Grid:setImage(RegisterImage(0x2F926473EDCBFCA))
	Grid:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	Grid:setShaderVector(0, 0, 0, 0, 0)
	Grid:setupNineSliceShader(22, 20)
	self:addElement(Grid)
	self.Grid = Grid
	local BlackStripTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 10)
	BlackStripTop:setRGB(0, 0, 0)
	BlackStripTop:setAlpha(0.96)
	self:addElement(BlackStripTop)
	self.BlackStripTop = BlackStripTop
	local BlackStripBot = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -10, 0)
	BlackStripBot:setRGB(0, 0, 0)
	BlackStripBot:setAlpha(0.96)
	self:addElement(BlackStripBot)
	self.BlackStripBot = BlackStripBot
	local BGDotPatternLarge = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -24, 24)
	BGDotPatternLarge:setRGB(0, 0, 0)
	BGDotPatternLarge:setAlpha(0)
	BGDotPatternLarge:setImage(RegisterImage(0xFC21A8215EA012B))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	local CommonStripes01Tiled = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -24, 26)
	CommonStripes01Tiled:setRGB(0, 0, 0)
	CommonStripes01Tiled:setImage(RegisterImage(0x649895CFFA4963D))
	CommonStripes01Tiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	CommonStripes01Tiled:setShaderVector(0, 0, 0, 0, 0)
	CommonStripes01Tiled:setupNineSliceShader(66, 48)
	self:addElement(CommonStripes01Tiled)
	self.CommonStripes01Tiled = CommonStripes01Tiled
	local Barcode = LUI.UIImage.new(0, 0, -1, 131, 0, 0, 83, 93)
	Barcode:setAlpha(0)
	Barcode:setImage(RegisterImage(0xF6039431B0986D6))
	self:addElement(Barcode)
	self.Barcode = Barcode
	local FrameTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -1, 15)
	FrameTop:setImage(RegisterImage(0xA924FF7151BEECF))
	self:addElement(FrameTop)
	self.FrameTop = FrameTop
	local FrameBot = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -15, 1)
	FrameBot:setXRot(180)
	FrameBot:setImage(RegisterImage(0xA924FF7151BEECF))
	self:addElement(FrameBot)
	self.FrameBot = FrameBot
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
