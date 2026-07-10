CoD.PC_BnetStore_Background = InheritFrom(LUI.UIElement)
CoD.PC_BnetStore_Background.__defaultWidth = 620
CoD.PC_BnetStore_Background.__defaultHeight = 770
CoD.PC_BnetStore_Background.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BnetStore_Background)
	self.id = "PC_BnetStore_Background"
	self.soundSet = "default"
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0, 0, 0)
	BG:setAlpha(0.9)
	self:addElement(BG)
	self.BG = BG
	local VerticalBGPattern2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	VerticalBGPattern2:setAlpha(0.05)
	VerticalBGPattern2:setImage(RegisterImage(@"uie_ui_menu_cac_vertical_pattern_bg"))
	VerticalBGPattern2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	VerticalBGPattern2:setShaderVector(0, 0, 0, 0, 0)
	VerticalBGPattern2:setupNineSliceShader(256, 256)
	self:addElement(VerticalBGPattern2)
	self.VerticalBGPattern2 = VerticalBGPattern2
	local LineTop = LUI.UIImage.new(0, 1, 1, -1, 0, 0, 0, 1)
	LineTop:setAlpha(0.08)
	self:addElement(LineTop)
	self.LineTop = LineTop
	local LineTopLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 20)
	LineTopLeft:setAlpha(0.08)
	self:addElement(LineTopLeft)
	self.LineTopLeft = LineTopLeft
	local LineTopRight = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 20)
	LineTopRight:setAlpha(0.08)
	self:addElement(LineTopRight)
	self.LineTopRight = LineTopRight
	local DotTopRight = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 1)
	DotTopRight:setAlpha(0.46)
	self:addElement(DotTopRight)
	self.DotTopRight = DotTopRight
	local DotTopRight2 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 28, 29)
	DotTopRight2:setAlpha(0.46)
	self:addElement(DotTopRight2)
	self.DotTopRight2 = DotTopRight2
	local DotTopLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	DotTopLeft:setAlpha(0.46)
	self:addElement(DotTopLeft)
	self.DotTopLeft = DotTopLeft
	local DotTopLeft2 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 28, 29)
	DotTopLeft2:setAlpha(0.46)
	self:addElement(DotTopLeft2)
	self.DotTopLeft2 = DotTopLeft2
	local LineBtm = LUI.UIImage.new(0, 1, 1, -1, 1, 1, -1, 0)
	LineBtm:setAlpha(0.08)
	self:addElement(LineBtm)
	self.LineBtm = LineBtm
	local LineBtmLeft = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -15, 0)
	LineBtmLeft:setAlpha(0.08)
	self:addElement(LineBtmLeft)
	self.LineBtmLeft = LineBtmLeft
	local LineBtmRight = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -15, 0)
	LineBtmRight:setAlpha(0.08)
	self:addElement(LineBtmRight)
	self.LineBtmRight = LineBtmRight
	local DotBtmRight = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	DotBtmRight:setAlpha(0.46)
	self:addElement(DotBtmRight)
	self.DotBtmRight = DotBtmRight
	local DotBtmLeft = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	DotBtmLeft:setAlpha(0.46)
	self:addElement(DotBtmLeft)
	self.DotBtmLeft = DotBtmLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
