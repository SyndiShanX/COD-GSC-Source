require("x64:96839bd6f46147f")
require("x64:fd51e83e2e6dbd1")
CoD.AttachmentSlotContainer = InheritFrom(LUI.UIElement)
CoD.AttachmentSlotContainer.__defaultWidth = 140
CoD.AttachmentSlotContainer.__defaultHeight = 90
CoD.AttachmentSlotContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttachmentSlotContainer)
	self.id = "AttachmentSlotContainer"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AttachmentSlot = CoD.AttachmentSlot.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	AttachmentSlot:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsElementAttachmentEquippedInCurrentClass(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACAttachmentItemLocked(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsAttachmentNew(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return CoD.WeaponAttachmentsUtility.CanEquipUberAttachmentInSlot(menu)
			end,
		},
		{
			stateName = "WildcardNeeded",
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
	local f1_local2 = AttachmentSlot
	local MutuallyExclusiveIcon = AttachmentSlot.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	MutuallyExclusiveIcon(f1_local2, f1_local4["CustomClassList.equippedItemsChanged"], function(f8_arg0)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	AttachmentSlot:linkToElementModel(self, nil, false, function(model)
		AttachmentSlot:setModel(model, f1_arg1)
	end)
	AttachmentSlot:linkToElementModel(self, "image", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			AttachmentSlot.AttachmentImage:setImage(RegisterImage(f10_local0))
		end
	end)
	AttachmentSlot:linkToElementModel(self, "displayNameShort", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			AttachmentSlot.AttachmentName.TextBox:setText(Engine[0xF9F1239CFD921FE](f11_local0))
		end
	end)
	self:addElement(AttachmentSlot)
	self.AttachmentSlot = AttachmentSlot
	MutuallyExclusiveIcon = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -18, -4, 0, 0, 4, 18)
	MutuallyExclusiveIcon:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACItemMutuallyExclusiveWithSelection(menu, element, f1_arg1)
			end,
		},
	})
	MutuallyExclusiveIcon:setRGB(1, 0.41, 0)
	MutuallyExclusiveIcon.image:setImage(RegisterImage(0x11D4E13C821CCE3))
	MutuallyExclusiveIcon:linkToElementModel(self, nil, false, function(model)
		MutuallyExclusiveIcon:setModel(model, f1_arg1)
	end)
	self:addElement(MutuallyExclusiveIcon)
	self.MutuallyExclusiveIcon = MutuallyExclusiveIcon
	self:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsElementAttachmentEquippedInCurrentClass(menu, self, f1_arg1)
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
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local2(f1_local4, f1_local5["CustomClassList.equippedItemsChanged"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		SetElementModelValue(self, "attachmentInFocus", true)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusLost", function(element)
		if CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "attachmentInFocus") then
			SetElementModelValue(self, "attachmentInFocus", false)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "LastInput", function(model)
		local f19_local0 = self
		if IsElementInFocus(self.AttachmentSlot) then
			SetElementModelValue(self, "attachmentInFocus", true)
		elseif CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "attachmentInFocus") then
			SetElementModelValue(self, "attachmentInFocus", false)
		end
	end)
	AttachmentSlot.id = "AttachmentSlot"
	self.__defaultFocus = AttachmentSlot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AttachmentSlotContainer.__resetProperties = function(f20_arg0)
	f20_arg0.AttachmentSlot:completeAnimation()
	f20_arg0.AttachmentSlot:setZoom(0)
	f20_arg0.AttachmentSlot:setScale(1, 1)
end
CoD.AttachmentSlotContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.AttachmentSlot:completeAnimation()
			f22_arg0.AttachmentSlot:setZoom(20)
			f22_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f22_arg0.clipFinished(f22_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f23_arg0.AttachmentSlot:setZoom(20)
				f23_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f23_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.AttachmentSlot:completeAnimation()
			f23_arg0.AttachmentSlot:setZoom(0)
			f23_arg0.AttachmentSlot:setScale(1, 1)
			f23_local0(f23_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f25_arg0.AttachmentSlot:setZoom(0)
				f25_arg0.AttachmentSlot:setScale(1, 1)
				f25_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.AttachmentSlot:completeAnimation()
			f25_arg0.AttachmentSlot:setZoom(20)
			f25_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f25_local0(f25_arg0.AttachmentSlot)
		end,
	},
	Equipped = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.AttachmentSlot:completeAnimation()
			f28_arg0.AttachmentSlot:setZoom(20)
			f28_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f28_arg0.clipFinished(f28_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f29_arg0.AttachmentSlot:setZoom(20)
				f29_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f29_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.AttachmentSlot:completeAnimation()
			f29_arg0.AttachmentSlot:setZoom(0)
			f29_arg0.AttachmentSlot:setScale(1, 1)
			f29_local0(f29_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f31_arg0.AttachmentSlot:setZoom(0)
				f31_arg0.AttachmentSlot:setScale(1, 1)
				f31_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.AttachmentSlot:completeAnimation()
			f31_arg0.AttachmentSlot:setZoom(20)
			f31_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f31_local0(f31_arg0.AttachmentSlot)
		end,
	},
}
CoD.AttachmentSlotContainer.__onClose = function(f33_arg0)
	f33_arg0.AttachmentSlot:close()
	f33_arg0.MutuallyExclusiveIcon:close()
end
