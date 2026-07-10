CoD.Battlenet_Checkout_View = InheritFrom(LUI.UIElement)
CoD.Battlenet_Checkout_View.__defaultWidth = 500
CoD.Battlenet_Checkout_View.__defaultHeight = 500
CoD.Battlenet_Checkout_View.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Battlenet_Checkout_View)
	self.id = "Battlenet_Checkout_View"
	self.soundSet = "none"
	local Image2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Image2)
	self.Image2 = Image2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.PCUtility.SetupBattlenetCheckoutElement(Image2)
	return self
end
CoD.Battlenet_Checkout_View.__onClose = function(f2_arg0)
	f2_arg0.Image2:close()
end
