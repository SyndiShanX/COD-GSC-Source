require("x64:49ba233f7105cb5")
CoD.WildcardSlotContainer = InheritFrom(LUI.UIElement)
CoD.WildcardSlotContainer.__defaultWidth = 148
CoD.WildcardSlotContainer.__defaultHeight = 226
CoD.WildcardSlotContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WildcardSlotContainer)
	self.id = "WildcardSlotContainer"
	self.soundSet = "CAC"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WildcardSlot = CoD.CommonItemSlotTall.new(f1_arg0, f1_arg1, 0, 0, -6, 142, 0, 0, -9, 217)
	WildcardSlot:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.BonuscardUtility.IsBonuscardEquippedInCurrentClass(menu, element)
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsItemNew(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "canEquipBonuscard")
			end,
		},
		{
			stateName = "DefaultStateHiddenName",
			condition = function(menu, element, event)
				return IsElementPropertyValue(menu, "_showItemNameOnButtonHold", true)
			end,
		},
	})
	WildcardSlot:linkToElementModel(WildcardSlot, "itemIndex", true, function(model)
		f1_arg0:updateElementState(WildcardSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local2 = WildcardSlot
	local f1_local3 = WildcardSlot.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["CustomClassList.equippedItemsChanged"], function(f8_arg0)
		f1_arg0:updateElementState(WildcardSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	WildcardSlot:linkToElementModel(WildcardSlot, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(WildcardSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	WildcardSlot:linkToElementModel(WildcardSlot, "canEquipBonuscard", true, function(model)
		f1_arg0:updateElementState(WildcardSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "canEquipBonuscard",
		})
	end)
	WildcardSlot:setScale(0.92, 0.92)
	WildcardSlot:linkToElementModel(self, nil, false, function(model)
		WildcardSlot:setModel(model, f1_arg1)
	end)
	WildcardSlot:linkToElementModel(self, "image", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			WildcardSlot.ItemImage:setImage(CoD.BaseUtility.AlreadyRegistered(f12_local0))
		end
	end)
	WildcardSlot:linkToElementModel(self, "displayNameShort", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			WildcardSlot.ItemName.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f13_local0))
		end
	end)
	self:addElement(WildcardSlot)
	self.WildcardSlot = WildcardSlot
	WildcardSlot.id = "WildcardSlot"
	self.__defaultFocus = WildcardSlot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WildcardSlotContainer.__resetProperties = function(f14_arg0)
	f14_arg0.WildcardSlot:completeAnimation()
	f14_arg0.WildcardSlot:setScale(0.92, 0.92)
end
CoD.WildcardSlotContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.WildcardSlot:completeAnimation()
			f16_arg0.WildcardSlot:setScale(0.97, 0.97)
			f16_arg0.clipFinished(f16_arg0.WildcardSlot)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.WildcardSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f17_arg0.WildcardSlot:setScale(0.97, 0.97)
				f17_arg0.WildcardSlot:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.WildcardSlot:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.WildcardSlot:completeAnimation()
			f17_arg0.WildcardSlot:setScale(1, 1)
			f17_local0(f17_arg0.WildcardSlot)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.WildcardSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f19_arg0.WildcardSlot:setScale(1, 1)
				f19_arg0.WildcardSlot:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.WildcardSlot:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.WildcardSlot:completeAnimation()
			f19_arg0.WildcardSlot:setScale(0.97, 0.97)
			f19_local0(f19_arg0.WildcardSlot)
		end,
	},
}
CoD.WildcardSlotContainer.__onClose = function(f21_arg0)
	f21_arg0.WildcardSlot:close()
end
