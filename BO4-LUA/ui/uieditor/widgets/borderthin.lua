require("x64:983ddadf96d56f1")
require("x64:cf5b4cc5bf2971b")
CoD.BorderThin = InheritFrom(LUI.UIElement)
CoD.BorderThin.__defaultWidth = 319
CoD.BorderThin.__defaultHeight = 136
CoD.BorderThin.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BorderThin)
	self.id = "BorderThin"
	self.soundSet = "default"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0.01)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.4)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBackingAdd:setAlpha(0.35)
	NoiseTiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local BoxButtonLrgInactiveStroke = CoD.cac_ButtonBoxLrgInactiveStroke.new(f1_arg0, f1_arg1, 0, 1, -3, 3, 0, 1, -3, 3)
	BoxButtonLrgInactiveStroke:setAlpha(0)
	self:addElement(BoxButtonLrgInactiveStroke)
	self.BoxButtonLrgInactiveStroke = BoxButtonLrgInactiveStroke
	local BoxButtonLrgInactiveDiag = CoD.cac_ButtonBoxLrgInactiveDiags.new(f1_arg0, f1_arg1, 0, 1, -3, 3, 0, 1, -3, 3)
	BoxButtonLrgInactiveDiag:setAlpha(0)
	self:addElement(BoxButtonLrgInactiveDiag)
	self.BoxButtonLrgInactiveDiag = BoxButtonLrgInactiveDiag
	local BoxButtonLrgInactive = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	BoxButtonLrgInactive:setAlpha(0)
	BoxButtonLrgInactive:setImage(RegisterImage(0x5AF002D5D24FFE3))
	BoxButtonLrgInactive:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoxButtonLrgInactive:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BoxButtonLrgInactive)
	self.BoxButtonLrgInactive = BoxButtonLrgInactive
	local BoxButtonLrgIdle = LUI.UIImage.new(0, 1, -6, 6, 0, 1, -3, 3)
	BoxButtonLrgIdle:setAlpha(0)
	BoxButtonLrgIdle:setImage(RegisterImage(0x535D18C44834110))
	BoxButtonLrgIdle:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoxButtonLrgIdle:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BoxButtonLrgIdle)
	self.BoxButtonLrgIdle = BoxButtonLrgIdle
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.02)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BorderThin.__onClose = function(f2_arg0)
	f2_arg0.BoxButtonLrgInactiveStroke:close()
	f2_arg0.BoxButtonLrgInactiveDiag:close()
end
