require("x64:b103ab1982e7112")
require("x64:e8fbdebfc99b5c5")
CoD.Armory_AttachmentUpgradeSlotContainer = InheritFrom(LUI.UIElement)
CoD.Armory_AttachmentUpgradeSlotContainer.__defaultWidth = 148
CoD.Armory_AttachmentUpgradeSlotContainer.__defaultHeight = 112
CoD.Armory_AttachmentUpgradeSlotContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_AttachmentUpgradeSlotContainer)
	self.id = "Armory_AttachmentUpgradeSlotContainer"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UpgradeArrow = CoD.AttachmentUpgradeArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -41, 41, 0, 0, -32, 20)
	UpgradeArrow:setZoom(10)
	self:addElement(UpgradeArrow)
	self.UpgradeArrow = UpgradeArrow
	local AttachmentSlot = CoD.ZMAttachmentSlotSmall.new(f1_arg0, f1_arg1, 0, 0, 0, 148, 0, 0, 0, 112)
	AttachmentSlot:mergeStateConditions({
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
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return not CoD.ZMLoadoutUtility.IsArmoryElementBaseAttachmentEquipped(element, f1_arg1, menu)
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
	local f1_local4 = AttachmentSlot.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.armoryAttachmentUpdated, function(f6_arg0)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "armoryAttachmentUpdated",
		})
	end, false)
	AttachmentSlot:linkToElementModel(self, nil, false, function(model)
		AttachmentSlot:setModel(model, f1_arg1)
	end)
	AttachmentSlot:linkToElementModel(self, "image", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			AttachmentSlot.AttachmentImage:setImage(RegisterImage(f8_local0))
		end
	end)
	AttachmentSlot:linkToElementModel(self, "displayName", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			AttachmentSlot.AttachmentName:setText(Engine[0xF9F1239CFD921FE](f9_local0))
		end
	end)
	self:addElement(AttachmentSlot)
	self.AttachmentSlot = AttachmentSlot
	self:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsArmoryElementAttachmentEquipped(element, f1_arg1, menu)
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
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.armoryAttachmentUpdated, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "armoryAttachmentUpdated",
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
CoD.Armory_AttachmentUpgradeSlotContainer.__resetProperties = function(f15_arg0)
	f15_arg0.UpgradeArrow:completeAnimation()
	f15_arg0.AttachmentSlot:completeAnimation()
	f15_arg0.UpgradeArrow:setZoom(10)
	f15_arg0.AttachmentSlot:setZoom(0)
	f15_arg0.AttachmentSlot:setScale(1, 1)
end
CoD.Armory_AttachmentUpgradeSlotContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.UpgradeArrow:completeAnimation()
			f17_arg0.UpgradeArrow:setZoom(0)
			f17_arg0.clipFinished(f17_arg0.UpgradeArrow)
			f17_arg0.AttachmentSlot:completeAnimation()
			f17_arg0.AttachmentSlot:setZoom(20)
			f17_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.UpgradeArrow:completeAnimation()
			f18_arg0.UpgradeArrow:setZoom(0)
			f18_arg0.clipFinished(f18_arg0.UpgradeArrow)
			local f18_local0 = function(f19_arg0)
				f18_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f18_arg0.AttachmentSlot:setZoom(20)
				f18_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f18_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.AttachmentSlot:completeAnimation()
			f18_arg0.AttachmentSlot:setZoom(0)
			f18_arg0.AttachmentSlot:setScale(1, 1)
			f18_local0(f18_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.UpgradeArrow:completeAnimation()
			f20_arg0.UpgradeArrow:setZoom(0)
			f20_arg0.clipFinished(f20_arg0.UpgradeArrow)
			local f20_local0 = function(f21_arg0)
				f20_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f20_arg0.AttachmentSlot:setZoom(0)
				f20_arg0.AttachmentSlot:setScale(1, 1)
				f20_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.AttachmentSlot:completeAnimation()
			f20_arg0.AttachmentSlot:setZoom(20)
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
			f23_arg0.AttachmentSlot:setZoom(20)
			f23_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f23_arg0.clipFinished(f23_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f24_arg0.AttachmentSlot:setZoom(20)
				f24_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f24_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.AttachmentSlot:completeAnimation()
			f24_arg0.AttachmentSlot:setZoom(0)
			f24_arg0.AttachmentSlot:setScale(1, 1)
			f24_local0(f24_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f26_arg0.AttachmentSlot:setZoom(0)
				f26_arg0.AttachmentSlot:setScale(1, 1)
				f26_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.AttachmentSlot:completeAnimation()
			f26_arg0.AttachmentSlot:setZoom(20)
			f26_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f26_local0(f26_arg0.AttachmentSlot)
		end,
	},
}
CoD.Armory_AttachmentUpgradeSlotContainer.__onClose = function(f28_arg0)
	f28_arg0.UpgradeArrow:close()
	f28_arg0.AttachmentSlot:close()
end
