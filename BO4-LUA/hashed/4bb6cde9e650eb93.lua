CoD.ZMTalismanEquipSlot = InheritFrom(LUI.UIElement)
CoD.ZMTalismanEquipSlot.__defaultWidth = 50
CoD.ZMTalismanEquipSlot.__defaultHeight = 50
CoD.ZMTalismanEquipSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMTalismanEquipSlot)
	self.id = "ZMTalismanEquipSlot"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SlotIcon = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	SlotIcon:setImage(RegisterImage(CoD.ZMTalismanUtility.GetTalismanSlotIcon(CoD.ZMTalismanUtility.TalismanTypes.NONE, 0x621DB435A480979)))
	self:addElement(SlotIcon)
	self.SlotIcon = SlotIcon
	local EquippedTalismanIcon = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	EquippedTalismanIcon:setAlpha(0)
	EquippedTalismanIcon:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EquippedTalismanIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(EquippedTalismanIcon)
	self.EquippedTalismanIcon = EquippedTalismanIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTalismanEquipSlot.__resetProperties = function(f3_arg0)
	f3_arg0.SlotIcon:completeAnimation()
	f3_arg0.EquippedTalismanIcon:completeAnimation()
	f3_arg0.SlotIcon:setAlpha(1)
	f3_arg0.EquippedTalismanIcon:setAlpha(0)
end
CoD.ZMTalismanEquipSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Equipped = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.SlotIcon:completeAnimation()
			f5_arg0.SlotIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.SlotIcon)
			f5_arg0.EquippedTalismanIcon:completeAnimation()
			f5_arg0.EquippedTalismanIcon:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.EquippedTalismanIcon)
		end,
	},
}
CoD.ZMTalismanEquipSlot.__onClose = function(f6_arg0)
	f6_arg0.EquippedTalismanIcon:close()
end
