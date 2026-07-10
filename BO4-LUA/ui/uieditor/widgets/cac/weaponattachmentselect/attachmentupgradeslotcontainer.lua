require("x64:96839bd6f46147f")
require("x64:b103ab1982e7112")
require("x64:fd51e83e2e6dbd1")
CoD.AttachmentUpgradeSlotContainer = InheritFrom(LUI.UIElement)
CoD.AttachmentUpgradeSlotContainer.__defaultWidth = 140
CoD.AttachmentUpgradeSlotContainer.__defaultHeight = 90
CoD.AttachmentUpgradeSlotContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttachmentUpgradeSlotContainer)
	self.id = "AttachmentUpgradeSlotContainer"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UpgradeArrow = CoD.AttachmentUpgradeArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -41, 41, 0, 0, -37, 15)
	UpgradeArrow:mergeStateConditions({
		{
			stateName = "UpgradeAvailable",
			condition = function(menu, element, event)
				return CoD.WeaponAttachmentsUtility.IsBaseAttachmentEquipped(menu, self, f1_arg1)
			end,
		},
	})
	UpgradeArrow:setZoom(10)
	self:addElement(UpgradeArrow)
	self.UpgradeArrow = UpgradeArrow
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
				return not CoD.WeaponAttachmentsUtility.IsBaseAttachmentEquipped(menu, self, f1_arg1)
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
	local f1_local3 = AttachmentSlot
	local MutuallyExclusiveIcon = AttachmentSlot.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	MutuallyExclusiveIcon(f1_local3, f1_local5["CustomClassList.equippedItemsChanged"], function(f8_arg0)
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
				return CoD.CACUtility.IsElementAttachmentEquippedInCurrentClass(menu, element, f1_arg1)
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
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local5, f1_local6["CustomClassList.equippedItemsChanged"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		SetElementModelValue(element, "attachmentInFocus", true)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusLost", function(element)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "attachmentInFocus") then
			SetElementModelValue(element, "attachmentInFocus", false)
		end
	end)
	AttachmentSlot.id = "AttachmentSlot"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AttachmentUpgradeSlotContainer.__resetProperties = function(f19_arg0)
	f19_arg0.UpgradeArrow:completeAnimation()
	f19_arg0.AttachmentSlot:completeAnimation()
	f19_arg0.UpgradeArrow:setZoom(10)
	f19_arg0.AttachmentSlot:setZoom(0)
	f19_arg0.AttachmentSlot:setScale(1, 1)
end
CoD.AttachmentUpgradeSlotContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.UpgradeArrow:completeAnimation()
			f20_arg0.UpgradeArrow:setZoom(0)
			f20_arg0.clipFinished(f20_arg0.UpgradeArrow)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.UpgradeArrow:completeAnimation()
			f21_arg0.UpgradeArrow:setZoom(0)
			f21_arg0.clipFinished(f21_arg0.UpgradeArrow)
			f21_arg0.AttachmentSlot:completeAnimation()
			f21_arg0.AttachmentSlot:setZoom(20)
			f21_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.UpgradeArrow:completeAnimation()
			f22_arg0.UpgradeArrow:setZoom(0)
			f22_arg0.clipFinished(f22_arg0.UpgradeArrow)
			local f22_local0 = function(f23_arg0)
				f22_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f22_arg0.AttachmentSlot:setZoom(20)
				f22_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f22_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.AttachmentSlot:completeAnimation()
			f22_arg0.AttachmentSlot:setZoom(0)
			f22_arg0.AttachmentSlot:setScale(1, 1)
			f22_local0(f22_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.UpgradeArrow:completeAnimation()
			f24_arg0.UpgradeArrow:setZoom(0)
			f24_arg0.clipFinished(f24_arg0.UpgradeArrow)
			local f24_local0 = function(f25_arg0)
				f24_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f24_arg0.AttachmentSlot:setZoom(0)
				f24_arg0.AttachmentSlot:setScale(1, 1)
				f24_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.AttachmentSlot:completeAnimation()
			f24_arg0.AttachmentSlot:setZoom(20)
			f24_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f24_local0(f24_arg0.AttachmentSlot)
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
			f27_arg0.AttachmentSlot:completeAnimation()
			f27_arg0.AttachmentSlot:setZoom(20)
			f27_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f27_arg0.clipFinished(f27_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f28_arg0.AttachmentSlot:setZoom(20)
				f28_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f28_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.AttachmentSlot:completeAnimation()
			f28_arg0.AttachmentSlot:setZoom(0)
			f28_arg0.AttachmentSlot:setScale(1, 1)
			f28_local0(f28_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f30_arg0.AttachmentSlot:setZoom(0)
				f30_arg0.AttachmentSlot:setScale(1, 1)
				f30_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.AttachmentSlot:completeAnimation()
			f30_arg0.AttachmentSlot:setZoom(20)
			f30_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f30_local0(f30_arg0.AttachmentSlot)
		end,
	},
}
CoD.AttachmentUpgradeSlotContainer.__onClose = function(f32_arg0)
	f32_arg0.UpgradeArrow:close()
	f32_arg0.AttachmentSlot:close()
	f32_arg0.MutuallyExclusiveIcon:close()
end
