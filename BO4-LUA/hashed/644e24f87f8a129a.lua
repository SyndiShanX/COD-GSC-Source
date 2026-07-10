require("x64:dab8c3a6f5b136c")
require("x64:2675595fa323085")
CoD.IGRPerksListBacking = InheritFrom(LUI.UIElement)
CoD.IGRPerksListBacking.__defaultWidth = 2140
CoD.IGRPerksListBacking.__defaultHeight = 253
CoD.IGRPerksListBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IGRPerksListBacking)
	self.id = "IGRPerksListBacking"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	local FocusGlow = LUI.UIImage.new(0, 1, -35, 35, 0, 1, -35, 35)
	FocusGlow:setAlpha(0.5)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_small"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0, 0)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(70, 70)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.7, 0.7, 0.7)
	self:addElement(BG)
	self.BG = BG
	local Noise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Noise:setAlpha(0.9)
	Noise:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	Noise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	Noise:setShaderVector(0, 0, 0, 0, 0)
	Noise:setupNineSliceShader(64, 64)
	self:addElement(Noise)
	self.Noise = Noise
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setImage(RegisterImage(@"hash_415BB65132BCEED9"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(8, 8)
	self:addElement(Border)
	self.Border = Border
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local CommonPixelBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonPixelBacking:setRGB(0.3, 0.3, 0.3)
	CommonPixelBacking.NoiseBacking:setAlpha(1)
	CommonPixelBacking.TiledShaderImage:setAlpha(0.15)
	CommonPixelBacking.TiledShaderImage:setupNineSliceShader(35, 35)
	self:addElement(CommonPixelBacking)
	self.CommonPixelBacking = CommonPixelBacking
	emptyFocusable.id = "emptyFocusable"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IGRPerksListBacking.__onClose = function(f2_arg0)
	f2_arg0.emptyFocusable:close()
	f2_arg0.CommonPixelBacking:close()
end
