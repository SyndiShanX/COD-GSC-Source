CoD.ContractItemBacker = InheritFrom(LUI.UIElement)
CoD.ContractItemBacker.__defaultWidth = 418
CoD.ContractItemBacker.__defaultHeight = 189
CoD.ContractItemBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractItemBacker)
	self.id = "ContractItemBacker"
	self.soundSet = "default"
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.34, 0.39, 0.41)
	self:addElement(Background)
	self.Background = Background
	local Noise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Noise:setAlpha(0.3)
	Noise:setImage(RegisterImage(0x34839E8065B1E53))
	Noise:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	Noise:setShaderVector(0, 0, 0, 0, 0)
	Noise:setupNineSliceShader(196, 88)
	self:addElement(Noise)
	self.Noise = Noise
	local LED = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LED:setRGB(0, 0, 0)
	LED:setImage(RegisterImage(0x4B6FFA90272070E))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	LED:setShaderVector(0, 0, 0, 0, 0)
	LED:setupNineSliceShader(24, 24)
	self:addElement(LED)
	self.LED = LED
	local FrameBorder = LUI.UIImage.new(0, 1, 2, 0, 0, 1, 2, 0)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.87, 0.87, 0.87)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0xE7BDCB879A5176D))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setShaderVector(1, 0, 0, 0, 0)
	Border:setupNineSliceShader(1, 1)
	self:addElement(Border)
	self.Border = Border
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
