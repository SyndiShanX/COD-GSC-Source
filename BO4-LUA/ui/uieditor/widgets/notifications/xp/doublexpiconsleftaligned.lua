require("ui/uieditor/widgets/notifications/xp/doublexpiconsinternal")
CoD.DoubleXPIconsLeftAligned = InheritFrom(LUI.UIElement)
CoD.DoubleXPIconsLeftAligned.__defaultWidth = 216
CoD.DoubleXPIconsLeftAligned.__defaultHeight = 72
CoD.DoubleXPIconsLeftAligned.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.DoubleXPIconsLeftAligned)
	self.id = "DoubleXPIconsLeftAligned"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DoubleXPIconsInternal = CoD.DoubleXPIconsInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 216, 0, 0, 0, 72)
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
CoD.DoubleXPIconsLeftAligned.__onClose = function(f3_arg0)
	f3_arg0.DoubleXPIconsInternal:close()
end
