require("x64:6a866391524bb19")
require("x64:96839bd6f46147f")
require("x64:ad25b4bd09d0d91")
CoD.AttachmentLoadoutClassListItem = InheritFrom(LUI.UIElement)
CoD.AttachmentLoadoutClassListItem.__defaultWidth = 110
CoD.AttachmentLoadoutClassListItem.__defaultHeight = 80
CoD.AttachmentLoadoutClassListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttachmentLoadoutClassListItem)
	self.id = "AttachmentLoadoutClassListItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WildcardHighlightBottom = CoD.CACWildcardSelectionAnimContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, 0, 52)
	WildcardHighlightBottom:setAlpha(0)
	self:addElement(WildcardHighlightBottom)
	self.WildcardHighlightBottom = WildcardHighlightBottom
	local WildcardHighlightTop = CoD.CACWildcardSelectionAnimContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, -52, 0)
	WildcardHighlightTop:setAlpha(0)
	WildcardHighlightTop:setZRot(180)
	self:addElement(WildcardHighlightTop)
	self.WildcardHighlightTop = WildcardHighlightTop
	local AttachmentSlot = CoD.AttachmentSlot.new(f1_arg0, f1_arg1, 0, 0, 0, 110, 0, 0, 0, 80)
	AttachmentSlot:mergeStateConditions({
		{
			stateName = "NotValid",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsAttachmentSlotValid(menu, f1_arg1, element)
			end,
		},
		{
			stateName = "WildcardNotAvailable",
			condition = function(menu, element, event)
				local f3_local0
				if not IsZombies() then
					f3_local0 = not CoD.BonuscardUtility.CanContextualEquipForSlot(menu, element)
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "WildcardNeeded",
			condition = function(menu, element, event)
				local f4_local0
				if not IsZombies() then
					f4_local0 = not CoD.BonuscardUtility.IsPrereqBonuscardEquippedForSlot(menu, element)
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "Add",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "loadoutListItem->itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
		{
			stateName = "DefaultStateHiddenName",
			condition = function(menu, element, event)
				return IsElementPropertyValue(menu, "_showItemNameOnButtonHold", true)
			end,
		},
	})
	AttachmentSlot:linkToElementModel(AttachmentSlot, "isAttachmentSlotAvailable", true, function(model)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isAttachmentSlotAvailable",
		})
	end)
	local f1_local4 = AttachmentSlot
	local ButtonFrameSelected = AttachmentSlot.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	ButtonFrameSelected(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local4 = AttachmentSlot
	ButtonFrameSelected = AttachmentSlot.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	ButtonFrameSelected(f1_local4, f1_local6["CustomClassList.equippedItemsChanged"], function(f9_arg0)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	AttachmentSlot:linkToElementModel(AttachmentSlot, "loadoutListItem", true, function(model)
		if AttachmentSlot["__stateValidation_loadoutListItem->itemIndex"] then
			AttachmentSlot:removeSubscription(AttachmentSlot["__stateValidation_loadoutListItem->itemIndex"])
			AttachmentSlot["__stateValidation_loadoutListItem->itemIndex"] = nil
		end
		if model then
			local f10_local0 = model:get()
			local f10_local1 = model:get()
			model = f10_local0 and f10_local1.itemIndex
		end
		if model then
			AttachmentSlot["__stateValidation_loadoutListItem->itemIndex"] = AttachmentSlot:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(AttachmentSlot, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "loadoutListItem->itemIndex",
				})
			end)
		end
	end)
	AttachmentSlot:linkToElementModel(self, nil, false, function(model)
		AttachmentSlot:setModel(model, f1_arg1)
	end)
	AttachmentSlot.AttachmentImage.__Item_Image = function(f13_arg0)
		local f13_local0 = f13_arg0:get()
		if f13_local0 ~= nil then
			AttachmentSlot.AttachmentImage:setImage(RegisterImage(f13_local0))
		end
	end
	AttachmentSlot:linkToElementModel(self, "loadoutListItem", true, function(model, f14_arg1)
		if f14_arg1["__AttachmentSlot.AttachmentImage.__Item_Image_loadoutListItem->image"] then
			f14_arg1:removeSubscription(f14_arg1["__AttachmentSlot.AttachmentImage.__Item_Image_loadoutListItem->image"])
			f14_arg1["__AttachmentSlot.AttachmentImage.__Item_Image_loadoutListItem->image"] = nil
		end
		if model then
			local f14_local0 = model:get()
			local f14_local1 = model:get()
			model = f14_local0 and f14_local1.image
		end
		if model then
			f14_arg1["__AttachmentSlot.AttachmentImage.__Item_Image_loadoutListItem->image"] = f14_arg1:subscribeToModel(model, AttachmentSlot.AttachmentImage.__Item_Image)
		end
	end)
	AttachmentSlot.AttachmentName.TextBox.__Item_Name = function(f15_arg0)
		local f15_local0 = f15_arg0:get()
		if f15_local0 ~= nil then
			AttachmentSlot.AttachmentName.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f15_local0))
		end
	end
	AttachmentSlot:linkToElementModel(self, "loadoutListItem", true, function(model, f16_arg1)
		if f16_arg1["__AttachmentSlot.AttachmentName.TextBox.__Item_Name_loadoutListItem->displayNameShort"] then
			f16_arg1:removeSubscription(f16_arg1["__AttachmentSlot.AttachmentName.TextBox.__Item_Name_loadoutListItem->displayNameShort"])
			f16_arg1["__AttachmentSlot.AttachmentName.TextBox.__Item_Name_loadoutListItem->displayNameShort"] = nil
		end
		if model then
			local f16_local0 = model:get()
			local f16_local1 = model:get()
			model = f16_local0 and f16_local1.displayNameShort
		end
		if model then
			f16_arg1["__AttachmentSlot.AttachmentName.TextBox.__Item_Name_loadoutListItem->displayNameShort"] = f16_arg1:subscribeToModel(model, AttachmentSlot.AttachmentName.TextBox.__Item_Name)
		end
	end)
	self:addElement(AttachmentSlot)
	self.AttachmentSlot = AttachmentSlot
	ButtonFrameSelected = CoD.CACWildcardSelectionAnimation.new(f1_arg0, f1_arg1, 0.5, 0.5, -55, 55, 0.5, 0.5, -40, 40)
	ButtonFrameSelected:setAlpha(0)
	self:addElement(ButtonFrameSelected)
	self.ButtonFrameSelected = ButtonFrameSelected
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.CACUtility.UpdateClassWeaponModel(f1_arg0, element, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusLost", function(element)
		if IsPC() then
			CoD.CACUtility.DelayedSetClassWeaponModelToDefault(f1_arg0, f1_arg1, 100)
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
CoD.AttachmentLoadoutClassListItem.__resetProperties = function(f19_arg0)
	f19_arg0.AttachmentSlot:completeAnimation()
	f19_arg0.WildcardHighlightTop:completeAnimation()
	f19_arg0.WildcardHighlightBottom:completeAnimation()
	f19_arg0.ButtonFrameSelected:completeAnimation()
	f19_arg0.AttachmentSlot:setScale(1, 1)
	f19_arg0.WildcardHighlightTop:setAlpha(0)
	f19_arg0.WildcardHighlightBottom:setAlpha(0)
	f19_arg0.ButtonFrameSelected:setAlpha(0)
end
CoD.AttachmentLoadoutClassListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.AttachmentSlot:completeAnimation()
			f21_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f22_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f22_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.AttachmentSlot:completeAnimation()
			f22_arg0.AttachmentSlot:setScale(1, 1)
			f22_local0(f22_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.AttachmentSlot:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.AttachmentSlot:setScale(1, 1)
				f24_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.AttachmentSlot:completeAnimation()
			f24_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f24_local0(f24_arg0.AttachmentSlot)
		end,
	},
	WildcardHighlight = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.WildcardHighlightBottom:completeAnimation()
			f26_arg0.WildcardHighlightBottom:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.WildcardHighlightBottom)
			f26_arg0.WildcardHighlightTop:completeAnimation()
			f26_arg0.WildcardHighlightTop:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.WildcardHighlightTop)
			f26_arg0.ButtonFrameSelected:completeAnimation()
			f26_arg0.ButtonFrameSelected:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.ButtonFrameSelected)
		end,
	},
}
CoD.AttachmentLoadoutClassListItem.__onClose = function(f27_arg0)
	f27_arg0.WildcardHighlightBottom:close()
	f27_arg0.WildcardHighlightTop:close()
	f27_arg0.AttachmentSlot:close()
	f27_arg0.ButtonFrameSelected:close()
end
