require("x64:fd51e83e2e6dbd1")
require("x64:3b67ce93166e913")
CoD.Armory_UberAttachmentSlot = InheritFrom(LUI.UIElement)
CoD.Armory_UberAttachmentSlot.__defaultWidth = 325
CoD.Armory_UberAttachmentSlot.__defaultHeight = 112
CoD.Armory_UberAttachmentSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_UberAttachmentSlot)
	self.id = "Armory_UberAttachmentSlot"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMItemSlotWide = CoD.ZMItemSlotWide.new(f1_arg0, f1_arg1, 1, 1, -300, 0, 0, 0, 0, 112)
	ZMItemSlotWide:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, f1_arg1, menu)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, f1_arg1)
			end,
		},
	})
	ZMItemSlotWide:linkToElementModel(ZMItemSlotWide, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ZMItemSlotWide, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local2 = ZMItemSlotWide
	local MutuallyExclusiveIcon = ZMItemSlotWide.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	MutuallyExclusiveIcon(f1_local2, f1_local4.armoryAttachmentUpdated, function(f5_arg0)
		f1_arg0:updateElementState(ZMItemSlotWide, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "armoryAttachmentUpdated",
		})
	end, false)
	ZMItemSlotWide:linkToElementModel(self, nil, false, function(model)
		ZMItemSlotWide:setModel(model, f1_arg1)
	end)
	ZMItemSlotWide:linkToElementModel(self, "image", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ZMItemSlotWide.AttachmentImage:setImage(RegisterImage(f7_local0))
		end
	end)
	ZMItemSlotWide:linkToElementModel(self, "displayName", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ZMItemSlotWide.AttachmentName:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	self:addElement(ZMItemSlotWide)
	self.ZMItemSlotWide = ZMItemSlotWide
	MutuallyExclusiveIcon = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -41, -27, 0, 0, 15, 29)
	MutuallyExclusiveIcon:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsAttachmentMutuallyExclusiveWithSelection(menu, element, f1_arg1)
			end,
		},
	})
	f1_local4 = MutuallyExclusiveIcon
	f1_local2 = MutuallyExclusiveIcon.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5.armoryAttachmentUpdated, function(f10_arg0)
		f1_arg0:updateElementState(MutuallyExclusiveIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "armoryAttachmentUpdated",
		})
	end, false)
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
	ZMItemSlotWide.id = "ZMItemSlotWide"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Armory_UberAttachmentSlot.__resetProperties = function(f14_arg0)
	f14_arg0.ZMItemSlotWide:completeAnimation()
	f14_arg0.ZMItemSlotWide:setScale(1, 1)
end
CoD.Armory_UberAttachmentSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.ZMItemSlotWide:completeAnimation()
			f16_arg0.ZMItemSlotWide:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.ZMItemSlotWide)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.ZMItemSlotWide:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f17_arg0.ZMItemSlotWide:setScale(1.05, 1.05)
				f17_arg0.ZMItemSlotWide:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ZMItemSlotWide:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ZMItemSlotWide:completeAnimation()
			f17_arg0.ZMItemSlotWide:setScale(1, 1)
			f17_local0(f17_arg0.ZMItemSlotWide)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.ZMItemSlotWide:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f19_arg0.ZMItemSlotWide:setScale(1, 1)
				f19_arg0.ZMItemSlotWide:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ZMItemSlotWide:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ZMItemSlotWide:completeAnimation()
			f19_arg0.ZMItemSlotWide:setScale(1.05, 1.05)
			f19_local0(f19_arg0.ZMItemSlotWide)
		end,
	},
}
CoD.Armory_UberAttachmentSlot.__onClose = function(f21_arg0)
	f21_arg0.ZMItemSlotWide:close()
	f21_arg0.MutuallyExclusiveIcon:close()
end
