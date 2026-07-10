CoD.KillcamKilledByEquipmentItem = InheritFrom(LUI.UIElement)
CoD.KillcamKilledByEquipmentItem.__defaultWidth = 120
CoD.KillcamKilledByEquipmentItem.__defaultHeight = 100
CoD.KillcamKilledByEquipmentItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamKilledByEquipmentItem)
	self.id = "KillcamKilledByEquipmentItem"
	self.soundSet = "none"
	local ItemName = LUI.UIText.new(0, 0, 0, 120, 0, 0, 69, 87)
	ItemName:setTTF("ttmussels_demibold")
	ItemName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	ItemName:setShaderVector(0, 0.2, 0, 0, 0)
	ItemName:setShaderVector(1, 0, 0, 0, 1)
	ItemName:setLetterSpacing(1)
	ItemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ItemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ItemName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ItemName:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(ItemName)
	self.ItemName = ItemName
	local ItemIcon2 = LUI.UIFixedAspectRatioImage.new(0, 0, 28, 92, 0, 0, 5, 69)
	ItemIcon2:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ItemIcon2:setImage(f3_local0)
		end
	end)
	self:addElement(ItemIcon2)
	self.ItemIcon2 = ItemIcon2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamKilledByEquipmentItem.__onClose = function(f4_arg0)
	f4_arg0.ItemName:close()
	f4_arg0.ItemIcon2:close()
end
