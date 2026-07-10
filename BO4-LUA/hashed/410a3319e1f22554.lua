CoD.PurchaseItemContentImage = InheritFrom(LUI.UIElement)
CoD.PurchaseItemContentImage.__defaultWidth = 832
CoD.PurchaseItemContentImage.__defaultHeight = 376
CoD.PurchaseItemContentImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchaseItemContentImage)
	self.id = "PurchaseItemContentImage"
	self.soundSet = "default"
	local ContractImage = LUI.UIImage.new(0, 0, 74, 906, 0, 0, 0, 376)
	ContractImage:setScale(0.66, 0.66)
	ContractImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	ContractImage:setShaderVector(0, 0.36, 1, 0, 0)
	ContractImage:setShaderVector(1, 0.43, 0.18, 0, 0)
	ContractImage:setShaderVector(2, 0, 1, 0, 0)
	ContractImage:setShaderVector(3, 0.18, 0.14, 0, 0)
	ContractImage:setShaderVector(4, 0, 0, 0, 0)
	ContractImage:linkToElementModel(self, "previewImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContractImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ContractImage)
	self.ContractImage = ContractImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PurchaseItemContentImage.__onClose = function(f3_arg0)
	f3_arg0.ContractImage:close()
end
