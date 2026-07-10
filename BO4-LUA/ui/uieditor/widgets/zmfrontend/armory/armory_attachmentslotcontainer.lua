require("x64:fd51e83e2e6dbd1")
require("x64:e8fbdebfc99b5c5")
CoD.Armory_AttachmentSlotContainer = InheritFrom(LUI.UIElement)
CoD.Armory_AttachmentSlotContainer.__defaultWidth = 148
CoD.Armory_AttachmentSlotContainer.__defaultHeight = 112
CoD.Armory_AttachmentSlotContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_AttachmentSlotContainer)
	self.id = "Armory_AttachmentSlotContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonBGMirrorSelected = LUI.UIImage.new(0, 0, 0, 148, 0, 0, 0, 112)
	ButtonBGMirrorSelected:setImage(RegisterImage(@"uie_ui_menu_cac_attachment_button_bg_mirror_selected"))
	self:addElement(ButtonBGMirrorSelected)
	self.ButtonBGMirrorSelected = ButtonBGMirrorSelected
	local ButtonBGMirror = LUI.UIImage.new(0, 0, 0, 148, 0, 0, 0, 112)
	ButtonBGMirror:setImage(RegisterImage(@"uie_ui_menu_cac_attachment_button_bg_mirror"))
	self:addElement(ButtonBGMirror)
	self.ButtonBGMirror = ButtonBGMirror
	local AttachmentSlot = CoD.ZMAttachmentSlotSmall.new(f1_arg0, f1_arg1, 0, 0, 0, 148, 0, 0, 0, 112)
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
	AttachmentSlot:linkToElementModel(AttachmentSlot, "itemIndex", true, function(model)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local4 = AttachmentSlot
	local MutuallyExclusiveIcon = AttachmentSlot.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	MutuallyExclusiveIcon(f1_local4, f1_local6.armoryAttachmentUpdated, function(f10_arg0)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "armoryAttachmentUpdated",
		})
	end, false)
	AttachmentSlot:linkToElementModel(self, nil, false, function(model)
		AttachmentSlot:setModel(model, f1_arg1)
	end)
	AttachmentSlot:linkToElementModel(self, "image", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			AttachmentSlot.AttachmentImage:setImage(RegisterImage(f12_local0))
		end
	end)
	AttachmentSlot:linkToElementModel(self, "displayName", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			AttachmentSlot.AttachmentName:setText(Engine[@"hash_4F9F1239CFD921FE"](f13_local0))
		end
	end)
	self:addElement(AttachmentSlot)
	self.AttachmentSlot = AttachmentSlot
	MutuallyExclusiveIcon = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -25, -11, 0, 0, 13, 27)
	MutuallyExclusiveIcon:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ZMLoadoutUtility.IsAttachmentMutuallyExclusiveWithSelection(menu, element, f1_arg1)
			end,
		},
	})
	f1_local6 = MutuallyExclusiveIcon
	f1_local4 = MutuallyExclusiveIcon.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local6, f1_local7.armoryAttachmentUpdated, function(f15_arg0)
		f1_arg0:updateElementState(MutuallyExclusiveIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
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
	f1_local6 = self
	f1_local4 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local6, f1_local7.armoryAttachmentUpdated, function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "armoryAttachmentUpdated",
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
		local f22_local0 = self
		if not IsMouse(f1_arg1) and IsElementInFocus(self.AttachmentSlot) then
			SetElementModelValue(self, "attachmentInFocus", true)
		elseif not IsMouse(f1_arg1) and CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "attachmentInFocus") then
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
CoD.Armory_AttachmentSlotContainer.__resetProperties = function(f23_arg0)
	f23_arg0.ButtonBGMirrorSelected:completeAnimation()
	f23_arg0.AttachmentSlot:completeAnimation()
	f23_arg0.ButtonBGMirror:completeAnimation()
	f23_arg0.ButtonBGMirrorSelected:setAlpha(1)
	f23_arg0.ButtonBGMirrorSelected:setZoom(0)
	f23_arg0.ButtonBGMirrorSelected:setScale(1, 1)
	f23_arg0.AttachmentSlot:setZoom(0)
	f23_arg0.AttachmentSlot:setScale(1, 1)
	f23_arg0.ButtonBGMirror:setAlpha(1)
	f23_arg0.ButtonBGMirror:setZoom(0)
	f23_arg0.ButtonBGMirror:setScale(1, 1)
