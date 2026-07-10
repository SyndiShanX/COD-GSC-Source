require("x64:59a390eb7025941")
CoD.LoadoutClassItemEquipment = InheritFrom(LUI.UIElement)
CoD.LoadoutClassItemEquipment.__defaultWidth = 213
CoD.LoadoutClassItemEquipment.__defaultHeight = 170
CoD.LoadoutClassItemEquipment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadoutClassItemEquipment)
	self.id = "LoadoutClassItemEquipment"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EquipmentSlot = CoD.CommonItemSlotLarge.new(f1_arg0, f1_arg1, 0, 0, 0, 213, 0, 0, 0, 170)
	EquipmentSlot:linkToElementModel(self, nil, false, function(model)
		EquipmentSlot:setModel(model, f1_arg1)
	end)
	EquipmentSlot:linkToElementModel(self, "imageLarge", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EquipmentSlot.ItemImage:setImage(CoD.BaseUtility.AlreadyRegistered(f3_local0))
		end
	end)
	EquipmentSlot:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EquipmentSlot.ItemName.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(EquipmentSlot)
	self.EquipmentSlot = EquipmentSlot
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.CACUtility.UpdateClassWeaponModel(f1_arg0, element, f1_arg1)
	end)
	EquipmentSlot.id = "EquipmentSlot"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadoutClassItemEquipment.__resetProperties = function(f6_arg0)
	f6_arg0.EquipmentSlot:completeAnimation()
	f6_arg0.EquipmentSlot:setScale(1, 1)
end
CoD.LoadoutClassItemEquipment.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.EquipmentSlot:completeAnimation()
			f8_arg0.EquipmentSlot:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.EquipmentSlot)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.EquipmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f9_arg0.EquipmentSlot:setScale(1.05, 1.05)
				f9_arg0.EquipmentSlot:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.EquipmentSlot:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.EquipmentSlot:completeAnimation()
			f9_arg0.EquipmentSlot:setScale(1, 1)
			f9_local0(f9_arg0.EquipmentSlot)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.EquipmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f11_arg0.EquipmentSlot:setScale(1, 1)
				f11_arg0.EquipmentSlot:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.EquipmentSlot:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.EquipmentSlot:completeAnimation()
			f11_arg0.EquipmentSlot:setScale(1.05, 1.05)
			f11_local0(f11_arg0.EquipmentSlot)
		end,
	},
}
CoD.LoadoutClassItemEquipment.__onClose = function(f13_arg0)
	f13_arg0.EquipmentSlot:close()
end
