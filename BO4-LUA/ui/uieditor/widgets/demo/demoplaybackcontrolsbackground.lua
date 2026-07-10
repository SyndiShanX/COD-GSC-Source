CoD.DemoPlaybackControlsBackground = InheritFrom(LUI.UIElement)
CoD.DemoPlaybackControlsBackground.__defaultWidth = 960
CoD.DemoPlaybackControlsBackground.__defaultHeight = 176
CoD.DemoPlaybackControlsBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoPlaybackControlsBackground)
	self.id = "DemoPlaybackControlsBackground"
	self.soundSet = "none"
	local BGBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlur:setImage(RegisterImage(0x8FD6CEEA1F2AEEA))
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local BGTint = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 176)
	BGTint:setRGB(0, 0, 0)
	BGTint:setAlpha(0.7)
	BGTint:setImage(RegisterImage(0x8FD6CEEA1F2AEEA))
	BGTint:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	BGTint:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(BGTint)
	self.BGTint = BGTint
	local PixelGridTiledBacking = LUI.UIImage.new(0.5, 0.5, -470, 470, 0.5, 0.5, -69, 69)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local FrameInnerTL = LUI.UIImage.new(0.5, 0.5, -480, 0, 0.5, 0.5, -88, 0)
	FrameInnerTL:setAlpha(0.8)
	FrameInnerTL:setImage(RegisterImage(0x15BAED0FC792DA9))
	self:addElement(FrameInnerTL)
	self.FrameInnerTL = FrameInnerTL
	local FrameInnerBL = LUI.UIImage.new(0.5, 0.5, -480, 0, 0.5, 0.5, 0, 88)
	FrameInnerBL:setAlpha(0.8)
	FrameInnerBL:setYRot(180)
	FrameInnerBL:setZRot(180)
	FrameInnerBL:setImage(RegisterImage(0x15BAED0FC792DA9))
	self:addElement(FrameInnerBL)
	self.FrameInnerBL = FrameInnerBL
	local FrameInnerTR = LUI.UIImage.new(0.5, 0.5, 0, 480, 0.5, 0.5, -88, 0)
	FrameInnerTR:setAlpha(0.8)
	FrameInnerTR:setImage(RegisterImage(0x386BA4A3F163950))
	self:addElement(FrameInnerTR)
	self.FrameInnerTR = FrameInnerTR
	local FrameInnerBR = LUI.UIImage.new(0.5, 0.5, 0, 480, 0.5, 0.5, 0, 88)
	FrameInnerBR:setAlpha(0.8)
	FrameInnerBR:setZRot(180)
	FrameInnerBR:setImage(RegisterImage(0x15BAED0FC792DA9))
	self:addElement(FrameInnerBR)
	self.FrameInnerBR = FrameInnerBR
	local FrameOutterTL = LUI.UIImage.new(0.5, 0.5, -480, 0, 0.5, 0.5, -88, 0)
	FrameOutterTL:setAlpha(0.8)
	FrameOutterTL:setImage(RegisterImage(0x927CBFFFB6EE834))
	self:addElement(FrameOutterTL)
	self.FrameOutterTL = FrameOutterTL
	local FrameOutterTR = LUI.UIImage.new(0.5, 0.5, 0, 480, 0.5, 0.5, -88, 0)
	FrameOutterTR:setAlpha(0.8)
	FrameOutterTR:setImage(RegisterImage(0x31F12D06DAFCBF9))
	self:addElement(FrameOutterTR)
	self.FrameOutterTR = FrameOutterTR
	local FrameOutterBL = LUI.UIImage.new(0.5, 0.5, -480, 0, 0.5, 0.5, 0, 88)
	FrameOutterBL:setAlpha(0.8)
	FrameOutterBL:setXRot(180)
	FrameOutterBL:setImage(RegisterImage(0x927CBFFFB6EE834))
	self:addElement(FrameOutterBL)
	self.FrameOutterBL = FrameOutterBL
	local FrameOutterBR = LUI.UIImage.new(0.5, 0.5, 0, 480, 0.5, 0.5, 0, 88)
	FrameOutterBR:setAlpha(0.8)
	FrameOutterBR:setXRot(180)
	FrameOutterBR:setYRot(180)
	FrameOutterBR:setImage(RegisterImage(0x927CBFFFB6EE834))
	self:addElement(FrameOutterBR)
	self.FrameOutterBR = FrameOutterBR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
