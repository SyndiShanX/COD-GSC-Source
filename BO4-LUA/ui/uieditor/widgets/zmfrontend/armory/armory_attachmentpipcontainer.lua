require("x64:94242ada7c129a0")
CoD.Armory_AttachmentPipContainer = InheritFrom(LUI.UIElement)
CoD.Armory_AttachmentPipContainer.__defaultWidth = 87
CoD.Armory_AttachmentPipContainer.__defaultHeight = 12
CoD.Armory_AttachmentPipContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_AttachmentPipContainer)
	self.id = "Armory_AttachmentPipContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OpticPip = CoD.Armory_AttachmentPip.new(f1_arg0, f1_arg1, 0, 0, 0, 12, 0, 0, 0, 12)
	OpticPip:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasOpticSlot")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasOpticEquipped")
			end,
		},
	})
	OpticPip:linkToElementModel(OpticPip, "hasOpticSlot", true, function(model)
		f1_arg0:updateElementState(OpticPip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasOpticSlot",
		})
	end)
	OpticPip:linkToElementModel(OpticPip, "hasOpticEquipped", true, function(model)
		f1_arg0:updateElementState(OpticPip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasOpticEquipped",
		})
	end)
	OpticPip:linkToElementModel(self, nil, false, function(model)
		OpticPip:setModel(model, f1_arg1)
	end)
	self:addElement(OpticPip)
	self.OpticPip = OpticPip
	local AttachmentPip1 = CoD.Armory_AttachmentPip.new(f1_arg0, f1_arg1, 0, 0, 15, 27, 0, 0, 0, 12)
	AttachmentPip1:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "totalSlotsCount", 1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "attachmentsEquippedCount", 1)
			end,
		},
	})
	AttachmentPip1:linkToElementModel(AttachmentPip1, "totalSlotsCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalSlotsCount",
		})
	end)
	AttachmentPip1:linkToElementModel(AttachmentPip1, "attachmentsEquippedCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "attachmentsEquippedCount",
		})
	end)
	AttachmentPip1:linkToElementModel(self, nil, false, function(model)
		AttachmentPip1:setModel(model, f1_arg1)
	end)
	self:addElement(AttachmentPip1)
	self.AttachmentPip1 = AttachmentPip1
	local AttachmentPip2 = CoD.Armory_AttachmentPip.new(f1_arg0, f1_arg1, 0, 0, 30, 42, 0, 0, 0, 12)
	AttachmentPip2:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "totalSlotsCount", 2)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsAttachmentSlotLocked(menu, element, f1_arg1, 2)
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "attachmentsEquippedCount", 2)
			end,
		},
	})
	AttachmentPip2:linkToElementModel(AttachmentPip2, "totalSlotsCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalSlotsCount",
		})
	end)
	AttachmentPip2:linkToElementModel(AttachmentPip2, "itemIndex", true, function(model)
		f1_arg0:updateElementState(AttachmentPip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	AttachmentPip2:linkToElementModel(AttachmentPip2, "attachmentsEquippedCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "attachmentsEquippedCount",
		})
	end)
	AttachmentPip2:linkToElementModel(self, nil, false, function(model)
		AttachmentPip2:setModel(model, f1_arg1)
	end)
	self:addElement(AttachmentPip2)
	self.AttachmentPip2 = AttachmentPip2
	local AttachmentPip3 = CoD.Armory_AttachmentPip.new(f1_arg0, f1_arg1, 0, 0, 45, 57, 0, 0, 0, 12)
	AttachmentPip3:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "totalSlotsCount", 3)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsAttachmentSlotLocked(menu, element, f1_arg1, 3)
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "attachmentsEquippedCount", 3)
			end,
		},
	})
	AttachmentPip3:linkToElementModel(AttachmentPip3, "totalSlotsCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalSlotsCount",
		})
	end)
	AttachmentPip3:linkToElementModel(AttachmentPip3, "itemIndex", true, function(model)
		f1_arg0:updateElementState(AttachmentPip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	AttachmentPip3:linkToElementModel(AttachmentPip3, "attachmentsEquippedCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "attachmentsEquippedCount",
		})
	end)
	AttachmentPip3:linkToElementModel(self, nil, false, function(model)
		AttachmentPip3:setModel(model, f1_arg1)
	end)
	self:addElement(AttachmentPip3)
	self.AttachmentPip3 = AttachmentPip3
	local AttachmentPip4 = CoD.Armory_AttachmentPip.new(f1_arg0, f1_arg1, 0, 0, 60, 72, 0, 0, 0, 12)
	AttachmentPip4:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "totalSlotsCount", 4)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsAttachmentSlotLocked(menu, element, f1_arg1, 4)
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "attachmentsEquippedCount", 4)
			end,
		},
	})
	AttachmentPip4:linkToElementModel(AttachmentPip4, "totalSlotsCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalSlotsCount",
		})
	end)
	AttachmentPip4:linkToElementModel(AttachmentPip4, "itemIndex", true, function(model)
		f1_arg0:updateElementState(AttachmentPip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	AttachmentPip4:linkToElementModel(AttachmentPip4, "attachmentsEquippedCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "attachmentsEquippedCount",
		})
	end)
	AttachmentPip4:linkToElementModel(self, nil, false, function(model)
		AttachmentPip4:setModel(model, f1_arg1)
	end)
	self:addElement(AttachmentPip4)
	self.AttachmentPip4 = AttachmentPip4
	local AttachmentPip5 = CoD.Armory_AttachmentPip.new(f1_arg0, f1_arg1, 0, 0, 75, 87, 0, 0, 0, 12)
	AttachmentPip5:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "totalSlotsCount", 5)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsAttachmentSlotLocked(menu, element, f1_arg1, 5)
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "attachmentsEquippedCount", 5)
			end,
		},
	})
	AttachmentPip5:linkToElementModel(AttachmentPip5, "totalSlotsCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalSlotsCount",
		})
	end)
	AttachmentPip5:linkToElementModel(AttachmentPip5, "itemIndex", true, function(model)
		f1_arg0:updateElementState(AttachmentPip5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	AttachmentPip5:linkToElementModel(AttachmentPip5, "attachmentsEquippedCount", true, function(model)
		f1_arg0:updateElementState(AttachmentPip5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "attachmentsEquippedCount",
		})
	end)
	AttachmentPip5:linkToElementModel(self, nil, false, function(model)
		AttachmentPip5:setModel(model, f1_arg1)
	end)
	self:addElement(AttachmentPip5)
	self.AttachmentPip5 = AttachmentPip5
	self:mergeStateConditions({
		{
			stateName = "FourSlots",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsWeaponAttachmentPipFourSlots(menu, element)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showAttachmentPips")
			end,
		},
		{
			stateName = "FourSlotsHideOptic",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "HideOptic",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "showAttachmentPips", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showAttachmentPips",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Armory_AttachmentPipContainer.__resetProperties = function(f47_arg0)
	f47_arg0.OpticPip:completeAnimation()
	f47_arg0.AttachmentPip5:completeAnimation()
	f47_arg0.AttachmentPip4:completeAnimation()
	f47_arg0.AttachmentPip3:completeAnimation()
	f47_arg0.AttachmentPip2:completeAnimation()
	f47_arg0.AttachmentPip1:completeAnimation()
	f47_arg0.OpticPip:setLeftRight(0, 0, 0, 12)
	f47_arg0.OpticPip:setAlpha(1)
	f47_arg0.AttachmentPip5:setLeftRight(0, 0, 75, 87)
	f47_arg0.AttachmentPip5:setAlpha(1)
	f47_arg0.AttachmentPip4:setLeftRight(0, 0, 60, 72)
	f47_arg0.AttachmentPip4:setAlpha(1)
	f47_arg0.AttachmentPip3:setLeftRight(0, 0, 45, 57)
	f47_arg0.AttachmentPip3:setAlpha(1)
	f47_arg0.AttachmentPip2:setLeftRight(0, 0, 30, 42)
	f47_arg0.AttachmentPip2:setAlpha(1)
	f47_arg0.AttachmentPip1:setLeftRight(0, 0, 15, 27)
	f47_arg0.AttachmentPip1:setAlpha(1)
end
CoD.Armory_AttachmentPipContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(0)
		end,
	},
	FourSlots = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(6)
			f49_arg0.OpticPip:completeAnimation()
			f49_arg0.OpticPip:setLeftRight(0, 0, 14.5, 26.5)
			f49_arg0.OpticPip:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.OpticPip)
			f49_arg0.AttachmentPip1:completeAnimation()
			f49_arg0.AttachmentPip1:setLeftRight(0, 0, 30, 42)
			f49_arg0.clipFinished(f49_arg0.AttachmentPip1)
			f49_arg0.AttachmentPip2:completeAnimation()
			f49_arg0.AttachmentPip2:setLeftRight(0, 0, 45, 57)
			f49_arg0.clipFinished(f49_arg0.AttachmentPip2)
			f49_arg0.AttachmentPip3:completeAnimation()
			f49_arg0.AttachmentPip3:setLeftRight(0, 0, 60, 72)
			f49_arg0.clipFinished(f49_arg0.AttachmentPip3)
			f49_arg0.AttachmentPip4:completeAnimation()
			f49_arg0.AttachmentPip4:setLeftRight(0, 0, 60, 72)
			f49_arg0.AttachmentPip4:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.AttachmentPip4)
			f49_arg0.AttachmentPip5:completeAnimation()
			f49_arg0.AttachmentPip5:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.AttachmentPip5)
		end,
	},
	Hidden = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(6)
			f50_arg0.OpticPip:completeAnimation()
			f50_arg0.OpticPip:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.OpticPip)
			f50_arg0.AttachmentPip1:completeAnimation()
			f50_arg0.AttachmentPip1:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.AttachmentPip1)
			f50_arg0.AttachmentPip2:completeAnimation()
			f50_arg0.AttachmentPip2:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.AttachmentPip2)
			f50_arg0.AttachmentPip3:completeAnimation()
			f50_arg0.AttachmentPip3:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.AttachmentPip3)
			f50_arg0.AttachmentPip4:completeAnimation()
			f50_arg0.AttachmentPip4:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.AttachmentPip4)
			f50_arg0.AttachmentPip5:completeAnimation()
			f50_arg0.AttachmentPip5:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.AttachmentPip5)
		end,
	},
	FourSlotsHideOptic = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(6)
			f51_arg0.OpticPip:completeAnimation()
			f51_arg0.OpticPip:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.OpticPip)
			f51_arg0.AttachmentPip1:completeAnimation()
			f51_arg0.AttachmentPip1:setLeftRight(0, 0, 22.5, 34.5)
			f51_arg0.clipFinished(f51_arg0.AttachmentPip1)
			f51_arg0.AttachmentPip2:completeAnimation()
			f51_arg0.AttachmentPip2:setLeftRight(0, 0, 37.5, 49.5)
			f51_arg0.clipFinished(f51_arg0.AttachmentPip2)
			f51_arg0.AttachmentPip3:completeAnimation()
			f51_arg0.AttachmentPip3:setLeftRight(0, 0, 52.5, 64.5)
			f51_arg0.clipFinished(f51_arg0.AttachmentPip3)
			f51_arg0.AttachmentPip4:completeAnimation()
			f51_arg0.AttachmentPip4:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.AttachmentPip4)
			f51_arg0.AttachmentPip5:completeAnimation()
			f51_arg0.AttachmentPip5:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.AttachmentPip5)
		end,
	},
	HideOptic = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(6)
			f52_arg0.OpticPip:completeAnimation()
			f52_arg0.OpticPip:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.OpticPip)
			f52_arg0.AttachmentPip1:completeAnimation()
			f52_arg0.AttachmentPip1:setLeftRight(0, 0, 7.5, 19.5)
			f52_arg0.clipFinished(f52_arg0.AttachmentPip1)
			f52_arg0.AttachmentPip2:completeAnimation()
			f52_arg0.AttachmentPip2:setLeftRight(0, 0, 22.5, 34.5)
			f52_arg0.clipFinished(f52_arg0.AttachmentPip2)
			f52_arg0.AttachmentPip3:completeAnimation()
			f52_arg0.AttachmentPip3:setLeftRight(0, 0, 37.5, 49.5)
			f52_arg0.clipFinished(f52_arg0.AttachmentPip3)
			f52_arg0.AttachmentPip4:completeAnimation()
			f52_arg0.AttachmentPip4:setLeftRight(0, 0, 52.5, 64.5)
			f52_arg0.clipFinished(f52_arg0.AttachmentPip4)
			f52_arg0.AttachmentPip5:completeAnimation()
			f52_arg0.AttachmentPip5:setLeftRight(0, 0, 67.5, 79.5)
			f52_arg0.clipFinished(f52_arg0.AttachmentPip5)
		end,
	},
}
CoD.Armory_AttachmentPipContainer.__onClose = function(f53_arg0)
	f53_arg0.OpticPip:close()
	f53_arg0.AttachmentPip1:close()
	f53_arg0.AttachmentPip2:close()
	f53_arg0.AttachmentPip3:close()
	f53_arg0.AttachmentPip4:close()
	f53_arg0.AttachmentPip5:close()
end
