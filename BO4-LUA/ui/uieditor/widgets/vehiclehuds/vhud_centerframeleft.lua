CoD.vhud_CenterFrameLeft = InheritFrom(LUI.UIElement)
CoD.vhud_CenterFrameLeft.__defaultWidth = 375
CoD.vhud_CenterFrameLeft.__defaultHeight = 484
CoD.vhud_CenterFrameLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_CenterFrameLeft)
	self.id = "vhud_CenterFrameLeft"
	self.soundSet = "default"
	local FrameHlineLeft = LUI.UIImage.new(0, 0, 193, 375, 0, 0, 238, 246)
	FrameHlineLeft:setImage(RegisterImage(0x9F9F4F6492BE854))
	self:addElement(FrameHlineLeft)
	self.FrameHlineLeft = FrameHlineLeft
	local FrameEngineLeft = LUI.UIImage.new(0, 0, 145, 185, 0, 0, 235, 281)
	FrameEngineLeft:setImage(RegisterImage(0x5338AA8246DD618))
	self:addElement(FrameEngineLeft)
	self.FrameEngineLeft = FrameEngineLeft
	local FrameRulerLeft = LUI.UIImage.new(0, 0, 92, 124, 0, 0, 11, 473)
	FrameRulerLeft:setImage(RegisterImage(0x3D4909F8A3D78E))
	self:addElement(FrameRulerLeft)
	self.FrameRulerLeft = FrameRulerLeft
	local FrameGraphicLeft = LUI.UIImage.new(0, 0, 74, 110, 0, 0, 0, 484)
	FrameGraphicLeft:setImage(RegisterImage(0xCCB3C262A05836A))
	self:addElement(FrameGraphicLeft)
	self.FrameGraphicLeft = FrameGraphicLeft
	local FrameBoxesLeft = LUI.UIImage.new(0, 0, 0, 74, 0, 0, 224, 260)
	FrameBoxesLeft:setImage(RegisterImage(0xC6FA7184B0307E7))
	self:addElement(FrameBoxesLeft)
	self.FrameBoxesLeft = FrameBoxesLeft
	local FrameVlineLeft = LUI.UIImage.new(0, 0, 124, 146, 0.5, 0.5, -241, 241)
	FrameVlineLeft:setImage(RegisterImage(0xBF1249DF22785BE))
	self:addElement(FrameVlineLeft)
	self.FrameVlineLeft = FrameVlineLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
