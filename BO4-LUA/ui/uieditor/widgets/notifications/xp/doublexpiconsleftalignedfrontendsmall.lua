require("x64:29c467d47773861")
CoD.DoubleXPIconsLeftAlignedFrontendSmall = InheritFrom(LUI.UIElement)
CoD.DoubleXPIconsLeftAlignedFrontendSmall.__defaultWidth = 216
CoD.DoubleXPIconsLeftAlignedFrontendSmall.__defaultHeight = 48
CoD.DoubleXPIconsLeftAlignedFrontendSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.DoubleXPIconsLeftAlignedFrontendSmall)
	self.id = "DoubleXPIconsLeftAlignedFrontendSmall"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DoubleXPIconsInternal = CoD.DoubleXPIconsFrontendSmallInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 216, 0, 0, 0, 48)
	DoubleXPIconsInternal:linkToElementModel(self, nil, false, function(model)
		DoubleXPIconsInternal:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPIconsInternal)
	self.DoubleXPIconsInternal = DoubleXPIconsInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPIconsLeftAlignedFrontendSmall.__onClose = function(f3_arg0)
	f3_arg0.DoubleXPIconsInternal:close()
end
