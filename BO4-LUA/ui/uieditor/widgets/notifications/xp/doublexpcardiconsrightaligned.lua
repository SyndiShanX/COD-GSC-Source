require("x64:1053cc2f0b27dee")
CoD.DoubleXPCardIconsRightAligned = InheritFrom(LUI.UIElement)
CoD.DoubleXPCardIconsRightAligned.__defaultWidth = 129
CoD.DoubleXPCardIconsRightAligned.__defaultHeight = 43
CoD.DoubleXPCardIconsRightAligned.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.DoubleXPCardIconsRightAligned)
	self.id = "DoubleXPCardIconsRightAligned"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DoubleXPCardIconsInternal = CoD.DoubleXPCardIconsInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 129, 0, 0, 0, 43)
	DoubleXPCardIconsInternal:linkToElementModel(self, nil, false, function(model)
		DoubleXPCardIconsInternal:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPCardIconsInternal)
	self.DoubleXPCardIconsInternal = DoubleXPCardIconsInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPCardIconsRightAligned.__onClose = function(f3_arg0)
	f3_arg0.DoubleXPCardIconsInternal:close()
end
