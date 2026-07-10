CoD.PC_BnetStore_LegalButton = InheritFrom(LUI.UIElement)
CoD.PC_BnetStore_LegalButton.__defaultWidth = 640
CoD.PC_BnetStore_LegalButton.__defaultHeight = 64
CoD.PC_BnetStore_LegalButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BnetStore_LegalButton)
	self.id = "PC_BnetStore_LegalButton"
	self.soundSet = "default"
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.44, 0.44, 0.44)
	BG:setAlpha(0.3)
	self:addElement(BG)
	self.BG = BG
	local LegalButtonTitle = LUI.UIText.new(0, 1, 25, -25, 0.5, 0.5, -9, 9)
	LegalButtonTitle:setRGB(0.47, 0.47, 0.47)
	LegalButtonTitle:setText(LocalizeToUpperString(0x93E719493E9E18F))
	LegalButtonTitle:setTTF("dinnext_regular")
	LegalButtonTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LegalButtonTitle:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(LegalButtonTitle)
	self.LegalButtonTitle = LegalButtonTitle
	local DotTL = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 15, 16)
	DotTL:setAlpha(0.8)
	self:addElement(DotTL)
	self.DotTL = DotTL
	local DotTR = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 15, 16)
	DotTR:setAlpha(0.8)
	self:addElement(DotTR)
	self.DotTR = DotTR
	local LineTopLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 10)
	LineTopLeft:setAlpha(0.15)
	self:addElement(LineTopLeft)
	self.LineTopLeft = LineTopLeft
	local LineTopRight = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 10)
	LineTopRight:setAlpha(0.15)
	self:addElement(LineTopRight)
	self.LineTopRight = LineTopRight
	local LineBtm = LUI.UIImage.new(0, 1, 1, -1, 1, 1, -1, 0)
	LineBtm:setAlpha(0.15)
	self:addElement(LineBtm)
	self.LineBtm = LineBtm
	local DotBR = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	DotBR:setAlpha(0.8)
	self:addElement(DotBR)
	self.DotBR = DotBR
	local DotBL = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	DotBL:setAlpha(0.8)
	self:addElement(DotBL)
	self.DotBL = DotBL
	local LineTop = LUI.UIImage.new(0, 1, 1, -1, 0, 0, 0, 1)
	LineTop:setAlpha(0.15)
	self:addElement(LineTop)
	self.LineTop = LineTop
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
