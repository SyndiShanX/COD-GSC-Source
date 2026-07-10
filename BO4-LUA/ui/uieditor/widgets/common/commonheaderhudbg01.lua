CoD.CommonHeaderHUDBG01 = InheritFrom(LUI.UIElement)
CoD.CommonHeaderHUDBG01.__defaultWidth = 675
CoD.CommonHeaderHUDBG01.__defaultHeight = 52
CoD.CommonHeaderHUDBG01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonHeaderHUDBG01)
	self.id = "CommonHeaderHUDBG01"
	self.soundSet = "default"
	local CommonHeaderBG01 = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -26, 26)
	CommonHeaderBG01:setImage(RegisterImage(0x74F7F572B3A3C58))
	CommonHeaderBG01:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	CommonHeaderBG01:setShaderVector(0, 0, 0, 0, 0)
	CommonHeaderBG01:setupNineSliceShader(52, 52)
	self:addElement(CommonHeaderBG01)
	self.CommonHeaderBG01 = CommonHeaderBG01
	local PipTL = LUI.UIImage.new(0, 0, -4, 4, 0, 0, -4, 4)
	PipTL:setImage(RegisterImage(0xAC3234E1F71D1D6))
	PipTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PipTL)
	self.PipTL = PipTL
	local PipTL2 = LUI.UIImage.new(1, 1, -4, 4, 0, 0, -4, 4)
	PipTL2:setImage(RegisterImage(0xAC3234E1F71D1D6))
	PipTL2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PipTL2)
	self.PipTL2 = PipTL2
	local PipBL = LUI.UIImage.new(0, 0, -4, 4, 1, 1, -4, 4)
	PipBL:setImage(RegisterImage(0xAC3234E1F71D1D6))
	PipBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PipBL)
	self.PipBL = PipBL
	local PipBL2 = LUI.UIImage.new(1, 1, -4, 4, 1, 1, -4, 4)
	PipBL2:setImage(RegisterImage(0xAC3234E1F71D1D6))
	PipBL2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PipBL2)
	self.PipBL2 = PipBL2
	local CommonLineAccentLeft = LUI.UIImage.new(0, 0, -552, -12, 0.5, 0.5, -2, 2)
	CommonLineAccentLeft:setAlpha(0.66)
	CommonLineAccentLeft:setImage(RegisterImage(0xFE30A9AF719A400))
	CommonLineAccentLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	CommonLineAccentLeft:setShaderVector(0, 0, 0, 0, 0)
	CommonLineAccentLeft:setupNineSliceShader(8, 4)
	self:addElement(CommonLineAccentLeft)
	self.CommonLineAccentLeft = CommonLineAccentLeft
	local CommonLineAccentRight = LUI.UIImage.new(1, 1, 12, 524, 0.5, 0.5, -2, 2)
	CommonLineAccentRight:setAlpha(0.66)
	CommonLineAccentRight:setImage(RegisterImage(0xFE30A9AF719A400))
	CommonLineAccentRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	CommonLineAccentRight:setShaderVector(0, 0, 0, 0, 0)
	CommonLineAccentRight:setupNineSliceShader(8, 4)
	self:addElement(CommonLineAccentRight)
	self.CommonLineAccentRight = CommonLineAccentRight
	local PipL = LUI.UIImage.new(0, 0, -570, -562, 0.5, 0.5, -4, 4)
	PipL:setImage(RegisterImage(0xAC3234E1F71D1D6))
	PipL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PipL)
	self.PipL = PipL
	local PipR = LUI.UIImage.new(1, 1, 562, 570, 0.5, 0.5, -4, 4)
	PipR:setAlpha(0)
	PipR:setImage(RegisterImage(0xAC3234E1F71D1D6))
	PipR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PipR)
	self.PipR = PipR
	local VerticalAccentLeft = LUI.UIImage.new(0, 0, -35, 21, 0.5, 0.5, -4, 4)
	VerticalAccentLeft:setAlpha(0.5)
	VerticalAccentLeft:setZRot(-90)
	VerticalAccentLeft:setImage(RegisterImage(0xFE30A9AF719A400))
	VerticalAccentLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	VerticalAccentLeft:setShaderVector(0, 0, 0, 0, 0)
	VerticalAccentLeft:setupNineSliceShader(8, 4)
	self:addElement(VerticalAccentLeft)
	self.VerticalAccentLeft = VerticalAccentLeft
	local VerticalAccentRight = LUI.UIImage.new(1, 1, -21, 35, 0.5, 0.5, -4, 4)
	VerticalAccentRight:setAlpha(0.5)
	VerticalAccentRight:setZRot(90)
	VerticalAccentRight:setImage(RegisterImage(0xFE30A9AF719A400))
	VerticalAccentRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	VerticalAccentRight:setShaderVector(0, 0, 0, 0, 0)
	VerticalAccentRight:setupNineSliceShader(8, 4)
	self:addElement(VerticalAccentRight)
	self.VerticalAccentRight = VerticalAccentRight
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
