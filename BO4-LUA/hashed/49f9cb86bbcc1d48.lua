CoD.SupplyChainBumperPointers = InheritFrom(LUI.UIElement)
CoD.SupplyChainBumperPointers.__defaultWidth = 32
CoD.SupplyChainBumperPointers.__defaultHeight = 80
CoD.SupplyChainBumperPointers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainBumperPointers)
	self.id = "SupplyChainBumperPointers"
	self.soundSet = "default"
	local pointer = LUI.UIImage.new(0, 0, 2.5, 34.5, 0, 0, 16.5, 83.5)
	pointer:setImage(RegisterImage(@"uie_ui_menu_item_shop_tier_pointer"))
	pointer:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	pointer:setShaderVector(0, 1.1, 0, 0, 0)
	self:addElement(pointer)
	self.pointer = pointer
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
