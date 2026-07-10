CoD.StoreSpinner = InheritFrom(LUI.UIElement)
CoD.StoreSpinner.__defaultWidth = 96
CoD.StoreSpinner.__defaultHeight = 96
CoD.StoreSpinner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StoreSpinner)
	self.id = "StoreSpinner"
	self.soundSet = "default"
	local SpinnerFlipbook = LUI.UIImage.new(0, 0, -11, 106, 0, 0, -11, 106)
	SpinnerFlipbook:setRGB(1, 0.63, 0)
	SpinnerFlipbook:setImage(RegisterImage(0xD7107421B53850D))
	SpinnerFlipbook:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	SpinnerFlipbook:setShaderVector(0, 28, 0, 0, 0)
	SpinnerFlipbook:setShaderVector(1, 22, 0, 0, 0)
	self:addElement(SpinnerFlipbook)
	self.SpinnerFlipbook = SpinnerFlipbook
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
