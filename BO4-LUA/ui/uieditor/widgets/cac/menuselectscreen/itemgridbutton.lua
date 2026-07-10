require("x64:96839bd6f46147f")
CoD.ItemGridButton = InheritFrom(LUI.UIElement)
CoD.ItemGridButton.__defaultWidth = 140
CoD.ItemGridButton.__defaultHeight = 90
CoD.ItemGridButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemGridButton)
	self.id = "ItemGridButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AttachmentSlot = CoD.AttachmentSlot.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	AttachmentSlot:mergeStateConditions({
		{
			stateName = "NotValid",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsItemEquippedInCurrentSlot(menu, element, f1_arg1)
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
		{
			stateName = "DefaultStateHiddenName",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	AttachmentSlot:linkToElementModel(AttachmentSlot, "itemIndex", true, function(model)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	AttachmentSlot:linkToElementModel(AttachmentSlot, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	AttachmentSlot:linkToElementModel(self, nil, false, function(model)
		AttachmentSlot:setModel(model, f1_arg1)
	end)
	AttachmentSlot:linkToElementModel(self, "image", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			AttachmentSlot.AttachmentImage:setImage(CoD.BaseUtility.AlreadyRegistered(f13_local0))
		end
	end)
	AttachmentSlot:linkToElementModel(self, "displayNameShort", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			AttachmentSlot.AttachmentName.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f14_local0))
		end
	end)
	self:addElement(AttachmentSlot)
	self.AttachmentSlot = AttachmentSlot
	AttachmentSlot.id = "AttachmentSlot"
	self.__defaultFocus = AttachmentSlot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemGridButton.__resetProperties = function(f15_arg0)
	f15_arg0.AttachmentSlot:completeAnimation()
	f15_arg0.AttachmentSlot:setScale(1, 1)
end
CoD.ItemGridButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.AttachmentSlot:completeAnimation()
			f17_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f18_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f18_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.AttachmentSlot:completeAnimation()
			f18_arg0.AttachmentSlot:setScale(1, 1)
			f18_local0(f18_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f20_arg0.AttachmentSlot:setScale(1, 1)
				f20_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.AttachmentSlot:completeAnimation()
			f20_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f20_local0(f20_arg0.AttachmentSlot)
		end,
	},
	Equipped = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.AttachmentSlot:completeAnimation()
			f23_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f23_arg0.clipFinished(f23_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f24_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.AttachmentSlot:completeAnimation()
			f24_arg0.AttachmentSlot:setScale(1, 1)
			f24_local0(f24_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f26_arg0.AttachmentSlot:setScale(1, 1)
				f26_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.AttachmentSlot:completeAnimation()
			f26_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f26_local0(f26_arg0.AttachmentSlot)
		end,
	},
}
CoD.ItemGridButton.__onClose = function(f28_arg0)
	f28_arg0.AttachmentSlot:close()
end
