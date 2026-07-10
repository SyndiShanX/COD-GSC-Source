require("x64:49ba233f7105cb5")
CoD.WildcardLoadoutListItem = InheritFrom(LUI.UIElement)
CoD.WildcardLoadoutListItem.__defaultWidth = 110
CoD.WildcardLoadoutListItem.__defaultHeight = 168
CoD.WildcardLoadoutListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WildcardLoadoutListItem)
	self.id = "WildcardLoadoutListItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WildcardSlot = CoD.CommonItemSlotTall.new(f1_arg0, f1_arg1, 0, 0, 0, 110, 0, 0, 0, 168)
	WildcardSlot:mergeStateConditions({
		{
			stateName = "Add",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "loadoutListItem->itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
		{
			stateName = "DefaultStateHiddenName",
			condition = function(menu, element, event)
				return IsElementPropertyValue(menu, "_showItemNameOnButtonHold", true)
			end,
		},
	})
	WildcardSlot:linkToElementModel(WildcardSlot, "loadoutListItem", true, function(model)
		if WildcardSlot["__stateValidation_loadoutListItem->itemIndex"] then
			WildcardSlot:removeSubscription(WildcardSlot["__stateValidation_loadoutListItem->itemIndex"])
			WildcardSlot["__stateValidation_loadoutListItem->itemIndex"] = nil
		end
		if model then
			local f4_local0 = model:get()
			local f4_local1 = model:get()
			model = f4_local0 and f4_local1.itemIndex
		end
		if model then
			WildcardSlot["__stateValidation_loadoutListItem->itemIndex"] = WildcardSlot:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(WildcardSlot, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "loadoutListItem->itemIndex",
				})
			end)
		end
	end)
	WildcardSlot:linkToElementModel(self, nil, false, function(model)
		WildcardSlot:setModel(model, f1_arg1)
	end)
	WildcardSlot.ItemImage.__Image = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			WildcardSlot.ItemImage:setImage(RegisterImage(f7_local0))
		end
	end
	WildcardSlot:linkToElementModel(self, "loadoutListItem", true, function(model, f8_arg1)
		if f8_arg1["__WildcardSlot.ItemImage.__Image_loadoutListItem->image"] then
			f8_arg1:removeSubscription(f8_arg1["__WildcardSlot.ItemImage.__Image_loadoutListItem->image"])
			f8_arg1["__WildcardSlot.ItemImage.__Image_loadoutListItem->image"] = nil
		end
		if model then
			local f8_local0 = model:get()
			local f8_local1 = model:get()
			model = f8_local0 and f8_local1.image
		end
		if model then
			f8_arg1["__WildcardSlot.ItemImage.__Image_loadoutListItem->image"] = f8_arg1:subscribeToModel(model, WildcardSlot.ItemImage.__Image)
		end
	end)
	WildcardSlot.ItemName.TextBox.__Item_Name = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			WildcardSlot.ItemName.TextBox:setText(Engine[0xF9F1239CFD921FE](f9_local0))
		end
	end
	WildcardSlot:linkToElementModel(self, "loadoutListItem", true, function(model, f10_arg1)
		if f10_arg1["__WildcardSlot.ItemName.TextBox.__Item_Name_loadoutListItem->displayNameShort"] then
			f10_arg1:removeSubscription(f10_arg1["__WildcardSlot.ItemName.TextBox.__Item_Name_loadoutListItem->displayNameShort"])
			f10_arg1["__WildcardSlot.ItemName.TextBox.__Item_Name_loadoutListItem->displayNameShort"] = nil
		end
		if model then
			local f10_local0 = model:get()
			local f10_local1 = model:get()
			model = f10_local0 and f10_local1.displayNameShort
		end
		if model then
			f10_arg1["__WildcardSlot.ItemName.TextBox.__Item_Name_loadoutListItem->displayNameShort"] = f10_arg1:subscribeToModel(model, WildcardSlot.ItemName.TextBox.__Item_Name)
		end
	end)
	self:addElement(WildcardSlot)
	self.WildcardSlot = WildcardSlot
	self:mergeStateConditions({
		{
			stateName = "Add",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "loadoutListItem->itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
	})
	self:linkToElementModel(self, "loadoutListItem", true, function(model)
		if self["__stateValidation_loadoutListItem->itemIndex"] then
			self:removeSubscription(self["__stateValidation_loadoutListItem->itemIndex"])
			self["__stateValidation_loadoutListItem->itemIndex"] = nil
		end
		if model then
			local f12_local0 = model:get()
			local f12_local1 = model:get()
			model = f12_local0 and f12_local1.itemIndex
		end
		if model then
			self["__stateValidation_loadoutListItem->itemIndex"] = self:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "loadoutListItem->itemIndex",
				})
			end)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.CACUtility.UpdateClassWeaponModel(f1_arg0, element, f1_arg1)
	end)
	WildcardSlot.id = "WildcardSlot"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WildcardLoadoutListItem.__resetProperties = function(f15_arg0)
	f15_arg0.WildcardSlot:completeAnimation()
	f15_arg0.WildcardSlot:setScale(1, 1)
end
CoD.WildcardLoadoutListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.WildcardSlot:completeAnimation()
			f17_arg0.WildcardSlot:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.WildcardSlot)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.WildcardSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f18_arg0.WildcardSlot:setScale(1.05, 1.05)
				f18_arg0.WildcardSlot:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.WildcardSlot:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.WildcardSlot:completeAnimation()
			f18_arg0.WildcardSlot:setScale(1, 1)
			f18_local0(f18_arg0.WildcardSlot)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.WildcardSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f20_arg0.WildcardSlot:setScale(1, 1)
				f20_arg0.WildcardSlot:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.WildcardSlot:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.WildcardSlot:completeAnimation()
			f20_arg0.WildcardSlot:setScale(1.05, 1.05)
			f20_local0(f20_arg0.WildcardSlot)
		end,
	},
	Add = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.WildcardSlot:completeAnimation()
			f23_arg0.WildcardSlot:setScale(1.05, 1.05)
			f23_arg0.clipFinished(f23_arg0.WildcardSlot)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.WildcardSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f24_arg0.WildcardSlot:setScale(1.05, 1.05)
				f24_arg0.WildcardSlot:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.WildcardSlot:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.WildcardSlot:completeAnimation()
			f24_arg0.WildcardSlot:setScale(1, 1)
			f24_local0(f24_arg0.WildcardSlot)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.WildcardSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f26_arg0.WildcardSlot:setScale(1, 1)
				f26_arg0.WildcardSlot:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.WildcardSlot:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.WildcardSlot:completeAnimation()
			f26_arg0.WildcardSlot:setScale(1.05, 1.05)
			f26_local0(f26_arg0.WildcardSlot)
		end,
	},
}
CoD.WildcardLoadoutListItem.__onClose = function(f28_arg0)
	f28_arg0.WildcardSlot:close()
end
