require("x64:12a692cf6c196d1")
require("x64:fd51e83e2e6dbd1")
CoD.UberAttachmentSlot = InheritFrom(LUI.UIElement)
CoD.UberAttachmentSlot.__defaultWidth = 225
CoD.UberAttachmentSlot.__defaultHeight = 80
CoD.UberAttachmentSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.UberAttachmentSlot)
	self.id = "UberAttachmentSlot"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonItemSlotWide = CoD.CommonItemSlotWide.new(f1_arg0, f1_arg1, 0.5, 0.5, -112.5, 117.5, 0.5, 0.5, -40, 40)
	CommonItemSlotWide:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsElementAttachmentEquippedInCurrentClass(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsAttachmentNew(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACAttachmentItemLocked(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return not CoD.WeaponAttachmentsUtility.CanEquipUberAttachmentInSlot(menu)
			end,
		},
	})
	CommonItemSlotWide:linkToElementModel(CommonItemSlotWide, "itemIndex", true, function(model)
		f1_arg0:updateElementState(CommonItemSlotWide, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local2 = CommonItemSlotWide
	local MutuallyExclusiveIcon = CommonItemSlotWide.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	MutuallyExclusiveIcon(f1_local2, f1_local4["CustomClassList.equippedItemsChanged"], function(f7_arg0)
		f1_arg0:updateElementState(CommonItemSlotWide, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	CommonItemSlotWide:linkToElementModel(self, nil, false, function(model)
		CommonItemSlotWide:setModel(model, f1_arg1)
	end)
	CommonItemSlotWide:linkToElementModel(self, "image", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CommonItemSlotWide.ItemImage:setImage(RegisterImage(f9_local0))
		end
	end)
	CommonItemSlotWide:linkToElementModel(self, "displayNameShort", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CommonItemSlotWide.ItemName.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f10_local0))
		end
	end)
	self:addElement(CommonItemSlotWide)
	self.CommonItemSlotWide = CommonItemSlotWide
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
	MutuallyExclusiveIcon.image:setImage(RegisterImage(@"hash_111D4E13C821CCE3"))
	MutuallyExclusiveIcon:linkToElementModel(self, nil, false, function(model)
		MutuallyExclusiveIcon:setModel(model, f1_arg1)
	end)
	self:addElement(MutuallyExclusiveIcon)
	self.MutuallyExclusiveIcon = MutuallyExclusiveIcon
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		SetElementModelValue(element, "attachmentInFocus", true)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusLost", function(element)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "attachmentInFocus") then
			SetElementModelValue(element, "attachmentInFocus", false)
		end
	end)
	CommonItemSlotWide.id = "CommonItemSlotWide"
	self.__defaultFocus = CommonItemSlotWide
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local2 = self
	return self
end
CoD.UberAttachmentSlot.__resetProperties = function(f15_arg0)
	f15_arg0.CommonItemSlotWide:completeAnimation()
	f15_arg0.CommonItemSlotWide:setScale(1, 1)
end
CoD.UberAttachmentSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.CommonItemSlotWide:completeAnimation()
			f17_arg0.CommonItemSlotWide:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.CommonItemSlotWide)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.CommonItemSlotWide:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f18_arg0.CommonItemSlotWide:setScale(1.05, 1.05)
				f18_arg0.CommonItemSlotWide:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.CommonItemSlotWide:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.CommonItemSlotWide:completeAnimation()
			f18_arg0.CommonItemSlotWide:setScale(1, 1)
			f18_local0(f18_arg0.CommonItemSlotWide)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.CommonItemSlotWide:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f20_arg0.CommonItemSlotWide:setScale(1, 1)
				f20_arg0.CommonItemSlotWide:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.CommonItemSlotWide:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.CommonItemSlotWide:completeAnimation()
			f20_arg0.CommonItemSlotWide:setScale(1.05, 1.05)
			f20_local0(f20_arg0.CommonItemSlotWide)
		end,
	},
}
CoD.UberAttachmentSlot.__onClose = function(f22_arg0)
	f22_arg0.CommonItemSlotWide:close()
	f22_arg0.MutuallyExclusiveIcon:close()
end
