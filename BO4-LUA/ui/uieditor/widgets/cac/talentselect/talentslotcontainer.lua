require("x64:96839bd6f46147f")
CoD.TalentSlotContainer = InheritFrom(LUI.UIElement)
CoD.TalentSlotContainer.__defaultWidth = 140
CoD.TalentSlotContainer.__defaultHeight = 90
CoD.TalentSlotContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TalentSlotContainer)
	self.id = "TalentSlotContainer"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TalentSlot = CoD.AttachmentSlot.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	TalentSlot:mergeStateConditions({
		{
			stateName = "NotValid",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.TalentSelectUtility.IsTalentEquippedInCurrentClass(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsItemNew(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "WildcardNotAvailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "WildcardNeeded",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Add",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	TalentSlot:linkToElementModel(TalentSlot, "itemIndex", true, function(model)
		f1_arg0:updateElementState(TalentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local2 = TalentSlot
	local f1_local3 = TalentSlot.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["CustomClassList.equippedItemsChanged"], function(f11_arg0)
		f1_arg0:updateElementState(TalentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	TalentSlot:linkToElementModel(TalentSlot, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(TalentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	TalentSlot:linkToElementModel(self, nil, false, function(model)
		TalentSlot:setModel(model, f1_arg1)
	end)
	TalentSlot:linkToElementModel(self, "image", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			TalentSlot.AttachmentImage:setImage(CoD.BaseUtility.AlreadyRegistered(f14_local0))
		end
	end)
	TalentSlot:linkToElementModel(self, "displayNameShort", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			TalentSlot.AttachmentName.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f15_local0))
		end
	end)
	self:addElement(TalentSlot)
	self.TalentSlot = TalentSlot
	self:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.TalentSelectUtility.IsTalentEquippedInCurrentClass(menu, element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["CustomClassList.equippedItemsChanged"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	TalentSlot.id = "TalentSlot"
	self.__defaultFocus = TalentSlot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TalentSlotContainer.__resetProperties = function(f19_arg0)
	f19_arg0.TalentSlot:completeAnimation()
	f19_arg0.TalentSlot:setScale(1, 1)
end
CoD.TalentSlotContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.TalentSlot:completeAnimation()
			f21_arg0.TalentSlot:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.TalentSlot)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.TalentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f22_arg0.TalentSlot:setScale(1.05, 1.05)
				f22_arg0.TalentSlot:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.TalentSlot:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.TalentSlot:completeAnimation()
			f22_arg0.TalentSlot:setScale(1, 1)
			f22_local0(f22_arg0.TalentSlot)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.TalentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.TalentSlot:setScale(1, 1)
				f24_arg0.TalentSlot:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.TalentSlot:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.TalentSlot:completeAnimation()
			f24_arg0.TalentSlot:setScale(1.05, 1.05)
			f24_local0(f24_arg0.TalentSlot)
		end,
	},
	Equipped = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.TalentSlot:completeAnimation()
			f27_arg0.TalentSlot:setScale(1.05, 1.05)
			f27_arg0.clipFinished(f27_arg0.TalentSlot)
		end,
		GainChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.TalentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f28_arg0.TalentSlot:setScale(1.05, 1.05)
				f28_arg0.TalentSlot:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.TalentSlot:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.TalentSlot:completeAnimation()
			f28_arg0.TalentSlot:setScale(1, 1)
			f28_local0(f28_arg0.TalentSlot)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.TalentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f30_arg0.TalentSlot:setScale(1, 1)
				f30_arg0.TalentSlot:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.TalentSlot:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.TalentSlot:completeAnimation()
			f30_arg0.TalentSlot:setScale(1.05, 1.05)
			f30_local0(f30_arg0.TalentSlot)
		end,
	},
}
CoD.TalentSlotContainer.__onClose = function(f32_arg0)
	f32_arg0.TalentSlot:close()
end