end
CoD.Armory_AttachmentSlotContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.ButtonBGMirrorSelected:completeAnimation()
			f24_arg0.ButtonBGMirrorSelected:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ButtonBGMirrorSelected)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.ButtonBGMirrorSelected:completeAnimation()
			f25_arg0.ButtonBGMirrorSelected:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ButtonBGMirrorSelected)
			f25_arg0.ButtonBGMirror:completeAnimation()
			f25_arg0.ButtonBGMirror:setZoom(0)
			f25_arg0.ButtonBGMirror:setScale(0.95, 0.95)
			f25_arg0.clipFinished(f25_arg0.ButtonBGMirror)
			f25_arg0.AttachmentSlot:completeAnimation()
			f25_arg0.AttachmentSlot:setZoom(20)
			f25_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f25_arg0.clipFinished(f25_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.ButtonBGMirrorSelected:completeAnimation()
			f26_arg0.ButtonBGMirrorSelected:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ButtonBGMirrorSelected)
			local f26_local0 = function(f27_arg0)
				f26_arg0.ButtonBGMirror:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f26_arg0.ButtonBGMirror:setScale(0.95, 0.95)
				f26_arg0.ButtonBGMirror:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ButtonBGMirror:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.ButtonBGMirror:completeAnimation()
			f26_arg0.ButtonBGMirror:setZoom(0)
			f26_arg0.ButtonBGMirror:setScale(1, 1)
			f26_local0(f26_arg0.ButtonBGMirror)
			local f26_local1 = function(f28_arg0)
				f26_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f26_arg0.AttachmentSlot:setZoom(20)
				f26_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f26_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.AttachmentSlot:completeAnimation()
			f26_arg0.AttachmentSlot:setZoom(0)
			f26_arg0.AttachmentSlot:setScale(1, 1)
			f26_local1(f26_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.ButtonBGMirrorSelected:completeAnimation()
			f29_arg0.ButtonBGMirrorSelected:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ButtonBGMirrorSelected)
			local f29_local0 = function(f30_arg0)
				f29_arg0.ButtonBGMirror:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f29_arg0.ButtonBGMirror:setScale(1, 1)
				f29_arg0.ButtonBGMirror:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ButtonBGMirror:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.ButtonBGMirror:completeAnimation()
			f29_arg0.ButtonBGMirror:setZoom(0)
			f29_arg0.ButtonBGMirror:setScale(0.95, 0.95)
			f29_local0(f29_arg0.ButtonBGMirror)
			local f29_local1 = function(f31_arg0)
				f29_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f29_arg0.AttachmentSlot:setZoom(0)
				f29_arg0.AttachmentSlot:setScale(1, 1)
				f29_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.AttachmentSlot:completeAnimation()
			f29_arg0.AttachmentSlot:setZoom(20)
			f29_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f29_local1(f29_arg0.AttachmentSlot)
		end,
	},
	Equipped = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.ButtonBGMirror:completeAnimation()
			f32_arg0.ButtonBGMirror:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ButtonBGMirror)
		end,
		ChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
			f33_arg0.ButtonBGMirrorSelected:completeAnimation()
			f33_arg0.ButtonBGMirrorSelected:setZoom(0)
			f33_arg0.ButtonBGMirrorSelected:setScale(0.95, 0.95)
			f33_arg0.clipFinished(f33_arg0.ButtonBGMirrorSelected)
			f33_arg0.ButtonBGMirror:completeAnimation()
			f33_arg0.ButtonBGMirror:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ButtonBGMirror)
			f33_arg0.AttachmentSlot:completeAnimation()
			f33_arg0.AttachmentSlot:setZoom(20)
			f33_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f33_arg0.clipFinished(f33_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(3)
			local f34_local0 = function(f35_arg0)
				f34_arg0.ButtonBGMirrorSelected:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f34_arg0.ButtonBGMirrorSelected:setScale(0.95, 0.95)
				f34_arg0.ButtonBGMirrorSelected:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.ButtonBGMirrorSelected:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.ButtonBGMirrorSelected:completeAnimation()
			f34_arg0.ButtonBGMirrorSelected:setZoom(0)
			f34_arg0.ButtonBGMirrorSelected:setScale(1, 1)
			f34_local0(f34_arg0.ButtonBGMirrorSelected)
			f34_arg0.ButtonBGMirror:completeAnimation()
			f34_arg0.ButtonBGMirror:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ButtonBGMirror)
			local f34_local1 = function(f36_arg0)
				f34_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f34_arg0.AttachmentSlot:setZoom(20)
				f34_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f34_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.AttachmentSlot:completeAnimation()
			f34_arg0.AttachmentSlot:setZoom(0)
			f34_arg0.AttachmentSlot:setScale(1, 1)
			f34_local1(f34_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			local f37_local0 = function(f38_arg0)
				f37_arg0.ButtonBGMirrorSelected:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f37_arg0.ButtonBGMirrorSelected:setScale(1, 1)
				f37_arg0.ButtonBGMirrorSelected:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.ButtonBGMirrorSelected:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.ButtonBGMirrorSelected:completeAnimation()
			f37_arg0.ButtonBGMirrorSelected:setZoom(0)
			f37_arg0.ButtonBGMirrorSelected:setScale(0.95, 0.95)
			f37_local0(f37_arg0.ButtonBGMirrorSelected)
			f37_arg0.ButtonBGMirror:completeAnimation()
			f37_arg0.ButtonBGMirror:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ButtonBGMirror)
			local f37_local1 = function(f39_arg0)
				f37_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f37_arg0.AttachmentSlot:setZoom(0)
				f37_arg0.AttachmentSlot:setScale(1, 1)
				f37_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.AttachmentSlot:completeAnimation()
			f37_arg0.AttachmentSlot:setZoom(20)
			f37_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f37_local1(f37_arg0.AttachmentSlot)
		end,
	},
}
CoD.Armory_AttachmentSlotContainer.__onClose = function(f40_arg0)
	f40_arg0.AttachmentSlot:close()
	f40_arg0.MutuallyExclusiveIcon:close()
end
