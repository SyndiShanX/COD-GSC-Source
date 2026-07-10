require("x64:aee1a1961c44090")
CoD.SupplyChainStream = InheritFrom(LUI.UIElement)
CoD.SupplyChainStream.__defaultWidth = 349
CoD.SupplyChainStream.__defaultHeight = 158
CoD.SupplyChainStream.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainStream)
	self.id = "SupplyChainStream"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local dotline = CoD.SupplyChainStreamInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -175, 174, 0.5, 0.5, -80, 78)
	dotline:linkToElementModel(self, nil, false, function(model)
		dotline:setModel(model, f1_arg1)
	end)
	self:addElement(dotline)
	self.dotline = dotline
	dotline.id = "dotline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainStream.__onClose = function(f3_arg0)
	f3_arg0.dotline:close()
end
