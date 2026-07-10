require("x64:6ea41c16ab56c2b")
CoD.SupplyChainItem = InheritFrom(LUI.UIElement)
CoD.SupplyChainItem.__defaultWidth = 140
CoD.SupplyChainItem.__defaultHeight = 158
CoD.SupplyChainItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainItem)
	self.id = "SupplyChainItem"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LockImage = CoD.SupplyChainItemInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 158)
	LockImage:linkToElementModel(self, nil, false, function(model)
		LockImage:setModel(model, f1_arg1)
	end)
	self:addElement(LockImage)
	self.LockImage = LockImage
	LockImage.id = "LockImage"
	self.__defaultFocus = LockImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainItem.__resetProperties = function(f3_arg0)
	f3_arg0.LockImage:completeAnimation()
	f3_arg0.LockImage:setRGB(1, 1, 1)
end
CoD.SupplyChainItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Active = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.LockImage:completeAnimation()
			f5_arg0.LockImage:setRGB(1, 1, 1)
			f5_arg0.clipFinished(f5_arg0.LockImage)
		end,
	},
}
CoD.SupplyChainItem.__onClose = function(f6_arg0)
	f6_arg0.LockImage:close()
end
