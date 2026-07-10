require("x64:feb97a42d076e79")
CoD.UpsellBanner = InheritFrom(LUI.UIElement)
CoD.UpsellBanner.__defaultWidth = 540
CoD.UpsellBanner.__defaultHeight = 150
CoD.UpsellBanner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.UpsellBanner)
	self.id = "UpsellBanner"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local UpsellBannerInternal = CoD.UpsellBanner_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 0, 150)
	UpsellBannerInternal:linkToElementModel(self, nil, false, function(model)
		UpsellBannerInternal:setModel(model, f1_arg1)
	end)
	self:addElement(UpsellBannerInternal)
	self.UpsellBannerInternal = UpsellBannerInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.UpsellBanner.__onClose = function(f3_arg0)
	f3_arg0.UpsellBannerInternal:close()
end
