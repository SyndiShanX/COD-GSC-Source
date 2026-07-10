CoD.EntitlementListItem = InheritFrom(LUI.UIElement)
CoD.EntitlementListItem.__defaultWidth = 550
CoD.EntitlementListItem.__defaultHeight = 40
CoD.EntitlementListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EntitlementListItem)
	self.id = "EntitlementListItem"
	self.soundSet = "none"
	local ItemName = LUI.UIText.new(0, 0, 10, 540, 0.5, 0.5, -15, 18)
	ItemName:setTTF("ttmussels_regular")
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ItemName:linkToElementModel(self, "displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ItemName:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(ItemName)
	self.ItemName = ItemName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EntitlementListItem.__onClose = function(f3_arg0)
	f3_arg0.ItemName:close()
end
