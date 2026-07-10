require("x64:e8fbdebfc99b5c5")
CoD.ZMItemGridButtonSmall = InheritFrom(LUI.UIElement)
CoD.ZMItemGridButtonSmall.__defaultWidth = 148
CoD.ZMItemGridButtonSmall.__defaultHeight = 112
CoD.ZMItemGridButtonSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMItemGridButtonSmall)
	self.id = "ZMItemGridButtonSmall"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ItemSmall = CoD.ZMAttachmentSlotSmall.new(f1_arg0, f1_arg1, 0, 0, 0, 148, 0, 0, 0, 112)
	ItemSmall:mergeStateConditions({
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
			stateName = "DefaultStateNoName",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ItemSmall:linkToElementModel(ItemSmall, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ItemSmall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	ItemSmall:linkToElementModel(ItemSmall, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(ItemSmall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	ItemSmall:linkToElementModel(self, nil, false, function(model)
		ItemSmall:setModel(model, f1_arg1)
	end)
	ItemSmall:linkToElementModel(self, "image", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ItemSmall.AttachmentImage:setImage(CoD.BaseUtility.AlreadyRegistered(f12_local0))
		end
	end)
	ItemSmall:linkToElementModel(self, "displayName", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			ItemSmall.AttachmentName:setText(Engine[0xF9F1239CFD921FE](f13_local0))
		end
	end)
	self:addElement(ItemSmall)
	self.ItemSmall = ItemSmall
	ItemSmall.id = "ItemSmall"
	self.__defaultFocus = ItemSmall
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMItemGridButtonSmall.__resetProperties = function(f14_arg0)
	f14_arg0.ItemSmall:completeAnimation()
	f14_arg0.ItemSmall:setScale(1, 1)
end
CoD.ZMItemGridButtonSmall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.ItemSmall:completeAnimation()
			f16_arg0.ItemSmall:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.ItemSmall)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.ItemSmall:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f17_arg0.ItemSmall:setScale(1.05, 1.05)
				f17_arg0.ItemSmall:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ItemSmall:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ItemSmall:completeAnimation()
			f17_arg0.ItemSmall:setScale(1, 1)
			f17_local0(f17_arg0.ItemSmall)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.ItemSmall:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f19_arg0.ItemSmall:setScale(1, 1)
				f19_arg0.ItemSmall:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ItemSmall:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ItemSmall:completeAnimation()
			f19_arg0.ItemSmall:setScale(1.05, 1.05)
			f19_local0(f19_arg0.ItemSmall)
		end,
	},
	Equipped = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.ItemSmall:completeAnimation()
			f22_arg0.ItemSmall:setScale(1.05, 1.05)
			f22_arg0.clipFinished(f22_arg0.ItemSmall)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.ItemSmall:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f23_arg0.ItemSmall:setScale(1.05, 1.05)
				f23_arg0.ItemSmall:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.ItemSmall:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.ItemSmall:completeAnimation()
			f23_arg0.ItemSmall:setScale(1, 1)
			f23_local0(f23_arg0.ItemSmall)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.ItemSmall:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f25_arg0.ItemSmall:setScale(1, 1)
				f25_arg0.ItemSmall:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ItemSmall:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.ItemSmall:completeAnimation()
			f25_arg0.ItemSmall:setScale(1.05, 1.05)
			f25_local0(f25_arg0.ItemSmall)
		end,
	},
}
CoD.ZMItemGridButtonSmall.__onClose = function(f27_arg0)
	f27_arg0.ItemSmall:close()
end
