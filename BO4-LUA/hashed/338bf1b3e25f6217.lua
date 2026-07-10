CoD.ZMInventoryListBackingInternalTip = InheritFrom(LUI.UIElement)
CoD.ZMInventoryListBackingInternalTip.__defaultWidth = 100
CoD.ZMInventoryListBackingInternalTip.__defaultHeight = 80
CoD.ZMInventoryListBackingInternalTip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInventoryListBackingInternalTip)
	self.id = "ZMInventoryListBackingInternalTip"
	self.soundSet = "none"
	local Base = LUI.UIImage.new(0, 0, -10, 56, 0, 1, 0, 0)
	Base:setRGB(0, 0, 0)
	Base:setAlpha(0.9)
	Base:setImage(RegisterImage(0x525AE154E13C7))
	Base:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	Base:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Base)
	self.Base = Base
	local BaseGradient = LUI.UIImage.new(0, 0, 56, 200, 0, 1, 0, 0)
	BaseGradient:setRGB(0, 0, 0)
	BaseGradient:setAlpha(0.5)
	BaseGradient:setMaterial(LUI.UIImage.GetCachedMaterial(0xDE760AC0E801E57))
	BaseGradient:setShaderVector(0, 0, 0, 0, 3.45)
	BaseGradient:setShaderVector(1, 0, 0, 0, 0)
	BaseGradient:setShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(BaseGradient)
	self.BaseGradient = BaseGradient
	local BG = LUI.UIImage.new(0, 0, 0, 200, 0, 1, 0, 0)
	BG:setAlpha(0.9)
	BG:setImage(RegisterImage(0x21A00C64313D22F))
	BG:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	BG:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BG)
	self.BG = BG
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
