CoD.UpsellWidget = InheritFrom(LUI.UIElement)
CoD.UpsellWidget.__defaultWidth = 200
CoD.UpsellWidget.__defaultHeight = 72
CoD.UpsellWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.UpsellWidget)
	self.id = "UpsellWidget"
	self.soundSet = "none"
	local upsellIcon = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	upsellIcon:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/purchase_icon"))
	upsellIcon:setTTF("default")
	upsellIcon:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(upsellIcon)
	self.upsellIcon = upsellIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
