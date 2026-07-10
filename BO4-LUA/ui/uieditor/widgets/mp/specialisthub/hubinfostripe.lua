require("x64:6c93bfd7fc87ac6")
CoD.HubInfoStripe = InheritFrom(LUI.UIElement)
CoD.HubInfoStripe.__defaultWidth = 487
CoD.HubInfoStripe.__defaultHeight = 16
CoD.HubInfoStripe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubInfoStripe)
	self.id = "HubInfoStripe"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local CommonStripeBar = CoD.CommonStripeBar.new(f1_arg0, f1_arg1, 0, 0, -104.5, 591.5, 0, 0, 0, 16)
	self:addElement(CommonStripeBar)
	self.CommonStripeBar = CommonStripeBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.HubInfoStripe.__onClose = function(f2_arg0)
	f2_arg0.CommonStripeBar:close()
end
