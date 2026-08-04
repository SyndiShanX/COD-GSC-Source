CoD.DialogSpinner = InheritFrom(LUI.UIElement)
CoD.DialogSpinner.__defaultWidth = 192
CoD.DialogSpinner.__defaultHeight = 192
CoD.DialogSpinner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DialogSpinner)
	self.id = "DialogSpinner"
	self.soundSet = "default"
	local SpinnerFlipbook = LUI.UIImage.new(0, 0, 0, 192, 0, 0, 0, 192)
	SpinnerFlipbook:setImage(RegisterImage("t7_menu_loadingspinner_flipbook"))
	SpinnerFlipbook:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	SpinnerFlipbook:setShaderVector(0, 28, 0, 0, 0)
	SpinnerFlipbook:setShaderVector(1, 22, 0, 0, 0)
	self:addElement(SpinnerFlipbook)
	self.SpinnerFlipbook = SpinnerFlipbook
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
